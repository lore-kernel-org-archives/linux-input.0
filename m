From: Raphael Assenat <raph@raphnet.net>
Subject: Re: [PATCH RESEND] Initialize axis values in joydev_open_device()
Date: Thu, 2 Feb 2017 23:22:29 -0500
Message-ID: <20170203042229.GH25054@yggdrasil2.lan.raphnet.net>
References: <20161218202050.GX10002@yggdrasil2.lan.raphnet.net>
 <20170128190100.GA32332@dtor-ws>
 <20170201014449.GA17308@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:58405 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbdBCE1h (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 23:27:37 -0500
Content-Disposition: inline
In-Reply-To: <20170201014449.GA17308@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dmitry,

On Tue, Jan 31, 2017 at 05:44:49PM -0800, Dmitry Torokhov wrote:
> On Sat, Jan 28, 2017 at 11:01:00AM -0800, Dmitry Torokhov wrote:
> > Hi Raphael,
> > 
> > On Sun, Dec 18, 2016 at 03:20:50PM -0500, Raphael Assenat wrote:
> > > Postpone axis initialization to the first open instead of doing it once
> > > in joydev_connect. This is to make sure the generated startup events
> > > are representative of the current joystick state rather than what
> > > it was when joydev_connect() was called, potentially much earlier.
> > > 
> > > This solves issues with joystick driven menus that start scrolling
> > > up each time they are started, until the user moves the joystick to
> > > generate events. In emulator menu setups where the menu program is
> > > restarted every time the game exits, the repeated need to move the
> > > joystick to stop the unintended scrolling gets old rather quickly...
> > > 
> > > Unless I misunderstood the intent of JS_EVENT_INIT, I think the startup
> > > events should reflect the current state of the joystick. Please consider
> > > applying if it makes sense.
> > 
> > Sorry for the delay and what you are saying certainly makes sense.
> > Unfortunately with the patch as is we end up re-initializing calibration
> > coefficients every time user opens device (assuming that there is only
> > one user of joystick device at a time), whereas before one could have a
> > small utility calibrating the joystick, and then go on to using it with
> > some other application (game). How about we keep most of the
> > initialization in connect() and only populate axis data in open(), like
> > below?
> 
> Thinking about it some more, do we really want to fetch current state of
> joystick and not start with "rest" state?
Both approaches have merits, and in the context of my original
issue, they both work perfectly.

But I think that returning the current value might be more correct as there
could be situations where it is needed. I'm thinking about unusual/custom/homemade
controls with potentiometers on a panel where the initial value should be
effective right from the start. But one could argue that this is not a joystick
anymore and should be using evdev (or even hidraw) instead.

(There is a similar issue with evdev by the way. For HID joysticks, the current
value of abs axes is zero until events are generated, but for a different
reason. More on this below.)

> If joystick is actively generating events then it doe snot matter, but
> if it is resting and has not generated any events yet, then axis values
> will be at 0, which, if axis range is [0-1024], will translate to
> -32767.
Indeed, it won't return a centered value initially, but HID joysticks
should generate events at startup (Through the use of HID Get_Report requests).

However this feature seems broken at the moment. While the get_report requests
are properly sent to the HID device, the answers arrive at a time when they
cannot be processed and get dropped.

I created two patches last year to workaround this issue, but I'm not sure if they
are correct (I re-order things and am not sure if there are implications I don't
see). I planned to rebase them (if necessary) and post them here soon, but for now
here are the originals:
http://www.raphnet-tech.com/support/retropie/usbhid_iostart.diff
http://www.raphnet-tech.com/support/retropie/usbhid_start_before_connect.diff

> Maybe we should start all clients with JS_CORR_BROKEN as:
> 
> 	val = (input_abs_get_max(dev, i) + input_abs_get_min(dev, i)) / 2;
> 	joydev->abs[i] = joydev_correct(val, &joydev->corr[i]);
> 
> What do you think?
I'm comfortable with both suggestions, however I feel that returning the current
value is better, even though it would not be perfect until a solution to the other
issue I mentioned is implemented.

Best regards,
Raphaël Assénat
