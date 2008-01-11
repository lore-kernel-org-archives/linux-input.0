From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [BISECTED] Re: psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
Date: Fri, 11 Jan 2008 09:47:11 -0500
Message-ID: <d120d5000801110647k4b1fa49ene974898baf745aec@mail.gmail.com>
References: <19f34abd0711141226n60323630rdc4833db0bfb2eeb@mail.gmail.com>
	 <19f34abd0801071224kb9cb121u244b00b274231db0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.233]:51668 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760810AbYAKOrP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 09:47:15 -0500
Received: by hu-out-0506.google.com with SMTP id 19so450173hue.21
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 06:47:11 -0800 (PST)
In-Reply-To: <19f34abd0801071224kb9cb121u244b00b274231db0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, William Pettersson <william.pettersson@gmail.com>

Hi Vegard,

On Jan 7, 2008 3:24 PM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> }, /* Dell Latitude D600 */
> +       { { 0x73, 0x02, 0x50 }, 0xcf, 0xff, ALPS_FW_BK_1 } /* Dell
> Vostro 1400 */
>  };
>
>
> After reverting, all buttons work as expected -- no lost syncs. I
> might add that my laptop is Acer Aspire 5720ZG. Also, the button in
> question is not truly a middle button; when operating correctly, it is
> used for scrolling (up/down). Now what can be done to make both models
> work correctly?
>

Thank you for identifying the problem commit. Could you please also do this:

echo 1 > /sys/module/i8042/parameters/debug
push and release left button
push and release rigth button
move finger on the touchpad a bit
echo 0 > /sys/module/i8042/parameters/debug
dmesg > dmesg.sync
echo 1 > /sys/module/i8042/parameters/debug
push and release middle button
echo 0 > /sys/module/i8042/parameters/debug
dmesg > dmesg.nosync

and send me both dmesg files?

Thank you.

-- 
Dmitry
