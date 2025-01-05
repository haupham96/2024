<script setup>
import { Button } from '@/components/ui/button'
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card'
import { Switch } from '@/components/ui/switch'
import { cn } from '@/lib/utils'
import { BellRing, Check } from 'lucide-vue-next'

const notifications = [
  {
    title: 'Your call has been confirmed.',
    description: '1 hour ago',
  },
  {
    title: 'You have a new message!',
    description: '1 hour ago',
  },
  {
    title: 'Your subscription is expiring soon!',
    description: '2 hours ago',
  },
]

import { RangeCalendar } from '@/components/ui/range-calendar'
import { getLocalTimeZone, today } from '@internationalized/date'
import { ref } from 'vue'

const start = today(getLocalTimeZone())
const end = start.add({ days: 7 })

const value = ref({
  start,
  end,
})
</script>
<template>
  <div>
    <Button>Click me</Button>
    <Button variant="destructive">Click me</Button>
    <Button variant="outline">Click me</Button>
    <Button variant="secondary" size="sm">Click me</Button>
    <Button variant="ghost">Click me</Button>
    <Button variant="link">Click me</Button>
  </div>
  <div class="mt-4">
    <Card :class="cn('w-[380px]', $attrs.class ?? '')">
      <CardHeader>
        <CardTitle>Notifications</CardTitle>
        <CardDescription>You have 3 unread messages.</CardDescription>
      </CardHeader>
      <CardContent class="grid gap-4">
        <div class="flex items-center space-x-4 rounded-md border p-4">
          <BellRing />
          <div class="flex-1 space-y-1">
            <p class="text-sm font-medium leading-none">Push Notifications</p>
            <p class="text-sm text-muted-foreground">Send notifications to device.</p>
          </div>
          <Switch />
        </div>
        <div>
          <div
            v-for="(notification, index) in notifications"
            :key="index"
            class="mb-4 grid grid-cols-[25px_minmax(0,1fr)] items-start pb-4 last:mb-0 last:pb-0"
          >
            <span class="flex h-2 w-2 translate-y-1 rounded-full bg-sky-500" />
            <div class="space-y-1">
              <p class="text-sm font-medium leading-none">
                {{ notification.title }}
              </p>
              <p class="text-sm text-muted-foreground">
                {{ notification.description }}
              </p>
            </div>
          </div>
        </div>
      </CardContent>
      <CardFooter>
        <Button class="w-full"> <Check class="mr-2 h-4 w-4" /> Mark all as read </Button>
      </CardFooter>
    </Card>
  </div>
  <div class="mt-4 w-72 h-72 flex justify-center items-center">
    <RangeCalendar v-model="value" class="rounded-md border" />
  </div>
</template>

<style scoped></style>
