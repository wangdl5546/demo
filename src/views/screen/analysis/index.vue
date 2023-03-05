<template>
  <ContentWrap>
    <IFrame :src="src" style="width: 90vw;height: 90vh;background-color: white;"/>
  </ContentWrap>
</template>
<script setup lang="ts" name="analysis">
const src = 'http://60.205.206.198:10015/#/chart/preview/11'
</script>
