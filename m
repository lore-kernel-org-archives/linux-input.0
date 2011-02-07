From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Laptop Function key (KEY_FN) not recognized by XWindows
Date: Mon, 7 Feb 2011 10:48:29 -0800
Message-ID: <20110207184829.GB31901@core.coreip.homeip.net>
References: <1FC56210173BB445BD77F608D6FB8D03165A0080B0@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56558 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab1BGSsh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Feb 2011 13:48:37 -0500
Received: by pxi15 with SMTP id 15so959007pxi.19
        for <linux-input@vger.kernel.org>; Mon, 07 Feb 2011 10:48:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D03165A0080B0@HQMAIL03.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Rakesh,

On Fri, Feb 04, 2011 at 05:05:50PM -0800, Rakesh Iyer wrote:
> Hi All.
> 
> I am writing a Keyboard driver where the Function key (as seen in Laptop) is used as a modifier.
> In my driver I have used "KEY_FN"(from include/linux/input.h) as the keycode for this key.
> 
> When I run "xev" the key press events do not get detected.
> If I modify the keycode to say KEY_MEDIA, "xev" does show the event properly.
> 
> I am wondering how to go about getting this key detected and processed by XWindows.

Yes, indeed, you are stumbling against limitation of X which does not
allow to pass keycodes above 255 through it.

One option would be assigning KEY_LEFTMETA or KEY_RIGHTMETA to your 'Fn'
key and then adjusting keymaps, but after I looked again at the keys you
have assigned by default to your Fn combinations  can see how one would
want to avoid involving X's keymaps and be able to generate needed
keycodes directly (volume, brightness and other control events) so that
infrastructure need not be hooked into X to be able to react to them.

I think if you implement a hard/soft-fn flag in platform data and, in
case of hard_fn mode would suppress KEY_FN event but rather treat it as
most significant bit in your row data (effectively doubling keymap size)
that would solve your issue.

What do you think?

Thanks.

-- 
Dmitry
