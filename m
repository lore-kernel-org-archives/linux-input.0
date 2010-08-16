From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in   JooJoo tablet
Date: Mon, 16 Aug 2010 17:37:23 +0200
Message-ID: <657DBC9C-D644-43B8-9414-3A4C34D8A007@enac.fr>
References: <m339wl2ug6.fsf@pullcord.laptop.org>   <m3hbiz8m11.fsf@pullcord.laptop.org>  <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>  <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr> <alpine.LNX.2.00.1008161557020.1019@pobox.suse.cz> <F35B802E-C47A-47BF-A350-8F57250D4394@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:40766 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0HPPh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 11:37:28 -0400
In-Reply-To: <F35B802E-C47A-47BF-A350-8F57250D4394@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Chris Ball <cjb@laptop.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, tito@bankiz.org


Le 16 ao=FBt 10 =E0 17:17, St=E9phane Chatty a =E9crit :

>
> Le 16 ao=FBt 10 =E0 15:58, Jiri Kosina a =E9crit :
>
>>
>>
>> thanks for the analysis. How do devices in their report descriptor
>> describe the fact whether the events should be interleaved by sync =20
>> or not?
>
> As far as I know, they don't. I know of two multitouch devices that =20
> send groups of fingers over several HID messages:
>  - the 3M 22" panel, when there are more than 6 fingers on the =20
> panel. You know there are more messages coming when the number of =20
> fingers (reported through ContactCount in the first message) is =20
> greater than 6.
>  - the eGalax 72xx series, that adds a second message whenever =20
> there are two fingers; I am not sure yet how one knows when to =20
> wait  for a second message. Mathieu might be able to tell us.
>

Oops... as usual, publishing an opinion is a good way of finding out =20
how it be can wrong :-) I just figured that if ContactMax is =20
available for all devices as well as ContactCount, then there is a =20
way of knowing:
  - if ContactMax is greater than the number of fingers in the report =20
descriptors, then you know that sometimes you'll get multiple messages.
  - if ContactCount in a message is greater than the number of =20
fingers in the report descriptors, then you know you'll need to read =20
more messages after this one.

We'll need to check this with all the known devices...

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
