From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 4/8 v3] Input: synaptics - add image sensor support
Date: Thu, 18 Aug 2011 00:47:12 +0800
Message-ID: <CAGS+omDWRu6CVgHs1BQpOpWYwA6oECNmn=60hnCsWEaVVbAckA@mail.gmail.com>
References: <1313169407-4358-1-git-send-email-djkurtz@chromium.org>
 <1313169407-4358-5-git-send-email-djkurtz@chromium.org> <20110812210911.GA9124@polaris.bitmath.org>
 <CAGS+omAo1tPzBQ_s+vz-7_5SS6vWv4bdzD1JfqepUS7wYxK5sA@mail.gmail.com>
 <CAGS+omCeb6R_Y7Js+da=E+etNYXWu+DjT=Mio_DLSwQo97yNkg@mail.gmail.com> <20110817163226.GB4877@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:54314 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab1HQQrg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 12:47:36 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p7HGlYhW032376
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 09:47:35 -0700
Received: from iye7 (iye7.prod.google.com [10.241.50.7])
	by hpaq1.eem.corp.google.com with ESMTP id p7HGlWtC024384
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 09:47:33 -0700
Received: by iye7 with SMTP id 7so2433287iye.31
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 09:47:32 -0700 (PDT)
In-Reply-To: <20110817163226.GB4877@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, chase.douglas@canonical.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

On Thu, Aug 18, 2011 at 12:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Aug 17, 2011 at 10:05:48PM +0800, Daniel Kurtz wrote:
> > On Mon, Aug 15, 2011 at 3:17 PM, Daniel Kurtz <djkurtz@chromium.org=
> wrote:
> > >
> > > Hi Henrik,
> > >
> > > Thanks for the great feedback.
> > >
> > > On Sat, Aug 13, 2011 at 5:09 AM, Henrik Rydberg <rydberg@euromail=
=2Ese> wrote:
> > > > Hi Daniel,
> > > >
> > > > looks good, some details below.
> > > >
> > > > The ABS_MT_TOUCH_MAJOR is supposed to have zero intercept, to r=
emain
> > > > compatible with user space handling of type A devices. Also, th=
e scale
> > > > should match the screen/pad size, such that the actual size of =
the
> > > > touch area can be deduced. In addition, based on the current se=
nsor
> > > > technologies, ABS_MT_PRESSURE and ABS_MT_TOUCH_MAJOR are normal=
ly
> > > > mutually exclusive.
> > > >
> > > > All in all, I would prefer to only report width via (the single=
-finger
> > > > axis) ABS_TOOL_WIDTH, and only for compatibility reasons.
> > > >
> > > > +
> > > > +static void synaptics_report_slot_agm(struct input_dev *dev, i=
nt slot,
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct synaptics_hw_state *agm)
> > > > +{
> > > > + =A0 =A0 input_mt_slot(dev, slot);
> > > > + =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, true)=
;
> > > > + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X, agm->x);
> > > > + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, invert_y(agm=
->y));
> > > > + =A0 =A0 input_report_abs(dev, ABS_MT_PRESSURE, agm->z);
> > > > +}
> > >
> > > With ABS_MT_TOUCH_MAJOR dropped, sgm and agm seems to coincide...
> > > ....
> > > >
> > > > Looks good otherwise.
> > > >
> > > > Thanks,
> > > > Henrik
> > > >
> > >
> > > Ahh.... =A0ok, this makes sense. =A0I missed this detail previous=
ly.
> > > Basically:
> > > =A0* Only report synaptics "w" as ABS_TOOL_WIDTH (for backwards c=
ompatibility)
> > > =A0* Report synaptics "z" as ABS_MT_TOUCH_MAJOR (assuming it is r=
eally
> > > 'width of finger in surface units'), and ABS_PRESSURE (for backwa=
rds
> > > compatibility).
> > > =A0* Don't use ABS_MT_PRESSURE.
> > > =A0* This will simplify agm/sgm reporting by making them both reo=
prt
> > > the same axes.
> >
> > Hi Henrik,
> >
> > I think I was wrong in my previous comment.
> >
> > I agree we should drop reporting synaptics 'w' (4-15, arbitrary uni=
ts)
> > in ABS_MT_TOUCH_MAJOR.
> > Instead, to support legacy, report 'w' in ABS_TOOL_WIDTH, and do no=
t
> > report ABS_MT_TOUCH_MAJOR at all.
> >
> > However, I believe we should still report synaptics 'z' (0-255, in
> > arbitrary units) as ABS_MT_PRESSURE.
> > This will, in turn, be used by input_mt_report_pointer_emulation() =
to
> > determine the correct ABS_PRESSURE to report for legacy userspace
> > uses.
>
> Alternatively, you can use input_mt_set_value() to save Z value to be
> used by input_mt_report_pointer_emulation() later, but not report it =
as
> part of MT packet.
>
> --
> Dmitry

But I want userspace to get per-contact pressure, since it is used to
determine whether a given contact is a palm or finger, etc. The
trackpad does not report a useful per-contact "width" that can be used
to generate "TOUCH_MAJOR".
Does it therefore sound reasonable to report ABS_MT_PRESSURE?

-Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
