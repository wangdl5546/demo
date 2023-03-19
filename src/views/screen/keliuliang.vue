<template>
  <ContentWrap>
    <IFrame :src="src" style="width: 90vw;height: 90vh;background-color: white;"/>
  </ContentWrap>
</template>
<script setup lang="ts" name="analysis">
import { getAccessToken } from "../../utils/auth";
const src = 'http://101.43.23.178:10015/#/chart/preview/18?token='+getAccessToken()
</script>
