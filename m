From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: synaptics - use firmware data for Cr-48
Date: Fri, 20 Jul 2012 09:25:10 +0200
Message-ID: <20120720072510.GA986@polaris.bitmath.org>
References: <1342606923-9997-1-git-send-email-cywang@chromium.org>
 <5006D86C.7030208@canonical.com>
 <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
 <500832D7.4040805@canonical.com>
 <CAGS+omA-PwoM=U3xP_Gtadaow9SGt555NPWor_-HuvVE8-R3MQ@mail.gmail.com>
 <50084529.2030001@canonical.com>
 <20120719184419.GA3626@polaris.bitmath.org>
 <CAM2ehZaLeJsxCOkqLv9jSko9y3Awix1jjobfTo5WQj8rcrYquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:40422 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab2GTHYF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 03:24:05 -0400
Content-Disposition: inline
In-Reply-To: <CAM2ehZaLeJsxCOkqLv9jSko9y3Awix1jjobfTo5WQj8rcrYquA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chung-Yih Wang =?utf-8?B?KOeOi+W0h+aHvyk=?= <cywang@google.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Daniel Kurtz <djkurtz@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 20, 2012 at 11:14:25AM +0800, Chung-Yih Wang (=E7=8E=8B=E5=B4=
=87=E6=87=BF) wrote:
> From our experiments, the assumption of "the slowest corner is the
> stationary finger" is not always true. That is the major reason we wa=
nt to
> report the firmware data instead of semi-mt.

Oh, but that was precisely the point; the reason it does not hold true
is due to sensor and discretization errors. If we can improve upon
this situation, we get a better model of reality.

> The problem here will be how
> to remove the pulling effect, we measured the pulling effect before a=
nd can
> not get a good result as there could be IIR in firmware as well. It s=
eems
> not an easy job to remove the pulling effect cleanly.

Probably a simple filter will work. If the bounding box is moving too
fast for the tracked point to stay in the right corner, the solution
is to use a smaller time step. In practise, keeping the tracked point
as a state in the driver, and updating the bounding box using box ->
(1 - m) box + m box_new. If the tracked point is in the right corner,
let m =3D 1. If not, choose a smaller m.

> > > * Add a new device property (INVALID_Y_AXIS_CROSSING?) that
> > > describes the exact behavior of this device. I would be ok with t=
his
> > > if everyone else is, but only because proper clickpad behavior
> > > (which I consider very importand) is broken without this knowledg=
e.
> >
> Sounds good to me(but I would rather to have INVALID_CROSSING instead=
,
> depending on the relative finger positions,  it could still have wron=
g
> tracking either in X or Y axis crossing)

Propagating information about various sensor defects to userspace
sounds horrid to me. The sooner we can forget about these devices, the
better.

> > > * Leave the device as SEMI_MT, but provide the real locations, an=
d
> > > allow userspace to determine the device vendor/model/etc. If
> > > userspace knows that a specific device behaves in a specific way,=
 it
> > > can do its own quirking handling. Given the specificity of this
> > > behavior to only some devices of one brand, this would be my
> > > suggested resolution to the issue.
> >
>=20
> A bit confused here, do you mean we report the real locations instead=
 of
> bounding box the current driver have? I am not quite sure if this wil=
l
> affect other existing works in userspace for this semi-mt driver.

I am not entirely opposed to this solution, but I would much rather
see an attempt to improve the bounding box in the driver, since such a
solution could be useful for other devices as well.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
