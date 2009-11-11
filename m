From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: keyboard leds not restored after s2ram in
	2.6.32-rc6-00166-g799dd75
Date: Wed, 11 Nov 2009 01:52:19 -0800
Message-ID: <20091111095218.GA3654@core.coreip.homeip.net>
References: <761296.29412.qm@web58402.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:58826 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbZKKJwS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 04:52:18 -0500
Content-Disposition: inline
In-Reply-To: <761296.29412.qm@web58402.mail.re3.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mikko,

On Tue, Nov 10, 2009 at 09:27:40AM -0800, Mikko Vinni wrote:
> Hi,
> 
> my laptop shows the caps lock and scroll lock leds as being on after s2ram
> (and resume), even though they are off. If I press the caps lock key, the caps
> lock led stays on, the num lock led turns off, and the screen unlock screen
> warns about the caps lock being on.
> 

Thank you for the report. Could youplease tell me if the patch below
fixes the problem?

Thanks!

-- 
Dmitry


Input: force LED reset on resume

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We should be sending EV_LED event down to drivers upon resume even in cases
when in-kernel state of the LED is off since device could come up with some
leds turned on.

Reported-by: Mikko Vinni <mmvinni@yahoo.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)


diff --git a/drivers/input/input.c b/drivers/input/input.c
index 61069b2..77b6efe 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1298,17 +1298,24 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#define INPUT_DO_TOGGLE(dev, type, bits, on)			\
-	do {							\
-		int i;						\
-		if (!test_bit(EV_##type, dev->evbit))		\
-			break;					\
-		for (i = 0; i < type##_MAX; i++) {		\
-			if (!test_bit(i, dev->bits##bit) ||	\
-			    !test_bit(i, dev->bits))		\
-				continue;			\
-			dev->event(dev, EV_##type, i, on);	\
-		}						\
+#define INPUT_DO_TOGGLE(dev, type, bits, on)				\
+	do {								\
+		int i;							\
+		bool active;						\
+									\
+		if (!test_bit(EV_##type, dev->evbit))			\
+			break;						\
+									\
+		for (i = 0; i < type##_MAX; i++) {			\
+			if (!test_bit(i, dev->bits##bit))		\
+				continue;				\
+									\
+			active = test_bit(i, dev->bits);		\
+			if (!active && !on)				\
+				continue;				\
+									\
+			dev->event(dev, EV_##type, i, on ? active : 0);	\
+		}							\
 	} while (0)
 
 #ifdef CONFIG_PM
