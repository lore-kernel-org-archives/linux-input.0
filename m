From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in   JooJoo tablet
Date: Mon, 16 Aug 2010 17:17:52 +0200
Message-ID: <F35B802E-C47A-47BF-A350-8F57250D4394@enac.fr>
References: <m339wl2ug6.fsf@pullcord.laptop.org>   <m3hbiz8m11.fsf@pullcord.laptop.org>  <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>  <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr> <alpine.LNX.2.00.1008161557020.1019@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:58124 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0HPPR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 11:17:59 -0400
In-Reply-To: <alpine.LNX.2.00.1008161557020.1019@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Chris Ball <cjb@laptop.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, tito@bankiz.org


Le 16 ao=FBt 10 =E0 15:58, Jiri Kosina a =E9crit :

>
>
> thanks for the analysis. How do devices in their report descriptor
> describe the fact whether the events should be interleaved by sync =20
> or not?

As far as I know, they don't. I know of two multitouch devices that =20
send groups of fingers over several HID messages:
  - the 3M 22" panel, when there are more than 6 fingers on the =20
panel. You know there are more messages coming when the number of =20
fingers (reported through ContactCount in the first message) is =20
greater than 6.
  - the eGalax 72xx series, that adds a second message whenever there =20
are two fingers; I am not sure yet how one knows when to wait  for a =20
second message. Mathieu might be able to tell us.


The short term solution could be to add a .sync hook similar =20
to .event. Each specific driver could override the call to input_sync=20
() based on its knowledge of the device.

>
> We definitely could create a specialized version of
> hidinput_report_event() for certain reports, which wouldn't issue the
> input_sync() call, but I wonder what is the distinguishing factor.

Yes, for months now I have wondered what the generic multitouch HID =20
driver in Windows 7 might look like :-) I suspect that we now have a =20
sufficient sample of devices (about 10 different ones, all claiming =20
to be Win7 compliant) to extrapolate from their behaviour.

Cheers

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
