From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] input: Add new sun4i-lradc-keys driver
Date: Thu, 18 Dec 2014 09:51:53 -0800
Message-ID: <20141218175153.GA34618@dtor-ws>
References: <1418898193-9160-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBPVIZSSAKGQEH4NZZUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418898193-9160-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Hans,

On Thu, Dec 18, 2014 at 11:23:13AM +0100, Hans de Goede wrote:
> Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
> specifically designed to have various (tablet) keys (ie home, back, search,
> etc). attached to it using a resistor network. This adds a driver for this.
> 
> There are 2 channels, currently this driver only supports chan0 since there
> are no boards known to use chan1.
> 
> This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
> a20-olinuxino-micro.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> --
> Changes in v2:
> -Change devicetree bindings to use a per key subnode, like gpio-keys does
> Changes in v3:
> -Handle keyup irq flag before irqdown, in case we get both at once

Thank you for making changes. Can you please tell me if the driver still
works if you drop the patch below on top of it? The changes are:

- split DT parsing into a separate function;
- make sure keymap is not empty;
- change 'ret' variable to 'error'; 

Thanks!

-- 
Dmitry

Input: sun4i-lradc-keys - misc changes

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/sun4i-lradc-keys.c |   87 +++++++++++++++++++----------
 1 file changed, 57 insertions(+), 30 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 06d5c69..cc8f7dd 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -122,11 +122,11 @@ static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
 static int sun4i_lradc_open(struct input_dev *dev)
 {
 	struct sun4i_lradc_data *lradc = input_get_drvdata(dev);
-	int ret;
+	int error;
 
-	ret = regulator_enable(lradc->vref_supply);
-	if (ret)
-		return ret;
+	error = regulator_enable(lradc->vref_supply);
+	if (error)
+		return error;
 
 	/* lradc Vref internally is divided by 2/3 */
 	lradc->vref = regulator_get_voltage(lradc->vref_supply) * 2 / 3;
@@ -155,42 +155,48 @@ static void sun4i_lradc_close(struct input_dev *dev)
 	regulator_disable(lradc->vref_supply);
 }
 
-static int sun4i_lradc_probe(struct platform_device *pdev)
+static int sun4i_lradc_load_dt_keymap(struct device *dev,
+				      struct sun4i_lradc_data *lradc)
 {
-	struct sun4i_lradc_data *lradc;
-	struct device *dev = &pdev->dev;
-	struct device_node *pp, *np = dev->of_node;
-	u32 channel;
-	int i, ret;
+	struct device_node *np, *pp;
+	int i;
+	int error;
 
-	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
-	if (!lradc)
-		return -ENOMEM;
+	np = dev->of_node;
+	if (!np)
+		return -EINVAL;
 
 	lradc->chan0_map_count = of_get_child_count(np);
-	lradc->chan0_map = devm_kmalloc(dev, lradc->chan0_map_count *
-				sizeof(struct sun4i_lradc_keymap), GFP_KERNEL);
+	if (lradc->chan0_map_count == 0) {
+		dev_err(dev, "keymap is missing in device tree\n");
+		return -EINVAL;
+	}
+
+	lradc->chan0_map = devm_kmalloc_array(dev, lradc->chan0_map_count,
+					      sizeof(struct sun4i_lradc_keymap),
+					      GFP_KERNEL);
 	if (!lradc->chan0_map)
 		return -ENOMEM;
 
 	i = 0;
 	for_each_child_of_node(np, pp) {
 		struct sun4i_lradc_keymap *map = &lradc->chan0_map[i];
+		u32 channel;
 
-		ret = of_property_read_u32(pp, "channel", &channel);
-		if (ret || channel != 0) {
+		error = of_property_read_u32(pp, "channel", &channel);
+		if (error || channel != 0) {
 			dev_err(dev, "%s: Inval channel prop\n", pp->name);
 			return -EINVAL;
 		}
 
-		ret = of_property_read_u32(pp, "voltage", &map->voltage);
-		if (ret) {
+		error = of_property_read_u32(pp, "voltage", &map->voltage);
+		if (error) {
 			dev_err(dev, "%s: Inval voltage prop\n", pp->name);
 			return -EINVAL;
 		}
 
-		ret = of_property_read_u32(pp, "linux,code", &map->keycode);
-		if (ret) {
+		error = of_property_read_u32(pp, "linux,code", &map->keycode);
+		if (error) {
 			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
 			return -EINVAL;
 		}
@@ -198,6 +204,24 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 		i++;
 	}
 
+	return 0;
+}
+
+static int sun4i_lradc_probe(struct platform_device *pdev)
+{
+	struct sun4i_lradc_data *lradc;
+	struct device *dev = &pdev->dev;
+	int i;
+	int error;
+
+	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
+	if (!lradc)
+		return -ENOMEM;
+
+	error = sun4i_lradc_load_dt_keymap(dev, lradc);
+	if (error)
+		return error;
+
 	lradc->vref_supply = devm_regulator_get(dev, "vref");
 	if (IS_ERR(lradc->vref_supply))
 		return PTR_ERR(lradc->vref_supply);
@@ -215,9 +239,11 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	lradc->input->id.vendor = 0x0001;
 	lradc->input->id.product = 0x0001;
 	lradc->input->id.version = 0x0100;
-	lradc->input->evbit[0] =  BIT(EV_SYN) | BIT(EV_KEY);
+
+	__set_bit(EV_KEY, lradc->input->evbit);
 	for (i = 0; i < lradc->chan0_map_count; i++)
-		set_bit(lradc->chan0_map[i].keycode, lradc->input->keybit);
+		__set_bit(lradc->chan0_map[i].keycode, lradc->input->keybit);
+
 	input_set_drvdata(lradc->input, lradc);
 
 	lradc->base = devm_ioremap_resource(dev,
@@ -225,14 +251,15 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	ret = devm_request_irq(dev, platform_get_irq(pdev, 0), sun4i_lradc_irq,
-			       0, "sun4i-a10-lradc-keys", lradc);
-	if (ret)
-		return ret;
+	error = devm_request_irq(dev, platform_get_irq(pdev, 0),
+				 sun4i_lradc_irq, 0,
+				 "sun4i-a10-lradc-keys", lradc);
+	if (error)
+		return error;
 
-	ret = input_register_device(lradc->input);
-	if (ret)
-		return ret;
+	error = input_register_device(lradc->input);
+	if (error)
+		return error;
 
 	platform_set_drvdata(pdev, lradc);
 	return 0;
