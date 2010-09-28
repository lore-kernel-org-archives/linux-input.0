From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Tue, 28 Sep 2010 20:49:28 +0200
Message-ID: <44799AC9-6D24-4F01-BE00-A1519498E88D@enac.fr>
References: <20100928093949.26553.55566.stgit@localhost.localdomain> <4CA232DD.7070803@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:49855 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046Ab0I1Sth convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 14:49:37 -0400
In-Reply-To: <4CA232DD.7070803@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Rudy Huang <rudy_huang@sitronix.com.tw>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, jkosina@suse.cz


Le 28 sept. 10 =E0 20:24, Henrik Rydberg a =E9crit :
>
>
>> +			return 1;
>> +		case HID_DG_CONTACTID:
>> +			hid_map_usage(hi, usage, bit, max,
>> +					EV_ABS, ABS_MT_TRACKING_ID);
>
>
> This usage of ABS_MT_TRACKING_ID is not ideal. The HID contact id =20
> normally maps
> to a slot number, which suggests the MT slots protocol be used =20
> instead.

I'm working on a slot-based version of the Stantum driver, and have =20
had a look into this. The Stantum firmware actually cycles over 8-bit =20
values for its ContactID. In this, it conforms more to the definition =20
you gave for ABS_MT_TRACKING_ID ("The slot protocol requires the use =20
of the ABS_MT_TRACKING_ID, either provided by the hardware or =20
computed from the raw data [5]") than to a slot number, doesn't it? =20
Nevertheless, given our recent exchanges about the 3M driver, I =20
planned to use the driver's own tracking ID.

Your thoughts?

St.







--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
