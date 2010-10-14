From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/4] hid-multitouch: added support for Cypress TrueTouch panels
Date: Thu, 14 Oct 2010 14:33:13 +0200
Message-ID: <4BAF2E06-CDEE-4206-ABE7-A0787025BE15@enac.fr>
References: <20101013223334.DFF199522F@smtp.lii-enac.fr> <4CB6F241.1040500@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:43398 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab0JNMdY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 08:33:24 -0400
In-Reply-To: <4CB6F241.1040500@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@lii-enac.fr>, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org


Le 14 oct. 10 =E0 14:06, Henrik Rydberg a =E9crit :
>>
>> +static int cypress_compute_slot(struct mt_device *td)
>> +{
>> +	if (td->curcontactid !=3D 0 || td->curcontact =3D=3D 0)
>> +		return td->curcontactid;
>> +	else
>> +		return -1;
>> +}
>
>
> Returned slots should always be valid, since the intent is to =20
> actually report
> data for the contact. If there is additional logic determining =20
> whether a touch
> is valid, like here, it can simply be added to the validity =20
> computation.

Then you'd need a second device-specific function, one that =20
determines if a contact is valid. I was trying to minimize that, =20
especially because it would be for the sake of one device only. =20
Managing it in the compute_slot function makes sense to me, giving =20
this function the semantics of "is this contact a real slot, and if =20
yes which is it?".

Maybe we could add somthing like td->curvalid =3D false to the =20
computation function? This would not work in the current code, but =20
maybe we can make it work.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
