From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Getting touchscreen to work on Fujitsu B6210
Date: Tue, 1 May 2007 14:02:28 -0400
Message-ID: <d120d5000705011102j2182e1faudb33e12d32999e41@mail.gmail.com>
References: <20070221221629.59088fed@localhost>
	 <200704040116.58366.dtor@insightbb.com>
	 <20070405133615.6536eea5@localhost>
	 <200704052227.19831.dtor@insightbb.com>
	 <d120d5000705010849h396fb6a0qf4e2065643f3adcf@mail.gmail.com>
	 <20070501103916.4580a674@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070501103916.4580a674@localhost.localdomain>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/1/07, Stephen Hemminger <shemminger@linux-foundation.org> wrote:
> On Tue, 1 May 2007 11:49:38 -0400
> "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
>
> > Hi Stephen,
> >
> > On 4/5/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > >
> > > Could ypou please load evbug module or run evtest utility and
> > > verify that the driver produces reasonable events?
> > >
> > > > Do I need an Xorg driver for it?
> > >
> > > Mousedev (i.e. /dev/input/{mouseX|mice} will provide crude
> > > emulation of normal mouse; there is evtouch X driver that
> > > should work better. You may also try evdev X driver from
> > > recent releases of x.org; as far as I know they want it to
> > > supesede evtouch eventually.
> > >
> >
> > Did you have any luck with fujitsu_ts module? Is it busted or is it ok for -mm?
> >
>
> Yes and no.  I got the touchscreen to function, but the input is all off.
> Cursor doesn't line up with stylus etc. Either there is a calibration issue or
> maybe the data isn't being interpreted correctly.
>

Hopefully it is the former. Could you please compile and load evbug
module or locate evtest utility and run your stylus around the
perimeter of your screen, clockwise, starting with upper left corner.
This will give us an idea whether the decoding work correctly or not.

Thanks!

-- 
Dmitry
