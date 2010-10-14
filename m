From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] hid-multitouch: added support for Cypress TrueTouch
 panels
Date: Thu, 14 Oct 2010 14:54:24 +0200
Message-ID: <4CB6FD80.4030808@euromail.se>
References: <20101013223334.DFF199522F@smtp.lii-enac.fr> <4CB6F241.1040500@euromail.se> <4BAF2E06-CDEE-4206-ABE7-A0787025BE15@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:52486 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462Ab0JNMyn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 08:54:43 -0400
In-Reply-To: <4BAF2E06-CDEE-4206-ABE7-A0787025BE15@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Stephane Chatty <chatty@lii-enac.fr>, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org

On 10/14/2010 02:33 PM, St=E9phane Chatty wrote:

>=20
> Le 14 oct. 10 =E0 14:06, Henrik Rydberg a =E9crit :
>>>
>>> +static int cypress_compute_slot(struct mt_device *td)
>>> +{
>>> +    if (td->curcontactid !=3D 0 || td->curcontact =3D=3D 0)
>>> +        return td->curcontactid;
>>> +    else
>>> +        return -1;
>>> +}
>>
>>
>> Returned slots should always be valid, since the intent is to actual=
ly report
>> data for the contact. If there is additional logic determining wheth=
er a touch
>> is valid, like here, it can simply be added to the validity computat=
ion.
>=20
> Then you'd need a second device-specific function, one that determine=
s if a
> contact is valid. I was trying to minimize that, especially because i=
t would be
> for the sake of one device only.


Now that single device clutters the logic for all other devices instead=
=2E.. We
could actually get away with zero device-specific functions, only branc=
hing on
the device class at a couple of places in the driver.

> Managing it in the compute_slot function makes
> sense to me, giving this function the semantics of "is this contact a=
 real slot,
> and if yes which is it?".
>=20
> Maybe we could add somthing like td->curvalid =3D false to the comput=
ation
> function? This would not work in the current code, but maybe we can m=
ake it work.


Another thing I forgot about: do all the currently included devices hav=
e good
contact ids, in the sense that they handle contacts during their lifeti=
me? Are
there any examples other than ntrig where it does not work that way? I =
am of
course asking to see if we need to care about non-slotted devices.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
