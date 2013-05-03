From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Fri, 3 May 2013 09:01:43 -0700
Message-ID: <20130503160142.GC5567@core.coreip.homeip.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
 <CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
 <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
 <3024546.hGDLPfhqRN@f17simon>
 <CAFmpkyhiDp6ji=9P6XtCwvNWFvw+DNAc3p+sJ06QOPAL_ewQhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:59800 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933207Ab3ECQBr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 12:01:47 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so869127dae.2
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 09:01:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyhiDp6ji=9P6XtCwvNWFvw+DNAc3p+sJ06QOPAL_ewQhQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: Simon Farnsworth <simon.farnsworth@onelan.com>, David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Fri, May 03, 2013 at 08:57:12AM -0400, Todd Showalter wrote:
> On Fri, May 3, 2013 at 6:29 AM, Simon Farnsworth
> <simon.farnsworth@onelan.com> wrote:
> 
> > Could you consider a gamepad equivalent of libv4l2 (source found in
> > http://git.linuxtv.org/v4l-utils.git/tree/HEAD:/lib )?
> 
> [8<]
> 
> > A gamepad version would intercept opens of /dev/input/event* nodes, and if
> > that node was a gamepad, do the remapping from gamepad-specific events to the
> > standard gamepad events. You can then use this with unmodified apps as an
> > LD_PRELOAD, or with modified apps as a shared library that only gets in the way
> > if the app is accessing a gamepad.
> 
>     The problem here is that this really shouldn't be a shared library
> if it's going to be accessed directly by (say) games.  Unless there's
> something I'm missing, accessing /dev/input/event* requires elevated
> privileges, and the idea that all games will run as root kind of
> terrifies me.

Actually not all input devices have to be accessible to root only. We
definitely need this for now for keyboards (since we do not have
revoke() yet) so that one user would not snoop another users keystrokes,
but I think we could relax the restriction for certain devices such as:

"A device that emits ABS_X and ABS_Y events and button events in
BTN_JOYSTICK - BTN_GAMEPAD ranges and no other key events can be considered
a gamepad or joystick device and should be available for read/write by
the current console owner".

You may want to talk to ConsoleKit/systemd folks and see if they are
willing to consider this.

Thanks.

-- 
Dmitry
