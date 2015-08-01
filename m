From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ALPS DualPoint double click bug
Date: Sat, 1 Aug 2015 08:48:55 +0200
Message-ID: <55BC6BD7.7080600@redhat.com>
References: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
 <55BA3C28.3080506@redhat.com>
 <CANuv8Qyx3zPDmWvV-2XRQXEiSVnOa10GYPGiYaF1B9iru10_9A@mail.gmail.com>
 <201507312317.43809@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47081 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbbHAGs5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 1 Aug 2015 02:48:57 -0400
In-Reply-To: <201507312317.43809@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Douglas Christman <douglaschristman@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

Hi,

On 31-07-15 23:17, Pali Roh=C3=A1r wrote:
> On Friday 31 July 2015 23:12:56 Douglas Christman wrote:
>> On Thu, Jul 30, 2015 at 11:00 AM, Hans de Goede <hdegoede@redhat.com=
>
>> wrote:
>>> Hi,
>>>
>>> On 30-07-15 16:46, Pali Roh=C3=A1r wrote:
>>>> What about introducing new flag ALPS_<something> instead calling
>>>> dmi_name_in_vendors() function every time when we need to process
>>>> packet?
>>>
>>> That is a good idea. Douglas can you test the attached version
>>> instead of the previous one please ?
>>>
>>> Thanks & Regards,
>>>
>>> Hans
>>
>> This patch works for me.
>>
>> Doug
>
> Douglas: Thanks for testing!

Ack, thanks for testing :)

> Hans: Can you update also documentation in Documentation/input/alps.t=
xt
> to match with this your change?

Good point, I've fixed this up and submitted the patch fixing
this upstream.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
