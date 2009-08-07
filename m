From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch 1/4] input: drivers/input/xpad.c: improve Xbox 360 wireless
  support and add sysfs interface
Date: Fri, 07 Aug 2009 15:45:51 +0300
Message-ID: <4A7C21FF.4050603@gmail.com>
References: <200908062304.n76N4Br7002564@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:53288 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbZHGMqx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Aug 2009 08:46:53 -0400
In-Reply-To: <200908062304.n76N4Br7002564@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, mamurph@cs.clemson.edu, randy.dunlap@oracle.com

akpm@linux-foundation.org wrote:
> From: Mike Murphy <mamurph@cs.clemson.edu>
> 
> Improved support for Xbox 360 wireless devices by enabling rumble and
> LED control, improved general usability by adding input controls, and
> added a sysfs interface for tuning driver behavior. Updated with fixes
> to code layout, typecasting, and use of internal functions.
> 
> [akpm@linux-foundation.org: coding-style fixes]
> [randy.dunlap@oracle.com: fix build error and warnings]
> Signed-off-by: Mike Murphy <mamurph@cs.clemson.edu>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/input/joystick/xpad.c | 1021 ++++++++++++++++++++++----------
>  drivers/input/joystick/xpad.h |  406 ++++++++++++
>  2 files changed, 1132 insertions(+), 295 deletions(-)
> 
> diff -puN drivers/input/joystick/xpad.c~input-drivers-input-xpadc-improve-xbox-360-wireless-support-and-add-sysfs-interface drivers/input/joystick/xpad.c
> --- a/drivers/input/joystick/xpad.c~input-drivers-input-xpadc-improve-xbox-360-wireless-support-and-add-sysfs-interface
> +++ a/drivers/input/joystick/xpad.c
[...]
> +/* Device attributes */
> +static DEVICE_ATTR(left_dead_zone, 0644, xpad_show_uint, xpad_store_uint);
> +static DEVICE_ATTR(right_dead_zone, 0644, xpad_show_uint, xpad_store_uint);
> +static DEVICE_ATTR(left_stick_limit, 0644, xpad_show_uint, xpad_store_uint);
> +static DEVICE_ATTR(right_stick_limit, 0644, xpad_show_uint, xpad_store_uint);

I'm somewhat unsure on introducing such device-specific attributes. Dead
zone and stick limit attributes could be useful for non-xpad input
devices as well, so shouldn't we have a generic interface?

> +static DEVICE_ATTR(rumble_enable, 0644, xpad_show_int, xpad_store_bool);

Ditto for this one. Disabling FF does not seem like device-specific feature.

> +static DEVICE_ATTR(left_trigger_full_axis, 0644, xpad_show_int,
> +			xpad_store_bool);
> +static DEVICE_ATTR(right_trigger_full_axis, 0644, xpad_show_int,
> +			xpad_store_bool);
> +static DEVICE_ATTR(controller_number, 0444, xpad_show_int, xpad_store_ro);
> +static DEVICE_ATTR(controller_present, 0444, xpad_show_int, xpad_store_ro);
> +static DEVICE_ATTR(controller_type, 0444, xpad_show_int, xpad_store_ro);
> +static DEVICE_ATTR(id, 0444, xpad_show_id, xpad_store_ro);
[...]
> +/* Driver History:

Do we wan't the driver changelog in xpad.c or not?
It was removed in commit bf8cb3141884138c2e4a2ecb56300ece6e8020a2 in
2008, no longer being up to date, and subsequent commits haven't been
listed there (notice the gap between 2004-2009).

I'll leave it to Dmitry to decide :)

> + * 2009-03-06 : Patches from -mm tree
> + *  - fixed build issue when CONFIG_JOYSTICK_XPAD_LEDS not set and removed
> + *    duplicate prototypes (thanks Randy Dunlap for patch)
> + *  - fixed erroneous whitespace reported by checkpatch (thanks Andrew Morton
> + *    for patch)
> + *  - added missing prototype
> + *
> + * 2009-03-02 : Code cleanup
> + *  - used min(), max(), and abs() where appropriate, simplifying code
> + *  - moved code that generates data objects out of xpad.h and into xpad.c
> + *  - changed legacy #if defined(...) to #ifdef
> + *  - removed unnecessary typecasts
> + *  - wireless 360 controller identification now done in workqueue task
> + *  - thanks Andrew Morton, Greg K-H, and Linus Torvalds
> + *
> + * 2009-02-28 : Triggers now half-axes by default
> + *  - triggers will now be positive half-axes only, unless a full axis mapping
> + *    is enabled via the sysfs interface on a per-trigger basis
> + *  - moved INIT_WORK to xpad_probe and removed INIT_WORK/PREPARE_WORK from
> + *    interrupt handler; also removed the work_pending flag from struct
> + *    usb_xpad (always flush shared workqueue on unload)
> + *  - read-write sysfs attributes now have 644 default permissions
> + *
> + * 2009-02-23 : Changes per mailing list (thanks Frederic Weisbecker)
> + *  - no more check for CONFIG_SYSFS: sysfs functions will simply return
> + *    0 if sysfs has not been enabled
> + *  - fixed weird ordering in sscanf return check
> + *  - checked code with scripts/checkpatch.pl and made style adjustments
> + *
> + * 2009-02-21 : Refactored and changed stick handling
> + *  - split code into two pieces (xpad.h and xpad.c)
> + *  - cleaned up sysfs interface
> + *  - changed square axis algorithm to an axis limit algorithm, which allows
> + *    size of inscribed square to be adjusted; available for both sticks
> + *  - dead zones now per-stick
> + *
> + * 2009-02-18 : Changes per mailing list (and some additions)
> + *  - revised sysfs interface (thanks Greg K-H)
> + *  - check return values of sscanf (thanks Oliver Neukum)
> + *  - urb submission while holding mutex now once again GFP_KERNEL
> + *    (thanks Oliver Neukum)
> + *  - work structure fixes (thanks Oliver Neukum)
> + *  - uevents generated for wireless controller online/offline
> + *  - sysfs interface only if CONFIG_SYSFS is set
> + *
> + * 2009-02-15 : Minor adjustments
> + *  - added KOBJ_ONLINE/KOBJ_OFFLINE events when controllers are connected to
> + *    or disconnected from the wireless 360 receiver
> + *  - ignore duplicate connect messages on the same connection
> + *  - added option to enable/disable rumble on a per-controller basis
> + *  - rumble events are not sent to guitar or dance pad devices
> + *
> + * 2009-02-14 : Added sysfs interface
> + *  - dead zones and square axis settings can now be made per-controller
> + *  - removed dead_zone and square_axis module parameters (use sysfs)
> + *  - new square axis algorithm
> + *
> + * 2009-02-13 : Disable square axis for right stick
> + *  - square axis applies to left stick only
> + *
> + * 2009-02-12 : Scaling for dead zone and square axis support
> + *  - axes now scale from 0 to 32767 starting at edge of dead zone
> + *  - increased default dead zone to 8192
> + *  - initial square axis support (reliable only with left stick)
> + *
> + * 2009-02-07 : More wireless 360 controller fixes
> + *  - removed bulk urb completely
> + *  - use xpad_send_led_command to set controller number on LED display
> + *    (wireless 360 controller)
> + *  - dead_zone is now an adjustable module parameter
> + *
> + * 2009-02-06 : Axis handling improvements
> + *  - unified handler for left and right sticks
> + *  - initial support for dead zones
> + *
> + * 2009-02-02 : Wireless 360 controller fixes
> + *  - followed PROTOCOL description from xboxdrv userspace driver
> + *  - LED and rumble support added for wireless 360 controller (protocol
> + *    is different from wired!)
> + *
> + * 2004-10-02 - 0.0.6 : DDR pad support
> + *  - borrowed from the XBOX linux kernel
> + *  - USB id's for commonly used dance pads are present
> + *  - dance pads will map D-PAD to buttons, not axes
> + *  - pass the module paramater 'dpad_to_buttons' to force
> + *    the D-PAD to map to buttons if your pad is not detected
> + *
> + * 2002-07-17 - 0.0.5 : simplified d-pad handling
> + *
> + * 2002-07-16 - 0.0.4 : minor changes, merge with Vojtech's v0.0.3
> + *  - verified the lack of HID and report descriptors
> + *  - verified that ALL buttons WORK
> + *  - fixed d-pad to axes mapping
> + *
> + * 2002-07-14 - 0.0.3 : rework by Vojtech Pavlik
> + *  - indentation fixes
> + *  - usb + input init sequence fixes
> + *
> + * 2002-07-02 - 0.0.2 : basic working version
> + *  - all axes and 9 of the 10 buttons work (german InterAct device)
> + *  - the black button does not work
> + *
> + * 2002-06-27 - 0.0.1 : first version, just said "XBOX HID controller"
> + *
> + */

-- 
Anssi Hannula
