From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Tue, 21 Sep 2010 19:37:31 +0200
Message-ID: <4C98ED5B.7020408@euromail.se>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>   <1283005748-3293-2-git-send-email-rydberg@euromail.se>   <CE1C24FC-7C9A-4940-8141-391A368C59E5@enac.fr>  <4C97BB33.5020806@euromail.se>  <6A8BB954-78BB-4507-86F3-19DA5174FA5E@enac.fr> <4C97BE69.2030100@euromail.se> <EBFF8B5B-5361-45B3-88B8-8254E3953578@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:55751 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752475Ab0IURiS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 13:38:18 -0400
In-Reply-To: <EBFF8B5B-5361-45B3-88B8-8254E3953578@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/20/2010 10:23 PM, St=E9phane Chatty wrote:

>=20
> Le 20 sept. 10 =E0 22:04, Henrik Rydberg a =E9crit :
>>>
>>> What about this:
>>> +            value =3D clamp_val(value, 0, MAX_SLOTS - 1);
>>>              if (md->valid) {
>>>                  md->curid =3D value;
>>>                  md->f[value].touch =3D md->touch;
>>>
>>> If you had tracking IDs 59, 60 and 61 in the same frame, this would=
 not work
>>> properly would it?
>>
>>
>> That is the slot id being set. The microtouch controller is also usi=
ng slots
>> internally.
>>
>=20
> Oh, right. Once again back to your definition of tracking ID that is =
not so
> intuitive to me :-) In the end we might end up dealing with three IDs=
: the
> device's tracking ID, the slot ID, and the Linux tracking ID. Here, t=
he first
> and the second are the same but will they always be? I remember when =
Stantum
> used to provide us with 16 bit "device tracking IDs"...
>=20
> Anyway, I have no more problem with this constant. Just with the voca=
bulary :-)


In the HID protocol, it is called ContactID... So, St=E9phane, are we c=
lose to
acking this patch now? :-)

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
