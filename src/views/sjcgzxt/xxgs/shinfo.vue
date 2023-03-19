<template>
  <div id="centreRight1">
    <div class="bg-color-black">
      <div class="d-flex pt-2 pl-2">
        <span style="color:#5cd9e8">
          <icon name="chart-line"></icon>
        </span>
        <div class="d-flex">
          <span class="fs-xl text mx-2">市场商户及优惠信息</span>
        </div>
      </div>
      <div class="d-flex jc-center body-box">
        <dv-scroll-board :config="config" style="height:4.28rem" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      config: {
        header: ["商户", "门店", "优惠率"],
        data: [
          ["强盛小灵通专卖", "dev-1", "<span  class='colorGrass'>↑75%</span>"],
          ["阿强鱼档", "dev-2", "<span  class='colorRed'>↓33%</span>"],
          ["星期八烧烤", "dev-3", "<span  class='colorGrass'>↑100%</span>"],
          ["阿兰小龙虾", "rea-1", "<span  class='colorGrass'>↑94%</span>"],
          ["龙哥游戏厅", "rea-2", "<span  class='colorGrass'>↑95%</span>"],
          ["大嫂成衣旗舰店", "fix-2", "<span  class='colorGrass'>↑63%</span>"],
          ["兴盛手表维修", "fix-4", "<span  class='colorGrass'>↑84%</span>"],
          ["小强电动车", "fix-7", "<span  class='colorRed'>↓46%</span>"],
          ["阿虎面店", "dev-2", "<span  class='colorRed'>↓13%</span>"],
          ["小龙杂货铺", "dev-9", "<span  class='colorGrass'>↑76%</span>"]
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