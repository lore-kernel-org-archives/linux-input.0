From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: HID-sensor(-hub.c) and device IDs
Date: Wed, 5 Dec 2012 20:24:03 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91C95FEB6@ORSMSX108.amr.corp.intel.com>
References: <50BF961D.5080101@ahsoftware.de>
 <4FA419E87744DF4DAECD5BCE1214B7A91C95FE7C@ORSMSX108.amr.corp.intel.com>
 <50BFAB5C.6060207@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25507 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab2LEUYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 15:24:14 -0500
In-Reply-To: <50BFAB5C.6060207@ahsoftware.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Yes, We can have a black list instead of white list. Are you planning to submit changes?
Thanks,
Srinivas


-----Original Message-----
From: Alexander Holler [mailto:holler@ahsoftware.de] 
Sent: Wednesday, December 05, 2012 12:15 PM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; linux-input@vger.kernel.org
Subject: Re: HID-sensor(-hub.c) and device IDs

Am 05.12.2012 20:21, schrieb Pandruvada, Srinivas:
> We have not tested on sensor hubs from different vendors except few. It is possible that some vendors are using sensor hub as raw devices . We can remove vendor product ids once we have a good list for support.

Hmm, sorry, I don't understand that fully. Does that mean that the list is there to use the driver only with a small group of devices because otherwise some HID-sensors aren't usable as raw devices?

I don't know how many HID-sensor devices are already out in the wild, but because the standard looks fairly new, I don't think there are that many. And I wonder how you want to get the list larger, if nobody notifies that they should use hid-sensor-hub.c.


I think the correct way would be to build a blacklist instead of a whitelist.

Regards,

Alexander

> Thanks,
> Srinivas
>
> -----Original Message-----
> From: Alexander Holler [mailto:holler@ahsoftware.de]
> Sent: Wednesday, December 05, 2012 10:45 AM
> To: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; 
> Pandruvada, Srinivas
> Subject: HID-sensor(-hub.c) and device IDs
>
> Hello,
>
> is there any special reason why vendor and devices IDs for HID-sensors must be listed in drivers/hid/hid-sensor-hub.c and drivers/hid/hid-core.c?
>
> Maybe I'm missing something, but I don't think this is how HID is supposed to work.
>
> Regards,
>
> Alexander
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>

