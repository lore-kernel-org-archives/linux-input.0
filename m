From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Tue, 28 Sep 2010 21:37:34 +0200
Message-ID: <296EC52A-446B-4BE2-B5D6-567B83C7DDBC@enac.fr>
References: <20100928093949.26553.55566.stgit@localhost.localdomain>  <4CA232DD.7070803@euromail.se>  <44799AC9-6D24-4F01-BE00-A1519498E88D@enac.fr> <4CA23D8A.8040807@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:60469 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616Ab0I1Tho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:37:44 -0400
In-Reply-To: <4CA23D8A.8040807@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Rudy Huang <rudy_huang@sitronix.com.tw>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, jkosina@suse.cz


Le 28 sept. 10 =E0 21:10, Henrik Rydberg a =E9crit :

> On 09/28/2010 08:49 PM, St=E9phane Chatty wrote:
> [...]
>>
>
>>> This usage of ABS_MT_TRACKING_ID is not ideal. The HID contact id =20
>>> normally maps
>>> to a slot number, which suggests the MT slots protocol be used =20
>>> instead.
>>
>> I'm working on a slot-based version of the Stantum driver, and =20
>> have had a look
>> into this. The Stantum firmware actually cycles over 8-bit values =20
>> for its
>> ContactID. In this, it conforms more to the definition you gave for
>> ABS_MT_TRACKING_ID ("The slot protocol requires the use of the
>> ABS_MT_TRACKING_ID, either provided by the hardware or computed =20
>> from the raw
>> data [5]") than to a slot number, doesn't it? Nevertheless, given =20
>> our recent
>> exchanges about the 3M driver, I planned to use the driver's own =20
>> tracking ID.
>>
>> Your thoughts?
>
>
> Excellent. :-) Speaking of drivers and multiplication, I think many =20
> of the
> current drivers could in fact be merged. It seems we have two or =20
> three different
> types so far, and different manufacturers may well be served by the =20
> same driver.

Yes, I have started reviewing all devices and making a summary of =20
their differences in that very purpose. Among the things we'll need =20
is some standard way for calling the filtering function at the end of =20
a set of fingers. CONTACTCOUNT is a good candidate, but I need to =20
check some devices. One thing bothers me though. It is that hid-core =20
has the whole information, then is splits it and calls us repeatedly, =20
then we more or less undo that by storing the information and trying =20
to determine the last time it calls us.

St.





--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
