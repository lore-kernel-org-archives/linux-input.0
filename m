From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/6] Input: elantech - use firmware provided x, y ranges
Date: Wed, 7 Sep 2011 10:33:40 +0800
Message-ID: <CAGS+omCWQk+mTXnYZRCWhH2wWrn5PfhEv414isN_r=NKAdcs1g@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-3-git-send-email-jj_ding@emc.com.tw> <20110818074756.GE10093@core.coreip.homeip.net>
 <4E5FCE58.9060906@canonical.com> <87sjobk711.fsf@emc.com.tw>
 <4E665249.2040602@canonical.com> <20110906173649.GA7419@core.coreip.homeip.net>
 <4E6660D7.9040800@canonical.com> <20110906182016.GB7419@core.coreip.homeip.net>
 <4E66749A.10009@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:10940 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab1IGCeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 22:34:04 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p872Y2eL021445
	for <linux-input@vger.kernel.org>; Tue, 6 Sep 2011 19:34:02 -0700
Received: from ywb26 (ywb26.prod.google.com [10.192.2.26])
	by hpaq12.eem.corp.google.com with ESMTP id p872XtVs030317
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 6 Sep 2011 19:34:00 -0700
Received: by ywb26 with SMTP id 26so5520221ywb.21
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 19:34:00 -0700 (PDT)
In-Reply-To: <4E66749A.10009@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Hi,

On Wed, Sep 7, 2011 at 3:29 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
>
> On 09/06/2011 11:20 AM, Dmitry Torokhov wrote:
> > On Tue, Sep 06, 2011 at 11:05:11AM -0700, Chase Douglas wrote:
> >> On 09/06/2011 10:36 AM, Dmitry Torokhov wrote:
> >>> On Tue, Sep 06, 2011 at 10:03:05AM -0700, Chase Douglas wrote:
> >>>> On 09/04/2011 08:22 PM, JJ Ding wrote:
> >>>>> Hi Chase,
> >>>>>
> >>>>> On Thu, 01 Sep 2011 11:26:32 -0700, Chase Douglas <chase.dougla=
s@canonical.com> wrote:
> >>>>>> On 08/18/2011 12:47 AM, Dmitry Torokhov wrote:
> >>>>>>> On Thu, Aug 18, 2011 at 09:57:05AM +0800, JJ Ding wrote:
> >>>>>>>> +
> >>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0i =3D (etd->fw_version > 0x0208=
00 &&
> >>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->fw_version < 0x02=
0900) ? 1 : 2;
> >>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*x_max =3D (etd->capabilities[1=
] - i) * 64;
> >>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*y_max =3D (etd->capabilities[2=
] - i) * 64;
> >>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*y_2ft_max =3D (*y_max - i) * 6=
4 / 4;
> >>>>>>>
> >>>>>>> Hmm, we should have the same range for ST and MT data and sca=
le MT data
> >>>>>>> if it has lower resolution to match ST.
> >>>>>>
> >>>>>> I saw this go by a while back and it made sense to me at the t=
ime.
> >>>>>> However, I've had some thoughts that give me pause.
> >>>>>>
> >>>>>> Seth Forshee has been working on getting a semi-mt driver for =
ALPS
> >>>>>> devices. The ALPS devices have an interesting mechanism for pr=
oviding
> >>>>>> multitouch data, but it boils down to having a resolution of o=
nly 15
> >>>>>> values in the X axis and 11 in the Y axis (it looks possible t=
o
> >>>>>> extrapolate and get double the resolution, but my point will r=
emain).
> >>>>>>
> >>>>>> Let's take the X synaptics module as an example of the repercu=
ssions of
> >>>>>> in-kernel axis scaling. The X synaptics module translates two =
touch
> >>>>>> drags into scroll events. Synaptics will want to use the highe=
st
> >>>>>> resolution axis for generating scroll events. If both the MT a=
nd ST axes
> >>>>>> have the same resolution, it might pick the MT axes for scroll=
ing. On
> >>>>>> ALPS devices with in-kernel axis scaling that would be a bad c=
hoice.
> >>>>> I don't know about the ALPS devices, but since we already repor=
t
> >>>>> ABS_MT_POSITION_{X,Y} with elantech v2, we have to do the scali=
ng in
> >>>>> kernel anyway to adhere to multitouch protocol. So I would say =
it is
> >>>>> still more appropriate to have the same resolution for ST and M=
T with
> >>>>> respect to elantech v2. Maybe ALPS should be considered an exce=
ption to this?
> >>>>
> >>>> The multitouch protocol doesn't require scaling of axes to match=
, at
> >>>> least not according to the protocol documentation.
> >>>>
> >>>> I see that the current code scales the coordinates for v2, but i=
t's only
> >>>> half-resolution. That's not a huge deal since the resolution of =
modern
> >>>> touchpads is very high. We could leave it scaled to not break ab=
i, if
> >>>> that was a concern. However, with new devices it makes sense to =
state
> >>>> the ranges in terms of what the device actually supports. Otherw=
ise,
> >>>> we're just masking out useful data that userspace could be using=
=2E
> >>>>
> >>>
> >>> I disagree. I believe that ST and MT ranges reported for the same
> >>> working surface should match, especially since many devices deriv=
e ST
> >>> data from MT.
> >>>
> >>> As far as devices that have ranges 0-15 in MT mode - I am not sur=
e how
> >>> useful such MT steam anyway and if we are better of just ignore t=
hem
> >>> (maybe just use the data to report number of fingers on the surfa=
ce but
> >>> otherwise use standard ST protocol).
> >>
> >> The MT data could still be useful for pinch to zoom or potentially
> >> rotate (though most low res devices probably are only semi-mt). I =
don't
> >> want to forsake pinch to zoom just because we can't pass on the
> >> resolution of MT data properly.
> >
> > How would userspace know that MT data should only be used for gestu=
res
> > but nothign else? By examining range? What is the "too small range"
> > then? It would be different for different devices. I do not want
> > userspace portions of the drivers to turn into unmanageble collecti=
on of
> > quirks.
>
> I wasn't suggesting that it have a big switch that enables or disable=
s
> gestures. I just want userspace to be able to figure out whether ST o=
r
> MT data would be better for a given task. If the range of the ST and =
MT
> axes could provide this data, then it makes sense to do so. The test
> wouldn't be like "is MT range big enough", it would be "is MT range
> better than ST or vice versa".
>
> However, Henrik pointed out that some devices report ranges that aren=
't
> representative of how accurate or precise they really are. That
> invalidates this approach.
>
> > Some hardware is just hopeless... And pinch to zoom is cute but har=
dly
> > most used function on a laptop (as opposed to phone/tablet), I'd ju=
st
> > leave it be.
>
> Just because a piece of hardware is imprecise does not mean it is
> useless for gestures. Sure, it may not work that great for precision
> zooming, but it would be good enough for threshold matching. The Unit=
y
> window manager uses these thresholds to fire actions like spread (or
> "expose" in OS X terms).
>
> -- Chase

As far as I can tell, when the pad reports exactly 2 fingers, it
reports them both with half the resolution with which it would report
a single finger (in the 1 finger or 3 fingers cases).

It sounded like Chase was recommending to report "ST" at full
resolution and "MT" at half resolution.  Thus, if there is 1 finger,
we would throw away 1 bit for the MT report.  If there were 2 fingers,
we would inflate the ST reported finger by one bit.

I prefer the original behavior of this patch, which just always
reports ST and MT using the ST scale.

-Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
