From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Wed, 3 Mar 2010 07:04:11 +0100
Message-ID: <20100303060411.GA1324@ucw.cz>
References: <20100221002001.0a7e05a7@neptune.home> <20100224170049.0d04af3c@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:35740 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751043Ab0CCGEZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Mar 2010 01:04:25 -0500
Content-Disposition: inline
In-Reply-To: <20100224170049.0d04af3c@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno Pr?mont <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

Hi!

> +#ifdef CONFIG_LOGO
> +/*
> + * This is a default logo to be loaded upon driver initialization
> + * replacing the default PicoLCD image loaded on device
> + * initialization. This is to provide the user a cue that the
> + * Linux driver is loaded and ready.
> + *
> + * This logo contains the text PicoLCD in the center with one penguin
> + * on each side of the text. The penguins are a 64x64 rendition of
> + * the default framebuffer 80x80 monochrome image scaled down and
> + * cleaned up to retain something that looks a little better than
> + * a simple scaling.
> + *
> + * This logo is a simple xbm image created in GIMP and exported.
> + * To view the image copy the following two #defines plus the
> + * picolcd_bits to an ASCII text file and save with extension
> + * .xbm, then open with GIMP or any other graphical editor
> + * such as eog that recognizes the .xbm format.
> + */
> +#define picolcd_width 256
> +#define picolcd_height 64
> +static const u8 picolcd_bits[PICOLCDFB_SIZE] = {
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +	0xff, 0xff, 0xff, 0xf8, 0x1f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xf8, 0x1f, 0xff, 0xff, 0xff,

Please remove this. There are less ugly/shorter ways to tell the user
device is ready.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
