From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Input: tsc200x-core - set INPUT_PROP_DIRECT
Date: Wed,  8 Nov 2017 00:40:00 +0100
Message-ID: <20171107234000.10236-1-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:54467 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753348AbdKGXkX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Nov 2017 18:40:23 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 8F62E20D19
        for <linux-input@vger.kernel.org>; Wed,  8 Nov 2017 00:40:21 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: keescook@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

If INPUT_PROP_DIRECT is set, userspace doesn't have to fall back to old
ways of identifying touchscreen devices.

In order to identify a touchscreen device, Android for example, seems to
already depend on INPUT_PROP_DIRECT to be present in drivers. udev still
checks for either BTN_TOUCH or INPUT_PROP_DIRECT. Checking for BTN_TOUCH
however can quite easily lead to false positives; it's a code that not only
touchscreen device drivers use.

According to the documentation, touchscreen drivers should have this
property set and in order to make life easy for userspace, let's set it.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

Still, as a paranoia measure, I'd not do a bulk-patchset adding this bit
to every driver here. I'll add it to drivers I know of, by using them
myself or people that report using tslib. Who knows what devices or
usecases exist out there :)


 drivers/input/touchscreen/tsc200x-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 542db26d7fd0..e0fde590df8e 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -531,6 +531,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 
 	input_set_drvdata(input_dev, ts);
 
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
 	input_set_abs_params(input_dev, ABS_X,
-- 
2.11.0

