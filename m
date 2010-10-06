From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
Date: Tue, 5 Oct 2010 23:16:52 -0700
Message-ID: <20101006061652.GA14609@core.coreip.homeip.net>
References: <cover.1285933331.git.viresh.kumar@st.com>
 <584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
 <20101005154737.GA19730@core.coreip.homeip.net>
 <4CABF3E0.8010909@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CABF3E0.8010909-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 06, 2010 at 09:28:24AM +0530, viresh kumar wrote:
> On 10/05/2010 09:17 PM, Dmitry Torokhov wrote:
> > As discussed previously I'd like to see the driver using as much of
> > matrix_keypad infrastructure as practical and also to see the initial
> > keypad copied into the spear_kbd structure to ensure that the board code
> > could be made const and bind/rebind of the device would restore the
> > original keymap.
> > 
> 
> Dmitry,
> 
> As suggested in V1, we have used KEY() macro from matrix_keypad.h file.
> Also we are allocating memory for keymap in driver itself in probe.
> Then we are copying keymap in from plat data. This makes it restore to
> original keymap on every bind/rebind of device.
> 
> Is there anything else we need to do??
> 

Viresh,

Sorry, did not look far enough in the patch and missed the separate
allocation. But do you really want to allocate it separately? I think
the following patch simplifies and speeds up things at the expense of
slightly larger keymap structure.

There are also fixes for proper __devinit/__devexit markups, locking of
open/close vs suspend/resume, keymap can be changed from userspace via
EVIOCSKEYCODE and bunch of other changes.

Thanks.

-- 
Dmitry


Input: spear-kbd - assorted changes

Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
---

 arch/arm/plat-spear/include/plat/keyboard.h |    3 
 drivers/input/keyboard/spear-keyboard.c     |  311 +++++++++++++--------------
 2 files changed, 149 insertions(+), 165 deletions(-)


diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index 29448bc..bc4e5a6 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -130,8 +130,7 @@ int name[] = {\
  * keymaps to drivers that implement keyboards.
  */
 struct kbd_platform_data {
-	int *keymap;
-	unsigned int keymapsize;
+	const struct matrix_keymap_data *keymap;
 	bool rep;
 };
 
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 4830e11..d34bb70 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -1,6 +1,4 @@
 /*
- * drivers/input/keyboard/keyboard-spear.c
- *
  * SPEAr Keyboard Driver
  * Based on omap-keypad driver
  *
@@ -27,7 +25,7 @@
 #include <linux/types.h>
 #include <plat/keyboard.h>
 
-/* Keyboard Regsiters */
+/* Keyboard Registers */
 #define MODE_REG	0x00	/* 16 bit reg */
 #define STATUS_REG	0x0C	/* 2 bit reg */
 #define DATA_REG	0x10	/* 8 bit reg */
@@ -55,60 +53,42 @@
 
 struct spear_kbd {
 	struct input_dev *input;
-	void __iomem *io_base;		/* Keyboard Base Address */
+	struct resource *res;
+	void __iomem *io_base;
 	struct clk *clk;
-	u8 last_key ;
-	u8 last_event;
-	int *keymap;
-	int keymapsize;
+	unsigned int irq;
+	unsigned short last_key;
+	unsigned short keycodes[256];
 };
-/* TODO: Need to optimize this function */
-static inline int get_key_value(struct spear_kbd *dev, int row, int col)
-{
-	int i, key;
-
-	key = KEY(row, col, 0);
-	for (i = 0; i < dev->keymapsize; i++)
-		if ((dev->keymap[i] & KEY_MASK) == key)
-			return dev->keymap[i] & KEY_VALUE;
-	return -ENOKEY;
-}
 
 static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 {
-	struct spear_kbd *dev = dev_id;
-	int key;
-	u8 sts, val = 0;
-
-	sts = readb(dev->io_base + STATUS_REG);
-	if (sts & DATA_AVAIL) {
-		/* following reads active (row, col) pair */
-		val = readb(dev->io_base + DATA_REG);
-		key = get_key_value(dev, (val & ROW_MASK)>>ROW_SHIFT, (val
-					& COLUMN_MASK));
-
-		/* valid key press event */
-		if (key >= 0) {
-			if (dev->last_event == 1) {
-				/* check if we missed a release event */
-				input_report_key(dev->input, dev->last_key,
-						!dev->last_event);
-			}
-			/* notify key press */
-			dev->last_event = 1;
-			dev->last_key = key;
-			input_report_key(dev->input, key, dev->last_event);
-		} else {
-			/* notify key release */
-			dev->last_event = 0;
-			input_report_key(dev->input, dev->last_key,
-					dev->last_event);
-		}
-	} else
+	struct spear_kbd *kbd = dev_id;
+	struct input_dev *input = kbd->input;
+	unsigned int key;
+	u8 sts, val;
+
+	sts = readb(kbd->io_base + STATUS_REG);
+	if (sts & DATA_AVAIL)
 		return IRQ_NONE;
 
+	if (kbd->last_key != KEY_RESERVED) {
+		input_report_key(input, kbd->last_key, 0);
+		kbd->last_key = KEY_RESERVED;
+	}
+
+	/* following reads active (row, col) pair */
+	val = readb(kbd->io_base + DATA_REG);
+	key = kbd->keycodes[val];
+
+	input_event(input, EV_MSC, MSC_SCAN, val);
+	input_report_key(input, key, 1);
+	input_sync(input);
+
+	kbd->last_key = key;
+
 	/* clear interrupt */
-	writeb(0, dev->io_base + STATUS_REG);
+	writeb(0, kbd->io_base + STATUS_REG);
 
 	return IRQ_HANDLED;
 }
@@ -116,8 +96,20 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 static int spear_kbd_open(struct input_dev *dev)
 {
 	struct spear_kbd *kbd = input_get_drvdata(dev);
+	int error;
 	u16 val;
 
+	kbd->last_key = KEY_RESERVED;
+
+	error = clk_enable(kbd->clk);
+	if (error)
+		return error;
+
+	/* program keyboard */
+	val = SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK;
+	writew(val, kbd->io_base + MODE_REG);
+	writeb(1, kbd->io_base + STATUS_REG);
+
 	/* start key scan */
 	val = readw(kbd->io_base + MODE_REG);
 	val |= START_SCAN;
@@ -135,165 +127,148 @@ static void spear_kbd_close(struct input_dev *dev)
 	val = readw(kbd->io_base + MODE_REG);
 	val &= ~START_SCAN;
 	writew(val, kbd->io_base + MODE_REG);
+
+	clk_disable(kbd->clk);
+
+	kbd->last_key = KEY_RESERVED;
 }
 
-static int __init spear_kbd_probe(struct platform_device *pdev)
+static int __devinit spear_kbd_probe(struct platform_device *pdev)
 {
+	const struct kbd_platform_data *pdata = pdev->dev.platform_data;
+	const struct matrix_keymap_data *keymap;
 	struct spear_kbd *kbd;
-	struct kbd_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input_dev;
 	struct resource *res;
-	int i, ret, irq, size;
-	u16 val = 0;
+	int irq;
+	int error;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "Invalid platform data\n");
 		return -EINVAL;
 	}
 
+	keymap = pdata->keymap;
+	if (!keymap) {
+		dev_err(&pdev->dev, "no keymap defined\n");
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no keyboard resource defined\n");
 		return -EBUSY;
 	}
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
-		dev_err(&pdev->dev, "keyboard region already claimed\n");
-		return -EBUSY;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "not able to get irq for the device\n");
+		return irq;
 	}
 
 	kbd = kzalloc(sizeof(*kbd), GFP_KERNEL);
-	if (!kbd) {
+	input_dev = input_allocate_device();
+	if (!kbd || !input_dev) {
 		dev_err(&pdev->dev, "out of memory\n");
-		ret = -ENOMEM;
-		goto err_release_mem_region;
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
-	kbd->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(kbd->clk)) {
-		ret = PTR_ERR(kbd->clk);
-		goto err_kfree;
+	kbd->input = input_dev;
+	kbd->irq = irq;
+	kbd->res = request_mem_region(res->start, resource_size(res),
+				      pdev->name);
+	if (!kbd->res) {
+		dev_err(&pdev->dev, "keyboard region already claimed\n");
+		error = -EBUSY;
+		goto err_free_mem;
 	}
 
-	ret = clk_enable(kbd->clk);
-	if (ret < 0)
-		goto err_clk_put;
-
-	platform_set_drvdata(pdev, kbd);
-	kbd->keymapsize = pdata->keymapsize;
-	size = kbd->keymapsize * sizeof(*pdata->keymap);
-	kbd->keymap = kmalloc(size, GFP_KERNEL);
-	if (!kbd->keymap)
-		goto err_clear_plat_data;
-
-	memcpy(kbd->keymap, pdata->keymap, size);
-
 	kbd->io_base = ioremap(res->start, resource_size(res));
 	if (!kbd->io_base) {
-		dev_err(&pdev->dev, "ioremap fail for kbd_region\n");
-		ret = -ENOMEM;
-		goto err_kfree_keymap;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "not able to get irq for the device\n");
-		ret = irq;
-		goto err_iounmap;
+		dev_err(&pdev->dev, "ioremap failed for kbd_region\n");
+		error = -ENOMEM;
+		goto err_release_mem_region;
 	}
 
-	kbd->input = input_allocate_device();
-	if (!kbd->input) {
-		ret = -ENOMEM;
-		dev_err(&pdev->dev, "input device allocation fail\n");
+	kbd->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(kbd->clk)) {
+		error = PTR_ERR(kbd->clk);
 		goto err_iounmap;
 	}
 
+	input_dev->name = "Spear Keyboard";
+	input_dev->phys = "keyboard/input0";
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->open = spear_kbd_open;
+	input_dev->close = spear_kbd_close;
+
+	__set_bit(EV_KEY, input_dev->evbit);
 	if (pdata->rep)
-		__set_bit(EV_REP, kbd->input->evbit);
-
-	/* setup input device */
-	__set_bit(EV_KEY, kbd->input->evbit);
-
-	for (i = 0; i < kbd->keymapsize; i++)
-		__set_bit(kbd->keymap[i] & KEY_MAX, kbd->input->keybit);
-
-	kbd->input->name = "keyboard";
-	kbd->input->phys = "keyboard/input0";
-	kbd->input->dev.parent = &pdev->dev;
-	kbd->input->id.bustype = BUS_HOST;
-	kbd->input->id.vendor = 0x0001;
-	kbd->input->id.product = 0x0001;
-	kbd->input->id.version = 0x0100;
-	kbd->input->open = spear_kbd_open;
-	kbd->input->close = spear_kbd_close;
-	input_set_drvdata(kbd->input, kbd);
-
-	ret = input_register_device(kbd->input);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to register keyboard device\n");
-		goto err_free_dev;
-	}
+		__set_bit(EV_REP, input_dev->evbit);
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
-	/* program keyboard */
-	val |= SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK;
-	writew(val, kbd->io_base + MODE_REG);
+	input_dev->keycode = kbd->keycodes;
+	input_dev->keycodesize = sizeof(kbd->keycodes[0]);
+	input_dev->keycodemax = ARRAY_SIZE(kbd->keycodes);
 
-	writeb(1, kbd->io_base + STATUS_REG);
+	matrix_keypad_build_keymap(keymap, ROW_SHIFT,
+			input_dev->keycode, input_dev->keybit);
 
-	device_init_wakeup(&pdev->dev, 1);
+	input_set_drvdata(input_dev, kbd);
+
+	/* ensure device is shut off */
+	spear_kbd_close(input_dev);
 
-	ret = request_irq(irq, spear_kbd_interrupt, 0, "keyboard",
-			kbd);
-	if (ret) {
+	error = request_irq(irq, spear_kbd_interrupt, 0, "keyboard", kbd);
+	if (error) {
 		dev_err(&pdev->dev, "request_irq fail\n");
-		goto err_unregister_dev;
+		goto err_put_clk;
+	}
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&pdev->dev, "Unable to register keyboard device\n");
+		goto err_free_irq;
 	}
 
+	device_init_wakeup(&pdev->dev, 1);
+	platform_set_drvdata(pdev, kbd);
+
 	return 0;
 
-err_unregister_dev:
-	input_unregister_device(kbd->input);
-	goto err_iounmap;
-err_free_dev:
-	input_free_device(kbd->input);
+err_free_irq:
+	free_irq(kbd->irq, kbd);
+err_put_clk:
+	clk_put(kbd->clk);
 err_iounmap:
 	iounmap(kbd->io_base);
-err_kfree_keymap:
-	kfree(kbd->keymap);
-err_clear_plat_data:
-	platform_set_drvdata(pdev, NULL);
-	clk_disable(kbd->clk);
-err_clk_put:
-	clk_put(kbd->clk);
-err_kfree:
-	kfree(kbd);
 err_release_mem_region:
 	release_mem_region(res->start, resource_size(res));
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(kbd);
 
-	return ret;
+	return error;
 }
 
-static int spear_kbd_remove(struct platform_device *pdev)
+static int __devexit spear_kbd_remove(struct platform_device *pdev)
 {
 	struct spear_kbd *kbd = platform_get_drvdata(pdev);
-	struct resource *res;
-	int irq;
 
-	irq = platform_get_irq(pdev, 0);
-	free_irq(irq, pdev);
-
-	/* unregister input device */
+	free_irq(kbd->irq, kbd);
 	input_unregister_device(kbd->input);
-
-	iounmap(kbd->io_base);
-	kfree(kbd->keymap);
-	platform_set_drvdata(pdev, NULL);
-	clk_disable(kbd->clk);
 	clk_put(kbd->clk);
+	iounmap(kbd->io_base);
+	release_mem_region(kbd->res->start, resource_size(kbd->res));
 	kfree(kbd);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
+
+	device_init_wakeup(&pdev->dev, 1);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
@@ -303,12 +278,17 @@ static int spear_kbd_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spear_kbd *kbd = platform_get_drvdata(pdev);
-	int irq;
+	struct input_dev *input_dev = kbd->input;
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		clk_enable(kbd->clk);
 
-	irq = platform_get_irq(pdev, 0);
-	clk_disable(kbd->clk);
 	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(irq);
+		enable_irq_wake(kbd->irq);
+
+	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
@@ -317,12 +297,17 @@ static int spear_kbd_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spear_kbd *kbd = platform_get_drvdata(pdev);
-	int irq;
+	struct input_dev *input_dev = kbd->input;
+
+	mutex_lock(&input_dev->mutex);
 
-	irq = platform_get_irq(pdev, 0);
 	if (device_may_wakeup(&pdev->dev))
-		disable_irq_wake(irq);
-	clk_enable(kbd->clk);
+		disable_irq_wake(kbd->irq);
+
+	if (input_dev->users)
+		clk_enable(kbd->clk);
+
+	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
@@ -335,7 +320,7 @@ static const struct dev_pm_ops spear_kbd_pm_ops = {
 
 static struct platform_driver spear_kbd_driver = {
 	.probe		= spear_kbd_probe,
-	.remove		= spear_kbd_remove,
+	.remove		= __devexit_p(spear_kbd_remove),
 	.driver		= {
 		.name	= "keyboard",
 		.owner	= THIS_MODULE,
@@ -345,7 +330,7 @@ static struct platform_driver spear_kbd_driver = {
 	},
 };
 
-static int __devinit spear_kbd_init(void)
+static int __init spear_kbd_init(void)
 {
 	return platform_driver_register(&spear_kbd_driver);
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
