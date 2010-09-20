From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 22:23:21 +0200
Message-ID: <EBFF8B5B-5361-45B3-88B8-8254E3953578@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>   <1283005748-3293-2-git-send-email-rydberg@euromail.se>   <CE1C24FC-7C9A-4940-8141-391A368C59E5@enac.fr>  <4C97BB33.5020806@euromail.se>  <6A8BB954-78BB-4507-86F3-19DA5174FA5E@enac.fr> <4C97BE69.2030100@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:59206 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757686Ab0ITUX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 16:23:29 -0400
In-Reply-To: <4C97BE69.2030100@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Le 20 sept. 10 =E0 22:04, Henrik Rydberg a =E9crit :
>>
>> What about this:
>> +            value =3D clamp_val(value, 0, MAX_SLOTS - 1);
>>              if (md->valid) {
>>                  md->curid =3D value;
>>                  md->f[value].touch =3D md->touch;
>>
>> If you had tracking IDs 59, 60 and 61 in the same frame, this =20
>> would not work
>> properly would it?
>
>
> That is the slot id being set. The microtouch controller is also =20
> using slots
> internally.
>

Oh, right. Once again back to your definition of tracking ID that is =20
not so intuitive to me :-) In the end we might end up dealing with =20
three IDs: the device's tracking ID, the slot ID, and the Linux =20
tracking ID. Here, the first and the second are the same but will =20
they always be? I remember when Stantum used to provide us with 16 =20
bit "device tracking IDs"...

Anyway, I have no more problem with this constant. Just with the =20
vocabulary :-)

St.--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
