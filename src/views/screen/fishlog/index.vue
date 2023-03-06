<template>
  <ContentWrap>
    <IFrame :src="src" style="width: 90vw;height: 90vh;background-color: white;"/>
  </ContentWrap>
</template>
<script setup lang="ts" name="fishlog">
import { getAccessToken } from "../../../utils/auth";
const src = 'http://60.205.206.198:10015/#/chart/preview/15?token='+getAccessToken()
</script>
