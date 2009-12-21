From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ep93xx_keypad.c: cleanup and use matrix_keypad helpers
Date: Mon, 21 Dec 2009 10:19:59 -0800
Message-ID: <20091221181959.GA6696@core.coreip.homeip.net>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F166@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:39826 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157AbZLUSUL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 13:20:11 -0500
Received: by pxi27 with SMTP id 27so2069547pxi.4
        for <linux-input@vger.kernel.org>; Mon, 21 Dec 2009 10:20:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F166@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

Hi Hartley,

On Mon, Dec 21, 2009 at 01:01:01PM -0500, H Hartley Sweeten wrote:
> ep93xx_keypad.c: cleanup and use matrix_keypad helpers
> 
> 1) use struct matrix_keymap_data to supply the keymap from the platform code
>    and use matrix_keypad_build_keymap() to initialize the keymap

I;d prefer this one split out. Also, is there any in-kernel users and
will they be converted to the new format of platform data.

> 2) namespace sanitize the local defines
> 3) cleanup the interrupt handler to make it more understandable
> 4) allocate the keycode matrix at run time

What is the point given that the size of the keymap is still constant
with your patch. And even if it was dynamic just stick it at the end of
struct ep93xx_keypad as unsigned short keycodes[] and allocate in one
shot.

Thanks.

-- 
Dmitry
