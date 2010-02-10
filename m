From: David Anders <dave123_aml@yahoo.com>
Subject: Re: PS/2 sniffer for windows
Date: Wed, 10 Feb 2010 10:05:26 -0800 (PST)
Message-ID: <589221.23018.qm@web54409.mail.re2.yahoo.com>
References: <62e5edd41002100920k7a171bf1gd1178d8d0bf08564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web54409.mail.re2.yahoo.com ([206.190.49.139]:27866 "HELO
	web54409.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754640Ab0BJSMJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 13:12:09 -0500
In-Reply-To: <62e5edd41002100920k7a171bf1gd1178d8d0bf08564@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?iso-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>

Erik,

sparkfun sells a small device design to read/write scan codes into the =
ps2 bus:

http://www.sparkfun.com/commerce/product_info.php?products_id=3D8652

it is based on the atmega168 avr which can be reprogrammed for any numb=
er of things.=20

alternatively you can use a standard logic analyzer to capture the sign=
als:

http://www.pctestinstruments.com/

Dave aka prpplague

--- On Wed, 2/10/10, Erik Andr=E9n <erik.andren@gmail.com> wrote:

> From: Erik Andr=E9n <erik.andren@gmail.com>
> Subject: PS/2 sniffer for windows
> To: linux-input@vger.kernel.org
> Date: Wednesday, February 10, 2010, 11:20 AM
> Hi,
>=20
> What is the easiest way to reverse engineer a windows
> driver using the ps/2 bus?
> Are there any ps/2 sniffer software which one can acquire?
>=20
> Best regards,
> Erik
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
