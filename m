From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/4] hid-multitouch: added support for Cypress TrueTouch panels
Date: Thu, 14 Oct 2010 17:16:39 +0200
Message-ID: <822A63AC-40D8-4E82-B2F6-EB886AE007D1@enac.fr>
References: <20101013223334.DFF199522F@smtp.lii-enac.fr> <4CB6F241.1040500@euromail.se> <4BAF2E06-CDEE-4206-ABE7-A0787025BE15@enac.fr> <4CB6FD80.4030808@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:33209 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab0JNPQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 11:16:51 -0400
In-Reply-To: <4CB6FD80.4030808@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@lii-enac.fr>, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org


Le 14 oct. 10 =E0 14:54, Henrik Rydberg a =E9crit :

>>> Returned slots should always be valid, since the intent is to =20
>>> actually report
>>> data for the contact. If there is additional logic determining =20
>>> whether a touch
>>> is valid, like here, it can simply be added to the validity =20
>>> computation.
>>
>> Then you'd need a second device-specific function, one that =20
>> determines if a
>> contact is valid. I was trying to minimize that, especially =20
>> because it would be
>> for the sake of one device only.
>
>
> Now that single device clutters the logic for all other devices =20
> instead... We
> could actually get away with zero device-specific functions, only =20
> branching on
> the device class at a couple of places in the driver.

Yes, but we don't know how many classes we'll get and might be safer =20
to protect the core logic of the driver from people who'll want to =20
add a new class.

Coming back to your point about the invalid slot number, I'll try to =20
think about it again. Honestly, I'm pretty much at ease with the =20
concept of overloading the return value of a function with a code for =20
errors, because it is so common in Unix and Linux. And the overall =20
meaning of the function is "is there any slot that corresponds to =20
this contact?", which makes sense to me. But let's see if we can find =20
a better way.


>> Managing it in the compute_slot function makes
>> sense to me, giving this function the semantics of "is this =20
>> contact a real slot,
>> and if yes which is it?".
>>
>> Maybe we could add somthing like td->curvalid =3D false to the =20
>> computation
>> function? This would not work in the current code, but maybe we =20
>> can make it work.
>
>
> Another thing I forgot about: do all the currently included devices =20
> have good
> contact ids, in the sense that they handle contacts during their =20
> lifetime? Are
> there any examples other than ntrig where it does not work that =20
> way? I am of
> course asking to see if we need to care about non-slotted devices.

NTrig is alone in its class so far.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
