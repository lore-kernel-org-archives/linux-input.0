From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: =?UTF-8?B?5Zue5L+h77yaIFJlOiBTaXRyb25peCBTVDlSTTAxIG11bHRpdG8=?=
 =?UTF-8?B?dWNoIHBhbmVs?=
Date: Thu, 30 Sep 2010 08:50:34 +0200
Message-ID: <4CA4333A.6060905@euromail.se>
References: <OF3ACE13A9.6923D1DE-ON482577AE.001EAE48-482577AE.0021EA7E@sitronix.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:55080 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750949Ab0I3GvY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Sep 2010 02:51:24 -0400
In-Reply-To: <OF3ACE13A9.6923D1DE-ON482577AE.001EAE48-482577AE.0021EA7E@sitronix.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rudy_huang@sitronix.com.tw
Cc: Alan Cox <alan@linux.intel.com>, =?UTF-8?B?U3TDqXBoYW5lIENoYXR0eQ==?= <chatty@enac.fr>, jkosina@suse.cz, linux-input@vger.kernel.org

Hi Rudy,
>

>>> +      case HID_DG_WIDTH:
>>> +         sd->w = value;
>>> +         break;
>>> +      case HID_DG_HEIGHT:
>>> +         sd->h = value;
>>> +         sitronix_filter_event(sd, input);
>>
>>
>> This kind of construction is unfortunate, because similar

>> devices may have a different attribute set, of the attributes
>> may appear in a different order. Better would be to allow to
>> first collect all attributes in random order, then perform the
>> contact update.

> 
>  How could I know that all attributes are collected ?
>  In our device, HID_DG_HEIGHT is the last field of finger.
>  Is there any reference code to which I can refer ? 


There will be in a little bit. The comment is really more of a general note
applicable to all the current drivers, and a moot point in this particular
instance now that it will be merged with the hid-stantum driver.

Thanks,
Henrik
