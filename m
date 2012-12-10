From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: hid-sensor-hub and autoloading of HID sensor modules
Date: Mon, 10 Dec 2012 22:53:05 +0100
Message-ID: <50C659C1.7060005@ahsoftware.de>
References: <50C64F29.9030200@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com> <50C6551B.1030107@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C96077D@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:40176 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab2LJVxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2012 16:53:34 -0500
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91C96077D@ORSMSX108.amr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "matteo.dameno@st.com" <matteo.dameno@st.com>

Am 10.12.2012 22:40, schrieb Pandruvada, Srinivas:
> I mean if your patch is merged, when new kernel is synced in the product line, we can't depend on auto loading of hid-sensor-hub. So we need to do something similar as you suggested.

Those patches aren't meant for your product line (mor for 3.8). But
hid-sensor-hub currently (as in 3.7-rc) doesn't load the necessary
modules at all, only hid-sensor-hub is currently loaded automatically,
not the other modules. That is at least what I've experienced here.

Regards,

Alexander

> 
> Thanks,
> Srinivas
> 
> 
> 
> -----Original Message-----
> From: Alexander Holler [mailto:holler@ahsoftware.de] 
> Sent: Monday, December 10, 2012 1:33 PM
> To: Pandruvada, Srinivas
> Cc: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; matteo.dameno@st.com
> Subject: Re: hid-sensor-hub and autoloading of HID sensor modules
> 
> Am 10.12.2012 22:22, schrieb Pandruvada, Srinivas:
>> This will be a problem for current implementations, which are about to get shipped.
>> Once I get chance, I will start looking at this idea. Meanwhile, you need to add hook to vendor and product id in the table.
> 
> Sorry, but I don't understand what that "shipped" has to do with the implementation in the kernel. And I don't seen any problems as only the implementation inside the kernel will change, nothing else.
> 
> Regards,
> 
> Alexander
> 
>>
>> Thanks,
>> Srinivas
>>
>>
>> -----Original Message-----
>> From: Alexander Holler [mailto:holler@ahsoftware.de]
>> Sent: Monday, December 10, 2012 1:08 PM
>> To: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; 
>> Pandruvada, Srinivas; matteo.dameno@st.com
>> Subject: hid-sensor-hub and autoloading of HID sensor modules
>>
>> Hello,
>>
>> as I've just posted a patch to get rid of the vendor and device IDs for USB HID sensor hubs, there is still one problem left: hid-sensor-hub doesn't automatically load the necessary drivers (if they are modules).
>>
>> Here is a suggestion about how to solve that:
>>
>> Create HID groups HID_GROUP_SENSOR_ACCEL, HID_GROUP_SENSOR_TIME, ...) for every type of (supported) sensor (instead of the one HID_GROUP_SENSOR_HUB), scan for their usage pages (e.g.
>> HID_USAGE_SENSOR_ACCEL, HID_USAGE_SENSOR_TIME, ...) set the group and so load the final module and not hid-sensor-hub. hid-sensor-hub will then get loaded automatically.
>>
>> As I don't have any real sensor hubs (and no business with them), I think others should implement such, if that idea got approved to make sense. ;) That just would be some few lines, but I couldn't test them with real-world stuff.
>>
>> Regards,
>>
>> Alexander
>>
> 

