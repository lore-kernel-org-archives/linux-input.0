From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Fri, 14 Jul 2017 11:28:03 +0200
Message-ID: <7f9ca984-2798-b3f1-f61a-ac80e5b055b9@butterbrot.org>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
 <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
 <20170710181120.GC23984@dtor-ws>
 <alpine.DEB.2.10.1707140951540.18874@butterbrot>
 <20170714082406.GA29703@jelly>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r8ejKTAgcDxsvg1a4p96Hu8F1nAjBT0LB"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:46239 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbdGNJ2J (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Jul 2017 05:28:09 -0400
In-Reply-To: <20170714082406.GA29703@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "modin@yuri.at" <modin@yuri.at>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r8ejKTAgcDxsvg1a4p96Hu8F1nAjBT0LB
Content-Type: multipart/mixed; boundary="nPK2NjEQHjO4CmwtFQNXF8NdwoCuPt0iF";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input <linux-input@vger.kernel.org>, "modin@yuri.at" <modin@yuri.at>
Message-ID: <7f9ca984-2798-b3f1-f61a-ac80e5b055b9@butterbrot.org>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
 <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
 <20170710181120.GC23984@dtor-ws>
 <alpine.DEB.2.10.1707140951540.18874@butterbrot>
 <20170714082406.GA29703@jelly>
In-Reply-To: <20170714082406.GA29703@jelly>

--nPK2NjEQHjO4CmwtFQNXF8NdwoCuPt0iF
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 14.07.2017 10:24, Peter Hutterer wrote:
> On Fri, Jul 14, 2017 at 09:54:03AM +0200, Florian Echtler wrote:
>> On Mon, 10 Jul 2017, Dmitry Torokhov wrote:
>>> On Mon, Jul 10, 2017 at 09:11:53AM +0200, Florian Echtler wrote:
>>>>
>>>> Related question: we first attempted to label non-touch objects as M=
T_TOOL_PALM,
>>>> but it looks like userspace (Xorg in particular) doesn't actually di=
stinguish
>>>> between MT_TOOL_* types; is that correct?
>>>
>>> It really should, but I think Peter never got around implementing thi=
s.
>>>
>>> Also, I think it is a good idea to set touch major to max in this cas=
e.
>>> I believe that that will help clients that do no understand MT_TOOL_P=
ALM
>>> to still do palm rejection.
>>>
>>> Peter?
>>
>> Would you consider merging v2 of the patch regardless of the Xorg situ=
ation?
>> Right now, it's a useful bugfix in any case, and we can deal with how =
to
>> represent blobs/palms/tokens later on.
>=20
> sorry about the delay, bit chaotic here. libinput 1.8 was released a we=
ek or
> so ago and it supports MT_TOOL_PALM, so consider userspace ready for th=
at. I
> also have patches to use major/minor for palm detection where appropria=
te
> which will hit git master (my) tonight.

Nevermind :-) Just to clarify, I can now set MT_TOOL_PALM on generic blob=

objects, and they will still be available in userspace "on request", but =
will
not be considered as touch points?

Do you know how "legacy" xserver-xorg-input-evdev will handle this case?

And final question: the SUR40 also is able to identify specific patterns =
as
tokens (so-called "bytetags", see
https://github.com/floe/surface-2.0/blob/master/bytetag/bytetag.pdf ). Wh=
at
would be a sensible way to expose these to userspace, too? Add another
MT_TOOL_TOKEN type?

Thanks & best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--nPK2NjEQHjO4CmwtFQNXF8NdwoCuPt0iF--

--r8ejKTAgcDxsvg1a4p96Hu8F1nAjBT0LB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllojqMACgkQ7CzyshGvatiZtQCfZTbhtrXMxvKPRQp5CDELdwKX
XaIAmgP4wGolr6FVbHSc+W8PWoLLVuA+
=xFAL
-----END PGP SIGNATURE-----

--r8ejKTAgcDxsvg1a4p96Hu8F1nAjBT0LB--
