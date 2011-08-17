From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/8 v3] Input: synaptics - add image sensor support
Date: Wed, 17 Aug 2011 09:32:26 -0700
Message-ID: <20110817163226.GB4877@core.coreip.homeip.net>
References: <1313169407-4358-1-git-send-email-djkurtz@chromium.org>
 <1313169407-4358-5-git-send-email-djkurtz@chromium.org>
 <20110812210911.GA9124@polaris.bitmath.org>
 <CAGS+omAo1tPzBQ_s+vz-7_5SS6vWv4bdzD1JfqepUS7wYxK5sA@mail.gmail.com>
 <CAGS+omCeb6R_Y7Js+da=E+etNYXWu+DjT=Mio_DLSwQo97yNkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52824 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab1HQQcd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 12:32:33 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omCeb6R_Y7Js+da=E+etNYXWu+DjT=Mio_DLSwQo97yNkg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, chase.douglas@canonical.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

On Wed, Aug 17, 2011 at 10:05:48PM +0800, Daniel Kurtz wrote:
> On Mon, Aug 15, 2011 at 3:17 PM, Daniel Kurtz <djkurtz@chromium.org> =
wrote:
> >
> > Hi Henrik,
> >
> > Thanks for the great feedback.
> >
> > On Sat, Aug 13, 2011 at 5:09 AM, Henrik Rydberg <rydberg@euromail.s=
e> wrote:
> > > Hi Daniel,
> > >
> > > looks good, some details below.
> > >
> > > The ABS_MT_TOUCH_MAJOR is supposed to have zero intercept, to rem=
ain
> > > compatible with user space handling of type A devices. Also, the =
scale
> > > should match the screen/pad size, such that the actual size of th=
e
> > > touch area can be deduced. In addition, based on the current sens=
or
> > > technologies, ABS_MT_PRESSURE and ABS_MT_TOUCH_MAJOR are normally
> > > mutually exclusive.
> > >
> > > All in all, I would prefer to only report width via (the single-f=
inger
> > > axis) ABS_TOOL_WIDTH, and only for compatibility reasons.
> > >
> > > +
> > > +static void synaptics_report_slot_agm(struct input_dev *dev, int=
 slot,
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct synaptics_hw_state *agm)
> > > +{
> > > + =A0 =A0 input_mt_slot(dev, slot);
> > > + =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
> > > + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X, agm->x);
> > > + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, invert_y(agm->=
y));
> > > + =A0 =A0 input_report_abs(dev, ABS_MT_PRESSURE, agm->z);
> > > +}
> >
> > With ABS_MT_TOUCH_MAJOR dropped, sgm and agm seems to coincide...
> > ....
> > >
> > > Looks good otherwise.
> > >
> > > Thanks,
> > > Henrik
> > >
> >
> > Ahh.... =A0ok, this makes sense. =A0I missed this detail previously=
=2E
> > Basically:
> > =A0* Only report synaptics "w" as ABS_TOOL_WIDTH (for backwards com=
patibility)
> > =A0* Report synaptics "z" as ABS_MT_TOUCH_MAJOR (assuming it is rea=
lly
> > 'width of finger in surface units'), and ABS_PRESSURE (for backward=
s
> > compatibility).
> > =A0* Don't use ABS_MT_PRESSURE.
> > =A0* This will simplify agm/sgm reporting by making them both reopr=
t
> > the same axes.
>=20
> Hi Henrik,
>=20
> I think I was wrong in my previous comment.
>=20
> I agree we should drop reporting synaptics 'w' (4-15, arbitrary units=
)
> in ABS_MT_TOUCH_MAJOR.
> Instead, to support legacy, report 'w' in ABS_TOOL_WIDTH, and do not
> report ABS_MT_TOUCH_MAJOR at all.
>=20
> However, I believe we should still report synaptics 'z' (0-255, in
> arbitrary units) as ABS_MT_PRESSURE.
> This will, in turn, be used by input_mt_report_pointer_emulation() to
> determine the correct ABS_PRESSURE to report for legacy userspace
> uses.

Alternatively, you can use input_mt_set_value() to save Z value to be
used by input_mt_report_pointer_emulation() later, but not report it as
part of MT packet.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
