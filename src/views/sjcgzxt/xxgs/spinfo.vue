<template>
  <div id="centreRight1">
    <div class="bg-color-black">
      <div class="d-flex pt-2 pl-2">
        <span style="color:#5cd9e8">
          <icon name="chart-line"></icon>
        </span>
        <div class="d-flex">
          <span class="fs-xl text mx-2">价格信息</span>
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
        header: ["商品", "价格", "市场优惠"],
        data: [
          ["苹果", "9.98", "<span  class='colorGrass'>↓5%</span>"],
          ["鲈鱼", "21.15", "<span  class='colorGrass'>↓3%</span>"],
          ["小龙虾", "33.78", "<span  class='colorGrass'>↓10%</span>"],
          ["蛤蜊", "14.48", "<span  class='colorGrass'>↓9%</span>"],
          ["香蕉", "7.98", "<span  class='colorGrass'>↓9%</span>"],
          ["大排", "24.45", "<span  class='colorGrass'>↓6%</span>"],
          ["牛腩", "49.98", "<span  class='colorGrass'>↓8%</span>"],
          ["卤牛肉", "98.98", "<span  class='colorGrass'>↓6%</span>"],
          ["拉面", "8.99", "<span  class='colorGrass'>↓3%</span>"],
          ["料酒", "4.68", "<span  class='colorGrass'>↓7%</span>"]
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