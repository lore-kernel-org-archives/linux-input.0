From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Wed, 21 May 2014 12:17:26 +0200
Message-ID: <CAE7qMrrH5Yeya9gKx+gbi1w39mJoEj9xw4mh3D86dLaKsWWLSQ@mail.gmail.com>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
 <1c6140633925b0838b7627e071e80761.squirrel@mungewell.org> <537BFEBF.8010601@logitech.com>
 <2643156.2tkLFqgYFg@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45521 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547AbaEUKR7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 06:17:59 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so2183947veb.6
        for <linux-input@vger.kernel.org>; Wed, 21 May 2014 03:17:56 -0700 (PDT)
In-Reply-To: <2643156.2tkLFqgYFg@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Roland Bosa <rbosa@logitech.com>, Simon Wood <simon@mungewell.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>, anssi.hannula@iki.fi

Elias, Simon, Michal,

It is unfortunate that we didn't get back to  you in 2013 when you
asked for help in reverse engineering, oftentimes we have conflicting
priorities and a particular request may be left laying around for some
time before being addressed. But please, don't hesitate to re-kick us
if you feel we are not being reactive.

Let me clearly say that our intentions are to disclose as much
information as possible and to help the community in having great
support to all our hardware across all platforms. We have zero problem
with being asked for information.

Many thanks,
-nestor




On Wed, May 21, 2014 at 4:13 AM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
>
> On Tuesday 20 of May 2014 18:17:51 Roland Bosa wrote:
> >
> > The file format of an IFR is probably easily deducible. There's a l=
ot of
> > textual clues to parameters and the values are also written out in
> > string form.
> >
> > I don't have a FEdit file at hand, but I suppose it will be similar=
=2E
>
> I believe that Elias successfully reverse engineered the effect file =
format
> produced by FEdit. There is no support for this kind of prefabricated=
 effects
> in the Linux FF API.
>
> > > I assume that most AAA games, would implement these through some =
middle
> > > layer. I think that is probably via Steam using SDL2 haptic API, =
we have
> > > been testing against SDL2's 'testhaptic'.
> >
> > I wasn't aware of this layer. I must read up on it. It sounds like =
a
> > simple way to access force feedback - I guess a game developer shou=
ld
> > shed some light on this...
> >
> >
> > > Do you see another path (which we should be supporting/testing)?
> >
> > Nope, not at this time.
> >
> > > There was some discussion about rate limiting the USB packets to =
the
> > > wheel, and how to deal if app updates too quickly. Is there an up=
per limit
> > > for the wheel itself, or is it just the USB 'pipe' which is the l=
imiting
> > > factor?
> >
> > On the Windows side we send 125 reports/sec. The entire simulation =
loop
> > runs with a 8ms resolution. I assume this value was chosen for some
> > hardware constraints back in the days, but it has proven to be a go=
od
> > compromise for simulated periodics and physics constraints.
>
> Our current code uses 8 msecs delay as well.
>
> > In any case, the USB traffic should be decoupled from the app. Any =
force
> > updates should only change state in the ff-memless[-next] driver. A=
ny
> > change there should trickle down to a 'slot' representation of the
> > device. If there's any change in the slots, the device is marked as
> > 'dirty' and USB transfers are scheduled to send the latest state to=
 the
> > physical device.
> >
> > The scheduling should keep track of how many requests are in-flight=
 and
> > delay writing the next output, until the previous one has completed=
=2E
>
> The approach I had in mind would keep track of the last effect that m=
ade it to
> the device and the last effect that arrived from userspace. This woul=
d be
> stored for each effect slot. An update would be scheduled at the desi=
red update
> rate. The updating routine would figure out the state change between =
last
> update and "now", send the required data to the device and reschedule=
 itself.
> The routine could check if there are any USB transfers still running =
and
> reschedule itself immediately.
>
> > Question back to the community: are there APIs in the USB layer to =
check
> > for presence of in-progress requests? Can one add a 'completion'
> > callback to a request, that gets invoked on completion/cancellation=
?
>
> For instance "usb_submit_urb()" can have a completion handler that is=
 called
> once the transfer is done. The current code uses "hid_hw_request()" w=
hich is
> asynchronous and doesn't report anything back.
>
> Proper decoupling of the userspace and driver is the only important t=
hing that
> is missing from the current code.
>
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
