From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: HID-sensor(-hub.c) and device IDs
Date: Wed, 05 Dec 2012 21:15:24 +0100
Message-ID: <50BFAB5C.6060207@ahsoftware.de>
References: <50BF961D.5080101@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C95FE7C@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:57891 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab2LEUPc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 15:15:32 -0500
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91C95FE7C@ORSMSX108.amr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Am 05.12.2012 20:21, schrieb Pandruvada, Srinivas:
> We have not tested on sensor hubs from different vendors except few. It is possible that some vendors are using sensor hub as raw devices . We can remove vendor product ids once we have a good list for support.

Hmm, sorry, I don't understand that fully. Does that mean that the list 
is there to use the driver only with a small group of devices because 
otherwise some HID-sensors aren't usable as raw devices?

I don't know how many HID-sensor devices are already out in the wild, 
but because the standard looks fairly new, I don't think there are that 
many. And I wonder how you want to get the list larger, if nobody 
notifies that they should use hid-sensor-hub.c.

I think the correct way would be to build a blacklist instead of a 
whitelist.

Regards,

Alexander

> Thanks,
> Srinivas
>
> -----Original Message-----
> From: Alexander Holler [mailto:holler@ahsoftware.de]
> Sent: Wednesday, December 05, 2012 10:45 AM
> To: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; Pandruvada, Srinivas
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
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

