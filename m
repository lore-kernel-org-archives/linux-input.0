From: Robert Gerlach <khnz@gmx.de>
Subject: Re: [PATCH v2] driver for the "Fujitsu Tablet PC Buttons" device
Date: Mon, 23 Nov 2009 01:03:08 +0100
Message-ID: <200911230103.08281.khnz@gmx.de>
References: <200911041928.38275.khnz@gmx.de> <20091111085504.GE22141@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755861AbZKWADF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Nov 2009 19:03:05 -0500
In-Reply-To: <20091111085504.GE22141@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dmitry,

On Wednesday 11 November 2009 09:55:04 Dmitry Torokhov wrote:
> On Wed, Nov 04, 2009 at 07:28:38PM +0100, Robert Gerlach wrote:
> > This is a driver for the tablet buttons and the tablet mode switch of
> > many Fujitsu tablet PCs. The driver is based on reverse-engineering of
> > the Windows driver, I have no specification for this device.
> >
> > v2: small cleanup requested by GregKH
> 
> I wonder if this driver should go into drivers/platform/x86 with the rest
> of ACPIish laptop drivers.

Okay, looks like a better place. I think I'll rename the module to fujitsu-
tablet because this device is only present on tablets and tablet laptops 
(AFAIK).

> Still, below some comments from input POV:
>
> > +
> > +#define REPEAT_RATE 16
> > +#define REPEAT_DELAY 700
> > +#define STICKY_TIMEOUT 1400	/* msec */
> > +
> > +#include <linux/kernel.h>
> 
> Defines are usually go after #includes
> 
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/version.h>
> > +#include <linux/dmi.h>
> > +#include <linux/bitops.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/acpi.h>
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/time.h>
> > +#include <linux/timer.h>
> > +#include <linux/delay.h>
> > +#include <linux/jiffies.h>
> > +
> > +#define MODULENAME "fsc_btns"
> > +
> > +MODULE_AUTHOR("Robert Gerlach <khnz@users.sourceforge.net>");
> > +MODULE_DESCRIPTION("Fujitsu Siemens tablet button driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_VERSION("2.1.0");
> > +
> > +static const struct acpi_device_id fscbtns_ids[] = {
> > +	{ .id = "FUJ02BD" },
> > +	{ .id = "FUJ02BF" },
> > +	{ .id = "" }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fscbtns_ids);
> > +
> > +struct fscbtns_config {
> > +	int invert_orientation_bit;
> > +	unsigned int keymap[16];
> > +};
> > +
> > +static struct fscbtns_config config_Lifebook_Tseries __initdata = {
> > +	.invert_orientation_bit = 1,
> > +	.keymap = {
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_SCROLLDOWN,
> > +		KEY_SCROLLUP,
> > +		KEY_DIRECTION,
> > +		KEY_LEFTCTRL,
> > +		KEY_BRIGHTNESSUP,
> > +		KEY_BRIGHTNESSDOWN,
> > +		KEY_BRIGHTNESS_ZERO,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_LEFTALT
> > +	}
> > +};
> > +
> > +static struct fscbtns_config config_Lifebook_U810 __initdata = {
> > +	.invert_orientation_bit = 1,
> > +	.keymap = {
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_PROG1,
> > +		KEY_PROG2,
> > +		KEY_DIRECTION,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_UP,
> > +		KEY_DOWN,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_FN,
> > +		KEY_SLEEP
> > +	}
> > +};
> > +
> > +static struct fscbtns_config config_Stylistic_Tseries __initdata = {
> > +	.invert_orientation_bit = 0,
> > +	.keymap = {
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_PRINT,
> > +		KEY_BACKSPACE,
> > +		KEY_SPACE,
> > +		KEY_ENTER,
> > +		KEY_BRIGHTNESSUP,
> > +		KEY_BRIGHTNESSDOWN,
> > +		KEY_DOWN,
> > +		KEY_UP,
> > +		KEY_SCROLLUP,
> > +		KEY_SCROLLDOWN,
> > +		KEY_FN
> > +	}
> > +};
> > +
> > +static struct fscbtns_config config_Stylistic_ST5xxx __initdata = {
> > +	.invert_orientation_bit = 0,
> > +	.keymap = {
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_RESERVED,
> > +		KEY_MAIL,
> > +		KEY_DIRECTION,
> > +		KEY_ESC,
> > +		KEY_ENTER,
> > +		KEY_BRIGHTNESSUP,
> > +		KEY_BRIGHTNESSDOWN,
> > +		KEY_DOWN,
> > +		KEY_UP,
> > +		KEY_SCROLLUP,
> > +		KEY_SCROLLDOWN,
> > +		KEY_FN,
> > +		KEY_LEFTALT
> > +	}
> > +};
> > +
> > +static const unsigned long modification_mask[BITS_TO_LONGS(KEY_MAX)] = {
> > +		[BIT_WORD(KEY_LEFTSHIFT)]	= BIT_MASK(KEY_LEFTSHIFT),
> > +		[BIT_WORD(KEY_RIGHTSHIFT)]	= BIT_MASK(KEY_RIGHTSHIFT),
> > +		[BIT_WORD(KEY_LEFTCTRL)]	= BIT_MASK(KEY_LEFTCTRL),
> > +		[BIT_WORD(KEY_RIGHTCTRL)]	= BIT_MASK(KEY_RIGHTCTRL),
> > +		[BIT_WORD(KEY_LEFTALT)]		= BIT_MASK(KEY_LEFTALT),
> > +		[BIT_WORD(KEY_RIGHTALT)]	= BIT_MASK(KEY_RIGHTALT),
> > +		[BIT_WORD(KEY_LEFTMETA)]	= BIT_MASK(KEY_LEFTMETA),
> > +		[BIT_WORD(KEY_RIGHTMETA)]	= BIT_MASK(KEY_RIGHTMETA),
> > +		[BIT_WORD(KEY_COMPOSE)]		= BIT_MASK(KEY_COMPOSE),
> > +		[BIT_WORD(KEY_LEFTALT)]		= BIT_MASK(KEY_LEFTALT),
> > +		[BIT_WORD(KEY_FN)]		= BIT_MASK(KEY_FN)};
> > +
> > +static struct {						/* fscbtns_t */
> > +	struct platform_device *pdev;
> > +	struct input_dev *idev_b;		/* tablet buttons */
> > +	struct input_dev *idev_s;		/* orientation switch */
> 
> Do we really need 2 separate devices?

Yes, evdev grabs the device and then hal can't read the switch state.

> > +	struct timer_list timer;		/* timer for sicky keys */
> > +
> > +	unsigned int interrupt;
> > +	unsigned int address;
> > +	struct fscbtns_config config;
> > +
> > +	int orientation;
> > +} fscbtns;
> > +
> > +
> > +/*** HELPER
> > *******************************************************************/
> > +
> > +static inline u8 fscbtns_ack(void)
> > +{
> > +	return inb(fscbtns.address+2);
> > +}
> > +
> > +static inline u8 fscbtns_status(void)
> > +{
> > +	return inb(fscbtns.address+6);
> > +}
> > +
> > +static inline u8 fscbtns_read_register(const u8 addr)
> > +{
> > +	outb(addr, fscbtns.address);
> > +	return inb(fscbtns.address+4);
> > +}
> > +
> > +static inline void fscbtns_use_config(struct fscbtns_config *config)
> > +{
> > +	memcpy(&fscbtns.config, config, sizeof(struct fscbtns_config));
> > +}
> > +
> > +
> > +/*** INPUT
> > ********************************************************************/
> > +
> > +static int __devinit input_fscbtns_setup_buttons(struct device *dev)
> > +{
> > +	struct input_dev *idev;
> > +	int error;
> > +	int x;
> > +
> > +	idev = input_allocate_device();
> > +	if (!idev)
> > +		return -ENOMEM;
> > +
> > +	idev->dev.parent = dev;
> > +	idev->phys = "fsc/input0";
> > +	idev->name = "fsc tablet buttons";
> > +	idev->id.bustype = BUS_HOST;
> > +	idev->id.vendor  = 0x1734;
> > +	idev->id.product = 0x0001;
> > +	idev->id.version = 0x0101;
> > +
> > +	idev->keycode = fscbtns.config.keymap;
> > +	idev->keycodesize = sizeof(unsigned int);
> 
> sizeof(fscbtns.config.keymap[0]) is safer. Make it unsigned short btw.
> 
> > +	idev->keycodemax = sizeof(fscbtns.config.keymap) / idev->keycodesize;
> 
> ARRAY_SIZE();
> 
> > +
> > +	set_bit(EV_REP, idev->evbit);
> > +	set_bit(EV_KEY, idev->evbit);
> 
> __set_bit() - no need for locked operations here.
> 
> > +
> > +	for (x = 0; x < idev->keycodemax; x++)
> > +		if (((unsigned int *)idev->keycode)[x])
> > +			set_bit(((unsigned int *)idev->keycode)[x],
> > +					idev->keybit);
> 
> Just operate on fscbtns.config.keymap to avoid much casting.
> 
> > +
> > +	set_bit(EV_MSC, idev->evbit);
> > +	set_bit(MSC_SCAN, idev->mscbit);
> > +
> > +	error = input_register_device(idev);
> > +	if (error) {
> > +		input_free_device(idev);
> > +		return error;
> > +	}
> > +
> > +	idev->rep[REP_DELAY]  = REPEAT_DELAY;
> > +	idev->rep[REP_PERIOD] = 1000 / REPEAT_RATE;
> > +
> > +	fscbtns.idev_b = idev;
> > +	return 0;
> > +}
> > +
> > +static int __devinit input_fscbtns_setup_switch(struct device *dev)
> > +{
> > +	struct input_dev *idev;
> > +	int error;
> > +
> > +	idev = input_allocate_device();
> > +	if (!idev)
> > +		return -ENOMEM;
> > +
> > +	idev->dev.parent = dev;
> > +	idev->phys = "fsc/input1";
> > +	idev->name = "fsc tablet switch";
> > +	idev->id.bustype = BUS_HOST;
> > +	idev->id.vendor  = 0x1734;
> > +	idev->id.product = 0x0002;
> > +	idev->id.version = 0x0101;
> > +
> > +	set_bit(EV_SW, idev->evbit);
> > +	set_bit(SW_TABLET_MODE, idev->swbit);
> > +
> > +	error = input_register_device(idev);
> > +	if (error) {
> > +		input_free_device(idev);
> > +		return error;
> > +	}
> > +
> > +	fscbtns.idev_s = idev;
> > +	return 0;
> > +}
> > +
> > +static void input_fscbtns_remove(void)
> > +{
> > +	if (fscbtns.idev_b)
> > +		input_unregister_device(fscbtns.idev_b);
> > +	if (fscbtns.idev_s)
> > +		input_unregister_device(fscbtns.idev_s);
> > +}
> > +
> > +static void fscbtns_report_orientation(void)
> > +{
> > +	int orientation = fscbtns_read_register(0xdd);
> > +
> > +	if (orientation & 0x02) {
> > +		orientation ^= fscbtns.config.invert_orientation_bit;
> > +		orientation &= 0x01;
> > +
> > +		if (orientation != fscbtns.orientation) {
> > +			input_report_switch(fscbtns.idev_s, SW_TABLET_MODE,
> > +					fscbtns.orientation = orientation);
> > +			input_sync(fscbtns.idev_s);
> > +		}
> > +	}
> > +}
> > +
> > +static void fscbtns_sticky_timeout(unsigned long keycode)
> > +{
> > +	input_report_key(fscbtns.idev_b, keycode, 0);
> > +	input_sync(fscbtns.idev_b);
> > +	fscbtns.timer.data = 0;
> > +}
> > +
> > +static inline int fscbtns_sticky_report_key(unsigned int keycode, int
> > pressed)
> > +{
> > +	if (pressed) {
> > +		del_timer(&fscbtns.timer);
> > +		fscbtns.timer.expires = jiffies + (STICKY_TIMEOUT*HZ)/1000;
> > +
> > +		if (fscbtns.timer.data == keycode) {
> > +			input_report_key(fscbtns.idev_b, keycode, 0);
> > +			input_sync(fscbtns.idev_b);
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	if ((fscbtns.timer.data) && (fscbtns.timer.data != keycode)) {
> > +		input_report_key(fscbtns.idev_b, keycode, 0);
> > +		input_sync(fscbtns.idev_b);
> > +		input_report_key(fscbtns.idev_b, fscbtns.timer.data, 0);
> > +		fscbtns.timer.data = 0;
> > +		return 1;
> > +	}
> > +
> > +	if (test_bit(keycode, modification_mask) &&
> > +			(fscbtns.timer.expires > jiffies)) {
> > +		fscbtns.timer.data = keycode;
> > +		fscbtns.timer.function = fscbtns_sticky_timeout;
> > +		add_timer(&fscbtns.timer);
> 
> I wonder if you should keep last keycode in the driver data and set up
> the timer once and use mod_timer() here.

I'll rework it.

> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void fscbtns_report_key(unsigned int kmindex, int pressed)
> > +{
> > +	unsigned int keycode = fscbtns.config.keymap[kmindex];
> > +	if (keycode == KEY_RESERVED)
> > +		return;
> > +
> > +	if (pressed)
> > +		input_event(fscbtns.idev_b, EV_MSC, MSC_SCAN, kmindex);
> > +
> > +	if (fscbtns_sticky_report_key(keycode, pressed))
> > +		return;
> > +
> > +	input_report_key(fscbtns.idev_b, keycode, pressed);
> > +	input_sync(fscbtns.idev_b);
> > +}
> > +
> > +static void fscbtns_event(void)
> > +{
> > +	unsigned long keymask;
> > +	unsigned long changed;
> > +	static unsigned long prev_keymask;
> > +
> > +	fscbtns_report_orientation();
> > +
> > +	keymask  = fscbtns_read_register(0xde);
> > +	keymask |= fscbtns_read_register(0xdf) << 8;
> > +	keymask ^= 0xffff;
> > +
> > +	changed = keymask ^ prev_keymask;
> > +
> > +	if (changed) {
> > +		int x = 0;
> > +		int pressed = !!(keymask & changed);
> > +
> > +		/* save current state and filter not changed bits */
> > +		prev_keymask = keymask;
> > +
> > +		/* get number of changed bit */
> > +		while (!test_bit(x, &changed))
> > +			x++;
> > +
> > +		fscbtns_report_key(x, pressed);
> > +	}
> > +}
> > +
> > +
> > +/*** INTERRUPT
> > ****************************************************************/
> > +
> > +static void fscbtns_isr_do(struct work_struct *work)
> > +{
> > +	fscbtns_event();
> > +	fscbtns_ack();
> > +}
> > +
> > +static DECLARE_WORK(isr_wq, fscbtns_isr_do);
> > +
> > +static irqreturn_t fscbtns_isr(int irq, void *dev_id)
> > +{
> > +	if (!(fscbtns_status() & 0x01))
> > +		return IRQ_NONE;
> > +
> > +	schedule_work(&isr_wq);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +
> > +/*** DEVICE
> > *******************************************************************/
> > +
> > +static int fscbtns_busywait(void)
> > +{
> > +	int timeout_counter = 100;
> > +
> > +	while (fscbtns_status() & 0x02 && --timeout_counter)
> > +		msleep(10);
> > +
> > +	return !timeout_counter;
> > +}
> > +
> > +static void fscbtns_reset(void)
> > +{
> > +	fscbtns_ack();
> > +	if (fscbtns_busywait())
> > +		printk(KERN_WARNING MODULENAME ": timeout, reset needed!\n");
> > +}
> > +
> > +static int __devinit fscbtns_probe(struct platform_device *pdev)
> > +{
> > +	int error;
> > +
> > +	error = input_fscbtns_setup_buttons(&pdev->dev);
> > +	if (error)
> > +		goto err_input;
> > +
> > +	error = input_fscbtns_setup_switch(&pdev->dev);
> > +	if (error)
> > +		goto err_input;
> > +
> > +	if (!request_region(fscbtns.address, 8, MODULENAME)) {
> > +		printk(KERN_ERR MODULENAME ": region 0x%04x busy\n",
> > +				fscbtns.address);
> > +		error = -EBUSY;
> > +		goto err_input;
> > +	}
> > +
> > +	fscbtns_reset();
> > +
> > +	fscbtns_report_orientation();
> > +	input_sync(fscbtns.idev_b);
> > +
> > +	error = request_irq(fscbtns.interrupt, fscbtns_isr,
> > +			IRQF_SHARED, MODULENAME, fscbtns_isr);
> > +	if (error) {
> > +		printk(KERN_ERR MODULENAME ": unable to get irq %d\n",
> > +				fscbtns.interrupt);
> > +		goto err_io;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_io:
> > +	release_region(fscbtns.address, 8);
> > +err_input:
> > +	input_fscbtns_remove();
> > +	return error;
> > +}
> > +
> > +static int __devexit fscbtns_remove(struct platform_device *pdev)
> > +{
> > +	free_irq(fscbtns.interrupt, fscbtns_isr);
> > +	release_region(fscbtns.address, 8);
> > +	input_fscbtns_remove();
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int fscbtns_resume(struct platform_device *pdev)
> > +{
> > +	fscbtns_reset();
> > +#if 0 /* because Xorg Bug #9623 */
> > +	fscbtns_report_orientation();
> > +#endif
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static struct platform_driver fscbtns_platform_driver = {
> > +	.driver		= {
> > +		.name	= MODULENAME,
> > +		.owner	= THIS_MODULE,
> > +	},
> > +	.probe		= fscbtns_probe,
> > +	.remove		= __devexit_p(fscbtns_remove),
> > +#ifdef CONFIG_PM
> > +	.resume		= fscbtns_resume,
> > +#endif
> > +};
> > +
> > +
> > +/*** ACPI
> > *********************************************************************/
> > +
> > +static acpi_status fscbtns_walk_resources(struct acpi_resource *res,
> > void *data)
> > +{
> > +	switch (res->type) {
> > +	case ACPI_RESOURCE_TYPE_IRQ:
> > +		fscbtns.interrupt = res->data.irq.interrupts[0];
> > +		return AE_OK;
> > +
> > +	case ACPI_RESOURCE_TYPE_IO:
> > +		fscbtns.address = res->data.io.minimum;
> > +		return AE_OK;
> > +
> > +	case ACPI_RESOURCE_TYPE_END_TAG:
> > +		if (fscbtns.interrupt && fscbtns.address)
> > +			return AE_OK;
> > +		else
> > +			return AE_NOT_FOUND;
> > +
> > +	default:
> > +		return AE_ERROR;
> > +	}
> > +}
> > +
> > +static int acpi_fscbtns_add(struct acpi_device *adev)
> > +{
> > +	acpi_status status;
> > +
> > +	if (!adev)
> > +		return -EINVAL;
> > +
> > +	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> > +			fscbtns_walk_resources, NULL);
> > +	if (ACPI_FAILURE(status))
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct acpi_driver acpi_fscbtns_driver = {
> > +	.name  = MODULENAME,
> > +	.class = "hotkey",
> > +	.ids   = fscbtns_ids,
> > +	.ops   = {
> > +		.add    = acpi_fscbtns_add
> > +	}
> > +};
> > +
> > +
> > +/*** DMI
> > **********************************************************************/
> > +
> > +static int __init fscbtns_dmi_matched(const struct dmi_system_id *dmi)
> > +{
> > +	printk(KERN_INFO MODULENAME ": found: %s\n", dmi->ident);
> > +	fscbtns_use_config(dmi->driver_data);
> > +	return 1;
> > +}
> > +
> > +static struct dmi_system_id dmi_ids[] __initdata = {
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Fujitsu Siemens P/T Series",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK")
> > +		},
> > +		.driver_data = &config_Lifebook_Tseries
> > +	},
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Fujitsu Lifebook T Series",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook T")
> > +		},
> > +		.driver_data = &config_Lifebook_Tseries
> > +	},
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Fujitsu Siemens Stylistic T Series",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Stylistic T")
> > +		},
> > +		.driver_data = &config_Stylistic_Tseries
> > +	},
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Fujitsu LifeBook U810",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook U810")
> > +		},
> > +		.driver_data = &config_Lifebook_U810
> > +	},
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Fujitsu Siemens Stylistic ST5xxx Series",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "STYLISTIC ST5")
> > +		},
> > +		.driver_data = &config_Stylistic_ST5xxx
> > +	},
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Fujitsu Siemens Stylistic ST5xxx Series",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Stylistic ST5")
> > +		},
> > +		.driver_data = &config_Stylistic_ST5xxx
> > +	},
> > +	{
> > +		.callback = fscbtns_dmi_matched,
> > +		.ident = "Unknown (using defaults)",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, ""),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "")
> > +		},
> > +		.driver_data = &config_Lifebook_Tseries
> > +	},
> > +	{ NULL }
> > +};
> > +
> > +
> > +/*** MODULE
> > *******************************************************************/
> > +
> > +static int __init fscbtns_module_init(void)
> > +{
> > +	int error;
> > +
> > +	dmi_check_system(dmi_ids);
> > +
> > +	error = acpi_bus_register_driver(&acpi_fscbtns_driver);
> > +	if (ACPI_FAILURE(error))
> > +		return -EINVAL;
> > +
> > +	if (!fscbtns.interrupt || !fscbtns.address)
> 
> You need to unregister acpi driver here.
> 
> > +		return -ENODEV;
> > +
> > +	init_timer(&fscbtns.timer);
> > +
> > +	error = platform_driver_register(&fscbtns_platform_driver);
> > +	if (error)
> > +		goto err;
> > +
> > +	fscbtns.pdev = platform_device_alloc(MODULENAME, -1);
> > +	if (!fscbtns.pdev) {
> > +		error = -ENOMEM;
> > +		goto err_pdrv;
> > +	}
> > +
> > +	error = platform_device_add(fscbtns.pdev);
> 
> This should be platform_device_register().
> 
> > +	if (error)
> > +		goto err_pdev;
> > +
> > +	return 0;
> > +
> > +err_pdev:
> > +	platform_device_put(fscbtns.pdev);
> > +err_pdrv:
> > +	platform_driver_unregister(&fscbtns_platform_driver);
> > +err:
> > +	acpi_bus_unregister_driver(&acpi_fscbtns_driver);
> > +
> > +	del_timer_sync(&fscbtns.timer);
> > +
> > +	return error;
> > +}
> > +
> > +static void __exit fscbtns_module_exit(void)
> > +{
> > +	platform_device_unregister(fscbtns.pdev);
> > +	platform_driver_unregister(&fscbtns_platform_driver);
> > +	acpi_bus_unregister_driver(&acpi_fscbtns_driver);
> > +
> > +	del_timer_sync(&fscbtns.timer);
> 
> Isn't this too late?
> 
> > +}
> > +
> > +module_init(fscbtns_module_init);
> > +module_exit(fscbtns_module_exit);
> 

Many thank for all the comments. I'll create a new patch.

  Robert
