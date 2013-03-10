From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tc3589x-keypad - fix keymap size
Date: Sat, 9 Mar 2013 16:23:00 -0800
Message-ID: <20130310002300.GA31236@core.coreip.homeip.net>
References: <1362752803-21853-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43221 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3CJAXE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Mar 2013 19:23:04 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so2486612pbb.20
        for <linux-input@vger.kernel.org>; Sat, 09 Mar 2013 16:23:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1362752803-21853-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-input@vger.kernel.org, rabin@rab.in

On Fri, Mar 08, 2013 at 03:26:43PM +0100, Rabin Vincent wrote:
> The keymap size used by tc3589x is too low, leading to the driver
> overwriting other people's memory.  Fix this by making the driver use
> the automatically allocated keymap provided by
> matrix_keypad_build_keymap() instead of allocating one on its own.
> 
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

Applied, thank you Rabin.

Do you think you could prepare a patch against stable as older kernels
should have the same issue but matrix_keypad_build_keymap does not
allocate keymap there?

Thanks!

-- 
Dmitry
