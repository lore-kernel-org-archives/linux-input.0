From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Tue, 28 Sep 2010 21:43:22 +0200
Message-ID: <4CA2455A.9070109@euromail.se>
References: <20100928093949.26553.55566.stgit@localhost.localdomain>  <4CA232DD.7070803@euromail.se>  <44799AC9-6D24-4F01-BE00-A1519498E88D@enac.fr> <4CA23D8A.8040807@euromail.se> <296EC52A-446B-4BE2-B5D6-567B83C7DDBC@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:49939 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989Ab0I1ToM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:44:12 -0400
In-Reply-To: <296EC52A-446B-4BE2-B5D6-567B83C7DDBC@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Rudy Huang <rudy_huang@sitronix.com.tw>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, jkosina@suse.cz

On 09/28/2010 09:37 PM, St=E9phane Chatty wrote:

>=20
> Le 28 sept. 10 =E0 21:10, Henrik Rydberg a =E9crit :
>=20
>> On 09/28/2010 08:49 PM, St=E9phane Chatty wrote:
>> [...]
>>>
>>
>>>> This usage of ABS_MT_TRACKING_ID is not ideal. The HID contact id =
normally maps
>>>> to a slot number, which suggests the MT slots protocol be used ins=
tead.
>>>
>>> I'm working on a slot-based version of the Stantum driver, and have=
 had a look
>>> into this. The Stantum firmware actually cycles over 8-bit values f=
or its
>>> ContactID. In this, it conforms more to the definition you gave for
>>> ABS_MT_TRACKING_ID ("The slot protocol requires the use of the
>>> ABS_MT_TRACKING_ID, either provided by the hardware or computed fro=
m the raw
>>> data [5]") than to a slot number, doesn't it? Nevertheless, given o=
ur recent
>>> exchanges about the 3M driver, I planned to use the driver's own tr=
acking ID.
>>>
>>> Your thoughts?
>>
>>
>> Excellent. :-) Speaking of drivers and multiplication, I think many =
of the
>> current drivers could in fact be merged. It seems we have two or thr=
ee different
>> types so far, and different manufacturers may well be served by the =
same driver.
>=20
> Yes, I have started reviewing all devices and making a summary of the=
ir
> differences in that very purpose. Among the things we'll need is some=
 standard
> way for calling the filtering function at the end of a set of fingers=
=2E
> CONTACTCOUNT is a good candidate, but I need to check some devices. O=
ne thing
> bothers me though. It is that hid-core has the whole information, the=
n is splits
> it and calls us repeatedly, then we more or less undo that by storing=
 the
> information and trying to determine the last time it calls us.


Right. A hid-mt device based on the raw protocol could be a good idea -=
 after we
reduced the current set a bit. :-)

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
