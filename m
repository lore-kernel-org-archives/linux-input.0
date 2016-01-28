From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH-V2 1/1] HID: Force feedback support for the Logitech
 G920
Date: Thu, 28 Jan 2016 14:33:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601281430560.21446@cbobk.fhfr.pm>
References: <1452468315-8978-1-git-send-email-e.velds@gmail.com> <0db5d205435e01d8228b97a2d87ef42d.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0db5d205435e01d8228b97a2d87ef42d.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Edwin Velds <e.velds@gmail.com>, linux-input@vger.kernel.org, Michal Maly <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 26 Jan 2016, Simon Wood wrote:

> On Sun, January 10, 2016 4:25 pm, Edwin Velds wrote:
> > This patch implements force feedback support for the Logitech
> > G920 Driving Force Racing Wheel. It is a generic implementation
> > of feature 0x8123 of the Logitech HID++ protocol and should be usable for
> > any future devices that implement this feature.
> 
> Apologies for being slow on this (something to do with changing jobs and
> accomodation ;-).
> 
> Doesn't patch cleanly on Linus' HEAD due to:
> --
> commit d8ce9bf5551bfea431893bdd0a943f24a5170828
> Author: Geliang Tang <geliangtang@163.com>
> Date:   Sun Dec 27 17:25:20 2015 +0800
> 
>     HID: move to_hid_device() to hid.h

I've fixed the conflict.

> --
> 
> A couple of white space issues:
> --
> ERROR: trailing whitespace
> #114: FILE: drivers/hid/hid-logitech-hidpp.c:867:
> +static const u8 HIDPP_FF_CONDITION_CMDS[] = { $
> 
> ERROR: trailing whitespace
> #121: FILE: drivers/hid/hid-logitech-hidpp.c:874:
> +static const char *HIDPP_FF_CONDITION_NAMES[] = { $

Fixed as well.

> --
> 
> Note: The wheel _DOES_NOT_ auto switch to Logitech/HID mode (it is stuck
> in XBox since the xpad changes where not included). Michal has an
> alternative approach documented here:

I've ammended the changelog with this information.

> Apart from these few minor points, but seems to work OK - tested against
> G920 with older firmware.
> 
> Tested-by: Simon Wood <simon@mungewell.org>

Applied to for-4.6/logitech, thanks.

(also, I've made hidpp_ff_init() and hidpp_ff_deinit() static, as they 
don't have to be exported outside of the unit).

-- 
Jiri Kosina
SUSE Labs
