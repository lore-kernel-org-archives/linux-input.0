From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Thu, 17 Sep 2009 23:49:45 -0700
Message-ID: <20090918064945.GH18668@core.coreip.homeip.net>
References: <4AB0929D.4030007@gmail.com> <20090916163305.GB4970@core.coreip.homeip.net> <4AB11F49.6060308@gmail.com> <200909161040.20085.dmitry.torokhov@gmail.com> <4AB19F9C.3080707@gmail.com> <20090918054529.GC18668@core.coreip.homeip.net> <4AB32C81.9040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:64010 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZIRGtq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 02:49:46 -0400
Received: by ywh5 with SMTP id 5so956407ywh.4
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 23:49:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AB32C81.9040708@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Sep 18, 2009 at 02:45:21PM +0800, Xiangfu Liu wrote:
> Dmitry Torokhov wrote:
> > On Thu, Sep 17, 2009 at 10:31:56AM +0800, Xiangfu Liu wrote:
> >> Dmitry Torokhov wrote:
> >>> On Wednesday 16 September 2009 10:24:25 am Xiangfu Liu wrote:
> >>>> Dmitry Torokhov wrote:
> >>>>> On Wed, Sep 16, 2009 at 10:44:01PM +0800, Xiangfu Liu wrote:
> >>>>>> Xiangfu Liu wrote:
> >>>>>>> Hi Dmitry
> >>>>>>>
> >>>>>>>>>  thanks for the reply.
> >>>>>>>>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy
> >>>>>>>>> change the defkeymap.map. make all the red keys work.
> >>>>>>>>>
> >>>>>>>>> but for the [Blue Fn] key. I don't know how to make it work in
> >>>>>>>>> keymap? there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier
> >>>>>>>>> keys. all used. so I can not may the [Fn] to those four modifier
> >>>>>>>>> keys.
> >>>>>>>>>
> >>>>>>>>> can I make the leftAlt and rightAlt generate different keys?
> >>>>>>>>> like:
> >>>>>>>>>  LeftAlt + 'U' = Alt + 'U'
> >>>>>>>>>  RightAlt + 'U' = '7'
> >>>>>>>> Keyboard driver supports 9 modifiers total, you should be able use one
> >>>>>>>> of these for your numeric buttons.
> >>>>>>> oh. can you give me some tips on the other modifiers.
> >>>>>>> how to define them?
> >>>>>>> can I just change the defkeymap.map file?
> >>>>>>> or I must change the source code?
> >>>>>> Hi Dmitry I found this[1] in the 'man keymaps', three are 9 modifiers.
> >>>>>> but the in defkaymap.map, there is alwasy like:
> >>>>>>
> >>>>>> control keycode  53 = Delete
> >>>>>>
> >>>>>> there is no ctrll in the defkeymap.map.
> >>>>>> how to implement this?
> >>>>>>
> >>>>>> ShiftL + u = U
> >>>>>> ShiflR + u = 7
> >>>>> The same as with AltGr you need to do
> >>>>>
> >>>>> keycode XX = CtrlR
> >>>>>
> >>>>> and then
> >>>>>
> >>>>> keycode YY = u
> >>>>> shift keycode YY = U
> >>>>> ctrlr keycode YY = seven
> >>>> Hi Dmitry
> >>>> thanks for the reply. I test this, it's not work.
> >>>> ----------
> >>>> $ loadkeys -m defkeymap.map > defkeymap.c && rm defkeymap.o
> >>>> loadkeys: defkeymap.map:71: adding map 64 violates explicit keymaps line
> >>> You need to fix this ^^^^ first.
> >>>
> >> the line 71 is the "ctrlr ....", so I think the defkeymap.map not support 
> >> the "ctrlr".
> >>
> > 
> > Please look at the very beginning of the file where there is "keymaps"
> > statement - you need to enable keymap 64.
> > 
> Hi Dmitry.
> very thanks. it's work now.

Great! I am glad to hear you were able to work this out.

-- 
Dmitry
