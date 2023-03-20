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

        <el-table :data="list">
          <el-table-column label="ID" align="center" key="id" prop="id" width="240" />
          <el-table-column label="地点" align="center" key="name" prop="name" :show-overflow-tooltip="true" width="240" />
          <el-table-column label="人数" key="count" prop="count" align="center" width="240" />
          <el-table-column label="创建时间" align="center" prop="createTime" />
        </el-table>
        <pagination :total="source.length" ref="page" @size-change="sizeChange" @current-change="currentChange" />
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';

const pagenation = ref("page")

const source = [
  {
    id: 1,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 2,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 3,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 4,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 5,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 6,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 7,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 8,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 9,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 10,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 11,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 12,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 13,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 14,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 15,
    name: "东入口",
    count: 20,
    createTime: "2020-12-07 12:07:08"
  }
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
</script>
