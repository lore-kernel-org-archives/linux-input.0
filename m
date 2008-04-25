From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142 joystick
	driver (v2)
Date: Fri, 25 Apr 2008 11:39:59 -0400
Message-ID: <20080425113501.ZZRA012@mailhub.coreip.homeip.net>
References: <1206643110-8789-1-git-send-email-cooloney@kernel.org> <20080418131149.ZZRA012@mailhub.coreip.homeip.net> <386072610804250309j5f2222cfj2f58b3b92d091a3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759197AbYDYPk1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <386072610804250309j5f2222cfj2f58b3b92d091a3a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: khali@linux-fr.org, andre@bitwigglers.org, linux-input@vger.kernel.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, vapier.adi@gmail.com, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 25, 2008 at 06:09:52PM +0800, Bryan Wu wrote:
> On Sat, Apr 19, 2008 at 1:15 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Bryan,
> >
> >
> >  On Thu, Mar 27, 2008 at 11:38:30AM -0700, Bryan Wu wrote:
> >  > +     input->keybit[BIT_WORD(BTN_BASE)] = BIT_MASK(BTN_BASE) |
> >  > +                                             BIT_MASK(BTN_BASE2) |
> >  > +                                             BIT_MASK(BTN_BASE3) |
> >  > +                                             BIT_MASK(BTN_BASE4);
> >  > +     input->keybit[BIT_WORD(KEY_UP)] |=  BIT_MASK(KEY_UP) |
> >  > +                                             BIT_MASK(KEY_DOWN) |
> >  > +                                             BIT_MASK(KEY_LEFT) |
> >  > +                                             BIT_MASK(KEY_RIGHT);
> >  > +
> >
> >  Why don't you use REL_X/REL_Y to report directional movement? Using
> >  buttons for that is pretty unusual.
> >
> 
> In our development board, it includes UP/DOWN/LEFT/RIGHT 4 buttons. So
> this driver matches this.
> Please found some information about the hardware as below:
> http://docs.blackfin.uclinux.org/doku.php?id=capacitance_touch_sensors&s[]=ad7142

What is the expected behaviur when a person touches one of these
buttons? Is it generatig a left/rigth mouse button clocks or moving a
pointer in some direction? Judging by the category of the devices you
are placing it in (joystick) it seems that latter is what you want,
therefore it should generate REL_X and REL_Y events. Otherwise it
should probably be called a button driver and live either in
drivers/input/keyboard or driver/input/misc. Do you agree?

Thanks.

-- 
Dmitry
