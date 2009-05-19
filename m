From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/3 ] hid: Multitouch support for the N-Trig touchscreen
Date: Tue, 19 May 2009 17:03:05 -0400
Message-ID: <4A131E89.7070208@seas.upenn.edu>
References: <2DCAF4CF-1408-4C2E-9713-5BD901899953@enac.fr> <4A131388.1030709@seas.upenn.edu> <1F279E42-BCE3-48DE-AFF3-1108BA000843@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:56491 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZESVDW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 17:03:22 -0400
In-Reply-To: <1F279E42-BCE3-48DE-AFF3-1108BA000843@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, jkosina@suze.cz, Henrik Rydberg <rydberg@euromail.se>, Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>

I suppose that constitutes good reason to expect them to be standardize=
d.

On another note, you should add a comma to your changes in hid-debug:
+       [SYN_MT_REPORT] =3D "MT Report"


St=E9phane Chatty wrote:
>=20
> Le 19 mai 09 =E0 22:16, Rafi Rubin a =E9crit :
>=20
>> I suggest adding a comment that these usages are tentative or at lea=
st
>> not yet mentioned in the official docs:
>> http://www.usb.org/developers/hidpage#HID_Usage
>>
>> Anyway, very cool that you figured out all those fields.  I haven't
>> even seen any of those codes in the 50's.
>>
>=20
> Actually, these usages are documented by Microsoft as being (soon, I
> guess) in the HID spec. See page 6 of
> http://download.*microsoft*.com/download/a/d/f/adf1347d-08dc-41a4-908=
4-
> 623b1194d4b2/*Digitizer*Drvs_touch.docx
>=20
> Sorry to disappoint you about my skills :-)
>=20
> About the comment, it's true that the usages are not yet in the offic=
ial
> doc so we have two options:
>  - trust Microsoft that they will appear soon
>  - or be careful but we must think later about removing them
>=20
> What do you think?
>=20
> St.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
