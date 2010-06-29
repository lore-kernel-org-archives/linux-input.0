From: "Dmitriy Vasil'ev" <tech@digiton.ru>
Subject: Re: rotary encoder
Date: Tue, 29 Jun 2010 19:06:24 +0400
Message-ID: <6F142F21F5134B03BDACDD706E7BCA3C@tech>
References: <20100602135251.GC2695@buzzloop.caiaq.de> <888FDE7800AB4E278ED6DF185FEDC869@tech> <20100617101021.GB17833@buzzloop.caiaq.de> <B221BAA24375436992F7587DF15BB812@tech> <20100617112135.GC17833@buzzloop.caiaq.de> <B111F158EBCF48779A16E4EF5FAA2F84@tech> <20100617113725.GD17833@buzzloop.caiaq.de> <1E284238E08046EFA4038129CEA2527F@tech> <20100617120005.GF17833@buzzloop.caiaq.de> <20100628182225.GB7427@core.coreip.homeip.net> <20100628183229.GI2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39691 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457Ab0F2PGb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 11:06:31 -0400
Received: by bwz1 with SMTP id 1so765453bwz.19
        for <linux-input@vger.kernel.org>; Tue, 29 Jun 2010 08:06:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

I am sorry, I am not a kernel programmer, I just share my code.
I think, kernel maintainers must heck any code before applying it to kernel.

I have found of the problem:
my editor uses \r\n as end of line symbol.
original code uses \n as end of line

diff utlility could be more flexible....

1. I do not know how many people use encoder without button.
Probably, need correct this code to disable using the button and free a irq, 
if button do not uses.

2. I do not know what code inside the kernel use the rotary encoder.
If this code there is, probably it need correct these code.

My patch, check it please before applying to kernel:

diff -ur linux-2.6.34/Documentation/input/rotary-encoder.txt 
linux/Documentation/input/rotary-encoder.txt
--- linux-2.6.34/Documentation/input/rotary-encoder.txt Mon May 17 01:17:36 
2010
+++ linux/Documentation/input/rotary-encoder.txt Thu Jun 17 13:24:14 2010
@@ -86,16 +86,26 @@

 #define GPIO_ROTARY_A 1
 #define GPIO_ROTARY_B 2
+#define GPIO_ROTARY_S 3

 static struct rotary_encoder_platform_data my_rotary_encoder_info = {
- .steps  = 24,
- .axis  = ABS_X,
- .relative_axis = false,
- .rollover = false,
+ .steps  = 1,
+ .type  = EV_KEY, //(EV_KEY, EV_REL, EV_ABS)
  .gpio_a  = GPIO_ROTARY_A,
  .gpio_b  = GPIO_ROTARY_B,
  .inverted_a = 0,
  .inverted_b = 0,
+ .codeleft = KEY_LEFT, //(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)
+ .coderight = KEY_RIGHT, //(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)
+ .rollover = 0,
+ .button  = {
+  .code = KEY_ENTER,
+  .gpio = GPIO_ROTARY_S,
+  .active_low = 1,
+  .type = EV_KEY,
+  .debounce_interval = 10,
+  .rep = false
+ }
 };

 static struct platform_device rotary_encoder_device = {
diff -ur linux-2.6.34/drivers/input/misc/rotary_encoder.c 
linux/drivers/input/misc/rotary_encoder.c
--- linux-2.6.34/drivers/input/misc/rotary_encoder.c Mon May 17 01:17:36 
2010
+++ linux/drivers/input/misc/rotary_encoder.c Tue Jun 29 18:49:16 2010
@@ -1,7 +1,8 @@
 /*
- * rotary_encoder.c
- *
- * (c) 2009 Daniel Mack <daniel@caiaq.de>
+ * based on the:
+ * rotary_encoder.c, (c) 2009 Daniel Mack <daniel@caiaq.de>
+ * and
+ * gpio_keys.c, Copyright 2005 Phil Blundell
  *
  * state machine code inspired by code from Tim Ruetz
  *
@@ -23,14 +24,22 @@
 #include <linux/gpio.h>
 #include <linux/rotary_encoder.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/sched.h>

 #define DRV_NAME "rotary-encoder"

+struct rotary_encoder_button_data {
+ struct rotary_encoder_button button;
+ unsigned int irq;
+ struct timer_list timer;
+ struct work_struct work;
+};
+
 struct rotary_encoder {
  struct input_dev *input;
  struct rotary_encoder_platform_data *pdata;

- unsigned int axis;
  unsigned int pos;

  unsigned int irq_a;
@@ -38,8 +47,12 @@

  bool armed;
  unsigned char dir; /* 0 - clockwise, 1 - CCW */
+
+ struct rotary_encoder_button_data bdata;
 };

+static struct rotary_encoder* encoder;
+
 static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 {
  struct rotary_encoder *encoder = dev_id;
@@ -58,10 +71,11 @@
   if (!encoder->armed)
    break;

-  if (pdata->relative_axis) {
-   input_report_rel(encoder->input, pdata->axis,
+  if (pdata->type == EV_REL) {
+   input_report_rel(encoder->input, pdata->codeleft,
       encoder->dir ? -1 : 1);
-  } else {
+  } else
+  if (pdata->type == EV_ABS) {
    unsigned int pos = encoder->pos;

    if (encoder->dir) {
@@ -78,8 +92,14 @@
    if (pdata->rollover)
     pos %= pdata->steps;
    encoder->pos = pos;
-   input_report_abs(encoder->input, pdata->axis,
+   input_report_abs(encoder->input, pdata->codeleft,
       encoder->pos);
+  } else
+  //if (pdata->type == EV_KEY)// this if not needed, because we are 
supporting only EV_REL, EV_ABS, EV_KEY
+  {
+   input_report_key(encoder->input, encoder->dir ? pdata->codeleft : 
pdata->coderight, 1);
+   input_sync(encoder->input);
+   input_report_key(encoder->input, encoder->dir ? pdata->codeleft : 
pdata->coderight, 0);
   }
   input_sync(encoder->input);

@@ -100,6 +120,46 @@
  return IRQ_HANDLED;
 }

+static void rotary_encoder_report_event(struct rotary_encoder *encoder)
+{
+ struct rotary_encoder_button *button = &(encoder->bdata.button);
+ struct input_dev *input = encoder->input;
+ int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
+
+ input_event(input, EV_KEY, button->code, !!state);
+ input_sync(input);
+}
+
+static void rotary_encoder_work_func(struct work_struct *work)
+{
+ struct rotary_encoder *encoder =
+  container_of(work, struct rotary_encoder, bdata.work);
+
+ rotary_encoder_report_event(encoder);
+}
+
+static void rotary_encoder_timer(unsigned long _data)
+{
+ struct rotary_encoder *encoder = (struct rotary_encoder *)_data;
+
+ schedule_work(&encoder->bdata.work);
+}
+
+static irqreturn_t rotary_encoder_key_irq(int irq, void *dev_id)
+{
+ struct rotary_encoder *encoder = dev_id;
+ struct rotary_encoder_button_data *bdata = &encoder->bdata;
+ struct rotary_encoder_button *button = &bdata->button;
+
+ if (button->debounce_interval)
+  mod_timer(&bdata->timer,
+   jiffies + msecs_to_jiffies(button->debounce_interval));
+ else
+  schedule_work(&bdata->work);
+
+ return IRQ_HANDLED;
+}
+
 static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 {
  struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
@@ -124,20 +184,27 @@
  encoder->pdata = pdata;
  encoder->irq_a = gpio_to_irq(pdata->gpio_a);
  encoder->irq_b = gpio_to_irq(pdata->gpio_b);
+ encoder->bdata.irq = gpio_to_irq(pdata->button.gpio);

  /* create and register the input driver */
  input->name = pdev->name;
  input->id.bustype = BUS_HOST;
  input->dev.parent = &pdev->dev;

- if (pdata->relative_axis) {
-  input->evbit[0] = BIT_MASK(EV_REL);
-  input->relbit[0] = BIT_MASK(pdata->axis);
- } else {
-  input->evbit[0] = BIT_MASK(EV_ABS);
-  input_set_abs_params(encoder->input,
-         pdata->axis, 0, pdata->steps, 0, 1);
- }
+ /* Enable auto repeat feature of Linux input subsystem */
+ if (pdata->button.rep)
+  set_bit(EV_REP, input->evbit);
+
+ encoder->bdata.button = pdata->button;
+
+ set_bit(pdata->type, input->evbit);
+ set_bit(pdata->codeleft, input->keybit);
+ set_bit(pdata->coderight, input->keybit);
+ set_bit(encoder->bdata.button.type, input->evbit);
+ set_bit(encoder->bdata.button.code, input->keybit);
+
+ setup_timer(&encoder->bdata.timer, rotary_encoder_timer, (unsigned 
long)encoder);
+ INIT_WORK(&encoder->bdata.work, rotary_encoder_work_func);

  err = input_register_device(input);
  if (err) {
@@ -174,6 +241,20 @@
   goto exit_free_gpio_a;
  }

+ err = gpio_request(pdata->button.gpio, DRV_NAME);
+ if (err) {
+  dev_err(&pdev->dev, "unable to request GPIO %d\n",
+   pdata->button.gpio);
+  goto exit_free_gpio_b;
+ }
+
+ err = gpio_direction_input(pdata->button.gpio);
+ if (err) {
+  dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
+   pdata->button.gpio);
+  goto exit_free_gpio_b;
+ }
+
  /* request the IRQs */
  err = request_irq(encoder->irq_a, &rotary_encoder_irq,
      IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
@@ -181,7 +262,7 @@
  if (err) {
   dev_err(&pdev->dev, "unable to request IRQ %d\n",
    encoder->irq_a);
-  goto exit_free_gpio_b;
+  goto exit_free_gpio_s;
  }

  err = request_irq(encoder->irq_b, &rotary_encoder_irq,
@@ -193,12 +274,24 @@
   goto exit_free_irq_a;
  }

+ err = request_irq(encoder->bdata.irq, &rotary_encoder_key_irq,
+     IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
+     DRV_NAME, encoder);
+ if (err) {
+  dev_err(&pdev->dev, "unable to request IRQ %d\n",
+   encoder->bdata.irq);
+  goto exit_free_irq_b;
+ }
+
  platform_set_drvdata(pdev, encoder);

  return 0;
-
+exit_free_irq_b:
+ free_irq(encoder->irq_b, encoder);
 exit_free_irq_a:
  free_irq(encoder->irq_a, encoder);
+exit_free_gpio_s:
+ gpio_free(pdata->button.gpio);
 exit_free_gpio_b:
  gpio_free(pdata->gpio_b);
 exit_free_gpio_a:
@@ -219,8 +312,13 @@

  free_irq(encoder->irq_a, encoder);
  free_irq(encoder->irq_b, encoder);
+ free_irq(encoder->bdata.irq, encoder);
+ if (pdata->button.debounce_interval)
+  del_timer_sync(&encoder->bdata.timer);
+ cancel_work_sync(&encoder->bdata.work);
  gpio_free(pdata->gpio_a);
  gpio_free(pdata->gpio_b);
+ gpio_free(pdata->button.gpio);
  input_unregister_device(encoder->input);
  platform_set_drvdata(pdev, NULL);
  kfree(encoder);
diff -ur linux-2.6.34/include/linux/rotary_encoder.h 
linux/include/linux/rotary_encoder.h
--- linux-2.6.34/include/linux/rotary_encoder.h Mon May 17 01:17:36 2010
+++ linux/include/linux/rotary_encoder.h Thu Jun 17 14:23:26 2010
@@ -1,15 +1,28 @@
 #ifndef __ROTARY_ENCODER_H__
 #define __ROTARY_ENCODER_H__

+struct rotary_encoder_button {
+ /* Configuration parameters */
+ u16 code;  /* input event code (KEY_*, SW_*) */
+ int gpio;
+ int active_low;
+ //char *desc;
+ u16 type;  /* input event type (EV_KEY, EV_SW) */
+ int debounce_interval; /* debounce ticks interval in msecs */
+ bool rep;/* enable input subsystem auto repeat */
+};
+
 struct rotary_encoder_platform_data {
  unsigned int steps;
- unsigned int axis;
+ u16 type; /*(EV_KEY, EV_REL, EV_ABS)*/
  unsigned int gpio_a;
  unsigned int gpio_b;
  unsigned int inverted_a;
  unsigned int inverted_b;
- bool relative_axis;
+ u16 codeleft; /*(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)*/
+ u16 coderight; /*(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)*/
  bool rollover;
+ struct rotary_encoder_button button;
 };

 #endif /* __ROTARY_ENCODER_H__ */


----- Original Message ----- 
From: "Daniel Mack" <daniel@caiaq.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Dmitriy Vasil'ev" <tech@digiton.ru>; <linux-input@vger.kernel.org>
Sent: Monday, June 28, 2010 10:32 PM
Subject: Re: rotary encoder


> On Mon, Jun 28, 2010 at 11:22:26AM -0700, Dmitry Torokhov wrote:
>> It looks like Dmitriy's editor of choice happily messed up all
>> whitespace in the original version converting tabs to spaces.
>
> Yeah, something like that. Dmitriy, don't get me wrong - any kind of
> help is certainly appreciated and it's good you try to push things back
> mainline. But please understand that there are some rules to follow :)
>
> Daniel 

