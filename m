From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: [BISECTED] Re: psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
Date: Mon, 7 Jan 2008 21:24:58 +0100
Message-ID: <19f34abd0801071224kb9cb121u244b00b274231db0@mail.gmail.com>
References: <19f34abd0711141226n60323630rdc4833db0bfb2eeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:44641 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651AbYAGUZA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2008 15:25:00 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1663501nze.1
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2008 12:24:58 -0800 (PST)
In-Reply-To: <19f34abd0711141226n60323630rdc4833db0bfb2eeb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, William Pettersson <william.pettersson@gmail.com>

Hi,

On Nov 14, 2007 9:26 PM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> Hello,
>
> With 2.6.23 kernel, the laptop middle button worked fine. With
> 2.6.24-rc1, when I press the middle button, the cursor jumps around
> the screen and this appears in the kernel log (for each time I press
> the button):
>
> psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: GlidePoint at isa0060/serio1/input0 - driver resynched.
>
> Related dmesg:
>
> input: Macintosh mouse button emulation as /class/input/input0
> PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
> mice: PS/2 mouse device common for all mice
> input: PS/2 Mouse as /class/input/input2
> input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
>
> Earlier dmesgs (2.6.23) had (only) this:
>
> input: Macintosh mouse button emulation as /class/input/input0
> PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
> mice: PS/2 mouse device common for all mice
> input: ImPS/2 Generic Wheel Mouse as /class/input/input2
>
>
> It seems that the driver used is different. What can I do to fix this?

I have now bisected the kernel (to the point where I made a guess) and
found that reverting this commit fixes my problem:

commit dac4ae0daa1be36ab015973ed9e9dc04a2684395
Author: William Pettersson <william.pettersson@gmail.com>
Date:   Wed Sep 5 00:18:44 2007 -0400

    Input: ALPS - add support for model found in Dell Vostro 1400

    Signed-off-by: William Pettersson <william.pettersson@gmail.com>
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 2c5f11a..a810ff8 100644 (file)
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -53,6 +53,7 @@ static const struct alps_model_info alps_model_data[] = {
        { { 0x20, 0x02, 0x0e }, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT
}, /* XXX */
        { { 0x22, 0x02, 0x0a }, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
        { { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT
}, /* Dell Latitude D600 */
+       { { 0x73, 0x02, 0x50 }, 0xcf, 0xff, ALPS_FW_BK_1 } /* Dell
Vostro 1400 */
 };


After reverting, all buttons work as expected -- no lost syncs. I
might add that my laptop is Acer Aspire 5720ZG. Also, the button in
question is not truly a middle button; when operating correctly, it is
used for scrolling (up/down). Now what can be done to make both models
work correctly?


Kind regards,
Vegard Nossum
