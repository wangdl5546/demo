<template>
  <div class="app-container">
    <!-- 搜索工作栏 -->
    <el-row :gutter="30">
      <el-col>
        <!-- <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd"
              v-hasPermi="['system:user:create']">新增</el-button>
          </el-col>
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
        </el-row> -->

        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
          <el-form-item label="关键字" prop="username">
            <el-input v-model="queryParams.name" placeholder="关键字" clearable style="width: 240px"/>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-table :data="list">
          <el-table-column label="ID" align="center" key="id" prop="id"  />
          <el-table-column label="消防设备" align="center" key="name" prop="name" :show-overflow-tooltip="true" />
          <el-table-column label="类型" key="type" prop="type" align="center" />
          <el-table-column label="位置" key="address" prop="address" align="center"/>
          <el-table-column label="负责人" key="duty" prop="duty" align="center"/>
          <el-table-column label="检查时间" align="center" key="checkTime" prop="checkTime" :show-overflow-tooltip="true" />
          <el-table-column label="创建时间" align="center" prop="createTime" />
        </el-table>
        <pagination :total="source.length" ref="page" @size-change="sizeChange" @current-change="currentChange" />
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';

const queryParams = ref({
  name:""
})
const source = [
  {
    id: 1,
    name: "消防栓",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 2,
    name: "灭火器",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 3,
    name: "灭火毯",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 4,
    name: "灭火沙",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 5,
    name: "铁锹",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 6,
    name: "灭火器",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 7,
    name: "灭火器",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 8,
    name: "灭火器",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 9,
    name: "灭火器",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 10,
    name: "灭火器",
    type: "消防设备",
    address:"A区1排22号摊位",
    duty:"张三",
    checkTime:"2020-12-07 12:07:08",
    createTime: "2020-12-07 12:07:08"
  },
]

const list = ref([{}])
const current = ref(1)
const pageSize= ref(10)

onMounted(() => {
  console.log(current.value)
  console.log(pageSize.value)
  getList(current.value,pageSize.value)
})

function getList(page, pageSize) {
  let s = (page - 1) * pageSize
  let e = page * pageSize
  if(s < 0){
    s = 0
  }
  if(e > source.length){
    e = source.length
  }

  list.value = source.slice(s,e)
}

function sizeChange(size) {
  pageSize.value = size
  getList(current.value, pageSize.value)
}

function currentChange(page) {
  current.value = page
  getList(current.value, pageSize.value)
}

function handleQuery(){
  let a = new Array()
  source.forEach( s => {
    if(!s.name.search(queryParams.value.name)){
      a.push(s)
    }
  })
  list.value = a
}

function resetQuery(){
  queryParams.value.name = ""
  getList(current.value, pageSize.value)
}
</script>
