From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: (matrix_keypad driver) Re: qi_lb60_keypad driver question?
Date: Mon, 07 Sep 2009 10:50:04 +0800
Message-ID: <4AA474DC.9010509@gmail.com>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com> <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:47048 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758528AbZIGCuL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Sep 2009 22:50:11 -0400
Received: by pxi14 with SMTP id 14so2147343pxi.19
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2009 19:50:13 -0700 (PDT)
In-Reply-To: <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "Hard- and Software Development, Kernel, Distribution, Roadmap" <developer@lists.qi-hardware.com>

Hi Dmitry
Dmitry Torokhov wrote:
> Hi,
> Historically our KEY_* definitions did not include defines for symbols
> like '@' because they do not have a dedicated key but rather being
> produced as a combination of a primary key + modifier; the mapping is
> done either in console driver or in X.
> 
> Looking at the picture of the device that you provided it appears that
> your device does not have a dedicated '@' key so it should work in the
> same fashion as above.
> 

since we don't have X now. I google about this. I don't know how to 
modify the console driver. can you tell me which file I need look 
into? thanks.

I found an another method. we use busybox in rootfs. the busybox have 
command [dumpkmap] [loadkmap] [showkey],

-----------
in host system run :
/usr/bin/dumpkeys > normal_keymap
/usr/bin/loadkeys funky_mini_keyboard_keymap
/usr/bin/busybox dumpkmap > funky_mini_keyboard_keymap.bin
/usr/bin/loadkeys normal_keymap

then in target system run
"loadkmap funky_mini_keyboard_keymap.bin"
-----------

in our device have a two special keys
[RED UP POINT] keycode is 94
[QI] keycode is 93

the loadkeys alwasy like:
compose '|' 's' to '$' 

how to write the keycode to the loadkeys file.

I just found this method yesterday. not test yet.
anyone have experience on this?

thanks for advice

--
Best Regards
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
