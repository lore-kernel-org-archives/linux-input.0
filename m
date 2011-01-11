From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch: changes from the review process
Date: Tue, 11 Jan 2011 16:07:23 +0100
Message-ID: <AANLkTinzuvULWvdaptpSUc2kYtGY2C8xOD34TQdjt6JU@mail.gmail.com>
References: <1294743194-2310-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110111131154.GC1961@polaris.bitmath.org>
	<AANLkTimESwHSh-LMdAnb20Ss3OxW=gpTaN0QdTSfEx33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46220 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab1AKPHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 10:07:24 -0500
In-Reply-To: <AANLkTimESwHSh-LMdAnb20Ss3OxW=gpTaN0QdTSfEx33@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 3:00 PM, Benjamin Tissoires
<benjamin.tissoires@enac.fr> wrote:
> On Tue, Jan 11, 2011 at 2:11 PM, Henrik Rydberg <rydberg@bitmath.org>=
 wrote:
>> [...]
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>>> + =A0 =A0 { .name =3D MT_CLS_DUAL1,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_SLOT_IS_CONTACTID,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>>> + =A0 =A0 { .name =3D MT_CLS_DUAL2,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_SLOT_IS_CONTACTNUMBE=
R,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>>> + =A0 =A0 { .name =3D MT_CLS_CYPRESS,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_CYPRESS,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>>> +
>>> + =A0 =A0 { }
>>> =A0};
>>
>> So no device is marked as NOT_SEEN_MEANS_UP, although allegedly some=
 devices should...
>
> Well, my fault: I was sure that Cypress devices need the
> NOT_SEEN_MEANS_UP, but in fact, it was another one. We (with Stephane=
)
> don't recall it at the moment, but Stephane already saw some devices
> that required this quirk.
>
> mea culpa

I was neither wrong, neither right:
=46or cypress, TipSwitch, Confidence, and InRange always are the same..=
=2E ;)
-> I'll need to put them with the quirk MT_NOT_SEEN_MEANS_UP

Cheers,
Benjamin
>
>>
>>[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
