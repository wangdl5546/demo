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
          <el-table-column label="商品名称" align="center" key="name" prop="name" :show-overflow-tooltip="true" />
          <el-table-column label="商品数量" key="count" prop="count" align="center" width="240" />
          <el-table-column label="商户" align="center" key="shop" prop="shop" :show-overflow-tooltip="true" />
          <el-table-column label="单价" key="price" prop="price" align="center" width="240" />
          <el-table-column label="供应商" key="supplier" prop="supplier" align="center"/>
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
    name: "苹果",
    count: "1吨",
    shop:"A区1排22号摊位",
    supplier:"市内水果批发市场",
    createTime: "2020-12-07 12:07:08"
  },
  {
    id: 1,
    name: "苹果",
    count: "1吨",
    shop:"A区1排22号摊位",
    supplier:"市内水果批发市场",
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
