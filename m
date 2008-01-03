From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Tosa keyboard support
Date: Thu, 3 Jan 2008 11:51:11 -0500
Message-ID: <d120d5000801030851j6629e4f0m102939aff412df5b@mail.gmail.com>
References: <20071223232914.GA28932@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:22818 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYACQvN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jan 2008 11:51:13 -0500
Received: by nf-out-0910.google.com with SMTP id g13so406929nfb.21
        for <linux-input@vger.kernel.org>; Thu, 03 Jan 2008 08:51:12 -0800 (PST)
In-Reply-To: <20071223232914.GA28932@doriath.ww600.siemens.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

Hi Dmitry,

Sorry for the slow response.

On Dec 23, 2007 6:29 PM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
> > From b213bef91e3f98c6104138050ad4eaa0a54e765d Mon Sep 17 00:00:00 2001
> From: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Date: Mon, 24 Dec 2007 02:15:34 +0300
> Subject: [PATCH] Tosa keyboard support
>
> Support keyboard on tosa (Sharp Zaurus SL-6000x).
> Largely based on patches by Dirk Opfer.
> This is the final version that supports switching between
> full keycode range and range available to the console and
> keyb Kdrive driver.
>

The driver looks very nice, just a couple minor comments:

> +
> +#ifdef CONFIG_PM
> +static int tosakbd_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +       /* Nothing yet */

Stop the polling timer here?

> +
> +       return 0;
> +}
> +
...

> +
> +       tosakbd->input = input_dev;
> +
> +       input_dev->private = tosakbd;

Please use input_set_drvdata(). I am about to commit the change
removing private from input_dev structure.

> +       input_dev->name = "Tosa Keyboard";
> +       input_dev->phys = "tosakbd/input0";
> +       input_dev->cdev.dev = &pdev->dev;

Please use input_dev->dev.parent. cdev is going away.

> +
> +       input_dev->id.bustype = BUS_HOST;
> +       input_dev->id.vendor = 0x0001;
> +       input_dev->id.product = 0x0001;
> +       input_dev->id.version = 0x0100;
> +
> +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
> +       input_dev->keycode = tosakbd->keycode;
> +       input_dev->keycodesize = sizeof(unsigned int);
> +       input_dev->keycodemax = ARRAY_SIZE(tosakbd_keycode);
> +
> +       memcpy(tosakbd->keycode, tosakbd_keycode, sizeof(tosakbd_keycode));
> +
> +       for (i = 0; i < ARRAY_SIZE(tosakbd_keycode); i++)
> +               set_bit(tosakbd->keycode[i], input_dev->keybit);
> +       clear_bit(0, input_dev->keybit);

Might want to switch to __set_bit to save couple of bytes. We dont
need atomicity here.

> +
> +#define TOSA_KEY_SYNC          KEY_102ND /* ??? */
> +
> +
> +#ifndef CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES
> +#define TOSA_KEY_RECORD                KEY_YEN
> +#define TOSA_KEY_ADDRESSBOOK   KEY_KATAKANA
> +#define TOSA_KEY_CANCEL                KEY_ESC
> +#define TOSA_KEY_CENTER                KEY_HIRAGANA
> +#define TOSA_KEY_OK            KEY_HENKAN
> +#define TOSA_KEY_CALENDAR      KEY_KATAKANAHIRAGANA
> +#define TOSA_KEY_HOMEPAGE      KEY_HANGEUL
> +#define TOSA_KEY_LIGHT         KEY_MUHENKAN
> +#define TOSA_KEY_MENU          KEY_HANJA
> +#define TOSA_KEY_FN            KEY_RIGHTALT
> +#define TOSA_KEY_MAIL          KEY_ZENKAKUHANKAKU
> +#else
> +#define TOSA_KEY_RECORD                KEY_RECORD
> +#define TOSA_KEY_ADDRESSBOOK   KEY_ADDRESSBOOK
> +#define TOSA_KEY_CANCEL                KEY_CANCEL
> +#define TOSA_KEY_CENTER                KEY_SELECT /* ??? */
> +#define TOSA_KEY_OK            KEY_OK
> +#define TOSA_KEY_CALENDAR      KEY_CALENDAR
> +#define TOSA_KEY_HOMEPAGE      KEY_HOMEPAGE
> +#define TOSA_KEY_LIGHT         KEY_SWITCHVIDEOMODE /* ??? */

KEY_ILLUMTOGGLE maybe? SWITCHWIDEOMODE is for cycling between outputs...

Also, I'd put these defines rigth in tosakbd.c.

Thanks.

-- 
Dmitry
