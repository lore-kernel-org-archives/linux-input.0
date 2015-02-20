From: simon@mungewell.org
Subject: Re: [PATCH RESEND] HID: Stop hiding options with !EXPERT
Date: Fri, 20 Feb 2015 13:41:29 -0500
Message-ID: <f949ff4723760d33685391195404f861.squirrel@mungewell.org>
References: <20150220173333.5a71d6cb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220173333.5a71d6cb@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

I can't really comment on the overall situation (Jiri replied to your last
thread), but...

> The HID_LOGITECH option is even worse than the others. Sub-options
> depend on it, and this causes menuconfig and friends to display the
> option even though the user can't change its value. The help page for
> HID_LOGITECH will not explain why the value can't be changed. It only
> says, for example:

Perhaps the Kconfig for Logitech does need some TLC.

It should be remembered that it supports a wide range of devices from
Unifying, to game controllers and wheels. In total it knows about 30
USB-IDs.

>
>   Depends on: INPUT [=y] && HID [=y]
>
> and that leaves the user puzzled about why the option is forced to y.
> You might argue that this is a Kconfig bug, but that doesn't make it
> less annoying for the user.
>
> Even worse is that some of the sub-options of HID_LOGITECH select
> INPUT_FF_MEMLESS, which in turn gets out of control for the user. So,
> if you set INPUT=y and HID=y (something most general purpose
> distributions would do these days, as both modules would get loaded on
> a vast majority of systems otherwise), and you want support for
> force-feedback game controllers, you can't have that as a module, it
> has to be built-in, regardless of how rare these devices are.

It make sense to remain as a module (if modules are enabled) when 'INPUT=y
and HID=y', and should not force 'FF_MEMLESS=Y' (just leave that as module
too).

There is also the 'LEDS CLASS' which is required for G27 support. IIRC
there was some 'magic' done with hid-steelseries to tweak problems with
LEDs.

I'd be open to helping this happen, given some guidance.
Simon
