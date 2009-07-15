From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] input/joystick: new AD7142driver
Date: Tue, 14 Jul 2009 23:42:28 -0400
Message-ID: <200907142342.29177.rgetz@blackfin.uclinux.org>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org> <20090714180309.GC14661@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:58018 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbZGODjG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 23:39:06 -0400
In-Reply-To: <20090714180309.GC14661@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: uclinux-dist-devel@blackfin.uclinux.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, "Hennerich, Michael" <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Tue 14 Jul 2009 14:03, Dmitry Torokhov pondered:
> Hi Bryan,
> 
> On Tue, Jul 14, 2009 at 01:33:46PM -0400, Mike Frysinger wrote:
> > From: Bryan Wu <cooloney@kernel.org>
> > 
> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> >  drivers/input/joystick/Kconfig  |    9 +
> >  drivers/input/joystick/Makefile |    1 +
> >  drivers/input/joystick/ad7142.c |  466
> +++++++++++++++++++++++++++++++++++++++

[snip]

> > +	input = data->input;
> > +	input->open = ad7142_open;
> > +	input->close = ad7142_close;
> > +	input->evbit[0] = BIT_MASK(EV_KEY);
> > +	input->keybit[BIT_WORD(BTN_BASE)] = BIT_MASK(BTN_BASE) |
> > +						BIT_MASK(BTN_BASE2) |
> > +						BIT_MASK(BTN_BASE3) |
> > +						BIT_MASK(BTN_BASE4);
> > +	input->keybit[BIT_WORD(KEY_UP)] |=  BIT_MASK(KEY_UP) |
> > +						BIT_MASK(KEY_DOWN) |
> > +						BIT_MASK(KEY_LEFT) |
> > +						BIT_MASK(KEY_RIGHT);
> > +
> 
> I am really not sure why you call it a joystick since it does not report
> relative axes... Let's put it in misc and just another button device.
> 
> > +	input->name = "ad7142 joystick";
> > +	input->phys = "ad7142/input0";
> > +	input->id.bustype = BUS_I2C;
> > +	input->id.vendor = 0x0001;
> > +	input->id.product = 0x0001;
> > +	input->id.version = 0x0100;

Since most people use it as a joypad - but I guess joypad isn't joystick...

However - the device in question is multi-purpose - depending on the PCB, it 
can be any of buttons, wheels, scroll-bar, slider, joypad, or touchpad.

https://docs.blackfin.uclinux.org/doku.php?id=capacitance_touch_sensors

So -- maybe misc would be better...
