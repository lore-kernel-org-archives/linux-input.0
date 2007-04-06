From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Getting touchscreen to work on Fujitsu B6210
Date: Thu, 5 Apr 2007 22:27:19 -0400
Message-ID: <200704052227.19831.dtor@insightbb.com>
References: <20070221221629.59088fed@localhost> <200704040116.58366.dtor@insightbb.com> <20070405133615.6536eea5@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070405133615.6536eea5@localhost>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-input@vger.kernel.org

On Thursday 05 April 2007 16:36, Stephen Hemminger wrote:
> On Wed, 4 Apr 2007 01:16:57 -0400
> Dmitry Torokhov <dtor@insightbb.com> wrote:
> 
> > Hi Stephen,
> > 
> > On Thursday 22 February 2007 01:16, Stephen Hemminger wrote:
> > > I did a little investigation and the touchscreen on B6210 is
> > > attached via the 8250 serial port. I tried enabling it with
> > > inputattach but seem to get garbage.
> > > 
> > > I can extract the initialization code from the evtouch driver
> > > to a usermode program and read information from /dev/ttyS0.
> > > 
> > > The lifebook psmouse extension won't work because it tries
> > > to grab the 8042 (touchpad) rather than the touch screen.
> > > 
> > > Ideas?
> > > 
> > 
> > Please try the patch below. You will need to load 8250_pnp,
> > serport and fujitsu_ts modules, then do
> > 
> >         inputattach -fjt /dev/ttyS0
> >
> 
> inputattach runs (then waits). Data is arriving when I touch
> the screen. Now what?

Could ypou please load evbug module or run evtest utility and
verify that the driver produces reasonable events?

> Do I need an Xorg driver for it? 

Mousedev (i.e. /dev/input/{mouseX|mice} will provide crude
emulation of normal mouse; there is evtouch X driver that
should work better. You may also try evdev X driver from
recent releases of x.org; as far as I know they want it to
supesede evtouch eventually.

There are also solutions based on tslib library that allows
touchscreen calibrating, etc. but I am not familiar with it
so I am CCing Richard Purdie.

-- 
Dmitry
