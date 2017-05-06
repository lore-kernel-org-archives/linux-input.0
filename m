From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: xpad - sync supported devices with xboxdrv
Date: Fri, 5 May 2017 21:25:25 -0700
Message-ID: <5db2dc88-a43f-98d4-ce77-a4dba910ab2d@gmail.com>
References: <20170504231544.335e8f42@nashorn>
 <20170504231714.16ea40d2@nashorn>
 <5f9b48e9-053c-2118-2026-5dcbc7705100@gmail.com>
 <20170505195021.27121915@nashorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35654 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdEFEZ1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 6 May 2017 00:25:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so3027632pgd.2
        for <linux-input@vger.kernel.org>; Fri, 05 May 2017 21:25:27 -0700 (PDT)
In-Reply-To: <20170505195021.27121915@nashorn>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Valentin <benpicco@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>

On 05/05/2017 10:50 AM, Benjamin Valentin wrote:
> The userspace xboxdrv driver [0] contains some USB IDs unknown to the
> kernel driver. I have created a simple script [1] to extract the
> missing devices and add them to xpad.
> 
> A quick google search confirmed that all the new devices called
> Fightstick/pad are Arcade-type devices [2] where the
> MAP_TRIGGERS_TO_BUTTONS option should apply.
> 
> There are some similar devices in the existing device table where this
> flag is not set, but I did refrain from changing those.
> 
> [0] https://github.com/xboxdrv/xboxdrv/blob/stable/src/xpad_device.cpp
> [1] http://codepad.org/CHV98BNH
> [2] https://www.google.com/search?q=SFxT+Fightstick+Pro&tbm=isch
> 
> Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>
> ---

Generally, you should resend the entire series with the 'v2' mark
and include a brief list of changes for your v2 underneath the
commit message '---' in each patch.

In any case, your modifications look good, so:

Reviewed-by: Cameron Gutman <aicommander@gmail.com>

>  drivers/input/joystick/xpad.c | 12 ++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index c754a79..a185956 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -145,6 +145,7 @@ static const struct xpad_device {
>  	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
>  	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
> +	{ 0x056e, 0x2004, "Elecom JC-U3613M", 0, XTYPE_XBOX360 },
>  	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX },
>  	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
>  	{ 0x0738, 0x4516, "Mad Catz Control Pad", 0, XTYPE_XBOX },
> @@ -179,6 +180,7 @@ static const struct xpad_device {
>  	{ 0x0e6f, 0x0006, "Edge wireless Controller", 0, XTYPE_XBOX },
>  	{ 0x0e6f, 0x0105, "HSM3 Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x0e6f, 0x0113, "Afterglow AX.1 Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
> +	{ 0x0e6f, 0x011f, "Rock Candy Gamepad Wired Controller", 0, XTYPE_XBOX360 },
>  	{ 0x0e6f, 0x0139, "Afterglow Prismatic Wired Controller", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x0146, "Rock Candy Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x0201, "Pelican PL-3601 'TSZ' Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
> @@ -186,6 +188,7 @@ static const struct xpad_device {
>  	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
>  	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
> +	{ 0x0e6f, 0x0413, "Afterglow AX.1 Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
>  	{ 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", 0, XTYPE_XBOX },
>  	{ 0x0e8f, 0x3008, "Generic xbox control (dealextreme)", 0, XTYPE_XBOX },
>  	{ 0x0f0d, 0x000a, "Hori Co. DOA4 FightStick", 0, XTYPE_XBOX360 },
> @@ -211,21 +214,30 @@ static const struct xpad_device {
>  	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf016, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
> +	{ 0x1bad, 0xf018, "Mad Catz Street Fighter IV SE Fighting Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
> +	{ 0x1bad, 0xf021, "Mad Cats Ghost Recon FS GamePad", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf023, "MLG Pro Circuit Controller (Xbox)", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf028, "Street Fighter IV FightPad", 0, XTYPE_XBOX360 },
> +	{ 0x1bad, 0xf02e, "Mad Catz Fightpad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf038, "Street Fighter IV FightStick TE", 0, XTYPE_XBOX360 },
> +	{ 0x1bad, 0xf03a, "Mad Catz SFxT Fightstick Pro", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf900, "Harmonix Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf901, "Gamestop Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf903, "Tron Xbox 360 controller", 0, XTYPE_XBOX360 },
> +	{ 0x1bad, 0xfa01, "MadCatz GamePad", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5300, "PowerA MINI PROEX Controller", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5303, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
> +	{ 0x24c6, 0x531a, "PowerA Pro Ex", 0, XTYPE_XBOX360 },
> +	{ 0x24c6, 0x5397, "FUS1ON Tournament Controller", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x541a, "PowerA Xbox One Mini Wired Controller", 0, XTYPE_XBOXONE },
>  	{ 0x24c6, 0x542a, "Xbox ONE spectra", 0, XTYPE_XBOXONE },
>  	{ 0x24c6, 0x543a, "PowerA Xbox One wired controller", 0, XTYPE_XBOXONE },
>  	{ 0x24c6, 0x5500, "Hori XBOX 360 EX 2 with Turbo", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5501, "Hori Real Arcade Pro VX-SA", 0, XTYPE_XBOX360 },
> +	{ 0x24c6, 0x5503, "Hori Fighting Edge", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5506, "Hori SOULCALIBUR V Stick", 0, XTYPE_XBOX360 },
> +	{ 0x24c6, 0x550d, "Hori GEM Xbox controller", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5b02, "Thrustmaster, Inc. GPX Controller", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
> @@ -315,6 +315,7 @@ static struct usb_device_id xpad_table[] = {
>  	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
>  	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
>  	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
> +	XPAD_XBOX360_VENDOR(0x056e),		/* Elecom JC-U3613M */
>  	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
>  	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
>  	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
> 
