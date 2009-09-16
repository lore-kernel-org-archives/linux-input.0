From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 01:06:07 -0700
Message-ID: <20090916080607.GJ2756@core.coreip.homeip.net>
References: <4AB0929D.4030007@gmail.com> <20090916073207.GI2756@core.coreip.homeip.net> <4AB09717.6040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:32997 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbZIPIGI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 04:06:08 -0400
Received: by yxe1 with SMTP id 1so6350678yxe.21
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 01:06:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AB09717.6040704@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 16, 2009 at 03:43:19PM +0800, Xiangfu Liu wrote:
> Dmitry Torokhov wrote:
> > On Wed, Sep 16, 2009 at 03:24:13PM +0800, Xiangfu Liu wrote:
> >> Hi
> >>
> >> I know in the IBM laptop, you use Fn + F1 to do something.
> >> I want [Fn + U = 7] in my device. 
> >> when you press Fn + U in the terminal it will display '7'.
> >>
> >>
> >> I look into the keyboard.c file.
> >> but don't know which function is handle the Fn key?
> >>
> >> there is [1] in the keyboard.h file. I don't know 
> >> which Fn key belong. is it KT_SHIFT???
> >>
> > 
> > Fn in laptops usually handled by firmware (OS does not see the scancode
> > for Fn at all). In your driver you will probably have to handle it
> > manually and adjust which keycode you emit (KEY_Y or KEY_7) depending on
> > whether Fn is active or not. I'd recommend not hardcoding KEY_* but
> > actually "shift" to different part of driver keymap so userspace could
> > change the keycodes if it wishes to do so.
> Hi Dmitry
>  thanks for the reply.
> see [1], I change the [Red arrow] key to [ALTGR] then I can easy change the 
> defkeymap.map. make all the red keys work.
> 
> but for the [Blue Fn] key. I don't know how to make it work in keymap?
> there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier keys.
> all used. so I can not may the [Fn] to those four modifier keys.
> 
> can I make the leftAlt and rightAlt generate different keys?
> like:
>  LeftAlt + 'U' = Alt + 'U'
>  RightAlt + 'U' = '7'
> 

Keyboard driver supports 9 modifiers total, you should be able use one
of these for your numeric buttons.

-- 
Dmitry
