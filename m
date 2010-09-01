From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 21/74] ST SPEAr : Added keyboard support
Date: Tue, 31 Aug 2010 23:31:59 -0700
Message-ID: <20100901063158.GF23585@core.coreip.homeip.net>
References: <cover.1283161023.git.viresh.kumar@st.com>
 <b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com>
 <20100830164825.GA28186@core.coreip.homeip.net>
 <4C7DE35F.9080103@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37005 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0IAGcG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 02:32:06 -0400
Received: by pzk9 with SMTP id 9so2721525pzk.19
        for <linux-input@vger.kernel.org>; Tue, 31 Aug 2010 23:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C7DE35F.9080103@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Armando VISCONTI <armando.visconti@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>

On Wed, Sep 01, 2010 at 10:53:43AM +0530, rajeev wrote:
> Hi Dmitry 
> 
> Please find my answers embedded below.
> 
> On 8/30/2010 10:18 PM, Dmitry Torokhov wrote:
> > Hi Rajeev,
> > 
> 
> [snip...]
> 
> > 
> > First of all, please split platform modifications from the driver itself
> > (as I care about the latter but less about the former).
> >
> 
> Will be done.
>  
> >> diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
> >> index 9252940..c48b779 100644
> 
> [snip...]
> 
> >> +++ b/arch/arm/plat-spear/include/plat/keyboard.h
> >> @@ -0,0 +1,154 @@
> >> +/*
> >> + * arch/arm/plat-spear/include/plat/keyboard.h
> >> + *
> >> + * Copyright (C) 2010 ST Microelectronics
> >> + * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> >> + *
> >> + * This file is licensed under the terms of the GNU General Public
> >> + * License version 2. This program is licensed "as is" without any
> >> + * warranty of any kind, whether express or implied.
> >> + */
> >> +
> >> +#ifndef __PLAT_KEYBOARD_H
> >> +#define __PLAT_KEYBOARD_H
> >> +
> >> +#include <linux/bitops.h>
> >> +#include <linux/input.h>
> >> +#include <mach/misc_regs.h>
> >> +
> >> +#define KEY(row, col, val) (((row) << 28 | ((col) << 24) | (val)))
> >> +
> > 
> > Please use definitions from include/linux/input/matrix_keypad.h
> > 
> 
> Ok. I will check it and modify.
> 
> >> +#define DECLARE_KEYMAP(name) \
> >> +int name[] = {\
> >> +     KEY(0, 0, KEY_ESC), \
> >> +     KEY(0, 1, KEY_1), \
> >> +     KEY(0, 2, KEY_2), \
> >> +     KEY(0, 3, KEY_3), \
> >> +     KEY(0, 4, KEY_4), \
> >> +     KEY(0, 5, KEY_5), \
> >> +     KEY(0, 6, KEY_6), \
> >> +     KEY(0, 7, KEY_7), \
> >> +     KEY(0, 8, KEY_8), \
> >> +     KEY(1, 0, KEY_9), \
> >> +     KEY(1, 1, KEY_MINUS), \
> >> +     KEY(1, 2, KEY_EQUAL), \
> >> +     KEY(1, 3, KEY_BACKSPACE), \
> >> +     KEY(1, 4, KEY_TAB), \
> >> +     KEY(1, 5, KEY_Q), \
> >> +     KEY(1, 6, KEY_W), \
> >> +     KEY(1, 7, KEY_E), \
> >> +     KEY(1, 8, KEY_R), \
> >> +     KEY(2, 0, KEY_T), \
> >> +     KEY(2, 1, KEY_Y), \
> >> +     KEY(2, 2, KEY_U), \
> >> +     KEY(2, 3, KEY_I), \
> >> +     KEY(2, 4, KEY_O), \
> >> +     KEY(2, 5, KEY_P), \
> >> +     KEY(2, 6, KEY_LEFTBRACE), \
> >> +     KEY(2, 7, KEY_RIGHTBRACE), \
> >> +     KEY(2, 8, KEY_ENTER), \
> >> +     KEY(3, 0, KEY_LEFTCTRL), \
> >> +     KEY(3, 1, KEY_A), \
> >> +     KEY(3, 2, KEY_S), \
> >> +     KEY(3, 3, KEY_D), \
> >> +     KEY(3, 4, KEY_F), \
> >> +     KEY(3, 5, KEY_G), \
> >> +     KEY(3, 6, KEY_H), \
> >> +     KEY(3, 7, KEY_J), \
> >> +     KEY(3, 8, KEY_K), \
> >> +     KEY(4, 0, KEY_L), \
> >> +     KEY(4, 1, KEY_SEMICOLON), \
> >> +     KEY(4, 2, KEY_APOSTROPHE), \
> >> +     KEY(4, 3, KEY_GRAVE), \
> >> +     KEY(4, 4, KEY_LEFTSHIFT), \
> >> +     KEY(4, 5, KEY_BACKSLASH), \
> >> +     KEY(4, 6, KEY_Z), \
> >> +     KEY(4, 7, KEY_X), \
> >> +     KEY(4, 8, KEY_C), \
> >> +     KEY(4, 0, KEY_L), \
> >> +     KEY(4, 1, KEY_SEMICOLON), \
> >> +     KEY(4, 2, KEY_APOSTROPHE), \
> >> +     KEY(4, 3, KEY_GRAVE), \
> >> +     KEY(4, 4, KEY_LEFTSHIFT), \
> >> +     KEY(4, 5, KEY_BACKSLASH), \
> >> +     KEY(4, 6, KEY_Z), \
> >> +     KEY(4, 7, KEY_X), \
> >> +     KEY(4, 8, KEY_C), \
> >> +     KEY(4, 0, KEY_L), \
> >> +     KEY(4, 1, KEY_SEMICOLON), \
> >> +     KEY(4, 2, KEY_APOSTROPHE), \
> >> +     KEY(4, 3, KEY_GRAVE), \
> >> +     KEY(4, 4, KEY_LEFTSHIFT), \
> >> +     KEY(4, 5, KEY_BACKSLASH), \
> >> +     KEY(4, 6, KEY_Z), \
> >> +     KEY(4, 7, KEY_X), \
> >> +     KEY(4, 8, KEY_C), \
> >> +     KEY(5, 0, KEY_V), \
> >> +     KEY(5, 1, KEY_B), \
> >> +     KEY(5, 2, KEY_N), \
> >> +     KEY(5, 3, KEY_M), \
> >> +     KEY(5, 4, KEY_COMMA), \
> >> +     KEY(5, 5, KEY_DOT), \
> >> +     KEY(5, 6, KEY_SLASH), \
> >> +     KEY(5, 7, KEY_RIGHTSHIFT), \
> >> +     KEY(5, 8, KEY_KPASTERISK), \
> >> +     KEY(6, 0, KEY_LEFTALT), \
> >> +     KEY(6, 1, KEY_SPACE), \
> >> +     KEY(6, 2, KEY_CAPSLOCK), \
> >> +     KEY(6, 3, KEY_F1), \
> >> +     KEY(6, 4, KEY_F2), \
> >> +     KEY(6, 5, KEY_F3), \
> >> +     KEY(6, 6, KEY_F4), \
> >> +     KEY(6, 7, KEY_F5), \
> >> +     KEY(6, 8, KEY_F6), \
> >> +     KEY(7, 0, KEY_F7), \
> >> +     KEY(7, 1, KEY_F8), \
> >> +     KEY(7, 2, KEY_F9), \
> >> +     KEY(7, 3, KEY_F10), \
> >> +     KEY(7, 4, KEY_NUMLOCK), \
> >> +     KEY(7, 5, KEY_SCROLLLOCK), \
> >> +     KEY(7, 6, KEY_KP7), \
> >> +     KEY(7, 7, KEY_KP8), \
> >> +     KEY(7, 8, KEY_KP9), \
> >> +     KEY(8, 0, KEY_KPMINUS), \
> >> +     KEY(8, 1, KEY_KP4), \
> >> +     KEY(8, 2, KEY_KP5), \
> >> +     KEY(8, 3, KEY_KP6), \
> >> +     KEY(8, 4, KEY_KPPLUS), \
> >> +     KEY(8, 5, KEY_KP1), \
> >> +     KEY(8, 6, KEY_KP2), \
> >> +     KEY(8, 7, KEY_KP3), \
> >> +     KEY(8, 8, KEY_KP0), \
> >> +};
> > 
> > Hm, I'd expect this to be in particular board code, not in the header
> > file.
> > 
> 
> Currently we have support for evaluation boards only and all of them will have
> this structure in their board source files. In order to remove redundant code we
> kept it in plat/keyboard.h.
> 

So call it "spear_default_keymap" and put it right into the driver? And
then allow platform code override it.

> >> +/**
> >> + * struct kbd_platform_data - keymap for spear keyboards
> >> + * keymap: pointer to array of values encoded with KEY() macro representing
> >> + * keymap
> >> + * keymapsize: number of entries (initialized) in this keymap
> >> + * rep: current values for autorepeat parameters
> >> + *
> >> + * This structure is supposed to be used by platform code to supply
> >> + * keymaps to drivers that implement keyboards.
> >> + */
> >> +struct kbd_platform_data {
> >> +     int *keymap;
> >> +     unsigned int keymapsize;
> >> +     unsigned int rep:1;
> > 
> > Bool please.
> > 
> 
> OK
> 
> >> +};
> >> +
> >> +/* This function is used to set platform data field of pdev->dev */
> >> +static inline void
> >> +kbd_set_plat_data(struct platform_device *pdev, struct kbd_platform_data *data)
> >> +{
> >> +#ifdef CONFIG_ARCH_SPEAR13XX
> >> +#define KBD_PAD_SEL  (BIT(18) | BIT(20) | BIT(22) | BIT(24) | BIT(26))
> >> +
> >> +     u32 val;
> >> +     /* Workaround:Setting bit for routing it to the IP */
> >> +     val = readl(PAD_FUNCTION_EN_2);
> >> +     val &= ~KBD_PAD_SEL;
> >> +     writel(val, PAD_FUNCTION_EN_2);
> > 
> > Why does it belong here?
> > 
> 
> Sorry. It will be handled in padmux framework.
> 
> >> +#endif
> >> +     pdev->dev.platform_data = data;
> >> +}
> >> +#endif /* __PLAT_KEYBOARD_H */
> >> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> >> index 9cc488d..2d7e3a8 100644
> >> --- a/drivers/input/keyboard/Kconfig
> >> +++ b/drivers/input/keyboard/Kconfig
> >> @@ -424,6 +424,14 @@ config KEYBOARD_OMAP
> >>         To compile this driver as a module, choose M here: the
> >>         module will be called omap-keypad.
> >>
> >> +config KEYBOARD_SPEAR
> >> +     tristate "ST SPEAR keyboard support"
> > 
> > No arch/platform dependencies?
> > 
> 
> Will add them.
> 
> >> +     help
> 
> [snip...]
> 
> >> +struct spear_kbd {
> >> +     struct input_dev *input;
> >> +     void __iomem *io_base;          /* Keyboard Base Address */
> >> +     struct clk *clk;
> >> +     int *keymap;
> > 
> > You need a copy of keymap here so that userspace can modify it safely
> > via EVIOCSKEYCODE.
> > 
> 
> We have one copy of struct spear_kbd per device structure. I think it
> will be fine if we change this structure only. And so don't need to copy
> another structure in driver.

Normally such platform data should be declared as 'const' and drivers
should not modify such data. Also unbinding device from driver and
rebinding later should restore the device into pristine state. Having a
copy of keymap in spear_kbd allows to achieve such behavior.

> 
> >> +};
> >> +/* TODO: Need to optimize this function */
> >> +static inline int get_key_value(struct spear_kbd *dev, int row, int col)
> >> +{
> >> +     int i, key;
> >> +     int *keymap = dev->keymap;
> >> +
> >> +     key = KEY(row, col, 0);
> >> +     for (i = 0; keymap[i] != 0; i++)
> >> +             if ((keymap[i] & KEY_MASK) == key)
> >> +                     return keymap[i] & KEY_VALUE;
> >> +     return -ENOKEY;
> >> +}
> >> +
> >> +static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
> >> +{
> >> +     struct spear_kbd *dev = dev_id;
> >> +     static u8 last_key ;
> >> +     static u8 last_event;
> > 
> > No statics please, pull it into spear_kbd structure.
> >
> 
> Ok
>  
> >> +     int key;
> >> +     u8 sts, val = 0;
> >> +
> >> +     if (dev == NULL) {
> > 
> > How can it be?
> > 
> 
> Not needed, will be fixed.
> 
> >> +             pr_err("Keyboard: Invalid dev_id in irq handler\n");
> >> +             return IRQ_NONE;
> >> +     }
> >> +
> >> +     sts = readb(dev->io_base + STATUS_REG);
> >> +     if (sts & DATA_AVAIL) {
> >> +             /* following reads active (row, col) pair */
> >> +             val = readb(dev->io_base + DATA_REG);
> >> +             key = get_key_value(dev, (val & ROW_MASK)>>ROW_SHIFT, (val
> >> +                                     & COLUMN_MASK));
> >> +
> >> +             /* valid key press event */
> >> +             if (key >= 0) {
> >> +                     if (last_event == 1) {
> >> +                             /* check if we missed a release event */
> >> +                             input_report_key(dev->input, last_key,
> >> +                                             !last_event);
> >> +                     }
> >> +                     /* notify key press */
> >> +                     last_event = 1;
> >> +                     last_key = key;
> >> +                     input_report_key(dev->input, key, last_event);
> >> +             } else {
> >> +                     /* notify key release */
> >> +                     last_event = 0;
> >> +                     input_report_key(dev->input, last_key, last_event);
> >> +             }
> >> +     } else
> > 
> > Don't you need to clear interrupt here? You got it somehow...
> >
> 
> I can think of only one way in which this handler is called for some other
> device interrupt, that is when this irq line is shared between peripherals.
> In that case if interrupt is not meant for kbd then kbd shouldn't clear it.

You would be clearing IRQ condition _in your device_ so that sould not
affect the other device in any way.

> Isn't it fine???

I guess it should be OK.

> 
> >> +             return IRQ_NONE;
> >> +
> >> +     /* clear interrupt */
> >> +     writeb(0, dev->io_base + STATUS_REG);
> >> +
> >> +     return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int __init spear_kbd_probe(struct platform_device *pdev)
> >> +{
> 
> [snip...]
> 
> >> +     ret = request_irq(irq, spear_kbd_interrupt, 0, "keyboard",
> >> +                     kbd);
> >> +     if (ret) {
> >> +             dev_err(&pdev->dev, "request_irq fail\n");
> >> +             goto err_iounmap;
> >> +     }
> >> +
> > 
> > Are you 100% sure the device is shut off at this point? Because if it
> > isn't you risk to get interrupt before you allocated your input device.
> >
> 
> I will check and place it at correct place.
> 
> >> +
> >> +     /* start key scan */
> >> +     val |= START_SCAN;
> >> +     writew(val, kbd->io_base + MODE_REG);
> > 
> > This should go into open() method.
> > 
> 
> OK.
> 
> >> +static int spear_kbd_remove(struct platform_device *pdev)
> >> +{
> >> +     struct spear_kbd *kbd = platform_get_drvdata(pdev);
> >> +     struct resource *res;
> >> +     u16 val;
> >> +     int irq;
> >> +
> >> +     val = readw(kbd->io_base + MODE_REG);
> >> +     val &= ~START_SCAN;
> >> +     writew(val, kbd->io_base + MODE_REG);
> > 
> > Need to go into close() method.
> >
> 
> OK.
>  
> >> +
> >> +     /* unregister input device */
> >> +     input_unregister_device(kbd->input);
> >> +     input_free_device(kbd->input);
> > 
> > No free after unregister.
> > 
> 
> OK.
> 
> >> +
> >> +     irq = platform_get_irq(pdev, 0);
> >> +     if (irq)
> >> +             free_irq(irq, pdev);
> > 
> > Can it ever be 0 here?
> > 
> 
> No. Will correct.
> 
> 
> >> +
> >> +static struct platform_driver spear_kbd_driver = {
> >> +     .probe          = spear_kbd_probe,
> >> +     .remove         = spear_kbd_remove,
> >> +     .suspend        = spear_kbd_suspend,
> >> +     .resume         = spear_kbd_resume,
> > 
> > Switch to dev_pm_ops please.
> > 
> 
> Ok.
> 
> 
> Thanks,
> rajeev.
> 

-- 
Dmitry
