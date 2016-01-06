From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Fix check for disabling unsupported key
Date: Wed, 6 Jan 2016 14:38:45 -0800
Message-ID: <20160106223845.GA26606@dtor-ws>
References: <1451856076-29045-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160105011942.GD11801@dtor-ws>
 <568B6FB8.6000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35594 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbcAFWit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 17:38:49 -0500
Content-Disposition: inline
In-Reply-To: <568B6FB8.6000101@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: pali.rohar@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 05, 2016 at 09:24:40AM +0200, Ivaylo Dimitrov wrote:
> Hi,
> 
> On  5.01.2016 03:19, Dmitry Torokhov wrote:
> >>  	/* First validate */
> >>-	for (i = 0; i < ddata->pdata->nbuttons; i++) {
> >>-		struct gpio_button_data *bdata = &ddata->data[i];
> >>+	for (i = 0; i < n_events; i++) {
> >
> >for_each_set_bit()?
> 
> Yeah, seems I must have overslept that helper, will send an updated version.
> 
> >
> >OTOH maybe we should do
> >
> >	bitmap = get_bitmap_events_by_type(type); // new, return keybit or swbit
> 
> new helper function? or static function in gpio-keys? who
> allocates/frees the bitmap memory? or this is static data? Maybe I
> don't get the idea :) .
> 
> >	if (!bitmap_subset(bits, bitmap, n_events)) {
> >		error = -EINVAL;
> >		goto out;
> >	}
> >
> >... and leave the rest of the loop as is?
> >
> 
> Not sure about that. Unless I miss something, what we want is:
> 
> 1. make sure that what user has written is within the range of the
> event type. I hope bitmap_parselist already does it for us.
> 
> 2. Make sure that for every bit in bits set based on what user has
> provided, there is a matching gpio in this particular gpio-keys
> device.
> 
> 3. Make sure that every gpio user wants disabled is actually allowed
> to be disabled.
> 
> I don't see how 2 is achieved with ^^^ code.
> 
> So, shall I send a new version of the patch with for_each_set_bit()
> used, or you'll fix the $subject problem with whatever magic you
> think is needed?

How about the patch below (compiled but not tested)?

Thanks.

-- 
Dmitry

Input: gpio-keys - fix check for disabling unsupported keys

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Commit 4ea14a53d8f881034fa9e186653821c4e3d9a8fb ("Input: gpio-keys - report
error when disabling unsupported key") tried let user know that they
attempted to disable an unsupported key, unfortunately the check is wrong
as it believes that all codes are invalid. Fix it by ensuring that keys
that we try to disable are subset of keys (or switches) that device
reports.

Fixes: 4ea14a53d8f8 ("Input: gpio-keys - report error when disabling unsupported key")
Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index bef317f..b9f01bd 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -96,7 +96,7 @@ struct gpio_keys_drvdata {
  * Return value of this function can be used to allocate bitmap
  * large enough to hold all bits for given type.
  */
-static inline int get_n_events_by_type(int type)
+static int get_n_events_by_type(int type)
 {
 	BUG_ON(type != EV_SW && type != EV_KEY);
 
@@ -104,6 +104,22 @@ static inline int get_n_events_by_type(int type)
 }
 
 /**
+ * get_bm_events_by_type() - returns bitmap of supported events per @type
+ * @input: input device from which bitmap is retrieved
+ * @type: type of button (%EV_KEY, %EV_SW)
+ *
+ * Return value of this function can be used to allocate bitmap
+ * large enough to hold all bits for given type.
+ */
+static const unsigned long *get_bm_events_by_type(struct input_dev *dev,
+						  int type)
+{
+	BUG_ON(type != EV_SW && type != EV_KEY);
+
+	return (type == EV_KEY) ? dev->keybit : dev->swbit;
+}
+
+/**
  * gpio_keys_disable_button() - disables given GPIO button
  * @bdata: button data for button to be disabled
  *
@@ -213,6 +229,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 					   const char *buf, unsigned int type)
 {
 	int n_events = get_n_events_by_type(type);
+	const unsigned long *bitmap = get_bm_events_by_type(ddata->input, type);
 	unsigned long *bits;
 	ssize_t error;
 	int i;
@@ -226,6 +243,11 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 		goto out;
 
 	/* First validate */
+	if (!bitmap_subset(bits, bitmap, n_events)) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
 		struct gpio_button_data *bdata = &ddata->data[i];
 
@@ -239,11 +261,6 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 		}
 	}
 
-	if (i == ddata->pdata->nbuttons) {
-		error = -EINVAL;
-		goto out;
-	}
-
 	mutex_lock(&ddata->disable_lock);
 
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
