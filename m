From: Mike Murphy <mamurph@cs.clemson.edu>
Subject: Re: [patch 1/2] input: drivers/input/xpad.c: improve Xbox 360
	wireless support and add sysfs interface
Date: Fri, 18 Sep 2009 16:18:39 -0400
Message-ID: <5aa163d00909181318p2f6d18bcpa1773913dba542e6@mail.gmail.com>
References: <200909181948.n8IJmc1I017429@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:54290 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbZIRUSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 16:18:37 -0400
Received: by mail-bw0-f210.google.com with SMTP id 6so932762bwz.37
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2009 13:18:40 -0700 (PDT)
In-Reply-To: <200909181948.n8IJmc1I017429@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: dtor@mail.ru, linux-input@vger.kernel.org, randy.dunlap@oracle.com

I can confirm the presence of a concurrency bug in the modified xpad
code, which directly results from submission of the USB urb using
GFP_KERNEL when rumble (force feedback) is utilized. It turns out the
ff_memoryless code is holding an IRQ spinlock before invoking the xpad
code, so the urb submission should be atomic. However, the
rumble-handling code in the xpad driver (both the modified and stable
versions) takes a mutex while holding the spinlock, which doesn't seem
correct.

I do not have time to continue working on this problem and am
personally moving to a userspace driver. Unless someone else wants to
pick up this code, I suggest dropping my patches, with the note that
the current stable xpad driver has exactly the same concurrency bug.
Since the current stable version only supports rumble on wired
controllers anyway, removing the force feedback code altogether might
be the simplest resolution if nobody wants to maintain the code for
the wireless devices.

Thanks,
Mike

On Fri, Sep 18, 2009 at 3:48 PM,  <akpm@linux-foundation.org> wrote:
> From: Mike Murphy <mamurph@cs.clemson.edu>
>
> Improved support for Xbox 360 wireless devices by enabling rumble and
> LED control, improved general usability by adding input controls, and
> added a sysfs interface for tuning driver behavior. Updated with fixe=
s
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
> =A0drivers/input/joystick/xpad.c | 1026 ++++++++++++++++++++++-------=
---
> =A0drivers/input/joystick/xpad.h | =A0406 ++++++++++++
> =A02 files changed, 1135 insertions(+), 297 deletions(-)
>
> diff -puN drivers/input/joystick/xpad.c~input-drivers-input-xpadc-imp=
rove-xbox-360-wireless-support-and-add-sysfs-interface drivers/input/jo=
ystick/xpad.c
> --- a/drivers/input/joystick/xpad.c~input-drivers-input-xpadc-improve=
-xbox-360-wireless-support-and-add-sysfs-interface
> +++ a/drivers/input/joystick/xpad.c
> @@ -1,5 +1,8 @@
> =A0/*
> - * X-Box gamepad driver
> + * Xbox gamepad driver with Xbox 360 wired/wireless support
> + *
> + * Last Modified: =A0 =A0 =A06 March 2009
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mike Murphy <mamurph@cs.c=
lemson.edu>
> =A0*
> =A0* Copyright (c) 2002 Marko Friedemann <mfr@bmx-chemnitz.de>
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 2004 Oliver Schwartz <Oliver.Schwart=
z@gmx.de>,
> @@ -9,6 +12,8 @@
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 2005 Dominic Cerquetti <binary1230@y=
ahoo.com>
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 2006 Adam Buchbinder <adam.buchbinde=
r@gmail.com>
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 2007 Jan Kratochvil <honza@jikos.cz>
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2009 Clemson University
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (contact: Mike Murphy <mamurp=
h@cs.clemson.edu>)
> =A0*
> =A0* This program is free software; you can redistribute it and/or
> =A0* modify it under the terms of the GNU General Public License as
> @@ -24,131 +29,120 @@
> =A0* along with this program; if not, write to the Free Software
> =A0* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1=
307 USA
> =A0*
> - *
> - * This driver is based on:
> - * =A0- information from =A0 =A0 http://euc.jp/periphs/xbox-controll=
er.ja.html
> - * =A0- the iForce driver =A0 =A0drivers/char/joystick/iforce.c
> - * =A0- the skeleton-driver =A0drivers/usb/usb-skeleton.c
> - * =A0- Xbox 360 information http://www.free60.org/wiki/Gamepad
> - *
> - * Thanks to:
> - * =A0- ITO Takayuki for providing essential xpad information on his=
 website
> - * =A0- Vojtech Pavlik =A0 =A0 - iforce driver / input subsystem
> - * =A0- Greg Kroah-Hartman - usb-skeleton driver
> - * =A0- XBOX Linux project - extra USB id's
> - *
> - * TODO:
> - * =A0- fine tune axes (especially trigger axes)
> - * =A0- fix "analog" buttons (reported as digital now)
> - * =A0- get rumble working
> - * =A0- need USB IDs for other dance pads
> - *
> - * History:
> - *
> - * 2002-06-27 - 0.0.1 : first version, just said "XBOX HID controlle=
r"
> - *
> - * 2002-07-02 - 0.0.2 : basic working version
> - * =A0- all axes and 9 of the 10 buttons work (german InterAct devic=
e)
> - * =A0- the black button does not work
> - *
> - * 2002-07-14 - 0.0.3 : rework by Vojtech Pavlik
> - * =A0- indentation fixes
> - * =A0- usb + input init sequence fixes
> - *
> - * 2002-07-16 - 0.0.4 : minor changes, merge with Vojtech's v0.0.3
> - * =A0- verified the lack of HID and report descriptors
> - * =A0- verified that ALL buttons WORK
> - * =A0- fixed d-pad to axes mapping
> - *
> - * 2002-07-17 - 0.0.5 : simplified d-pad handling
> - *
> - * 2004-10-02 - 0.0.6 : DDR pad support
> - * =A0- borrowed from the XBOX linux kernel
> - * =A0- USB id's for commonly used dance pads are present
> - * =A0- dance pads will map D-PAD to buttons, not axes
> - * =A0- pass the module paramater 'dpad_to_buttons' to force
> - * =A0 =A0the D-PAD to map to buttons if your pad is not detected
> - *
> - * Later changes can be tracked in SCM.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/stat.h>
> -#include <linux/module.h>
> -#include <linux/usb/input.h>
> -
> -#define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
> -#define DRIVER_DESC "X-Box pad driver"
> -
> -#define XPAD_PKT_LEN 32
> -
> -/* xbox d-pads should map to buttons, as is required for DDR pads
> - =A0 but we map them to axes when possible to simplify things */
> -#define MAP_DPAD_TO_BUTTONS =A0 =A00
> -#define MAP_DPAD_TO_AXES =A0 =A0 =A0 1
> -#define MAP_DPAD_UNKNOWN =A0 =A0 =A0 2
> -
> -#define XTYPE_XBOX =A0 =A0 =A0 =A00
> -#define XTYPE_XBOX360 =A0 =A0 1
> -#define XTYPE_XBOX360W =A0 =A02
> -#define XTYPE_UNKNOWN =A0 =A0 3
> + * Please see xbox.h for the ChangeLog.
> + */
>
> +#include "xpad.h"
> +
> +/* This module parameter is something of a relic, but it remains for
> + * compatibility. Importantly, the option to map the D-PAD buttons a=
pplies
> + * only to controller *interfaces* (i.e. vendor and product codes) n=
ot
> + * explicitly present in xpad_device[]. */
> =A0static int dpad_to_buttons;
> =A0module_param(dpad_to_buttons, bool, S_IRUGO);
> -MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than =
axes for unknown pads");
> +MODULE_PARM_DESC(dpad_to_buttons,
> + =A0 =A0 =A0 "Map D-PAD to buttons rather than axes for unknown pads=
");
> +
>
> +/* Table of various device interfaces recognized by this driver. Eac=
h supported
> + * device has a directional pad mapping, interface type, and control=
ler type.
> + * Note that wireless 360 devices have XCONTROLLER_TYPE_NONE, as the=
 actual
> + * type of the gaming controller is not known until the controller b=
inds
> + * wirelessly with the receiver
> + */
> =A0static const struct xpad_device {
> =A0 =A0 =A0 =A0u16 idVendor;
> =A0 =A0 =A0 =A0u16 idProduct;
> =A0 =A0 =A0 =A0char *name;
> =A0 =A0 =A0 =A0u8 dpad_mapping;
> =A0 =A0 =A0 =A0u8 xtype;
> + =A0 =A0 =A0 u8 controller_type;
> =A0} xpad_device[] =3D {
> - =A0 =A0 =A0 { 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPA=
D_TO_BUTTONS, XTYPE_XBOX360W },
> - =A0 =A0 =A0 { 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_=
TO_BUTTONS, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_=
DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x046d, 0xc242, "Logitech Chillstream Controller", MA=
P_DPAD_TO_AXES, XTYPE_XBOX360 },
> - =A0 =A0 =A0 { 0x046d, 0xca84, "Logitech Xbox Cordless Controller", =
MAP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x046d, 0xca88, "Logitech Compact Controller for Xbox=
", MAP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x05fd, 0x1007, "Mad Catz Controller (unverified)", M=
AP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (G=
ermany)", MAP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4516, "Mad Catz Control Pad", MAP_DPAD_TO_A=
XES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4522, "Mad Catz LumiCON", MAP_DPAD_TO_AXES,=
 XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4526, "Mad Catz Control Pad Pro", MAP_DPAD_=
TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4536, "Mad Catz MicroCON", MAP_DPAD_TO_AXES=
, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTT=
ONS, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", =
MAP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller",=
 MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
> - =A0 =A0 =A0 { 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_=
BUTTONS, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_=
TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0c12, 0x880a, "Pelican Eclipse PL-2023", MAP_DPAD_T=
O_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0c12, 0x8810, "Zeroplus Xbox Controller", MAP_DPAD_=
TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", MA=
P_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0e4c, 0x1097, "Radica Gamester Controller", MAP_DPA=
D_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0e4c, 0x2390, "Radica Games Jtech Controller", MAP_=
DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0e6f, 0x0003, "Logic3 Freebird wireless Controller"=
, MAP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0e6f, 0x0005, "Eclipse wireless Controller", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0e6f, 0x0006, "Edge wireless Controller", MAP_DPAD_=
TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0e6f, 0x0006, "Pelican 'TSZ' Wired Xbox 360 Control=
ler", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
> - =A0 =A0 =A0 { 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", MAP=
_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0f30, 0x0202, "Joytech Advanced Controller", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0f30, 0x8888, "BigBen XBMiniPad Controller", MAP_DP=
AD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x102c, 0xff0c, "Joytech Wireless Advanced Controller=
", MAP_DPAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTT=
ONS, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP=
_DPAD_TO_AXES, XTYPE_XBOX360 },
> - =A0 =A0 =A0 { 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)=
", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_T=
O_AXES, XTYPE_XBOX360 },
> - =A0 =A0 =A0 { 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPA=
D_TO_BUTTONS, XTYPE_XBOX360 },
> - =A0 =A0 =A0 { 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_D=
PAD_TO_AXES, XTYPE_XBOX },
> - =A0 =A0 =A0 { 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN=
, XTYPE_UNKNOWN }
> + =A0 =A0 =A0 { 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPA=
D_TO_BUTTONS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX360W, XCONTROLLER_TYPE_NONE }=
,
> + =A0 =A0 =A0 { 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_=
TO_BUTTONS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_DANCE_PAD =
},
> + =A0 =A0 =A0 { 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_=
DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x046d, 0xc242, "Logitech Chillstream Controller", MA=
P_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX360, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x046d, 0xca84, "Logitech Xbox Cordless Controller", =
MAP_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x046d, 0xca88, "Logitech Compact Controller for Xbox=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_AXES, XTYPE_XBOX, XCONTROLL=
ER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x05fd, 0x1007, "Mad Catz Controller (unverified)", M=
AP_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (G=
ermany)",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_AXES, XTYPE_XBOX, XCONTROLL=
ER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4516, "Mad Catz Control Pad", MAP_DPAD_TO_A=
XES, XTYPE_XBOX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4522, "Mad Catz LumiCON", MAP_DPAD_TO_AXES,=
 XTYPE_XBOX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4526, "Mad Catz Control Pad Pro", MAP_DPAD_=
TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4536, "Mad Catz MicroCON", MAP_DPAD_TO_AXES=
, XTYPE_XBOX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTT=
ONS, XTYPE_XBOX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XCONTROLLER_TYPE_DANCE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", =
MAP_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_AXES, XTYPE_XBOX360, XCONTR=
OLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_=
BUTTONS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_DANCE_PAD =
},
> + =A0 =A0 =A0 { 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_=
TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0c12, 0x880a, "Pelican Eclipse PL-2023", MAP_DPAD_T=
O_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0c12, 0x8810, "Zeroplus Xbox Controller", MAP_DPAD_=
TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", MA=
P_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e4c, 0x1097, "Radica Gamester Controller", MAP_DPA=
D_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e4c, 0x2390, "Radica Games Jtech Controller", MAP_=
DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e6f, 0x0003, "Logic3 Freebird wireless Controller"=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_AXES, XTYPE_XBOX, XCONTROLL=
ER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e6f, 0x0005, "Eclipse wireless Controller", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e6f, 0x0006, "Edge wireless Controller", MAP_DPAD_=
TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e6f, 0x0006, "Pelican 'TSZ' Wired Xbox 360 Control=
ler",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_AXES, XTYPE_XBOX360, XCONTR=
OLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", MAP=
_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0f30, 0x0202, "Joytech Advanced Controller", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0f30, 0x8888, "BigBen XBMiniPad Controller", MAP_DP=
AD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x102c, 0xff0c, "Joytech Wireless Advanced Controller=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_AXES, XTYPE_XBOX, XCONTROLL=
ER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTT=
ONS, XTYPE_XBOX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XCONTROLLER_TYPE_DANCE_PAD },
> + =A0 =A0 =A0 { 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP=
_DPAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX360, XCONTROLLER_TYPE_GUITAR =
},
> + =A0 =A0 =A0 { 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_DPAD_TO_BUTTONS, XTYPE_XBOX, XCONTR=
OLLER_TYPE_DANCE_PAD },
> + =A0 =A0 =A0 { 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_T=
O_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX360, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPA=
D_TO_BUTTONS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX360, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_D=
PAD_TO_AXES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XTYPE_XBOX, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN=
, XTYPE_UNKNOWN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XCONTROLLER_TYPE_PAD }
> =A0};
>
> +
> =A0/* buttons shared with xbox and xbox360 */
> =A0static const signed short xpad_common_btn[] =3D {
> =A0 =A0 =A0 =A0BTN_A, BTN_B, BTN_X, BTN_Y, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* "analog" buttons */
> @@ -169,12 +163,14 @@ static const signed short xpad_btn_pad[]
> =A0 =A0 =A0 =A0-1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* terminating entry */
> =A0};
>
> -static const signed short xpad360_btn[] =3D { =A0/* buttons for x360=
 controller */
> +/* buttons for x360 controller */
> +static const signed short xpad360_btn[] =3D {
> =A0 =A0 =A0 =A0BTN_TL, BTN_TR, =A0 =A0 =A0 =A0 /* Button LB/RB */
> =A0 =A0 =A0 =A0BTN_MODE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The big X but=
ton */
> =A0 =A0 =A0 =A0-1
> =A0};
>
> +/* sticks and triggers common to all devices */
> =A0static const signed short xpad_abs[] =3D {
> =A0 =A0 =A0 =A0ABS_X, ABS_Y, =A0 =A0 =A0 =A0 =A0 /* left stick */
> =A0 =A0 =A0 =A0ABS_RX, ABS_RY, =A0 =A0 =A0 =A0 /* right stick */
> @@ -188,62 +184,350 @@ static const signed short xpad_abs_pad[]
> =A0 =A0 =A0 =A0-1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* termi=
nating entry */
> =A0};
>
> -/* Xbox 360 has a vendor-specific class, so we cannot match it with =
only
> - * USB_INTERFACE_INFO (also specifically refused by USB subsystem), =
so we
> - * match against vendor id as well. Wired Xbox 360 devices have prot=
ocol 1,
> - * wireless controllers have protocol 129. */
> -#define XPAD_XBOX360_VENDOR_PROTOCOL(vend,pr) \
> - =A0 =A0 =A0 .match_flags =3D USB_DEVICE_ID_MATCH_VENDOR | USB_DEVIC=
E_ID_MATCH_INT_INFO, \
> - =A0 =A0 =A0 .idVendor =3D (vend), \
> - =A0 =A0 =A0 .bInterfaceClass =3D USB_CLASS_VENDOR_SPEC, \
> - =A0 =A0 =A0 .bInterfaceSubClass =3D 93, \
> - =A0 =A0 =A0 .bInterfaceProtocol =3D (pr)
> -#define XPAD_XBOX360_VENDOR(vend) \
> - =A0 =A0 =A0 { XPAD_XBOX360_VENDOR_PROTOCOL(vend,1) }, \
> - =A0 =A0 =A0 { XPAD_XBOX360_VENDOR_PROTOCOL(vend,129) }
> -
> -static struct usb_device_id xpad_table [] =3D {
> - =A0 =A0 =A0 { USB_INTERFACE_INFO('X', 'B', 0) }, =A0 =A0/* X-Box US=
B-IF not approved class */
> - =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x045e), =A0 =A0 =A0 =A0 =A0 =A0/* =
Microsoft X-Box 360 controllers */
> - =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x046d), =A0 =A0 =A0 =A0 =A0 =A0/* =
Logitech X-Box 360 style controllers */
> - =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x0738), =A0 =A0 =A0 =A0 =A0 =A0/* =
Mad Catz X-Box 360 controllers */
> - =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x0e6f), =A0 =A0 =A0 =A0 =A0 =A0/* =
0x0e6f X-Box 360 controllers */
> - =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x1430), =A0 =A0 =A0 =A0 =A0 =A0/* =
RedOctane X-Box 360 controllers */
> - =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x1bad), =A0 =A0 =A0 =A0 =A0 =A0/* =
Rock Band Drums */
> +static struct usb_device_id xpad_table[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* X-Box USB-IF not approved class */
> + =A0 =A0 =A0 { USB_INTERFACE_INFO('X', 'B', 0) },
> + =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x045e), =A0 =A0/* Microsoft X-Box =
360 controllers */
> + =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x046d), =A0 =A0/* Logitech 360 sty=
le controllers */
> + =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x0738), =A0 =A0/* Mad Catz X-Box 3=
60 controllers */
> + =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x0e6f), =A0 =A0/* 0x0e6f X-Box 360=
 controllers */
> + =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x1430), =A0 =A0/* RedOctane X-Box =
360 controllers */
> + =A0 =A0 =A0 XPAD_XBOX360_VENDOR(0x1bad), =A0 =A0/* Rock Band Drums =
*/
> =A0 =A0 =A0 =A0{ }
> =A0};
>
> -MODULE_DEVICE_TABLE (usb, xpad_table);
> +MODULE_DEVICE_TABLE(usb, xpad_table);
>
> -struct usb_xpad {
> - =A0 =A0 =A0 struct input_dev *dev; =A0 =A0 =A0 =A0 =A0/* input devi=
ce interface */
> - =A0 =A0 =A0 struct usb_device *udev; =A0 =A0 =A0 =A0/* usb device *=
/
> +static struct usb_driver xpad_driver =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "xpad",
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D xpad_probe,
> + =A0 =A0 =A0 .disconnect =A0 =A0 =3D xpad_disconnect,
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D xpad_table,
> +};
>
> - =A0 =A0 =A0 int pad_present;
>
> - =A0 =A0 =A0 struct urb *irq_in; =A0 =A0 =A0 =A0 =A0 =A0 /* urb for =
interrupt in report */
> - =A0 =A0 =A0 unsigned char *idata; =A0 =A0 =A0 =A0 =A0 /* input data=
 */
> - =A0 =A0 =A0 dma_addr_t idata_dma;
> +/* Wireless 360 device identification.
> + *
> + * When a wireless controller connects, the 2nd packet it sends SEEM=
S to
> + * be some kind of unique controller identification message. Using u=
sbmon
> + * (see Documentation/usb/usbmon.txt), I tried 4 gamepads and a guit=
ar, and
> + * I collected the following 5 ID packets from the 5 devices:
> + *
> + * 000f00f0 00ccfd27 0060e226 63700010 13e3201d 30034001 5001ffff ff
> + * 000f00f0 f0ccfd27 0060d8c4 e9600009 13e7201d 30034001 5001ffff ff
> + * 000f00f0 00ccfd27 0060578b 82f00010 13e3201d 30034001 5001ffff ff
> + * 000f00f0 f0ccfd27 0060da1c b1500009 13e7201d 30034001 5001ffff ff
> + * 000f00f0 f0ccfd27 006002d1 71d10000 13e3201d 30034430 5107ffff ff
> + *
> + * From this trace data, I concocted the following (potentially inco=
rrect)
> + * scheme for detecting type and unique ID:
> + *
> + * ******** xx****xx xxxxxxxx xxxx**xx **xx**** ****tttt tttt**** **
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0unique id | =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0| =A0type |
> + *
> + * It appears that some of the bytes in the first half of the messag=
e, noted
> + * above as "unique id" are some sort of serial number, though I can=
not work
> + * out any correspondence between these bytes and the serial number =
printed
> + * under the battery pack. Many of the bytes in this possibly unique=
 field
> + * are not unique across my controllers, and may not in fact be part=
 of the
> + * controller's unique identification, but I figured it was better t=
o have
> + * extra bytes on either end of the unique byte string instead of th=
e
> + * alternative. In addition, the packet appears to indicate the type=
 of
> + * the controller toward the end: the pads all send 4001 5001, while=
 the
> + * guitar sends 4430 5107.
> + *
> + * Further testing over a wider variety of devices is probably neede=
d to
> + * determine if changes need to be made to this scheme.
> + */
> +static const struct w360_id {
> + =A0 =A0 =A0 unsigned char id_bytes[4];
> + =A0 =A0 =A0 u8 controller_type;
> +} w360_id[] =3D {
> + =A0 =A0 =A0 { {0x40, 0x01, 0x50, 0x01}, XCONTROLLER_TYPE_PAD },
> + =A0 =A0 =A0 { {0x44, 0x30, 0x51, 0x07}, XCONTROLLER_TYPE_GUITAR },
> + =A0 =A0 =A0 { {0x00, 0x00, 0x00, 0x00}, XCONTROLLER_TYPE_NONE }
> +};
>
> - =A0 =A0 =A0 struct urb *bulk_out;
> - =A0 =A0 =A0 unsigned char *bdata;
>
> -#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD=
_LEDS)
> - =A0 =A0 =A0 struct urb *irq_out; =A0 =A0 =A0 =A0 =A0 =A0/* urb for =
interrupt out report */
> - =A0 =A0 =A0 unsigned char *odata; =A0 =A0 =A0 =A0 =A0 /* output dat=
a */
> - =A0 =A0 =A0 dma_addr_t odata_dma;
> - =A0 =A0 =A0 struct mutex odata_mutex;
> -#endif
> +/* The dead zone and stick limit both affect the behavior of the cor=
responding
> + * analog stick, since the output values reported for the stick inpu=
ts will
> + * be scaled onto [0,32767]. It is thus necessary to ensure that the=
 dead zone
> + * is never larger than the stick limit. In fact, a minimal amount o=
f stick
> + * travel space (1024) is maintained between the two values. In prac=
tice,
> + * however, the stick limit should always be much greater than the d=
ead zone.
> + */
>
> -#if defined(CONFIG_JOYSTICK_XPAD_LEDS)
> - =A0 =A0 =A0 struct xpad_led *led;
> -#endif
> +static void set_dead_zone(unsigned int new_size, unsigned int *dz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int stick_limit)
> +{
> + =A0 =A0 =A0 *dz =3D min(new_size, stick_limit - 1024);
> +}
>
> - =A0 =A0 =A0 char phys[64]; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* ph=
ysical device path */
> +static void set_stick_limit(unsigned int new_size, unsigned int *sl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int dead_zone)
> +{
> + =A0 =A0 =A0 *sl =3D min(max(new_size, dead_zone + 1024), 32767u);
> +}
> +
> +
> +/*******************************************************************=
*********/
> +/*
> + * SysFs interface functions
> + *
> + * We use common functions, where possible, to implement the show/st=
ore
> + * routines. This design saves on code and reduces the burden of add=
ing to or
> + * changing the interface.
> + */
> +
> +
> +static ssize_t xpad_show_uint(struct device *dev, struct device_attr=
ibute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D to_xpad(dev);
> + =A0 =A0 =A0 unsigned int value;
> + =A0 =A0 =A0 if (attr =3D=3D &dev_attr_left_dead_zone)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->left_dead_zone;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_right_dead_zone)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->right_dead_zone;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_left_stick_limit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->left_stick_limit;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_right_stick_limit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->right_stick_limit;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 return snprintf(buf, PAGE_SIZE, "%u\n", value);
> +}
> +
> +
> +static ssize_t xpad_store_uint(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const ch=
ar *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D to_xpad(dev);
> + =A0 =A0 =A0 unsigned int new_value;
> + =A0 =A0 =A0 if (sscanf(buf, "%u", &new_value) !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 if (attr =3D=3D &dev_attr_left_dead_zone)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dead_zone(new_value, &xpad->left_de=
ad_zone,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->l=
eft_stick_limit);
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_right_dead_zone)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dead_zone(new_value, &xpad->right_d=
ead_zone,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->r=
ight_stick_limit);
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_left_stick_limit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_stick_limit(new_value, &xpad->left_=
stick_limit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->l=
eft_dead_zone);
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_right_stick_limit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_stick_limit(new_value, &xpad->right=
_stick_limit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->r=
ight_dead_zone);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 return strnlen(buf, PAGE_SIZE);
> +}
> +
> +
> +static ssize_t xpad_store_bool(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const ch=
ar *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D to_xpad(dev);
> + =A0 =A0 =A0 int newvalue;
> + =A0 =A0 =A0 if (sscanf(buf, "%d", &newvalue) !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 if (attr =3D=3D &dev_attr_rumble_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->rumble_enable =3D (newvalue) ? 1 =
: 0;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_left_trigger_full_axis)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->left_trigger_full_axis =3D (newva=
lue) ? 1 : 0;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_right_trigger_full_axis)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->right_trigger_full_axis =3D (newv=
alue) ? 1 : 0;
> + =A0 =A0 =A0 return strnlen(buf, PAGE_SIZE);
> +}
> +
> +
> +/* read-only attributes share a common store function that returns a=
n error */
> +static ssize_t xpad_store_ro(struct device *dev, struct device_attri=
bute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 return -EIO;
> +}
> +
> +
> +static ssize_t xpad_show_int(struct device *dev, struct device_attri=
bute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D to_xpad(dev);
> + =A0 =A0 =A0 int value;
> + =A0 =A0 =A0 if (attr =3D=3D &dev_attr_rumble_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->rumble_enable;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_controller_number)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->controller_number;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_controller_present)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->controller_present;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_controller_type)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->controller_type;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_left_trigger_full_axis)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->left_trigger_full_axis;
> + =A0 =A0 =A0 else if (attr =3D=3D &dev_attr_right_trigger_full_axis)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->right_trigger_full_axis=
;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +}
> +
> +
> +static ssize_t xpad_show_id(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *bu=
f)
> +{
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D to_xpad(dev);
> + =A0 =A0 =A0 return snprintf(buf, PAGE_SIZE, "%s\n", xpad->controlle=
r_unique_id);
> +}
> +
> +
> +/* end of sysfs interface */
> +/*******************************************************************=
**********/
> +
> +/* Input section */
> +
> +/* =A0 =A0 xpad_init_controller
> + *
> + * =A0 =A0 Performs controller setup based on controller type.
> + *
> + * =A0 =A0 NOTE: xpad->controller_data->controller_type needs to be =
set BEFORE
> + * =A0 =A0 calling this function!
> + */
> +
> +static void xpad_init_controller(struct usb_xpad *xpad)
> +{
> + =A0 =A0 =A0 set_stick_limit(XSTICK_LIMIT_DEFAULT, &xpad->left_stick=
_limit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->left_dead_zone);
> + =A0 =A0 =A0 set_stick_limit(XSTICK_LIMIT_DEFAULT, &xpad->right_stic=
k_limit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->right_dead_zone);
> + =A0 =A0 =A0 set_dead_zone(XDEAD_ZONE_DEFAULT, &xpad->left_dead_zone=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->left_stick_limit)=
;
> + =A0 =A0 =A0 set_dead_zone(XDEAD_ZONE_DEFAULT, &xpad->right_dead_zon=
e,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->right_stick_limit=
);
> + =A0 =A0 =A0 xpad->left_trigger_full_axis =3D XFULL_TRIGGER_AXIS_DEF=
AULT;
> + =A0 =A0 =A0 xpad->right_trigger_full_axis =3D XFULL_TRIGGER_AXIS_DE=
=46AULT;
> +
> + =A0 =A0 =A0 if (xpad->controller_type =3D=3D XCONTROLLER_TYPE_GUITA=
R)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->rumble_enable =3D 0;
> + =A0 =A0 =A0 else if (xpad->controller_type =3D=3D XCONTROLLER_TYPE_=
DANCE_PAD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->rumble_enable =3D 0;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->rumble_enable =3D 1;
> +}
> +
> +
> +/*
> + * =A0 =A0 xpad_process_sticks
> + *
> + * =A0 =A0 Handles stick input, accounting for dead zones and square=
 axes. Based
> + * =A0 =A0 on the original handlers for the Xbox and Xbox 360 in
> + * =A0 =A0 xpad_process_packet and xpad360_process_packet, but unifi=
ed to avoid
> + * =A0 =A0 duplication.
> + *
> + * =A0 =A0 Whenever a dead zone is used, each axis is scaled so that=
 moving the
> + * =A0 =A0 stick slightly out of the dead zone range results in a lo=
w axis
> + * =A0 =A0 value in jstest(1), while moving the stick to the maximum=
 position
> + * =A0 =A0 along any axis still results in 32767.
> + *
> + * =A0 =A0 In order to provide the ability to map inputs to a square=
 axis (used
> + * =A0 =A0 by older games), the left_stick_limit and right_stick_lim=
it can be
> + * =A0 =A0 set. These limits specify at what point in the raw input =
coordinates
> + * =A0 =A0 an axis is reported to be at maximum value (32767 or -327=
67).
> + *
> + * =A0 =A0 Both the dead zone and stick limit algorithms are impleme=
nted
> + * =A0 =A0 together as a coordinate transformation from "effective c=
oordinates"
> + * =A0 =A0 onto the output coordinates (which have absolute values f=
rom 0 to
> + * =A0 =A0 32767 and are positive or negative based on direction). E=
ffective
> + * =A0 =A0 coordinates are defined as those input values that are gr=
eater than
> + * =A0 =A0 the dead zone but less than the stick limit on the axis i=
n question.
> + *
> + * =A0 =A0 DANGER: All denominator values in division operations MUS=
T be checked
> + * =A0 =A0 for non-zero condition. Dividing by zero inside the kerne=
l can cause
> + * =A0 =A0 a system deadlock.
> + */
> +
> +static void xpad_process_sticks(struct usb_xpad *xpad, __le16 *data)
> +{
> + =A0 =A0 =A0 struct input_dev *dev =3D xpad->dev;
> + =A0 =A0 =A0 s16 coords[4]; =A0 =A0/* x, y, rx, ry */
> + =A0 =A0 =A0 int c;
> + =A0 =A0 =A0 int range;
> + =A0 =A0 =A0 int abs_magnitude, adjusted_magnitude, difference, scal=
e_fraction;
> + =A0 =A0 =A0 int dead_zone[2], stick_limit[2];
> +
> + =A0 =A0 =A0 dead_zone[0] =3D xpad->left_dead_zone;
> + =A0 =A0 =A0 dead_zone[1] =3D xpad->right_dead_zone;
> + =A0 =A0 =A0 stick_limit[0] =3D xpad->left_stick_limit;
> + =A0 =A0 =A0 stick_limit[1] =3D xpad->right_stick_limit;
> +
> + =A0 =A0 =A0 /* Stick input data starts at byte 12 (16-bit word 6) f=
or the regular
> + =A0 =A0 =A0 =A0* Xbox controller, byte 6 (16-bit word 3) for the 36=
0 controllers */
> + =A0 =A0 =A0 data +=3D (xpad->xtype =3D=3D XTYPE_XBOX) ? 6 : 3;
> +
> + =A0 =A0 =A0 coords[0] =3D le16_to_cpup(data);
> + =A0 =A0 =A0 coords[1] =3D ~le16_to_cpup(data + 1);
> + =A0 =A0 =A0 coords[2] =3D le16_to_cpup(data + 2);
> + =A0 =A0 =A0 coords[3] =3D ~le16_to_cpup(data + 3);
> +
> + =A0 =A0 =A0 /* Adjustment for dead zone and square axis */
> + =A0 =A0 =A0 for (c =3D 0; c < 4; c++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 abs_magnitude =3D abs(coords[c]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted_magnitude =3D abs_magnitude;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 range =3D (stick_limit[c/2] - dead_zone=
[c/2]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (abs_magnitude >=3D stick_limit[c/2]=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted_magnitude =3D =
32767;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (abs_magnitude <=3D dead_zone=
[c/2]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted_magnitude =3D =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (range > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 difference =3D 32767 - =
range;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (difference) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DIVI=
SION: difference non-zero */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scale_f=
raction =3D range / difference;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjuste=
d_magnitude =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 abs_magnitude - dead_zone[c/2];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Appr=
oximate floating-point division with a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* "c=
atch-up" scaling algorithm that adds back
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to=
 the adjusted_magnitude based on distance
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fr=
om the origin (0 in adjusted coordinates).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If=
 the range / difference is at least 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* th=
en 1 needs to be added to the adjusted
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ma=
gnitude for every scale_fraction units
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fr=
om the origin. If the range / difference
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is=
 less than 1 (0 in integer division),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* th=
en divide the difference by the range to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ob=
tain the number of units to add per unit
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fr=
om the adjusted origin.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sca=
le_fraction) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* DIVISION: scale_fraction non-zero */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 adjusted_magnitude +=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 adjusted_magnitude
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 / scale_fraction;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* DIVISION: range non-zero */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 scale_fraction =3D difference / range;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 adjusted_magnitude +=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 adjusted_magnitude
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 * scale_fraction;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (adj=
usted_magnitude > 32767)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 adjusted_magnitude =3D 32767;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 coords[c] =3D (coords[c] < 0) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -adjust=
ed_magnitude : adjusted_magnitude;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_report_abs(dev, ABS_X, coords[0]);
> + =A0 =A0 =A0 input_report_abs(dev, ABS_Y, coords[1]);
> + =A0 =A0 =A0 input_report_abs(dev, ABS_RX, coords[2]);
> + =A0 =A0 =A0 input_report_abs(dev, ABS_RY, coords[3]);
> +}
>
> - =A0 =A0 =A0 int dpad_mapping; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* map d-=
pad to buttons or to axes */
> - =A0 =A0 =A0 int xtype; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* type of xbox device */
> -};
>
> =A0/*
> =A0* =A0 =A0 xpad_process_packet
> @@ -255,21 +539,13 @@ struct usb_xpad {
> =A0* =A0 =A0 =A0http://euc.jp/periphs/xbox-controller.ja.html
> =A0*/
>
> -static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data)
> +static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char *data)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *dev =3D xpad->dev;
>
> - =A0 =A0 =A0 /* left stick */
> - =A0 =A0 =A0 input_report_abs(dev, ABS_X,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(__s16) le16_to_cpup=
((__le16 *)(data + 12)));
> - =A0 =A0 =A0 input_report_abs(dev, ABS_Y,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~(__s16) le16_to_cpu=
p((__le16 *)(data + 14)));
> -
> - =A0 =A0 =A0 /* right stick */
> - =A0 =A0 =A0 input_report_abs(dev, ABS_RX,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(__s16) le16_to_cpup=
((__le16 *)(data + 16)));
> - =A0 =A0 =A0 input_report_abs(dev, ABS_RY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~(__s16) le16_to_cpu=
p((__le16 *)(data + 18)));
> + =A0 =A0 =A0 /* left and right sticks */
> + =A0 =A0 =A0 xpad_process_sticks(xpad, (__le16 *) data);
>
> =A0 =A0 =A0 =A0/* triggers left/right */
> =A0 =A0 =A0 =A0input_report_abs(dev, ABS_Z, data[10]);
> @@ -307,6 +583,7 @@ static void xpad_process_packet(struct u
> =A0 =A0 =A0 =A0input_sync(dev);
> =A0}
>
> +
> =A0/*
> =A0* =A0 =A0 xpad360_process_packet
> =A0*
> @@ -317,10 +594,11 @@ static void xpad_process_packet(struct u
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 http://www.free60.org/wiki/Gamepad
> =A0*/
>
> -static void xpad360_process_packet(struct usb_xpad *xpad,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u16 cmd, unsigned char *data)
> +static void xpad360_process_packet(struct usb_xpad *xpad, u16 cmd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char *data)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *dev =3D xpad->dev;
> + =A0 =A0 =A0 int trigger;
>
> =A0 =A0 =A0 =A0/* digital pad */
> =A0 =A0 =A0 =A0if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES) {
> @@ -353,25 +631,78 @@ static void xpad360_process_packet(struc
> =A0 =A0 =A0 =A0input_report_key(dev, BTN_TR, =A0 data[3] & 0x02);
> =A0 =A0 =A0 =A0input_report_key(dev, BTN_MODE, data[3] & 0x04);
>
> - =A0 =A0 =A0 /* left stick */
> - =A0 =A0 =A0 input_report_abs(dev, ABS_X,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(__s16) le16_to_cpup=
((__le16 *)(data + 6)));
> - =A0 =A0 =A0 input_report_abs(dev, ABS_Y,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~(__s16) le16_to_cpu=
p((__le16 *)(data + 8)));
> -
> - =A0 =A0 =A0 /* right stick */
> - =A0 =A0 =A0 input_report_abs(dev, ABS_RX,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(__s16) le16_to_cpup=
((__le16 *)(data + 10)));
> - =A0 =A0 =A0 input_report_abs(dev, ABS_RY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~(__s16) le16_to_cpu=
p((__le16 *)(data + 12)));
> + =A0 =A0 =A0 /* left and right sticks */
> + =A0 =A0 =A0 xpad_process_sticks(xpad, (__le16 *) data);
>
> - =A0 =A0 =A0 /* triggers left/right */
> - =A0 =A0 =A0 input_report_abs(dev, ABS_Z, data[4]);
> - =A0 =A0 =A0 input_report_abs(dev, ABS_RZ, data[5]);
> + =A0 =A0 =A0 /* triggers left/right: when full_axis is not enabled, =
report the
> + =A0 =A0 =A0 =A0* absolute data value (0-255), which will be mapped =
onto [0,32767].
> + =A0 =A0 =A0 =A0* If full axis is enabled, map the data value onto [=
-255:255], so
> + =A0 =A0 =A0 =A0* that the input subsystem maps it onto [-32767:3276=
7]. */
> + =A0 =A0 =A0 trigger =3D data[4];
> + =A0 =A0 =A0 if (xpad->left_trigger_full_axis)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger =3D (2 * trigger) - 255;
> + =A0 =A0 =A0 input_report_abs(dev, ABS_Z, trigger);
> + =A0 =A0 =A0 trigger =3D data[5];
> + =A0 =A0 =A0 if (xpad->right_trigger_full_axis)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger =3D (2 * trigger) - 255;
> + =A0 =A0 =A0 input_report_abs(dev, ABS_RZ, trigger);
>
> =A0 =A0 =A0 =A0input_sync(dev);
> =A0}
>
> +
> +static void xpad360w_identify_controller(struct usb_xpad *xpad)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned char *data =3D xpad->id_packet;
> +
> + =A0 =A0 =A0 if (!data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 snprintf(xpad->controller_unique_id, 17,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%02x%02x%02x%02x%02x%02x%02x%02x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data[8], data[9], data[10], data[11], d=
ata[12], data[13],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data[14], data[15]);
> +
> + =A0 =A0 =A0 /* Identify controller type */
> + =A0 =A0 =A0 xpad->controller_type =3D XCONTROLLER_TYPE_OTHER;
> + =A0 =A0 =A0 for (i =3D 0; w360_id[i].id_bytes; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!memcmp(data + 22, &w360_id[i].id_b=
ytes, 4)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_type =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w360_id=
[i].controller_type;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (xpad->controller_type =3D=3D XCONTROLLER_TYPE_OTHER=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "xpad: unknown wireles=
s controller: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%02x%02x %02x%02x\n", =
data[22], data[23], data[24],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data[25]);
> +}
> +
> +
> +/*
> + * =A0 =A0 xpad_work_controller
> + *
> + * =A0 =A0 Submits command to set pad number on LED display of wirel=
ess 360
> + * =A0 =A0 controllers, as well as online/offline event. The shared =
workqueue
> + * =A0 =A0 =A0is used for this purpose, so that the interrupt handle=
r is kept short.
> + */
> +
> +static void xpad_work_controller(struct work_struct *w)
> +{
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D container_of(w, struct usb_xp=
ad, work);
> + =A0 =A0 =A0 if (xpad->controller_present) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad360w_identify_controller(xpad);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_init_controller(xpad);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_send_led_command(xpad, xpad->contr=
oller_number + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kobject_uevent(&xpad->dev->dev.kobj, KO=
BJ_ONLINE);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kobject_uevent(&xpad->dev->dev.kobj, KO=
BJ_OFFLINE);
> + =A0 =A0 =A0 }
> +}
> +
> +
> =A0/*
> =A0* xpad360w_process_packet
> =A0*
> @@ -381,30 +712,57 @@ static void xpad360_process_packet(struc
> =A0* Byte.Bit
> =A0* 00.1 - Status change: The controller or headset has connected/di=
sconnected
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Bits 01.7 and 01.6 a=
re valid
> + * 01.f - Some kind of unique identifier message (see above)
> =A0* 01.7 - Controller present
> =A0* 01.6 - Headset present
> =A0* 01.1 - Pad state (Bytes 4+) valid
> =A0*
> =A0*/
>
> -static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, =
unsigned char *data)
> +static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char *data)
> =A0{
> + =A0 =A0 =A0 int padnum =3D 0;
> +
> =A0 =A0 =A0 =A0/* Presence change */
> =A0 =A0 =A0 =A0if (data[0] & 0x08) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 padnum =3D xpad->controller_number;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data[1] & 0x80) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->pad_present =3D 1=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_submit_urb(xpad->bu=
lk_out, GFP_ATOMIC);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->pad_present =3D 0=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ignore duplicates */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!xpad->controller_p=
resent) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->c=
ontroller_present =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*sched=
ule_work(&xpad->work);*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait=
 for id packet before setting
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* co=
ntroller type and LEDs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_presen=
t =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_unique=
_id[0] =3D '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_type =3D=
 XCONTROLLER_TYPE_NONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We do NOT flush the =
shared workqueue here, because
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this function is c=
alled from an interrupt handler.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the controller =
has disconnected from the receiver,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the worst that wil=
l happen from the work task running
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is that a packet w=
ill be transmitted from the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* receiver to a non-=
listening controller
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Valid pad data */
> - =A0 =A0 =A0 if (!(data[1] & 0x1))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 xpad360_process_packet(xpad, cmd, &data[4]);
> + =A0 =A0 =A0 /* Process packets according to type */
> + =A0 =A0 =A0 if (data[1] =3D=3D 0x0f) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!xpad->controller_unique_id[0]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xpad->id_packet) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(=
xpad->id_packet, data, 29);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedul=
e_work(&xpad->work);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else if (data[1] & 0x1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad360_process_packet(xpad, cmd, &data=
[4]);
> + =A0 =A0 =A0 }
> =A0}
>
> +
> =A0static void xpad_irq_in(struct urb *urb)
> =A0{
> =A0 =A0 =A0 =A0struct usb_xpad *xpad =3D urb->context;
> @@ -441,30 +799,22 @@ static void xpad_irq_in(struct urb *urb)
> =A0 =A0 =A0 =A0}
>
> =A0exit:
> - =A0 =A0 =A0 retval =3D usb_submit_urb (urb, GFP_ATOMIC);
> + =A0 =A0 =A0 retval =3D usb_submit_urb(urb, GFP_ATOMIC);
> =A0 =A0 =A0 =A0if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err ("%s - usb_submit_urb failed with r=
esult %d",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err("%s - usb_submit_urb failed with re=
sult %d",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, retval);
> =A0}
>
> -static void xpad_bulk_out(struct urb *urb)
> -{
> - =A0 =A0 =A0 switch (urb->status) {
> - =A0 =A0 =A0 case 0:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* success */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case -ECONNRESET:
> - =A0 =A0 =A0 case -ENOENT:
> - =A0 =A0 =A0 case -ESHUTDOWN:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this urb is terminated, clean up */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("%s - urb shutting down with status=
: %d", __func__, urb->status);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("%s - nonzero urb status received: =
%d", __func__, urb->status);
> - =A0 =A0 =A0 }
> -}
> +
> +/* end input section */
> +
> +/*******************************************************************=
**********/
> +/* IRQ output section: present in object code only if the force feed=
back or
> + * LED interface is enabled.
> + */
>
> =A0#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XP=
AD_LEDS)
> +
> =A0static void xpad_irq_out(struct urb *urb)
> =A0{
> =A0 =A0 =A0 =A0int retval, status;
> @@ -495,12 +845,13 @@ exit:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, retval);
> =A0}
>
> +
> =A0static int xpad_init_output(struct usb_interface *intf, struct usb=
_xpad *xpad)
> =A0{
> =A0 =A0 =A0 =A0struct usb_endpoint_descriptor *ep_irq_out;
> =A0 =A0 =A0 =A0int error =3D -ENOMEM;
>
> - =A0 =A0 =A0 if (xpad->xtype !=3D XTYPE_XBOX360)
> + =A0 =A0 =A0 if ((xpad->xtype !=3D XTYPE_XBOX360) && (xpad->xtype !=3D=
 XTYPE_XBOX360W))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0xpad->odata =3D usb_buffer_alloc(xpad->udev, XPAD_PKT_=
LEN,
> @@ -516,7 +867,8 @@ static int xpad_init_output(struct usb_i
>
> =A0 =A0 =A0 =A0ep_irq_out =3D &intf->cur_altsetting->endpoint[1].desc=
;
> =A0 =A0 =A0 =A0usb_fill_int_urb(xpad->irq_out, xpad->udev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_sndintpipe(xpad-=
>udev, ep_irq_out->bEndpointAddress),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_sndintpipe(xpad-=
>udev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep_irq_=
out->bEndpointAddress),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata, XPAD_PKT=
_LEN,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_irq_out, xpad, e=
p_irq_out->bInterval);
> =A0 =A0 =A0 =A0xpad->irq_out->transfer_dma =3D xpad->odata_dma;
> @@ -528,45 +880,82 @@ static int xpad_init_output(struct usb_i
> =A0fail1: =A0 =A0 =A0 =A0return error;
> =A0}
>
> +
> =A0static void xpad_stop_output(struct usb_xpad *xpad)
> =A0{
> - =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360)
> + =A0 =A0 =A0 if ((xpad->xtype =3D=3D XTYPE_XBOX360) || (xpad->xtype =
=3D=3D XTYPE_XBOX360W))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_kill_urb(xpad->irq_out);
> =A0}
>
> +
> =A0static void xpad_deinit_output(struct usb_xpad *xpad)
> =A0{
> - =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360) {
> + =A0 =A0 =A0 if ((xpad->xtype =3D=3D XTYPE_XBOX360) || (xpad->xtype =
=3D=3D XTYPE_XBOX360W)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_free_urb(xpad->irq_out);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_buffer_free(xpad->udev, XPAD_PKT_L=
EN,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad->=
odata, xpad->odata_dma);
> =A0 =A0 =A0 =A0}
> =A0}
> +
> =A0#else
> -static int xpad_init_output(struct usb_interface *intf, struct usb_x=
pad *xpad) { return 0; }
> +/* Dummy implementations for xpad_probe and xpad_disconnect */
> +static int xpad_init_output(struct usb_interface *intf, struct usb_x=
pad *xpad)
> + =A0 =A0 =A0 { return 0; }
> =A0static void xpad_deinit_output(struct usb_xpad *xpad) {}
> =A0static void xpad_stop_output(struct usb_xpad *xpad) {}
> =A0#endif
>
> +/* end output section */
> +
> +/*******************************************************************=
**********/
> +
> +/* Force feedback (rumble effect) section, depends on CONFIG_JOYSTIC=
K_XPAD_FF */
> +
> =A0#ifdef CONFIG_JOYSTICK_XPAD_FF
> +
> +/* Rumble support for wireless controllers follows protocol descript=
ion
> + * from xboxdrv userspace driver:
> + * =A0 =A0 =A0 http://pingus.seul.org/~grumbel/xboxdrv/
> + */
> =A0static int xpad_play_effect(struct input_dev *dev, void *data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ff_effe=
ct *effect)
> =A0{
> =A0 =A0 =A0 =A0struct usb_xpad *xpad =3D input_get_drvdata(dev);
>
> + =A0 =A0 =A0 if (!xpad->rumble_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0if (effect->type =3D=3D FF_RUMBLE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u16 strong =3D effect->u.rumble.stro=
ng_magnitude;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u16 weak =3D effect->u.rumble.weak_m=
agnitude;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[0] =3D 0x00;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[1] =3D 0x08;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[2] =3D 0x00;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[3] =3D strong / 256;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[4] =3D weak / 256;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[5] =3D 0x00;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[6] =3D 0x00;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[7] =3D 0x00;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->irq_out->transfer_buffer_length =3D=
 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&xpad->odata_mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360W) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[0] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[1] =3D 0x01=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[2] =3D 0x0f=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[3] =3D 0xc0=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[4] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[5] =3D stro=
ng / 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[6] =3D weak=
 / 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[7] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[8] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[9] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[10] =3D 0x0=
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[11] =3D 0x0=
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->irq_out->transfer=
_buffer_length =3D 12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[0] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[1] =3D 0x08=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[2] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[3] =3D stro=
ng / 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[4] =3D weak=
 / 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[5] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[6] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[7] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->irq_out->transfer=
_buffer_length =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_submit_urb(xpad->irq_out, GFP_KERN=
EL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&xpad->odata_mutex);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> @@ -574,7 +963,7 @@ static int xpad_play_effect(struct input
>
> =A0static int xpad_init_ff(struct usb_xpad *xpad)
> =A0{
> - =A0 =A0 =A0 if (xpad->xtype !=3D XTYPE_XBOX360)
> + =A0 =A0 =A0 if ((xpad->xtype !=3D XTYPE_XBOX360) && (xpad->xtype !=3D=
 XTYPE_XBOX360W))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
> @@ -583,26 +972,49 @@ static int xpad_init_ff(struct usb_xpad
> =A0}
>
> =A0#else
> +/* dummy implementation for xpad_probe */
> =A0static int xpad_init_ff(struct usb_xpad *xpad) { return 0; }
> =A0#endif
>
> -#if defined(CONFIG_JOYSTICK_XPAD_LEDS)
> -#include <linux/leds.h>
>
> -struct xpad_led {
> - =A0 =A0 =A0 char name[16];
> - =A0 =A0 =A0 struct led_classdev led_cdev;
> - =A0 =A0 =A0 struct usb_xpad *xpad;
> -};
> +/* end force feedback section */
>
> +/*******************************************************************=
**********/
> +
> +/* LED handling section: provides support for the ring of LEDs on th=
e 360
> + * controllers. */
> +
> +#ifdef CONFIG_JOYSTICK_XPAD_LEDS
> +
> +
> +/* XBox 360 wireless controller follows protocol from xboxdrv usersp=
ace
> + * driver:
> + * =A0 =A0http://pingus.seul.org/~grumbel/xboxdrv/
> + */
> =A0static void xpad_send_led_command(struct usb_xpad *xpad, int comma=
nd)
> =A0{
> =A0 =A0 =A0 =A0if (command >=3D 0 && command < 14) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&xpad->odata_mutex);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[0] =3D 0x01;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[1] =3D 0x03;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[2] =3D command;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->irq_out->transfer_buffer_length =3D=
 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360W) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[0] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[1] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[2] =3D 0x08=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[3] =3D 0x40=
 + (command % 0x0e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[4] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[5] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[6] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[7] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[8] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[9] =3D 0x00=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[10] =3D 0x0=
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[11] =3D 0x0=
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->irq_out->transfer=
_buffer_length =3D 12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[0] =3D 0x01=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[1] =3D 0x03=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->odata[2] =3D comm=
and;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->irq_out->transfer=
_buffer_length =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_submit_urb(xpad->irq_out, GFP_KERN=
EL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&xpad->odata_mutex);
> =A0 =A0 =A0 =A0}
> @@ -617,6 +1029,7 @@ static void xpad_led_set(struct led_clas
> =A0 =A0 =A0 =A0xpad_send_led_command(xpad_led->xpad, value);
> =A0}
>
> +
> =A0static int xpad_led_probe(struct usb_xpad *xpad)
> =A0{
> =A0 =A0 =A0 =A0static atomic_t led_seq =3D ATOMIC_INIT(0);
> @@ -625,7 +1038,7 @@ static int xpad_led_probe(struct usb_xpa
> =A0 =A0 =A0 =A0struct led_classdev *led_cdev;
> =A0 =A0 =A0 =A0int error;
>
> - =A0 =A0 =A0 if (xpad->xtype !=3D XTYPE_XBOX360)
> + =A0 =A0 =A0 if ((xpad->xtype !=3D XTYPE_XBOX360) && (xpad->xtype !=3D=
 XTYPE_XBOX360W))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0xpad->led =3D led =3D kzalloc(sizeof(struct xpad_led),=
 GFP_KERNEL);
> @@ -666,17 +1079,24 @@ static void xpad_led_disconnect(struct u
> =A0 =A0 =A0 =A0}
> =A0}
> =A0#else
> +/* dummies for xpad_probe, xpad_disconnect, & xpad_send_led_command =
*/
> =A0static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
> =A0static void xpad_led_disconnect(struct usb_xpad *xpad) { }
> +static void xpad_send_led_command(struct usb_xpad *xpad, int command=
) { }
> =A0#endif
>
> +/* end LED section */
> +
> +/*******************************************************************=
**********/
> +
> +/* Module and device functions */
>
> =A0static int xpad_open(struct input_dev *dev)
> =A0{
> =A0 =A0 =A0 =A0struct usb_xpad *xpad =3D input_get_drvdata(dev);
>
> =A0 =A0 =A0 =A0/* URB was submitted in probe */
> - =A0 =A0 =A0 if(xpad->xtype =3D=3D XTYPE_XBOX360W)
> + =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360W)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0xpad->irq_in->dev =3D xpad->udev;
> @@ -690,7 +1110,7 @@ static void xpad_close(struct input_dev
> =A0{
> =A0 =A0 =A0 =A0struct usb_xpad *xpad =3D input_get_drvdata(dev);
>
> - =A0 =A0 =A0 if(xpad->xtype !=3D XTYPE_XBOX360W)
> + =A0 =A0 =A0 if (xpad->xtype !=3D XTYPE_XBOX360W)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_kill_urb(xpad->irq_in);
> =A0 =A0 =A0 =A0xpad_stop_output(xpad);
> =A0}
> @@ -708,7 +1128,10 @@ static void xpad_set_up_abs(struct input
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case ABS_Z:
> =A0 =A0 =A0 =A0case ABS_RZ: =A0 =A0/* the triggers */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, abs, 0,=
 255, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Triggers have a phony -255 to 255 ra=
nge. Normally, only
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0 to 255 will be reported (+ axis)=
, unless full_trigger_axis
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is set, in which case -255 to 255 =
will be reported. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, abs, -2=
55, 255, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case ABS_HAT0X:
> =A0 =A0 =A0 =A0case ABS_HAT0Y: /* the d-pad (only if MAP_DPAD_TO_AXES=
) */
> @@ -717,18 +1140,22 @@ static void xpad_set_up_abs(struct input
> =A0 =A0 =A0 =A0}
> =A0}
>
> -static int xpad_probe(struct usb_interface *intf, const struct usb_d=
evice_id *id)
> +static int xpad_probe(struct usb_interface *intf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct usb_device_id *id)
> =A0{
> =A0 =A0 =A0 =A0struct usb_device *udev =3D interface_to_usbdev(intf);
> =A0 =A0 =A0 =A0struct usb_xpad *xpad;
> =A0 =A0 =A0 =A0struct input_dev *input_dev;
> =A0 =A0 =A0 =A0struct usb_endpoint_descriptor *ep_irq_in;
> + =A0 =A0 =A0 int controller_type;
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0int error =3D -ENOMEM;
>
> =A0 =A0 =A0 =A0for (i =3D 0; xpad_device[i].idVendor; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((le16_to_cpu(udev->descriptor.idVen=
dor) =3D=3D xpad_device[i].idVendor) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (le16_to_cpu(udev->descriptor.i=
dProduct) =3D=3D xpad_device[i].idProduct))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((le16_to_cpu(udev->descriptor.idVen=
dor) =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 xpad_device[i].idVendor) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (le16_t=
o_cpu(udev->descriptor.idProduct) =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 xpad_device[i].idProduct))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> @@ -749,11 +1176,14 @@ static int xpad_probe(struct usb_interfa
> =A0 =A0 =A0 =A0xpad->udev =3D udev;
> =A0 =A0 =A0 =A0xpad->dpad_mapping =3D xpad_device[i].dpad_mapping;
> =A0 =A0 =A0 =A0xpad->xtype =3D xpad_device[i].xtype;
> + =A0 =A0 =A0 controller_type =3D xpad_device[i].controller_type;
> =A0 =A0 =A0 =A0if (xpad->dpad_mapping =3D=3D MAP_DPAD_UNKNOWN)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad->dpad_mapping =3D !dpad_to_button=
s;
> =A0 =A0 =A0 =A0if (xpad->xtype =3D=3D XTYPE_UNKNOWN) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intf->cur_altsetting->desc.bInterfa=
ceClass =3D=3D USB_CLASS_VENDOR_SPEC) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intf->cur_altsettin=
g->desc.bInterfaceProtocol =3D=3D 129)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intf->cur_altsetting->desc.bInterfa=
ceClass =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 USB_CLASS_VENDOR_SPEC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intf->cur_altsettin=
g->desc.bInterfaceProtocol =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 129)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad->=
xtype =3D XTYPE_XBOX360W;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad->=
xtype =3D XTYPE_XBOX360;
> @@ -785,16 +1215,18 @@ static int xpad_probe(struct usb_interfa
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; xpad_btn[i] >=3D 0; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(xpad_btn[i], i=
nput_dev->keybit);
> - =A0 =A0 =A0 if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_BUTTONS)
> + =A0 =A0 =A0 if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_BUTTONS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; xpad_btn_pad[i] >=3D 0; =
i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(xpad_btn_pad[i=
], input_dev->keybit);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* set up axes */
> =A0 =A0 =A0 =A0for (i =3D 0; xpad_abs[i] >=3D 0; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad_set_up_abs(input_dev, xpad_abs[i]=
);
> - =A0 =A0 =A0 if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES)
> + =A0 =A0 =A0 if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; xpad_abs_pad[i] >=3D 0; =
i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_set_up_abs(input_dev, xpad=
_abs_pad[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_set_up_abs(input_d=
ev, xpad_abs_pad[i]);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0error =3D xpad_init_output(intf, xpad);
> =A0 =A0 =A0 =A0if (error)
> @@ -822,6 +1254,10 @@ static int xpad_probe(struct usb_interfa
>
> =A0 =A0 =A0 =A0usb_set_intfdata(intf, xpad);
>
> + =A0 =A0 =A0 xpad->controller_type =3D controller_type;
> + =A0 =A0 =A0 if (controller_type !=3D XCONTROLLER_TYPE_NONE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_init_controller(xpad);
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Submit the int URB immediatly rather than waiting f=
or open
> =A0 =A0 =A0 =A0 * because we get status messages from the device whet=
her
> @@ -830,48 +1266,43 @@ static int xpad_probe(struct usb_interfa
> =A0 =A0 =A0 =A0 * we're waiting for.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (xpad->xtype =3D=3D XTYPE_XBOX360W) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_present =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_number =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (intf->cur_altsetting->=
desc.bInterfaceNumber / 2) + 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad->irq_in->dev =3D xpad->udev;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D usb_submit_urb(xpad->irq_in,=
 GFP_KERNEL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail4;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Setup the message to set the LEDs =
on the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* controller when it shows up
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bulk_out =3D usb_alloc_urb(0, GFP=
_KERNEL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!xpad->bulk_out)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->id_packet =3D kzalloc(XPAD_PKT_LE=
N *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sizeof(unsigned char), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!xpad->id_packet)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_present =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_number =3D 0;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bdata =3D kzalloc(XPAD_PKT_LEN, G=
=46P_KERNEL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!xpad->bdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail6;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bdata[2] =3D 0x08;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (intf->cur_altsetting->desc.bInt=
erfaceNumber) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bdata[3] =3D 0x42=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bdata[3] =3D 0x43=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bdata[3] =3D 0x44=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 6:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->bdata[3] =3D 0x45=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep_irq_in =3D &intf->cur_altsetting->en=
dpoint[1].desc;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_fill_bulk_urb(xpad->bulk_out, udev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_snd=
bulkpipe(udev, ep_irq_in->bEndpointAddress),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->b=
data, XPAD_PKT_LEN, xpad_bulk_out, xpad);
> + =A0 =A0 =A0 /* Set up device attributes */
> + =A0 =A0 =A0 xpad->sysfs_ok =3D 1;
> + =A0 =A0 =A0 xpad->controller_unique_id[0] =3D '\0';
> + =A0 =A0 =A0 error =3D sysfs_create_group(&input_dev->dev.kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &xpad_default_attr_group);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Driver will work without the sysfs i=
nterface, but parameters
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* will not be adjustable, so this fa=
ilure is a warning. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "xpad: sysfs_create_gro=
up failed with error %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->sysfs_ok =3D 0;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 INIT_WORK(&xpad->work, &xpad_work_controller);
> +
> =A0 =A0 =A0 =A0return 0;
>
> - fail6: =A0 =A0 =A0 =A0usb_free_urb(xpad->bulk_out);
> - fail5: =A0 =A0 =A0 =A0usb_kill_urb(xpad->irq_in);
> + fail5: usb_set_intfdata(intf, NULL);
> + =A0 =A0 =A0 input_unregister_device(xpad->dev);
> + =A0 =A0 =A0 xpad_led_disconnect(xpad);
> =A0fail4: =A0 =A0 =A0 =A0usb_free_urb(xpad->irq_in);
> =A0fail3: =A0 =A0 =A0 =A0xpad_deinit_output(xpad);
> =A0fail2: =A0 =A0 =A0 =A0usb_buffer_free(udev, XPAD_PKT_LEN, xpad->id=
ata, xpad->idata_dma);
> @@ -883,31 +1314,31 @@ static int xpad_probe(struct usb_interfa
>
> =A0static void xpad_disconnect(struct usb_interface *intf)
> =A0{
> - =A0 =A0 =A0 struct usb_xpad *xpad =3D usb_get_intfdata (intf);
> + =A0 =A0 =A0 struct usb_xpad *xpad =3D usb_get_intfdata(intf);
>
> =A0 =A0 =A0 =A0usb_set_intfdata(intf, NULL);
> =A0 =A0 =A0 =A0if (xpad) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ensure we don't have any pending wor=
k */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_scheduled_work();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xpad->sysfs_ok)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysfs_remove_group(&xpa=
d->dev->dev.kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &xpad_default_attr_group);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad_led_disconnect(xpad);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_unregister_device(xpad->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad_deinit_output(xpad);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360W) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_kill_urb(xpad->bulk=
_out);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_free_urb(xpad->bulk=
_out);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX360W)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_kill_urb(xpad->irq=
_in);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_free_urb(xpad->irq_in);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_buffer_free(xpad->udev, XPAD_PKT_L=
EN,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpad->=
idata, xpad->idata_dma);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(xpad->id_packet);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(xpad);
> =A0 =A0 =A0 =A0}
> =A0}
>
> -static struct usb_driver xpad_driver =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "xpad",
> - =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D xpad_probe,
> - =A0 =A0 =A0 .disconnect =A0 =A0 =3D xpad_disconnect,
> - =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D xpad_table,
> -};
> +
>
> =A0static int __init usb_xpad_init(void)
> =A0{
> @@ -922,6 +1353,7 @@ static void __exit usb_xpad_exit(void)
> =A0 =A0 =A0 =A0usb_deregister(&xpad_driver);
> =A0}
>
> +
> =A0module_init(usb_xpad_init);
> =A0module_exit(usb_xpad_exit);
>
> diff -puN /dev/null drivers/input/joystick/xpad.h
> --- /dev/null
> +++ a/drivers/input/joystick/xpad.h
> @@ -0,0 +1,406 @@
> +/*
> + * Xbox gamepad driver with Xbox 360 wired/wireless support
> + *
> + * Last Modified: =A0 =A0 =A06 March 2009
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mike Murphy <mamurph@cs.c=
lemson.edu>
> + *
> + * Copyright (c) 2002 Marko Friedemann <mfr@bmx-chemnitz.de>
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2004 Oliver Schwartz <Oliver.Schwartz=
@gmx.de>,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Steven Toth <steve@toth.de=
mon.co.uk>,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Franz Lehner <franz@caos.a=
t>,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Ivan Hawkes <blackhawk@iva=
nhawkes.com>
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2005 Dominic Cerquetti <binary1230@ya=
hoo.com>
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2006 Adam Buchbinder <adam.buchbinder=
@gmail.com>
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2007 Jan Kratochvil <honza@jikos.cz>
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2009 Clemson University
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (contact: Mike Murphy <mamurp=
h@cs.clemson.edu>)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + *
> + *
> + * This driver is based on:
> + * =A0- information from =A0 =A0 http://euc.jp/periphs/xbox-controll=
er.ja.html
> + * =A0- the iForce driver =A0 =A0drivers/char/joystick/iforce.c
> + * =A0- the skeleton-driver =A0drivers/usb/usb-skeleton.c
> + * =A0- Xbox 360 information http://www.free60.org/wiki/Gamepad
> + * =A0- xboxdrv docs =A0 =A0 =A0 =A0 http://pingus.seul.org/~grumbel=
/xboxdrv/
> + *
> + * Thanks to:
> + * =A0- ITO Takayuki for providing essential xpad information on his=
 website
> + * =A0- Vojtech Pavlik =A0 =A0 - iforce driver / input subsystem
> + * =A0- Greg Kroah-Hartman - usb-skeleton driver
> + * =A0- XBOX Linux project - extra USB id's
> + *
> + * TODO:
> + * =A0- fix "analog" buttons (reported as digital now)
> + * =A0- need USB IDs for other dance pads
> + *
> + * Driver history is located at the bottom of this file.
> + */
> +
> +#ifndef _XPAD_H
> +#define _XPAD_H
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/module.h>
> +#include <linux/usb/input.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/string.h>
> +
> +#ifdef CONFIG_JOYSTICK_XPAD_LEDS
> +#include <linux/leds.h>
> +
> +struct xpad_led {
> + =A0 =A0 =A0 char name[16];
> + =A0 =A0 =A0 struct led_classdev led_cdev;
> + =A0 =A0 =A0 struct usb_xpad *xpad;
> +};
> +#endif
> +
> +
> +#define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
> +#define DRIVER_DESC "Xbox/360 pad driver"
> +
> +#define XPAD_PKT_LEN 32
> +
> +
> +/* xbox d-pads should map to buttons, as is required for DDR pads
> + =A0 but we map them to axes when possible to simplify things */
> +#define MAP_DPAD_TO_BUTTONS =A0 =A00
> +#define MAP_DPAD_TO_AXES =A0 =A0 =A0 1
> +#define MAP_DPAD_UNKNOWN =A0 =A0 =A0 2
> +
> +/* Type of controller *interface* (original, wired 360, wireless 360=
) */
> +#define XTYPE_XBOX =A0 =A0 =A0 =A00
> +#define XTYPE_XBOX360 =A0 =A0 1
> +#define XTYPE_XBOX360W =A0 =A02
> +#define XTYPE_UNKNOWN =A0 =A0 3
> +
> +/* Type of controller (e.g. pad, guitar, other input device) */
> +#define XCONTROLLER_TYPE_NONE =A0 =A0 =A0 =A0 =A00
> +#define XCONTROLLER_TYPE_PAD =A0 =A0 =A0 =A0 =A0 1
> +#define XCONTROLLER_TYPE_GUITAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> +#define XCONTROLLER_TYPE_DANCE_PAD =A0 =A0 3
> +#define XCONTROLLER_TYPE_OTHER =A0 =A0 =A0 =A0 255
> +
> +
> +/* The Xbox 360 controllers have sensitive sticks that often do not =
center
> + * exactly. A dead zone causes stick events below a certain threshho=
ld to be
> + * reported as zero.
> + *
> + * The default dead zone size is 8192, which was obtained by testing=
 a
> + * wireless 360 controller with jstest(1) and consulting gaming foru=
ms for
> + * a recommended dead zone for this controller. The consensus opinio=
n was
> + * 0.25 (on a scale from 0 to 1), which corresponds to 8192 (out of =
32767).
> + */
> +#define XDEAD_ZONE_DEFAULT =A0 8192
> +
> +/* Default limit for the sticks is the maximum axis value (32767), w=
hich will
> + * cause the sticks to have a radial axis as designed in the hardwar=
e. To
> + * enable square axis support, set the stick limits to 23170 or lowe=
r at run
> + * time via the sysfs interface. */
> +#define XSTICK_LIMIT_DEFAULT 32767
> +
> +/* Rumble normally enabled */
> +#define XRUMBLE_DEFAULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +
> +/* Normally, trigger axes report in the range 0 to 32767 (positive a=
xis only) */
> +#define XFULL_TRIGGER_AXIS_DEFAULT =A0 =A0 0
> +
> +
> +/* Xbox 360 has a vendor-specific class, so we cannot match it with =
only
> + * USB_INTERFACE_INFO (also specifically refused by USB subsystem), =
so we
> + * match against vendor id as well. Wired Xbox 360 devices have prot=
ocol 1,
> + * wireless controllers have protocol 129. */
> +#define XPAD_XBOX360_VENDOR_PROTOCOL(vend, pr) \
> + =A0 =A0 =A0 .match_flags =3D USB_DEVICE_ID_MATCH_VENDOR | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_MATCH_INT=
_INFO, \
> + =A0 =A0 =A0 .idVendor =3D (vend), \
> + =A0 =A0 =A0 .bInterfaceClass =3D USB_CLASS_VENDOR_SPEC, \
> + =A0 =A0 =A0 .bInterfaceSubClass =3D 93, \
> + =A0 =A0 =A0 .bInterfaceProtocol =3D (pr)
> +#define XPAD_XBOX360_VENDOR(vend) \
> + =A0 =A0 =A0 { XPAD_XBOX360_VENDOR_PROTOCOL(vend, 1) }, \
> + =A0 =A0 =A0 { XPAD_XBOX360_VENDOR_PROTOCOL(vend, 129) }
> +
> +
> +
> +/* Some of the fields in the following structure are for later use w=
ith
> + * userspace applications to recognize individual controllers. The d=
ead zones
> + * and axis limits can be changed "on the fly" and are effective imm=
ediately.
> + *
> + * The fields labeled "ro" and "rw" are intended to be read-only and
> + * read-write, respectively, when exposed in sysfs. Most of the read=
-only
> + * fields are to support *wireless* 360 controllers. The controller_=
number
> + * is used to set the LED, while controller_present tracks whether t=
he
> + * controller is connected to the wireless receiver. Controller type=
 applies
> + * to all models (wired and wireless), and tracks whether the device=
 is a pad,
> + * guitar, etc. for later userspace use. See the comment above regar=
ding
> + * type and unique ID detection on wireless 360 receivers.
> + */
> +struct usb_xpad {
> + =A0 =A0 =A0 struct input_dev *dev; =A0 =A0 =A0 =A0 =A0/* input devi=
ce interface */
> + =A0 =A0 =A0 struct usb_device *udev; =A0 =A0 =A0 =A0/* usb device *=
/
> +
> + =A0 =A0 =A0 struct urb *irq_in; =A0 =A0 =A0 =A0 =A0 =A0 /* urb for =
interrupt in report */
> + =A0 =A0 =A0 unsigned char *idata; =A0 =A0 =A0 =A0 =A0 /* input data=
 */
> + =A0 =A0 =A0 dma_addr_t idata_dma;
> +
> +#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD=
_LEDS)
> + =A0 =A0 =A0 struct urb *irq_out; =A0 =A0 =A0 =A0 =A0 =A0/* urb for =
interrupt out report */
> + =A0 =A0 =A0 unsigned char *odata; =A0 =A0 =A0 =A0 =A0 /* output dat=
a */
> + =A0 =A0 =A0 dma_addr_t odata_dma;
> + =A0 =A0 =A0 struct mutex odata_mutex;
> +#endif
> +
> +#ifdef CONFIG_JOYSTICK_XPAD_LEDS
> + =A0 =A0 =A0 struct xpad_led *led;
> +#endif
> +
> + =A0 =A0 =A0 char phys[64]; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* ph=
ysical device path */
> +
> + =A0 =A0 =A0 int dpad_mapping; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* map d-=
pad to buttons or to axes */
> + =A0 =A0 =A0 int xtype; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* type of xbox device */
> +
> + =A0 =A0 =A0 /* Work structure for moving the call to xpad_send_led_=
command
> + =A0 =A0 =A0 =A0* outside the interrupt handler for packet processin=
g */
> + =A0 =A0 =A0 struct work_struct work;
> +
> + =A0 =A0 =A0 /* id packet for wireless 360 controller */
> + =A0 =A0 =A0 unsigned char *id_packet;
> +
> + =A0 =A0 =A0 int controller_number; =A0 =A0 =A0 =A0 =A0/* controller=
 # (1-4) for 360w. ro */
> + =A0 =A0 =A0 int controller_present; =A0 =A0 =A0 =A0 /* 360w control=
ler presence. ro */
> + =A0 =A0 =A0 int controller_type; =A0 =A0 =A0 =A0 =A0 =A0/* controll=
er type. ro */
> + =A0 =A0 =A0 char controller_unique_id[17]; =A0/* unique ID of contr=
oller (360w). ro */
> + =A0 =A0 =A0 unsigned int left_dead_zone; =A0 =A0/* dead zone for le=
ft stick. rw */
> + =A0 =A0 =A0 unsigned int right_dead_zone; =A0 /* dead zone for righ=
t stick. rw */
> + =A0 =A0 =A0 unsigned int left_stick_limit; =A0/* axis limit for lef=
t stick. rw */
> + =A0 =A0 =A0 unsigned int right_stick_limit; /* axis limit for right=
 stick. rw */
> + =A0 =A0 =A0 int rumble_enable; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* enable=
/disable rumble. rw */
> + =A0 =A0 =A0 int left_trigger_full_axis; =A0 =A0 /* full axis - left=
 trigger. rw */
> + =A0 =A0 =A0 int right_trigger_full_axis; =A0 =A0/* full axis - righ=
t trigger. rw */
> +
> + =A0 =A0 =A0 int sysfs_ok; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sy=
sfs interface OK */
> +};
> +#define to_xpad(d) input_get_drvdata(to_input_dev(d))
> +
> +
> +/* Function prototypes for non-sysfs interface functions */
> +static void set_dead_zone(unsigned int new_size, unsigned int *dz,
> + =A0 =A0 =A0 unsigned int stick_limit);
> +static void set_stick_limit(unsigned int new_size, unsigned int *sl,
> + =A0 =A0 =A0 unsigned int dead_zone);
> +static void xpad_init_controller(struct usb_xpad *xpad);
> +static void xpad_send_led_command(struct usb_xpad *xpad, int command=
);
> +static void xpad_work_controller(struct work_struct *w);
> +static void xpad_process_sticks(struct usb_xpad *xpad, __le16 *data)=
;
> +static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd,
> + =A0 =A0 =A0 unsigned char *data);
> +static void xpad360_process_packet(struct usb_xpad *xpad, u16 cmd,
> + =A0 =A0 =A0 unsigned char *data);
> +static void xpad360w_identify_controller(struct usb_xpad *xpad);
> +static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd,
> + =A0 =A0 =A0 unsigned char *data);
> +static void xpad_irq_in(struct urb *urb);
> +static void xpad_irq_out(struct urb *urb);
> +static int xpad_init_output(struct usb_interface *intf, struct usb_x=
pad *xpad);
> +static void xpad_stop_output(struct usb_xpad *xpad);
> +static void xpad_deinit_output(struct usb_xpad *xpad);
> +static int xpad_play_effect(struct input_dev *dev, void *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ff_effec=
t *effect);
> +static int xpad_init_ff(struct usb_xpad *xpad);
> +#ifdef CONFIG_JOYSTICK_XPAD_LEDS
> +static void xpad_led_set(struct led_classdev *led_cdev,
> + =A0 =A0 =A0 enum led_brightness value);
> +#endif
> +static int xpad_led_probe(struct usb_xpad *xpad);
> +static void xpad_led_disconnect(struct usb_xpad *xpad);
> +static int xpad_open(struct input_dev *dev);
> +static void xpad_close(struct input_dev *dev);
> +static void xpad_set_up_abs(struct input_dev *input_dev, signed shor=
t abs);
> +static int xpad_probe(struct usb_interface *intf,
> + =A0 =A0 =A0 const struct usb_device_id *id);
> +static void xpad_disconnect(struct usb_interface *intf);
> +static int __init usb_xpad_init(void);
> +static void __exit usb_xpad_exit(void);
> +
> +
> +/* sysfs interface */
> +static ssize_t xpad_show_uint(struct device *dev, struct device_attr=
ibute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf);
> +static ssize_t xpad_store_uint(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const ch=
ar *buf, size_t count);
> +static ssize_t xpad_store_bool(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const ch=
ar *buf, size_t count);
> +static ssize_t xpad_store_ro(struct device *dev, struct device_attri=
bute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count);
> +static ssize_t xpad_show_int(struct device *dev, struct device_attri=
bute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf);
> +static ssize_t xpad_show_id(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *bu=
f);
> +
> +
> +
> +/* Device attributes */
> +static DEVICE_ATTR(left_dead_zone, 0644, xpad_show_uint, xpad_store_=
uint);
> +static DEVICE_ATTR(right_dead_zone, 0644, xpad_show_uint, xpad_store=
_uint);
> +static DEVICE_ATTR(left_stick_limit, 0644, xpad_show_uint, xpad_stor=
e_uint);
> +static DEVICE_ATTR(right_stick_limit, 0644, xpad_show_uint, xpad_sto=
re_uint);
> +static DEVICE_ATTR(rumble_enable, 0644, xpad_show_int, xpad_store_bo=
ol);
> +static DEVICE_ATTR(left_trigger_full_axis, 0644, xpad_show_int,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_store_bool);
> +static DEVICE_ATTR(right_trigger_full_axis, 0644, xpad_show_int,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad_store_bool);
> +static DEVICE_ATTR(controller_number, 0444, xpad_show_int, xpad_stor=
e_ro);
> +static DEVICE_ATTR(controller_present, 0444, xpad_show_int, xpad_sto=
re_ro);
> +static DEVICE_ATTR(controller_type, 0444, xpad_show_int, xpad_store_=
ro);
> +static DEVICE_ATTR(id, 0444, xpad_show_id, xpad_store_ro);
> +
> +static struct attribute *xpad_default_attrs[] =3D {
> + =A0 =A0 =A0 &dev_attr_left_dead_zone.attr,
> + =A0 =A0 =A0 &dev_attr_right_dead_zone.attr,
> + =A0 =A0 =A0 &dev_attr_left_stick_limit.attr,
> + =A0 =A0 =A0 &dev_attr_right_stick_limit.attr,
> + =A0 =A0 =A0 &dev_attr_rumble_enable.attr,
> + =A0 =A0 =A0 &dev_attr_left_trigger_full_axis.attr,
> + =A0 =A0 =A0 &dev_attr_right_trigger_full_axis.attr,
> + =A0 =A0 =A0 &dev_attr_controller_number.attr,
> + =A0 =A0 =A0 &dev_attr_controller_present.attr,
> + =A0 =A0 =A0 &dev_attr_controller_type.attr,
> + =A0 =A0 =A0 &dev_attr_id.attr,
> + =A0 =A0 =A0 NULL
> +};
> +
> +static struct attribute_group xpad_default_attr_group =3D {
> + =A0 =A0 =A0 .attrs =3D xpad_default_attrs,
> + =A0 =A0 =A0 .name =3D "game_device",
> +};
> +
> +#endif
> +
> +/* Driver History:
> + *
> + * 2009-03-06 : Patches from -mm tree
> + * =A0- fixed build issue when CONFIG_JOYSTICK_XPAD_LEDS not set and=
 removed
> + * =A0 =A0duplicate prototypes (thanks Randy Dunlap for patch)
> + * =A0- fixed erroneous whitespace reported by checkpatch (thanks An=
drew Morton
> + * =A0 =A0for patch)
> + * =A0- added missing prototype
> + *
> + * 2009-03-02 : Code cleanup
> + * =A0- used min(), max(), and abs() where appropriate, simplifying =
code
> + * =A0- moved code that generates data objects out of xpad.h and int=
o xpad.c
> + * =A0- changed legacy #if defined(...) to #ifdef
> + * =A0- removed unnecessary typecasts
> + * =A0- wireless 360 controller identification now done in workqueue=
 task
> + * =A0- thanks Andrew Morton, Greg K-H, and Linus Torvalds
> + *
> + * 2009-02-28 : Triggers now half-axes by default
> + * =A0- triggers will now be positive half-axes only, unless a full =
axis mapping
> + * =A0 =A0is enabled via the sysfs interface on a per-trigger basis
> + * =A0- moved INIT_WORK to xpad_probe and removed INIT_WORK/PREPARE_=
WORK from
> + * =A0 =A0interrupt handler; also removed the work_pending flag from=
 struct
> + * =A0 =A0usb_xpad (always flush shared workqueue on unload)
> + * =A0- read-write sysfs attributes now have 644 default permissions
> + *
> + * 2009-02-23 : Changes per mailing list (thanks Frederic Weisbecker=
)
> + * =A0- no more check for CONFIG_SYSFS: sysfs functions will simply =
return
> + * =A0 =A00 if sysfs has not been enabled
> + * =A0- fixed weird ordering in sscanf return check
> + * =A0- checked code with scripts/checkpatch.pl and made style adjus=
tments
> + *
> + * 2009-02-21 : Refactored and changed stick handling
> + * =A0- split code into two pieces (xpad.h and xpad.c)
> + * =A0- cleaned up sysfs interface
> + * =A0- changed square axis algorithm to an axis limit algorithm, wh=
ich allows
> + * =A0 =A0size of inscribed square to be adjusted; available for bot=
h sticks
> + * =A0- dead zones now per-stick
> + *
> + * 2009-02-18 : Changes per mailing list (and some additions)
> + * =A0- revised sysfs interface (thanks Greg K-H)
> + * =A0- check return values of sscanf (thanks Oliver Neukum)
> + * =A0- urb submission while holding mutex now once again GFP_KERNEL
> + * =A0 =A0(thanks Oliver Neukum)
> + * =A0- work structure fixes (thanks Oliver Neukum)
> + * =A0- uevents generated for wireless controller online/offline
> + * =A0- sysfs interface only if CONFIG_SYSFS is set
> + *
> + * 2009-02-15 : Minor adjustments
> + * =A0- added KOBJ_ONLINE/KOBJ_OFFLINE events when controllers are c=
onnected to
> + * =A0 =A0or disconnected from the wireless 360 receiver
> + * =A0- ignore duplicate connect messages on the same connection
> + * =A0- added option to enable/disable rumble on a per-controller ba=
sis
> + * =A0- rumble events are not sent to guitar or dance pad devices
> + *
> + * 2009-02-14 : Added sysfs interface
> + * =A0- dead zones and square axis settings can now be made per-cont=
roller
> + * =A0- removed dead_zone and square_axis module parameters (use sys=
fs)
> + * =A0- new square axis algorithm
> + *
> + * 2009-02-13 : Disable square axis for right stick
> + * =A0- square axis applies to left stick only
> + *
> + * 2009-02-12 : Scaling for dead zone and square axis support
> + * =A0- axes now scale from 0 to 32767 starting at edge of dead zone
> + * =A0- increased default dead zone to 8192
> + * =A0- initial square axis support (reliable only with left stick)
> + *
> + * 2009-02-07 : More wireless 360 controller fixes
> + * =A0- removed bulk urb completely
> + * =A0- use xpad_send_led_command to set controller number on LED di=
splay
> + * =A0 =A0(wireless 360 controller)
> + * =A0- dead_zone is now an adjustable module parameter
> + *
> + * 2009-02-06 : Axis handling improvements
> + * =A0- unified handler for left and right sticks
> + * =A0- initial support for dead zones
> + *
> + * 2009-02-02 : Wireless 360 controller fixes
> + * =A0- followed PROTOCOL description from xboxdrv userspace driver
> + * =A0- LED and rumble support added for wireless 360 controller (pr=
otocol
> + * =A0 =A0is different from wired!)
> + *
> + * 2004-10-02 - 0.0.6 : DDR pad support
> + * =A0- borrowed from the XBOX linux kernel
> + * =A0- USB id's for commonly used dance pads are present
> + * =A0- dance pads will map D-PAD to buttons, not axes
> + * =A0- pass the module paramater 'dpad_to_buttons' to force
> + * =A0 =A0the D-PAD to map to buttons if your pad is not detected
> + *
> + * 2002-07-17 - 0.0.5 : simplified d-pad handling
> + *
> + * 2002-07-16 - 0.0.4 : minor changes, merge with Vojtech's v0.0.3
> + * =A0- verified the lack of HID and report descriptors
> + * =A0- verified that ALL buttons WORK
> + * =A0- fixed d-pad to axes mapping
> + *
> + * 2002-07-14 - 0.0.3 : rework by Vojtech Pavlik
> + * =A0- indentation fixes
> + * =A0- usb + input init sequence fixes
> + *
> + * 2002-07-02 - 0.0.2 : basic working version
> + * =A0- all axes and 9 of the 10 buttons work (german InterAct devic=
e)
> + * =A0- the black button does not work
> + *
> + * 2002-06-27 - 0.0.1 : first version, just said "XBOX HID controlle=
r"
> + *
> + */
> _
>



--=20
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
http://cirg.cs.clemson.edu/~mamurph
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
