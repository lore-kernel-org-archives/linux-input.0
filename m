From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Tue, 17 Aug 2010 07:44:13 -0400
Message-ID: <1282045453.13264.40.camel@mini>
References: <4C695985.5080403@bitmath.org>
	 <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr>
	 <1282042502.13264.21.camel@mini>
	 <D329710B-AA85-411D-834B-FE2626AD8727@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40231 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab0HQLoT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 07:44:19 -0400
In-Reply-To: <D329710B-AA85-411D-834B-FE2626AD8727@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input <linux-input@vger.kernel.org>

On Tue, 2010-08-17 at 13:33 +0200, St=C3=A9phane Chatty wrote:
> Yes, the debate is what to do when the 'actual oldest' finger is =20
> released: should the 'second oldest' take its place or should this be=
 =20
> a release or should somthing else occur.
>=20
> Some arguments in favour of the first option:
> - My experience is that 'accidental' touches are transient. =20
> Therefore, the conjunction of having an accidental touch and a =20
> release is not very frequent.
>   - At the opposite, on very large screens, it may sometimes be =20
> comfortable to "replace one finger with another", thus 'moving' the =20
> dragged object from one hand to the other.
>=20
> More or less, the debate is about statistics and user experience =20
> design...

Thanks for the explanation! Since this comes down to what the user
intends with multiple touches on the screen, I'll trust your experience
over mine :).

However, while your 'eldest' method may be good for touchscreens, I
think it's a moot point for touchpads since they are relative devices
(even if they are really absolute in the driver). The user won't be abl=
e
to continuously drag across the screen by using multiple fingers becaus=
e
each switch of coordinates from the eldest to the next eldest will
generate a relative motion that will just shift the object back where w=
e
started a drag.

I'll probably leave my current implementation for the trackpad as is,
since it's easier than the 'eldest' method and provides just as much
functionality.

-- Chase

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
