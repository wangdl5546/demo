<template>
  <div id="centreRight1">
    <div class="bg-color-black">
      <div class="d-flex pt-2 pl-2">
        <span style="color:#5cd9e8">
          <icon name="chart-line"></icon>
        </span>
        <div class="d-flex">
          <span class="fs-xl text mx-2">市场招商</span>
        </div>
      </div>
      <div class="d-flex jc-center body-box">
        <dv-scroll-board :config="config" style="width:3.375rem;height:4.28rem" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      config: {
        header: ["招商类型", "主管部门", "紧急度"],
        data: [
          ["鱼类卖场", "商务1部", "<span  class='colorRed'>75%</span>"],
          ["水果类卖场", "商务1部", "<span  class='colorRed'>33%</span>"],
          ["衣服类卖场", "商务1部", "<span  class='colorRed'>100%</span>"],
          ["蔬菜类卖场", "商务1部", "<span  class='colorRed'>94%</span>"],
          ["海鲜类卖场", "商务1部", "<span  class='colorRed'>95%</span>"],
          ["卤味店卖场", "商务1部", "<span  class='colorRed'>63%</span>"],
          ["进口类", "商务1部", "<span  class='colorRed'>84%</span>"],
          ["酒类卖场", "商务1部", "<span  class='colorRed'>46%</span>"],
          ["装修类", "商务1部", "<span  class='colorRed'>13%</span>"],
          ["鲜花类", "商务1部", "<span  class='colorRed'>76%</span>"]
        ],
        rowNum: 7, //表格行数
        headerHeight: 35,
        headerBGC: "#0f1325", //表头
        oddRowBGC: "#0f1325", //奇数行
        evenRowBGC: "#171c33", //偶数行
        index: true,
        columnWidth: [50],
        align: ["center"]
      }
    };
  },
  components: {},
  mounted() {},
  methods: {}
};
</script>

<style lang="scss">
#centreRight1 {
  padding: 0.2rem;
  height: 5.125rem;
  min-width: 3.75rem;
  border-radius: 0.0625rem;
  .bg-color-black {
    height: 4.8125rem;
    border-radius: 0.125rem;
  }
  .text {
    color: #c3cbde;
  }
  .body-box {
    border-radius: 0.125rem;
    overflow: hidden;
  }
}
</style>