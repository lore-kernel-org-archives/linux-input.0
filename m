From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Fri, 11 Mar 2011 07:53:03 +0100
Message-ID: <AANLkTims5Qg3m7pe-PBFNjmTmeOCPi6i8wqqrK1OJS84@mail.gmail.com>
References: <20110308080414.GA2888@polaris.bitmath.org>
	<AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	<20110308091434.GA3282@polaris.bitmath.org>
	<AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
	<20110308094630.GA3396@polaris.bitmath.org>
	<1299627518.2306.47.camel@itzy>
	<20110309082455.GA3166@polaris.bitmath.org>
	<AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
	<20110309092337.GC3824@polaris.bitmath.org>
	<AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
	<20110309114038.GA9143@polaris.bitmath.org>
	<1299823326.1910.11.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:60052 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab1CKGxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 01:53:05 -0500
Received: by wwi17 with SMTP id 17so2275047wwi.1
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2011 22:53:04 -0800 (PST)
In-Reply-To: <1299823326.1910.11.camel@itzy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Richard,

I'm really sorry, but it's a NACK for me:
what ever Henrik said, I do not want to have numerical constants
throughout the code. It would be the open door to many others. The
reason we have "mt_class" is to regroup each per-device parameters in
it. So there is no need to introduce those constants everywhere.

Cheers,
Benjamin

On Fri, Mar 11, 2011 at 07:02, Richard Nauber
<richard.nauber@googlemail.com> wrote:
> Hi,
>
> Except for a missing comma, Henriks patch works fine for me and I wou=
ld
> be glad to have it submitted. So feel free to add my SIGNED-OFF-BY.
> (Or should I repost the patch?)
>
> Greetings and thanks to all,
> Richard
>
> --- snip ---
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 57575ff..ee01e65 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -131,7 +131,7 @@ struct mt_class mt_classes[] =3D {
> =A0 =A0 =A0 =A0{ .name =3D MT_CLS_EGALAX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.quirks =3D =A0MT_QUIRK_SLOT_IS_CONTAC=
TID |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MT_QUIRK_VALID_IS_INRA=
NGE |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_EGALAX_XYZ_FIX=
UP
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_EGALAX_XYZ_FIX=
UP,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.maxcontacts =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sn_move =3D 4096,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sn_pressure =3D 32,
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
