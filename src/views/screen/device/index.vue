<template>
  <ContentWrap>
    
    <IFrame :src="src" style="width: 80vw;height: 80vh;background-color: white;"/>
  </ContentWrap>
</template>
<script setup lang="ts" name="devicetrend">
const src = 'http://60.205.206.198:10015/#/chart/preview/9'
</script>
