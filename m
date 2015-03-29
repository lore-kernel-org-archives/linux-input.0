From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 00/12] HID: hid-lg, hid-lg4ff: Mostly cleanup patches
Date: Sun, 29 Mar 2015 11:01:00 +0200
Message-ID: <CADbOyBRndvHy_s=T5K_JU+i4t3fdrMJCQmio2wF2rzEpH_XmUg@mail.gmail.com>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36667 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbC2JBB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Mar 2015 05:01:01 -0400
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Wood <simon@mungewell.org>

On Sat, Mar 21, 2015 at 12:47 PM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> Hello everyone,
>
> this is a mostly boring series that deals with a few inconsistencies =
in the
> code that have accumulated over the years. Besides that it patches up=
 a handful
> of problems such a return values not being checked etc.
>
> The only significant change comes in patch 0007 which introduces a sp=
inlock to
> handle concurrent access to the HID report that is used by the driver=
 to send
> data to the wheel. I would appreciate some comments on this one, part=
icularly
> on the way it handles deinitialization.
>
> Michal Mal=C3=BD (12):
>   HID: hid-lg4ff: (Cleanup) Remove double underscore prefix from nume=
ric
>     types.
>   HID: hid-lg4ff: (Cleanup) Remove "hid_" prefix from some functions
>     names.
>   HID: hid-lg4ff: (Cleanup) Replace DEVICE_ATTR_RW with DEVICE_ATTR t=
o
>     have all internal functions prefixed with "lg4ff_"
>   HID: hid-lg4ff: (Cleanup) Remove unused variable from the
>     "lg4ff_device_entry" struct.
>   HID: hid-lg4ff: Update a warning message for a case where device is
>     incorrectly flagged to be handled by hid-lg4ff in hid-lg.
>   HID: hid-lg: Check return values from lg[N]ff_init()
>   HID: hid-lg4ff: Protect concurrent access to the output HID report
>     values with a spinlock.
>   HID: hid-lg4ff: Store pointer to the output HID report struct in th=
e
>     device entry struct.
>   HID: hid-lg4ff: Constify those members of lg4ff_device_entry struct
>     whose value is not supposed to change.
>   HID: hid-lg4ff: Allow the driver to continue without sysfs interfac=
e.
>   HID: hid-lg4ff: Update respective sysfs interface documentation
>   HID: hid-lg: Only one of LG_FF flags can be set for a given device.
>
>  .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |   8 +-
>  drivers/hid/hid-lg.c                               |  21 +-
>  drivers/hid/hid-lg4ff.c                            | 459 +++++++++++=
+++-------
>  drivers/hid/hid-lg4ff.h                            |   4 +-
>  4 files changed, 319 insertions(+), 173 deletions(-)
>
> --
> 2.3.3
>

Tested on kernel 3.18.6 (I had to apply some uptream patches first).
I tried to crash the kernel by simultaneously running many instances
of FF applications (which made use of effects with nonzero attack
times, thus the ff-memless timer's timeout got modified often), and
then unplugging the device while in use.
Instead of crashing, the kernel behaved like it should, no panics or
lockups were found.

Tested with to following devices:
- Logitech MOMO (Black) : PID 0xCA03
- Logitech Formula Vibration : PID 0xCA04

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>

Regards,
Elias
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
