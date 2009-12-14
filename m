From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Mon, 14 Dec 2009 09:36:31 -0800
Message-ID: <20091214173631.GC2373@core.coreip.homeip.net>
References: <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de> <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com> <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de> <4B21308F.5070304@canonical.com> <1260541128.3656.6.camel@bede> <4B225601.3080002@canonical.com> <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi> <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41039 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZLNRgp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2009 12:36:45 -0500
Received: by fxm5 with SMTP id 5so3821347fxm.28
        for <linux-input@vger.kernel.org>; Mon, 14 Dec 2009 09:36:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B261412.6090409@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Mon, Dec 14, 2009 at 11:31:46AM +0100, Stefan Bader wrote:
> Dmitry Torokhov wrote:
> > On Sat, Dec 12, 2009 at 04:00:50AM +0200, Anssi Hannula wrote:
> >> Tim Cole wrote:
> >>> On Fri, 2009-12-11 at 15:24 +0100, Stefan Bader wrote:
> >>>> The problem moved though. For the older kernels it was the tablets that
> >>>> were incorrectly detected as joysticks. But that patch of you went upstream
> >>>> and now it is the one joystick model that does not work.
> >>>> In our tree we reverted the patch in Jaunty, but with Karmic we have the other
> >>>> behavior. So in essence, someone is always complaining. :-P
> >>> I know what you mean, but well -- ideally we want to converge on the
> >>> correct behavior.  Otherwise we'll just keep spinning and things stay
> >>> broken.
> >>>
> >>> To my view, blacklisting a joystick which (wrongly) reports itself as a
> >>> digitizer tablet is an improvement over creating broken joystick devices
> >>> for anything that reports itself as a tablet.  From that position we can
> >>> fix the problem with the single device reporting the wrong device type
> >>> and then everyone can be happy.
> >> As far as I understood, we do not yet know why the joystick gets
> >> assigned digitizer keys, as the HID debug information requested has not
> >> been provided. We do not know for sure what the joystick itself reports
> >> or whether it is wrong or not.
> >>
> > 
> > Well, the thing is reported ot have 39 buttons... HID simply starts at
> > BTN_TRIGGER and goes form there.
> > 
> > 39 buttons.. sheesh.. maybe we need to reclassify it as a keyboard and
> > be done with it ;)
> > 
> 
> This might be an overly naive approach (or call it thinking loudly)...
> It would probably break a lot of stuff when the JOYSTICK/TRIGGER block
> moved to the 0x210 region, but would it be a solution to have a block
> of additional joystick buttons there and check on assigning buttons to
> a joystick, whether it traverses over to GAMEPAD and in that case skip
> to the additional block?
> 

That's what we have to do I guess... I wonder how many keycodes will we
need so we won't have to split the region again? Will they come up with
70 buttons next time?

-- 
Dmitry
