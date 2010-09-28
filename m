From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Tue, 28 Sep 2010 21:10:02 +0200
Message-ID: <4CA23D8A.8040807@euromail.se>
References: <20100928093949.26553.55566.stgit@localhost.localdomain> <4CA232DD.7070803@euromail.se> <44799AC9-6D24-4F01-BE00-A1519498E88D@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39062 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753955Ab0I1TKk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:10:40 -0400
In-Reply-To: <44799AC9-6D24-4F01-BE00-A1519498E88D@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Rudy Huang <rudy_huang@sitronix.com.tw>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, jkosina@suse.cz

On 09/28/2010 08:49 PM, St=E9phane Chatty wrote:
[...]
>

>> This usage of ABS_MT_TRACKING_ID is not ideal. The HID contact id no=
rmally maps
>> to a slot number, which suggests the MT slots protocol be used inste=
ad.
>=20
> I'm working on a slot-based version of the Stantum driver, and have h=
ad a look
> into this. The Stantum firmware actually cycles over 8-bit values for=
 its
> ContactID. In this, it conforms more to the definition you gave for
> ABS_MT_TRACKING_ID ("The slot protocol requires the use of the
> ABS_MT_TRACKING_ID, either provided by the hardware or computed from =
the raw
> data [5]") than to a slot number, doesn't it? Nevertheless, given our=
 recent
> exchanges about the 3M driver, I planned to use the driver's own trac=
king ID.
>=20
> Your thoughts?


Excellent. :-) Speaking of drivers and multiplication, I think many of =
the
current drivers could in fact be merged. It seems we have two or three =
different
types so far, and different manufacturers may well be served by the sam=
e driver.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
