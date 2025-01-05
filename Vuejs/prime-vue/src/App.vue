<script setup>
import InputText from 'primevue/inputtext'
import Button from 'primevue/button'
import DatePicker from 'primevue/datepicker'
</script>

<template>
  <InputText type="text" v-model="value" />
  <Button label="Submit" />
  <DatePicker v-model="date" showIcon showTime iconDisplay="input" />
</template>

<style scoped></style>
