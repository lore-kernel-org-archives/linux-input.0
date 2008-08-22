From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] POSKeyboard driver for exclusive keyboard access
Date: Fri, 22 Aug 2008 14:02:56 -0400
Message-ID: <20080822135507.ZZRA012@mailhub.coreip.homeip.net>
References: <1b51b6f80808220917t20fdb09el78b117c5ba5b7f7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:46662 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbYHVSDC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2008 14:03:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so86955and.103
        for <linux-input@vger.kernel.org>; Fri, 22 Aug 2008 11:03:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1b51b6f80808220917t20fdb09el78b117c5ba5b7f7c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org

Hi Niels,

On Fri, Aug 22, 2008 at 06:17:28PM +0200, Niels de Vos wrote:
> This new driver makes it possible for middleware like JavaPOS to use
> a POSKeyboard (connected to PS/2) with exclusive access. This is
> required by the UnifiedPOS Specification which is available from
> http://www.nrf-arts.org/UnifiedPOS. Any middleware using this driver
> should implement the full exception-handling in user-space. Therefor
> it is possible to use specific POS-extensions of POSKeyboards, without
> abusing other keyboard-drivers.
> 
> Opening /dev/poskeyboard will route all scancodes to this device. The
> scancodes will not be processes by the input-subsystem anymore. Reading
> /dev/poskeyboard results in receiving the scancodes as raw data for
> further processing by the reader. Sending commands to the hardware can
> be done by writing to /dev/poskeyboard.
> 
> If the driver is loaded and /dev/poskeyboard is not opened, all
> scancodes are given to the input-subsystem. This allows 'normal' use of
> the keyboard.
> 
> Making the driver active involves some commands like the following:
>    echo -n serio1 > /sys/bus/serio/drivers/atkbd/unbind
>    echo -n serio1 > /sys/bus/serio/drivers/poskbd/bind
> 

It seems you have just reimplemented serio_raw driver, therefore NAK.
Right now serio_raw is limited to untranslated ports but adding
SERIO_I8042XL signature should be easy.

> Open questions:
> - How to achieve the same with USB-HID complaint keyboards?

Thsi is probably is the candidate for legitimate use of EVIOCGRAB.
Just grab device for exclusive access and do your processing, probably
looking at MSC_SCAN (or KEY_*, depends on how hardware-sepcific this
thing is). This approach shoudl work equally well for HID, PS/2,
serial or any other kind of keyboard/input device actually. You can
also re-inject the keystrokes you are not interested in back into
input core via uinput.

> - Does serio_unregister_port() a kfree() on the port?

Eventually, after the last user drops off.

-- 
Dmitry
