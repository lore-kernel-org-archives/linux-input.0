From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: hid-sensor-hub and autoloading of HID sensor modules
Date: Mon, 10 Dec 2012 21:40:45 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91C96077D@ORSMSX108.amr.corp.intel.com>
References: <50C64F29.9030200@ahsoftware.de>
 <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com>
 <50C6551B.1030107@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11657 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab2LJVku convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2012 16:40:50 -0500
In-Reply-To: <50C6551B.1030107@ahsoftware.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "matteo.dameno@st.com" <matteo.dameno@st.com>

I mean if your patch is merged, when new kernel is synced in the product line, we can't depend on auto loading of hid-sensor-hub. So we need to do something similar as you suggested.

Thanks,
Srinivas



-----Original Message-----
From: Alexander Holler [mailto:holler@ahsoftware.de] 
Sent: Monday, December 10, 2012 1:33 PM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; matteo.dameno@st.com
Subject: Re: hid-sensor-hub and autoloading of HID sensor modules

Am 10.12.2012 22:22, schrieb Pandruvada, Srinivas:
> This will be a problem for current implementations, which are about to get shipped.
> Once I get chance, I will start looking at this idea. Meanwhile, you need to add hook to vendor and product id in the table.

Sorry, but I don't understand what that "shipped" has to do with the implementation in the kernel. And I don't seen any problems as only the implementation inside the kernel will change, nothing else.

Regards,

Alexander

> 
> Thanks,
> Srinivas
> 
> 
> -----Original Message-----
> From: Alexander Holler [mailto:holler@ahsoftware.de]
> Sent: Monday, December 10, 2012 1:08 PM
> To: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; 
> Pandruvada, Srinivas; matteo.dameno@st.com
> Subject: hid-sensor-hub and autoloading of HID sensor modules
> 
> Hello,
> 
> as I've just posted a patch to get rid of the vendor and device IDs for USB HID sensor hubs, there is still one problem left: hid-sensor-hub doesn't automatically load the necessary drivers (if they are modules).
> 
> Here is a suggestion about how to solve that:
> 
> Create HID groups HID_GROUP_SENSOR_ACCEL, HID_GROUP_SENSOR_TIME, ...) for every type of (supported) sensor (instead of the one HID_GROUP_SENSOR_HUB), scan for their usage pages (e.g.
> HID_USAGE_SENSOR_ACCEL, HID_USAGE_SENSOR_TIME, ...) set the group and so load the final module and not hid-sensor-hub. hid-sensor-hub will then get loaded automatically.
> 
> As I don't have any real sensor hubs (and no business with them), I think others should implement such, if that idea got approved to make sense. ;) That just would be some few lines, but I couldn't test them with real-world stuff.
> 
> Regards,
> 
> Alexander
> 

