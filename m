From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC, PATCH] gspca pac7302: add support for camera button
Date: Mon, 16 Nov 2009 09:43:59 +0100
Message-ID: <4B0110CF.1060907@redhat.com>
References: <4AFFC00F.6060704@freemail.hu> <4AFFD685.9060209@redhat.com> <4B00F804.2090203@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbZKPIhR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2009 03:37:17 -0500
In-Reply-To: <4B00F804.2090203@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Jean-Francois Moine <moinejf@free.fr>, V4L Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org

Hi,

On 11/16/2009 07:58 AM, N=E9meth M=E1rton wrote:
> Hi,
> Hans de Goede wrote:
>> Hi,
>>
>> Thanks for working on this! I think it would be great if we could
>> get support for camera buttons in general into gspca.
>>
>> I've not looked closely at your code yet, have you looked at
>> the camera button code in the gspca sn9c20x.c driver? Also I would r=
eally
>
> As you proposed I had a look on sn9c20x. It seems that sn9c20x uses r=
egister read
> via USB control message. The pac7302 uses interrupt endpoint. So it l=
ooks like
> quite different to me. Currently I see the common point in the connec=
tion
> to input subsystem only.
>

Ah you are right, oops, most camera's use an interrupt end point so I a=
ssumed
sn9c20x would be the same, my bad.

>> like to see as much of the button handling code as possible go into
>> the gspca core. AFAIK many many camera's use an usb interrupt ep for=
 this, so
>> I would like to see the setting up and cleanup of this interrupt ep =
be in
>> the core (as said before see the sn9c20x driver for another driver w=
hich
>> does such things).
>
> Unfortunately I do not know how the USB descriptors of other webcams =
look like.
> I have access to two webcams which are handled by gspca:
>

No problem, just put all the input code in pac7302.c for now, we will a=
bstract it
later when we add support for the button on other camera's too.

<snip>

> Comparing these two endpoints shows the common and different points:
> Common: interface class, endpoint direction, endpoint type.
> Different: interface number, sub class, protocol, endpoint address, m=
ax
>             packet size, interval.
>
> Maybe the second example is not a good one because I don't know wheth=
er
> the interrupt endpoint is used for buttons or not.
>
> Do you have access to webcams equipped with button? Could you please
> send the device descriptor (lsusb -v) about these devices in order
> the common points can be identified for interrupt endpoints?
>

As the author/maintainer of quite a few drivers and libv4l author I hav=
e
build up quite a test camera collection, I'll send you the lsusb -v out=
put
of a few in a private mail. But as said before, for now I think you can=
 just put
the input code inside pac7302.c, then later on we can try to abstract i=
t.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
