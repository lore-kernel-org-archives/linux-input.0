From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH  2/3] hid: Multitouch support for the N-Trig touchscreen
Date: Tue, 19 May 2009 17:20:54 +0200
Message-ID: <9C1D49A6-194E-4504-ACDA-573DF7E8F7E1@enac.fr>
References: <2DB714C8-82E9-411A-881D-5327C521B5FC@enac.fr> <alpine.LNX.2.00.0905191643290.22712@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:52290 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbZESPU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 11:20:57 -0400
In-Reply-To: <alpine.LNX.2.00.0905191643290.22712@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>


Le 19 mai 09 =E0 16:46, Jiri Kosina a =E9crit :
>
> On Tue, 19 May 2009, St=E9phane Chatty wrote:
>
>> Exported hidinput_hid_event, so as to be able to call it from =20
>> device-specific
>> drivers.
>>
> Why is this needed? ->event() callback is called for every HID driver
> which has this callback registered, and fallback to =20
> hidinput_hid_event()
> is performed in cases the driver-specific ->event() handler returns =20
> return
> value > 0 , signalizing that the event hasn't been fully processed an=
d
> processing by generic layer is needed.

Correct me if I am wrong, but if ->event() is called and returns 1, =20
then hiddev_hid_event gets no chance to be called from =20
hid_process_event. Is hidinput exclusive of hiddev?

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
