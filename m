From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 4/8 v3] Input: synaptics - add image sensor support
Date: Wed, 17 Aug 2011 22:05:48 +0800
Message-ID: <CAGS+omCeb6R_Y7Js+da=E+etNYXWu+DjT=Mio_DLSwQo97yNkg@mail.gmail.com>
References: <1313169407-4358-1-git-send-email-djkurtz@chromium.org>
 <1313169407-4358-5-git-send-email-djkurtz@chromium.org> <20110812210911.GA9124@polaris.bitmath.org>
 <CAGS+omAo1tPzBQ_s+vz-7_5SS6vWv4bdzD1JfqepUS7wYxK5sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omAo1tPzBQ_s+vz-7_5SS6vWv4bdzD1JfqepUS7wYxK5sA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: chase.douglas@canonical.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com
List-Id: linux-input@vger.kernel.org

On Mon, Aug 15, 2011 at 3:17 PM, Daniel Kurtz <djkurtz@chromium.org> wr=
ote:
>
> Hi Henrik,
>
> Thanks for the great feedback.
>
> On Sat, Aug 13, 2011 at 5:09 AM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
> > Hi Daniel,
> >
> > looks good, some details below.
> >
> > The ABS_MT_TOUCH_MAJOR is supposed to have zero intercept, to remai=
n
> > compatible with user space handling of type A devices. Also, the sc=
ale
> > should match the screen/pad size, such that the actual size of the
> > touch area can be deduced. In addition, based on the current sensor
> > technologies, ABS_MT_PRESSURE and ABS_MT_TOUCH_MAJOR are normally
> > mutually exclusive.
> >
> > All in all, I would prefer to only report width via (the single-fin=
ger
> > axis) ABS_TOOL_WIDTH, and only for compatibility reasons.
> >
> > +
> > +static void synaptics_report_slot_agm(struct input_dev *dev, int s=
lot,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 const struct synaptics_hw_state *agm)
> > +{
> > + =A0 =A0 input_mt_slot(dev, slot);
> > + =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
> > + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X, agm->x);
> > + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, invert_y(agm->y)=
);
> > + =A0 =A0 input_report_abs(dev, ABS_MT_PRESSURE, agm->z);
> > +}
>
> With ABS_MT_TOUCH_MAJOR dropped, sgm and agm seems to coincide...
> ....
> >
> > Looks good otherwise.
> >
> > Thanks,
> > Henrik
> >
>
> Ahh.... =A0ok, this makes sense. =A0I missed this detail previously.
> Basically:
> =A0* Only report synaptics "w" as ABS_TOOL_WIDTH (for backwards compa=
tibility)
> =A0* Report synaptics "z" as ABS_MT_TOUCH_MAJOR (assuming it is reall=
y
> 'width of finger in surface units'), and ABS_PRESSURE (for backwards
> compatibility).
> =A0* Don't use ABS_MT_PRESSURE.
> =A0* This will simplify agm/sgm reporting by making them both reoprt
> the same axes.

Hi Henrik,

I think I was wrong in my previous comment.

I agree we should drop reporting synaptics 'w' (4-15, arbitrary units)
in ABS_MT_TOUCH_MAJOR.
Instead, to support legacy, report 'w' in ABS_TOOL_WIDTH, and do not
report ABS_MT_TOUCH_MAJOR at all.

However, I believe we should still report synaptics 'z' (0-255, in
arbitrary units) as ABS_MT_PRESSURE.
This will, in turn, be used by input_mt_report_pointer_emulation() to
determine the correct ABS_PRESSURE to report for legacy userspace
uses.

Do you agree with this?

Thanks,
-Dan
