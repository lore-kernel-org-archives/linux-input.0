From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [PATCH] touchscreen: Fujitsu touchscreen driver
Date: Tue, 10 Jul 2007 16:09:23 -0700
Message-ID: <20070710160923.7065b64a@localhost>
References: <20070221221629.59088fed@localhost>
	<200704040116.58366.dtor@insightbb.com>
	<20070405133615.6536eea5@localhost>
	<200704052227.19831.dtor@insightbb.com>
	<d120d5000705010849h396fb6a0qf4e2065643f3adcf@mail.gmail.com>
	<20070501103916.4580a674@localhost.localdomain>
	<d120d5000705011102j2182e1faudb33e12d32999e41@mail.gmail.com>
	<20070521120229.3ab484ca@localhost>
	<d120d5000705220624k38728dc5kdff5ea3670bf6036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000705220624k38728dc5kdff5ea3670bf6036@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, 22 May 2007 09:24:20 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Hi Stephen,
> 
> Thank you for looking at the patch and working out quirks...
> 
> On 5/21/07, Stephen Hemminger <shemminger@linux-foundation.org> wrote:
> > +
> > +#define X_AXIS_MIN     90
> > +#define X_AXIS_MAX     4000
> > +#define Y_AXIS_MIN     185
> > +#define Y_AXIS_MAX     4000
> 
> I am not sure that we want to use data from one particular laptop
> here. Since we don't know a way to query the thouchscreen on a
> particular box I'd stick with physical protocol limits (0 - 4095) and
> have user calibrate the screen.

Went back to 0 by 4096 on followup versions

> Have you tried going through the calibration procedure with evtouch
> driver? Does it not work or works incorrectly (I have no idea since I
> don't have the hardware)?

I tried it, and it corrects for offsets.

> > +static irqreturn_t fujitsu_interrupt(struct serio *serio,
> > +                                    unsigned char data, unsigned int flags)
> > +{
> > +       struct fujitsu *fujitsu = serio_get_drvdata(serio);
> > +       struct input_dev *dev = fujitsu->dev;
> > +
> > +       if (fujitsu->idx == 0) {
> > +               /* resync skip until start of frame */
> > +               if (!(data & 0x80))
> > +                       return IRQ_HANDLED;
> 
> The data sheet that I have shows the following for the first byte:
> 
> 1 C 0 0 R S S S
> 
> Where C is 1 while in calibration mode (which we don't use) and R is 1
> when no coordinate corection was done. My original patch had the check
> "(data & 0xf8) != 80", did it give you issues with the data stream
> coming out of the touchscreen? Or the missing fujitsu->idx = 0 is all
> that is really needed?
>

The first byte is always: 0x88

Sample touch in middle is
	88 72 11 4b 0f
        89 71 11 4c 0f
	89 72 11 4b 0f
	8a 71 11 48 0f

So original code that checks for (data & 0xf8) == 0x80
wouldn't work
