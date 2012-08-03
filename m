From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx51 crashes at gpio_keys_probe
Date: Thu, 2 Aug 2012 22:01:34 -0300
Message-ID: <CAOMZO5DV6yDh95SKAOtb1=tpbnNuztCsiCR+2QzX+KvrPq4FBg@mail.gmail.com>
References: <CAOMZO5D9CZ2=ON2zNxcMa+PW549NE12=aeS522cor67F8Soaww@mail.gmail.com>
	<CAOMZO5C_x=1KhgofYAV9oKYVvCYB_37mBj-wak9rf5VcUODUCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:64010 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab2HCBBf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Aug 2012 21:01:35 -0400
Received: by ghrr11 with SMTP id r11so192478ghr.19
        for <linux-input@vger.kernel.org>; Thu, 02 Aug 2012 18:01:34 -0700 (PDT)
In-Reply-To: <CAOMZO5C_x=1KhgofYAV9oKYVvCYB_37mBj-wak9rf5VcUODUCg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, rob.herring@calxeda.com
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, aletes.xgr@gmail.com

On Thu, Aug 2, 2012 at 8:58 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Aug 2, 2012 at 7:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi,
>>
>> Running today's linux-next on a imx51-babbage board I get the
>> following (with a dt kernel):
>>
>> ...
>> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>> pgd = 80004000
>> [00000004] *pgd=00000000
>> Internal error: Oops: 805 [#1] ARM
>> Modules linked in:
>
> Reverting 30161f6b2e7d1 (Input: gpio_keys - clean up device tree
> parser ) fixes the issue for me.

Ok, the patch below fixes the issue on top of today's linux-next:

---
 drivers/input/keyboard/gpio_keys.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c
b/drivers/input/keyboard/gpio_keys.c
index 6ee68ec..620ef24 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -559,7 +559,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	struct gpio_keys_button *button;
 	int error;
 	int nbuttons;
-	int i;

 	node = dev->of_node;
 	if (!node) {
@@ -580,9 +579,11 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		goto err_out;
 	}

+	pdata->buttons = (struct gpio_keys_button *) (pdata + 1);
+	pdata->nbuttons = nbuttons;
+
 	pdata->rep = !!of_get_property(node, "autorepeat", NULL);

-	i = 0;
 	for_each_child_of_node(node, pp) {
 		enum of_gpio_flags flags;

@@ -592,8 +593,13 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			continue;
 		}

-		button = &pdata->buttons[i++];
-
+		button = pdata->buttons;
+		
+		if (!button)	{
+			error = -ENOMEM;
+			goto err_free_pdata;
+		}
+		
 		button->gpio = of_get_gpio_flags(pp, 0, &flags);
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;

@@ -614,6 +620,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		if (of_property_read_u32(pp, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
+
+		button++;
 	}

 	if (pdata->nbuttons == 0) {
-- 
1.7.1

I based it on the initial dt submission from Shawn:
http://patches.linaro.org/2743/

Please let me know if the patch looks correct and I can send a formal
one to the list.

Thanks,

Fabio Estevam
