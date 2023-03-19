<template>
  <div class="app-container">
    <!-- 搜索工作栏 -->
    <el-row :gutter="30">
      <!--部门数据-->
      <!-- <el-col :span="4" :xs="24">
        <div class="head-container">
          <el-input v-model="deptName" placeholder="请输入部门名称" clearable size="small" prefix-icon="el-icon-search" style="margin-bottom: 20px"/>
        </div>
        <div class="head-container">
          <el-tree :data="deptOptions" :props="defaultProps" :expand-on-click-node="false" :filter-node-method="filterNode"
                   ref="tree" default-expand-all highlight-current @node-click="handleNodeClick"/>
        </div>
      </el-col> -->
      <!--用户数据-->
      <el-col>
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
          <el-form-item label="摊位" prop="username">
            <el-input v-model="queryParams.username" placeholder="摊位" clearable style="width: 240px"
                      @keyup.enter.native="handleQuery"/>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd"
                       v-hasPermi="['system:user:create']">新增</el-button>
          </el-col>
          <!-- <el-col :span="1.5">
            <el-button type="info" icon="el-icon-upload2" size="mini" @click="handleImport"
                       v-hasPermi="['system:user:import']">导入</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" icon="el-icon-download" size="mini" @click="handleExport" :loading="exportLoading"
                       v-hasPermi="['system:user:export']">导出</el-button>
          </el-col> -->
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="userList">
          <el-table-column label="ID" align="center" key="id" prop="id" v-if="columns[0].visible"  width="240"/>
          <el-table-column label="交易时间" align="center" prop="createTime" v-if="columns[6].visible" width="240">
            <template v-slot="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="交易摊位" align="center" key="username" prop="username" v-if="columns[1].visible" :show-overflow-tooltip="true"/>
          <el-table-column label="交易商品" align="center" key="nickname" prop="nickname" v-if="columns[1].visible" :show-overflow-tooltip="true"/>
          <el-table-column label="交易金额" align="center" key="email" prop="email" v-if="columns[1].visible" :show-overflow-tooltip="true"/>

        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNo" :limit.sync="queryParams.pageSize"
                    @pagination="getList"/>
      </el-col>
    </el-row>

    <!-- 添加或修改参数配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="设备名称" prop="nickname">
              <el-input v-model="form.nickname" placeholder="请输入设备名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="归属部门" prop="deptId">
              <treeselect v-model="form.deptId" :options="deptOptions" :show-count="true" :clearable="false"
                          placeholder="请选择归属部门" :normalizer="normalizer"/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 添加或修改参数配置对话框 -->
    <el-dialog :title="'设备阈值配置'" :visible.sync="openAlarm" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="设备名称" prop="nickname">
              <el-input v-model="form.nickname" placeholder="请输入设备名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="告警阈值" prop="deptId">
              <el-input placeholder="请输入" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  addUser,
  changeUserStatus,
  delUser,
  exportUser,
  getUser,
  importTemplate,
  listUser,
  resetUserPwd,
  updateUser
} from "@/api/system/user";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";

import {listSimpleDepts} from "@/api/system/dept";
import {listSimplePosts} from "@/api/system/post";

import {CommonStatusEnum} from "@/utils/constants";
import {DICT_TYPE, getDictDatas} from "@/utils/dict";
import {assignUserRole, listUserRoles} from "@/api/system/permission";
import {listSimpleRoles} from "@/api/system/role";
import {getBaseHeader} from "@/utils/request";

export default {
  name: "User",
  components: { Treeselect },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 导出遮罩层
      exportLoading: false,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 用户表格数据
      userList: null,
      // 弹出层标题
      title: "",
      // 部门树选项
      deptOptions: undefined,
      // 是否显示弹出层
      open: false,
      // 告警配置
      openAlarm: false,
      // 部门名称
      deptName: undefined,
      // 默认密码
      initPassword: undefined,
      // 性别设备设备字典
      sexOptions: [],
      // 岗位选项
      postOptions: [],
      // 角色选项
      roleOptions: [],
      // 表单参数
      form: {},
      defaultProps: {
        children: "children",
        label: "name"
      },
      // 用户导入参数
      upload: {
        // 是否显示弹出层（用户导入）
        open: false,
        // 弹出层标题（用户导入）
        title: "",
        // 是否禁用上传
        isUploading: false,
        // 是否更新已经存在的用户数据
        updateSupport: 0,
        // 设置上传的请求头部
        headers: getBaseHeader(),
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + '/admin-api/system/user/import'
      },
      // 查询参数
      queryParams: {
        pageNo: 1,
        pageSize: 10,
        username: undefined,
        mobile: undefined,
        status: undefined,
        deptId: undefined,
        createTime: []
      },
      // 列信息
      columns: [
        { key: 0, label: `设备编码`, visible: true },
        { key: 1, label: `设备名称`, visible: true },
        { key: 2, label: `用户昵称`, visible: true },
        { key: 3, label: `部门`, visible: true },
        { key: 4, label: `手机号码`, visible: true },
        { key: 5, label: `设备设备`, visible: true },
        { key: 6, label: `创建时间`, visible: true }
      ],
      // 表单校验
      rules: {
        username: [
          { required: true, message: "设备名称不能为空", trigger: "blur" }
        ],
        nickname: [
          { required: true, message: "设备名称不能为空", trigger: "blur" }
        ],
        password: [
          { required: true, message: "设备名称不能为空", trigger: "blur" }
        ],
        email: [
          {
            type: "email",
            message: "'请输入正确的邮箱地址",
            trigger: ["blur", "change"]
          }
        ],
        mobile: [
          {
            pattern: /^(?:(?:\+|00)86)?1(?:3[\d]|4[5-79]|5[0-35-9]|6[5-7]|7[0-8]|8[\d]|9[189])\d{8}$/,
            message: "请输入正确的手机号码",
            trigger: "blur"
          }
        ]
      },
      // 是否显示弹出层（角色权限）
      openRole: false,

      // 枚举
      SysCommonStatusEnum: CommonStatusEnum,
      // 数据字典
      statusDictDatas: getDictDatas(DICT_TYPE.COMMON_STATUS),
      sexDictDatas: getDictDatas(DICT_TYPE.SYSTEM_USER_SEX),
    };
  },
  watch: {
    // 根据名称筛选部门树
    deptName(val) {
      this.$refs.tree.filter(val);
    }
  },
  created() {
    this.getList();
    this.getTreeselect();
    this.getConfigKey("sys.user.init-password").then(response => {
      this.initPassword = response.msg;
    });
  },
  methods: {
    // 更多操作
    handleCommand(command, index, row) {
      switch (command) {
        case 'handleUpdate':
          this.handleUpdate(row);//修改客户信息
          break;
        case 'handleDelete':
          this.handleDelete(row);//红号变更
          break;
        case 'handleResetPwd':
          this.handleResetPwd(row);
          break;
        case 'handleRole':
          this.handleRole(row);
          break;
        default:
          break;
      }
    },
    /** 查询用户列表 */
    getList() {
      this.loading = true;
      listUser(this.queryParams).then(response => {
          console.log(response.data.list)
          response.data.list[0].username = '东区A1'
          response.data.list[0].email = '10'
          response.data.list[0].nickname = '蔬菜'
          response.data.list[0].remark = '王五'

          response.data.list[1].username = '东区B2'
          response.data.list[1].email = '50'
          response.data.list[1].nickname = '水果'
          response.data.list[1].remark = '赵六'

          response.data.list[2].username = '南区A1'
          response.data.list[2].email = '8'
          response.data.list[2].nickname = '淡水水产'
          response.data.list[2].remark = '犀利'

          response.data.list[3].username = '南区B1'
          response.data.list[3].email = '65'
          response.data.list[3].nickname = '海鲜'
          response.data.list[3].remark = '梓潼'

          response.data.list[4].username = '西区A1'
          response.data.list[4].email = '90'
          response.data.list[4].nickname = '肉类'
          response.data.list[4].remark = '一辉'

          response.data.list[5].username = '西区C1'
          response.data.list[5].email = '58'
          response.data.list[5].nickname = '家禽'
          response.data.list[5].remark = '星耀'

          response.data.list[6].username = '北区A1'
          response.data.list[6].email = '16'
          response.data.list[6].nickname = '豆制品'
          response.data.list[6].remark = '小A'

          response.data.list[7].username = '北区A2'
          response.data.list[7].email = '20'
          response.data.list[7].nickname = '干货'
          response.data.list[7].remark = '菊琴'

          response.data.list[8].username = '北区D1'
          response.data.list[8].email = '3.5'
          response.data.list[8].nickname = '炒货'
          response.data.list[8].remark = '李黛'

          this.userList = response.data.list;
          this.total = response.data.total;
          this.loading = false;
        }
      );
    },
    /** 查询部门下拉树结构 + 岗位下拉 */
    getTreeselect() {
      listSimpleDepts().then(response => {
        // 处理 deptOptions 参数
        this.deptOptions = [];
        this.deptOptions.push(...this.handleTree(response.data, "id"));
      });
      listSimplePosts().then(response => {
        // 处理 postOptions 参数
        this.postOptions = [];
        this.postOptions.push(...response.data);
      });
    },
    // 筛选节点
    filterNode(value, data) {
      if (!value) return true;
      return data.name.indexOf(value) !== -1;
    },
    // 节点单击事件
    handleNodeClick(data) {
      this.queryParams.deptId = data.id;
      this.getList();
    },
    // 用户设备设备修改
    handleStatusChange(row) {
      let text = row.status === CommonStatusEnum.ENABLE ? "启用" : "停用";
      this.$modal.confirm('确认要"' + text + '""' + row.username + '"设备吗?').then(function() {
          return changeUserStatus(row.id, row.status);
        }).then(() => {
          this.$modal.msgSuccess(text + "成功");
        }).catch(function() {
          row.status = row.status === CommonStatusEnum.ENABLE ? CommonStatusEnum.DISABLE
              : CommonStatusEnum.ENABLE;
        });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.openAlarm = false;
      this.reset();
    },
    // 取消按钮（角色权限）
    cancelRole() {
      this.openRole = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: undefined,
        deptId: undefined,
        username: undefined,
        nickname: undefined,
        password: undefined,
        mobile: undefined,
        email: undefined,
        sex: undefined,
        status: "0",
        remark: undefined,
        postIds: [],
        roleIds: []
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNo = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      // 获得下拉数据
      this.getTreeselect();
      // 打开表单，并设置初始化
      this.open = true;
      this.title = "添加设备";
      this.form.password = this.initPassword;
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      this.getTreeselect();
      const id = row.id;
      getUser(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改设备";
        this.form.password = "";
      });
    },
    handleAlarmUpdate(row) {
      this.openAlarm = true
    },
    /** 重置密码按钮操作 */
    handleResetPwd(row) {
      this.$prompt('请输入"' + row.username + '"的新密码', "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消"
      }).then(({ value }) => {
          resetUserPwd(row.id, value).then(response => {
            this.$modal.msgSuccess("修改成功，新密码是：" + value);
          });
        }).catch(() => {});
    },
    /** 分配用户角色操作 */
    handleRole(row) {
      this.reset();
      const id = row.id
      // 处理了 form 的用户 username 和 nickname 的展示
      this.form.id = id;
      this.form.username = row.username;
      this.form.nickname = row.nickname;
      // 打开弹窗
      this.openRole = true;
      // 获得角色列表
      listSimpleRoles().then(response => {
        // 处理 roleOptions 参数
        this.roleOptions = [];
        this.roleOptions.push(...response.data);
      });
      // 获得角色拥有的菜单集合
      listUserRoles(id).then(response => {
        // 设置选中
        this.form.roleIds = response.data;
      })
    },
    /** 提交按钮 */
    submitForm: function() {
      this.openAlarm = false
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id !== undefined) {
            updateUser(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addUser(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 提交按钮（角色权限） */
    submitRole: function() {
      if (this.form.id !== undefined) {
        assignUserRole({
          userId: this.form.id,
          roleIds: this.form.roleIds,
        }).then(response => {
          this.$modal.msgSuccess("分配角色成功");
          this.openRole = false;
          this.getList();
        });
      }
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除设备编码为"' + ids + '"的数据项?').then(function() {
          return delUser(ids);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.$modal.confirm('是否确认导出所有用户数据项?').then(() => {
          // 处理查询参数
          let params = {...this.queryParams};
          params.pageNo = undefined;
          params.pageSize = undefined;
          this.exportLoading = true;
          return exportUser(params);
        }).then(response => {
          this.$download.excel(response, '用户数据.xls');
          this.exportLoading = false;
      }).catch(() => {});
    },
    /** 导入按钮操作 */
    handleImport() {
      this.upload.title = "用户导入";
      this.upload.open = true;
    },
    /** 下载模板操作 */
    importTemplate() {
      importTemplate().then(response => {
        this.$download.excel(response, '用户导入模板.xls');
      });
    },
    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true;
    },
    // 文件上传成功处理
    handleFileSuccess(response, file, fileList) {
      if (response.code !== 0) {
        this.$modal.msgError(response.msg)
        return;
      }
      this.upload.open = false;
      this.upload.isUploading = false;
      this.$refs.upload.clearFiles();
      // 拼接提示语
      let data = response.data;
      let text = '创建成功数量：' + data.createUsernames.length;
      for (const username of data.createUsernames) {
        text += '<br />&nbsp;&nbsp;&nbsp;&nbsp;' + username;
      }
      text += '<br />更新成功数量：' + data.updateUsernames.length;
      for (const username of data.updateUsernames) {
        text += '<br />&nbsp;&nbsp;&nbsp;&nbsp;' + username;
      }
      text += '<br />更新失败数量：' + Object.keys(data.failureUsernames).length;
      for (const username in data.failureUsernames) {
        text += '<br />&nbsp;&nbsp;&nbsp;&nbsp;' + username + '：' + data.failureUsernames[username];
      }
      this.$alert(text, "导入结果", { dangerouslyUseHTMLString: true });
      this.getList();
    },
    // 提交上传文件
    submitFileForm() {
      this.$refs.upload.submit();
    },
    // 格式化部门的下拉框
    normalizer(node) {
      return {
        id: node.id,
        label: node.name,
        children: node.children
      }
    }
  }
};
</script>
