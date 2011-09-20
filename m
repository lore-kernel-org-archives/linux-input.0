From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: gpio_keys - Use of_property_read_u32
Date: Mon, 19 Sep 2011 23:26:04 -0700
Message-ID: <20110920062604.GA26576@core.coreip.homeip.net>
References: <1314775945-6822-1-git-send-email-tklauser@distanz.ch>
 <1316423391-20219-1-git-send-email-tklauser@distanz.ch>
 <20110920112627.41b180e05dc6717beee0f5e8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43247 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab1ITG0K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 02:26:10 -0400
Received: by ywb5 with SMTP id 5so118359ywb.19
        for <linux-input@vger.kernel.org>; Mon, 19 Sep 2011 23:26:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110920112627.41b180e05dc6717beee0f5e8@canb.auug.org.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tobias Klauser <tklauser@distanz.ch>, linux-input@vger.kernel.org

On Tue, Sep 20, 2011 at 11:26:27AM +1000, Stephen Rothwell wrote:
> Hi Tobias,
> 
> On Mon, 19 Sep 2011 11:09:51 +0200 Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > Use the of_property_read_u32 helper function to retreive u32 values
> > from the device tree. Also do not pass the len parameter to
> > of_get_property if it isn't checked afterwards.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> > v2: Fix build failure caused by a missing opening brace (reported by
> >     Stephen Rothwell)
> 
> Sure, but it will still generate all the warnings I reported as "reg" is
> the wrong type now.
> 
> drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_get_devtree_pdata':
> drivers/input/keyboard/gpio_keys.c:500:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> drivers/input/keyboard/gpio_keys.c:504:19: warning: assignment makes integer from pointer without a cast
> drivers/input/keyboard/gpio_keys.c:508:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> drivers/input/keyboard/gpio_keys.c:509:20: warning: assignment makes integer from pointer without a cast
> drivers/input/keyboard/gpio_keys.c:515:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> drivers/input/keyboard/gpio_keys.c:516:33: warning: assignment makes integer from pointer without a cast
> 

I think the following shoudl fix it, I am going to fold it into original
path.

Thanks.

-- 
Dmitry

Input: gpio-keys - fix compile issues

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/gpio_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e913294..ed1ed46 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -461,7 +461,7 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 	struct device_node *node, *pp;
 	int i;
 	struct gpio_keys_button *buttons;
-	const u32 *reg;
+	u32 reg;
 
 	node = dev->of_node;
 	if (node == NULL)
@@ -497,7 +497,7 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 		buttons[i].gpio = of_get_gpio_flags(pp, 0, &flags);
 		buttons[i].active_low = flags & OF_GPIO_ACTIVE_LOW;
 
-		if (of_property_read_u32(pp, "linux,code", &reg))
+		if (of_property_read_u32(pp, "linux,code", &reg)) {
 			dev_err(dev, "Button without keycode: 0x%x\n", buttons[i].gpio);
 			goto out_fail;
 		}
