From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Three buttons reported on two-button touchpad
Date: Sun, 15 Nov 2009 15:59:08 -0800
Message-ID: <20091115235908.GA29455@core.coreip.homeip.net>
References: <200911141551.14263.arvidjaar@mail.ru> <20091115062036.GA9844@core.coreip.homeip.net> <200911151148.32631.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752896AbZKOX7U@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200911151148.32631.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Nov 15, 2009 at 11:48:29AM +0300, Andrey Borzenkov wrote:
> On Sunday 15 of November 2009 09:20:36 Dmitry Torokhov wrote:
> > Hi Andrey,
> > 
> > On Sat, Nov 14, 2009 at 03:51:10PM +0300, Andrey Borzenkov wrote:
> > > Kernel 2.6.31.x
> > >
> > > dmesg:
> > > Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1c0b1, caps:
> > > 0xa04751/0x0
> > >
> > > but /proc/bus/input/devices:
> > >
> > > I: Bus=0011 Vendor=0002 Product=0007 Version=01b1
> > > N: Name="SynPS/2 Synaptics TouchPad"
> > > P: Phys=isa0060/serio1/input0
> > > S: Sysfs=/devices/platform/i8042/serio1/input/input15
> > > U: Uniq=
> > > H: Handlers=mouse1 event2
> > > B: EV=b
> > > B: KEY=420 70000 0 0 0 0
> > > B: ABS=11000003
> > >
> > > So even when capabilities clear say only 2 buttons, driver claims
> > > there are 3 of them.
> > >
> > > The reason most likely is initialization sequence.
> > > psmouse_switch_protocol() unconditionally sets supported buttons:
> > >
> > >         input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
> > >         input_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT)
> > > | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT); input_dev->relbit[0]
> > > = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
> > >
> > > before even starting hardware detection and knowing real
> > > capabilities. Detection for specific hardware won't change it
> > > (possibly only extend).
> > 
> > Some of them do.
> > 
> > > Is it OK to move button bits setting into ps2bare_detect()? This
> > > seems to agree with comments in psmouse_extensions() as well:
> > >
> > > /*
> > >  * Okay, all failed, we have a standard mouse here. The number of
> > > the buttons
> > >  * is still a question, though. We assume 3.
> > >  */
> > >
> > > All other detection routines seem to be setting those bits already.
> > 
> > Not all of them but yes, I think we should to this. DOes th patch
> >  below work for you?
> > 
> 
> Yes (I can test only Synaptics case).
> 
> Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 

Thank you for testing.

> > +       input_dev->keybit[BIT_WORD(BTN_MOUSE)] =
> > +                               BIT_MASK(BTN_LEFT) | 
> BIT_MASK(BTN_RIGHT);
> 
> Just curious - is Apple touchpad (as found on MacBook) handled by 
> different driver? Because it has just single button.

It is an USB device and it is handled by either handled by appletouch or
by bcm5974 drivers.

-- 
Dmitry
