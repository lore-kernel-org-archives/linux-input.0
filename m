From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v3] input: tegra-kbc - Add tegra keyboard driver
Date: Mon, 10 Jan 2011 14:49:25 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A00805F@HQMAIL03.nvidia.com>
References: <1294422307-19107-1-git-send-email-riyer@nvidia.com>
 <20110110221624.GA16445@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:16568 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab1AJWwz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 17:52:55 -0500
In-Reply-To: <20110110221624.GA16445@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "jj@chaosbits.net" <jj@chaosbits.net>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>, "shubhrajyoti@ti.com" <shubhrajyoti@ti.com>, "ccross@android.com" <ccross@android.com>, "konkers@android.com" <konkers@android.com>, "olof@lixom.net" <olof@lixom.net>, Andrew Chew <AChew@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> On Fri, Jan 07, 2011 at 09:45:07AM -0800, riyer@nvidia.com wrote:
> > +
> > +struct tegra_kbc {
> > +	void __iomem *mmio;
> > +	struct input_dev *idev;
> > +	int irq;
> > +	unsigned int wake_enable_rows;
> > +	unsigned int wake_enable_cols;
> > +	spinlock_t lock;
> > +	unsigned int repoll_time;
> > +	unsigned long cp_dly_jiffies;
> > +	int fifo[KBC_MAX_KPENT];
> > +	const struct tegra_kbc_platform_data *pdata;
> > +	int *plain_keycode;
> > +	int *fn_keycode;
> 
> There should not be separate keycodes for FN and normal kys - FN is just
> a modifier, like SHIFT or CTRL or ALT are and shoudl be handled in upper
> layers.

We had the same thought regarding Function as a modifier akin to Shift, Ctrl an Alt.
But this does not appear to be the case. 

This keyboard is used primarily for Laptop-like form factors where function keys are used to overload the existing keys. 
In addition the Fn key mappings aren't identical in different keyboard layouts.

So at this point in order to function with the target hardware and the target operating system which is Chrome, this modifier keymap is necessary.

Let me know what you think.

> 
> Also you should wire up keycode/keycodemax/keycodesize in input_dev
> structuire so that keymap can be retrieved via EVIOCGKEYCODE and
> modified via EVIOGSKEYCODE.

I will proceed to do this.

>  Also, because keymap is modifiable, the
> original keymap should be copied in per-device structure, leaving
> original intact. It (the original) also should be marked as const.
I did not get the significance to preserving a copy of the original keymap.
In what situation would we use that.


> Since this papears to be a matrix keypad consider using definitions from
> linux/input/matrix_keypad.h
>

I looked at the linux/input/matrix_keypad.h and noticed it shares a decent amount of structure with the tegra keyboard.
But the tegra kbc hardware differences from the matrix_keypad are significant enough to warrant its own structure.

Regards
Rakesh

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Monday, January 10, 2011 2:16 PM
> To: Rakesh Iyer
> Cc: jj@chaosbits.net; tsoni@codeaurora.org; shubhrajyoti@ti.com; ccross@android.com;
> konkers@android.com; olof@lixom.net; Andrew Chew; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-input@vger.kernel.org
> Subject: Re: [PATCH v3] input: tegra-kbc - Add tegra keyboard driver
> 
> Hi Rakesh,
> 
> On Fri, Jan 07, 2011 at 09:45:07AM -0800, riyer@nvidia.com wrote:
> > +
> > +struct tegra_kbc {
> > +	void __iomem *mmio;
> > +	struct input_dev *idev;
> > +	int irq;
> > +	unsigned int wake_enable_rows;
> > +	unsigned int wake_enable_cols;
> > +	spinlock_t lock;
> > +	unsigned int repoll_time;
> > +	unsigned long cp_dly_jiffies;
> > +	int fifo[KBC_MAX_KPENT];
> > +	const struct tegra_kbc_platform_data *pdata;
> > +	int *plain_keycode;
> > +	int *fn_keycode;
> 
> There should not be separate keycodes for FN and normal kys - FN is just
> a modifier, like SHIFT or CTRL or ALT are and shoudl be handled in upper
> layers.
> 
> Also you should wire up keycode/keycodemax/keycodesize in input_dev
> structuire so that keymap can be retrieved via EVIOCGKEYCODE and
> modified via EVIOGSKEYCODE. Also, because keymap is modifiable, the
> original keymap should be copied in per-device structure, leaving
> original intact. It (the original) also should be marked as const.
> 
> Since this papears to be a matrix keypad consider using definitions from
> linux/input/matrix_keypad.h
> 
> Thank you.
> 
> --
> Dmitry
