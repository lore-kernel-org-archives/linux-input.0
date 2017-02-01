From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] Initialize axis values in joydev_open_device()
Date: Tue, 31 Jan 2017 17:44:49 -0800
Message-ID: <20170201014449.GA17308@dtor-ws>
References: <20161218202050.GX10002@yggdrasil2.lan.raphnet.net>
 <20170128190100.GA32332@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34179 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdBABow (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 20:44:52 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so30534047pfb.1
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2017 17:44:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170128190100.GA32332@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raphael Assenat <raph@raphnet.net>
Cc: linux-input@vger.kernel.org

On Sat, Jan 28, 2017 at 11:01:00AM -0800, Dmitry Torokhov wrote:
> Hi Raphael,
> 
> On Sun, Dec 18, 2016 at 03:20:50PM -0500, Raphael Assenat wrote:
> > Postpone axis initialization to the first open instead of doing it once
> > in joydev_connect. This is to make sure the generated startup events
> > are representative of the current joystick state rather than what
> > it was when joydev_connect() was called, potentially much earlier.
> > 
> > This solves issues with joystick driven menus that start scrolling
> > up each time they are started, until the user moves the joystick to
> > generate events. In emulator menu setups where the menu program is
> > restarted every time the game exits, the repeated need to move the
> > joystick to stop the unintended scrolling gets old rather quickly...
> > 
> > Unless I misunderstood the intent of JS_EVENT_INIT, I think the startup
> > events should reflect the current state of the joystick. Please consider
> > applying if it makes sense.
> 
> Sorry for the delay and what you are saying certainly makes sense.
> Unfortunately with the patch as is we end up re-initializing calibration
> coefficients every time user opens device (assuming that there is only
> one user of joystick device at a time), whereas before one could have a
> small utility calibrating the joystick, and then go on to using it with
> some other application (game). How about we keep most of the
> initialization in connect() and only populate axis data in open(), like
> below?

Thinking about it some more, do we really want to fetch current state of
joystick and not start with "rest" state?

If joystick is actively generating events then it doe snot matter, but
if it is resting and has not generated any events yet, then axis values
will be at 0, which, if axis range is [0-1024], will translate to
-32767.

Maybe we should start all clients with JS_CORR_BROKEN as:

	val = (input_abs_get_max(dev, i) + input_abs_get_min(dev, i)) / 2;
	joydev->abs[i] = joydev_correct(val, &joydev->corr[i]);

What do you think?

Thanks.

-- 
Dmitry
