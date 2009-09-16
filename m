From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 10:40:19 -0700
Message-ID: <200909161040.20085.dmitry.torokhov@gmail.com>
References: <4AB0929D.4030007@gmail.com> <20090916163305.GB4970@core.coreip.homeip.net> <4AB11F49.6060308@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:60974 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbZIPRkn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 13:40:43 -0400
Received: by fxm17 with SMTP id 17so2452838fxm.37
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 10:40:45 -0700 (PDT)
In-Reply-To: <4AB11F49.6060308@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Wednesday 16 September 2009 10:24:25 am Xiangfu Liu wrote:
> Dmitry Torokhov wrote:
> > On Wed, Sep 16, 2009 at 10:44:01PM +0800, Xiangfu Liu wrote:
> >> Xiangfu Liu wrote:
> >>> Hi Dmitry
> >>>
> >>>>>  thanks for the reply.
> >>>>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy
> >>>>> change the defkeymap.map. make all the red keys work.
> >>>>>
> >>>>> but for the [Blue Fn] key. I don't know how to make it work in
> >>>>> keymap? there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier
> >>>>> keys. all used. so I can not may the [Fn] to those four modifier
> >>>>> keys.
> >>>>>
> >>>>> can I make the leftAlt and rightAlt generate different keys?
> >>>>> like:
> >>>>>  LeftAlt + 'U' = Alt + 'U'
> >>>>>  RightAlt + 'U' = '7'
> >>>>
> >>>> Keyboard driver supports 9 modifiers total, you should be able use one
> >>>> of these for your numeric buttons.
> >>>
> >>> oh. can you give me some tips on the other modifiers.
> >>> how to define them?
> >>> can I just change the defkeymap.map file?
> >>> or I must change the source code?
> >>
> >> Hi Dmitry I found this[1] in the 'man keymaps', three are 9 modifiers.
> >> but the in defkaymap.map, there is alwasy like:
> >>
> >> control keycode  53 = Delete
> >>
> >> there is no ctrll in the defkeymap.map.
> >> how to implement this?
> >>
> >> ShiftL + u = U
> >> ShiflR + u = 7
> >
> > The same as with AltGr you need to do
> >
> > keycode XX = CtrlR
> >
> > and then
> >
> > keycode YY = u
> > shift keycode YY = U
> > ctrlr keycode YY = seven
> 
> Hi Dmitry
> thanks for the reply. I test this, it's not work.
> ----------
> $ loadkeys -m defkeymap.map > defkeymap.c && rm defkeymap.o
> loadkeys: defkeymap.map:71: adding map 64 violates explicit keymaps line

You need to fix this ^^^^ first.

-- 
Dmitry
