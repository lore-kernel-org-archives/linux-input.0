From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Synaptics i2c-hid touchpad driver
Date: Mon, 18 Nov 2013 14:32:57 -0500
Message-ID: <CAN+gG=EyFsaaa1wnYCEv99GYCOowkt2gy=XKujGPjM6r=Dn4Fg@mail.gmail.com>
References: <5289EDEB.1020006@dynora.nl>
	<CAN+gG=Ewzcp5m-kZT4cv6z6EmJ2Kv7yQO63quEaPMX6-+doJFg@mail.gmail.com>
	<528A6991.2010604@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50854 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3KRTc7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 14:32:59 -0500
Received: by mail-lb0-f177.google.com with SMTP id w7so1480129lbi.36
        for <linux-input@vger.kernel.org>; Mon, 18 Nov 2013 11:32:58 -0800 (PST)
In-Reply-To: <528A6991.2010604@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Wouter van der Graaf <wouter@dynora.nl>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Alright, here we go... \o/

following the thread
http://www.spinics.net/lists/linux-input/msg27737.html

=46or the record, the Dell XPS12 from 2013 has a current driver under
development for its touchpad.

It is located here:
https://github.com/mightybigcar/synaptics-rmi4/commits/rmihid

As mentioned by Andrew, any feedback are welcome.

Cheers,
Benjamin

On Mon, Nov 18, 2013 at 2:25 PM, Andrew Duggan <aduggan@synaptics.com> =
wrote:
> Hi Benjamin and Wouter,
>
> Adding linux-input to this thread is fine with me. The plan is to sub=
mit the
> core of the rmi4 driver and then submitting the HID pieces. But, havi=
ng
> people who are interested in the driver look it over in the mean time=
 would
> be good. Especially, now that there is hardware on the market.
>
> Andrew
>
>
> On 11/18/2013 07:48 AM, Benjamin Tissoires wrote:
>>
>> Hi Wouter,
>>
>> sorry, I should have kept you informed.
>>
>> I have asked Andrew from Synaptics to know what was their plan for
>> this. He told me that they are still working on it.
>>
>> He also gave me the link to the development tree of this work:
>> https://github.com/mightybigcar/synaptics-rmi4/commits/rmihid
>>
>> I have tested it, and it works even if there is some tiny adjustment=
s
>> to do before taking this upstream.
>>
>> Andrew, I was not sure if we could add the linux-input LKML to this
>> thread (don't know how much private this repo is). If so, I think so=
me
>> other users would be interested by this information, and we should
>> open it.
>>
>> Cheers,
>> Benjamin
>>
>> On Mon, Nov 18, 2013 at 5:37 AM, Wouter van der Graaf <wouter@dynora=
=2Enl>
>> wrote:
>>>
>>> Hi Benjamin,
>>>
>>> Just curious; is there any progress on the Synaptics i2c-hid touchp=
ad
>>> driver? Is it still on the radar? Can I contribute in some way?
>>>
>>> Thank you!
>>>
>>> Wouter
>>>
>>> --
>>> Wouter van der Graaf
>>> Open technologist / Partner
>>>
>>> d y n o r a
>>> Innovative software development
>>>
>>> +31 6 2893 0615 | wouter@dynora.nl
>>>
>>> Burg. de Bru=C3=AFnelaan 95 | 3331 AC Zwijndrecht | NL
>>> +31 78 843 3139 | contact@dynora.nl | www.dynora.nl
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
