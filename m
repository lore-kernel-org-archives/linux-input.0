From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 09:33:05 -0700
Message-ID: <20090916163305.GB4970@core.coreip.homeip.net>
References: <4AB0929D.4030007@gmail.com> <20090916073207.GI2756@core.coreip.homeip.net> <4AB09717.6040704@gmail.com> <20090916080607.GJ2756@core.coreip.homeip.net> <4AB0AEF6.7020103@gmail.com> <4AB0F9B1.90606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:58883 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZIPQdJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 12:33:09 -0400
Received: by fxm17 with SMTP id 17so2408188fxm.37
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 09:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AB0F9B1.90606@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 16, 2009 at 10:44:01PM +0800, Xiangfu Liu wrote:
> Xiangfu Liu wrote:
> > Hi Dmitry
> > 
> >>>  thanks for the reply.
> >>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy change the 
> >>> defkeymap.map. make all the red keys work.
> >>>
> >>> but for the [Blue Fn] key. I don't know how to make it work in keymap?
> >>> there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier keys.
> >>> all used. so I can not may the [Fn] to those four modifier keys.
> >>>
> >>> can I make the leftAlt and rightAlt generate different keys?
> >>> like:
> >>>  LeftAlt + 'U' = Alt + 'U'
> >>>  RightAlt + 'U' = '7'
> >>>
> >> Keyboard driver supports 9 modifiers total, you should be able use one
> >> of these for your numeric buttons.
> >>
> > 
> > oh. can you give me some tips on the other modifiers.
> > how to define them? 
> > can I just change the defkeymap.map file?
> > or I must change the source code?
> > 
> Hi Dmitry I found this[1] in the 'man keymaps', three are 9 modifiers.
> but the in defkaymap.map, there is alwasy like:
> 
> control keycode  53 = Delete
> 
> there is no ctrll in the defkeymap.map.
> how to implement this?
>
> ShiftL + u = U
> ShiflR + u = 7
> 

The same as with AltGr you need to do

keycode XX = CtrlR

and then

keycode YY = u
shift keycode YY = U
ctrlr keycode YY = seven

Let me know if this works.

-- 
Dmitry
