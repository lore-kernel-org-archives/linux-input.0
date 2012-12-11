From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: hid-sensor-hub and autoloading of HID sensor modules
Date: Tue, 11 Dec 2012 18:40:04 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91C9609AD@ORSMSX108.amr.corp.intel.com>
References: <50C64F29.9030200@ahsoftware.de>
 <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com>
 <50C6551B.1030107@ahsoftware.de>
 <4FA419E87744DF4DAECD5BCE1214B7A91C96077D@ORSMSX108.amr.corp.intel.com>
 <50C659C1.7060005@ahsoftware.de> <50C77CA9.2090803@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58682 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab2LKSkG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Dec 2012 13:40:06 -0500
In-Reply-To: <50C77CA9.2090803@ahsoftware.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "matteo.dameno@st.com" <matteo.dameno@st.com>


Yes, only hid-sensor-hub is loaded automatically currently. IIO sensor driver needs to be loaded by modprobe or insmod. 

Thanks,
Srinivas

-----Original Message-----
From: Alexander Holler [mailto:holler@ahsoftware.de] 
Sent: Tuesday, December 11, 2012 10:34 AM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; matteo.dameno@st.com
Subject: Re: hid-sensor-hub and autoloading of HID sensor modules

Am 10.12.2012 22:53, schrieb Alexander Holler:
> Am 10.12.2012 22:40, schrieb Pandruvada, Srinivas:
>> I mean if your patch is merged, when new kernel is synced in the product line, we can't depend on auto loading of hid-sensor-hub. So we need to do something similar as you suggested.
> 
> Those patches aren't meant for your product line (mor for 3.8). But 
> hid-sensor-hub currently (as in 3.7-rc) doesn't load the necessary 
> modules at all, only hid-sensor-hub is currently loaded automatically, 
> not the other modules. That is at least what I've experienced here.

As I'm not sure if I could describe clearly what I meant to say, I try it again: ;)

The problem that the necessary modules will not be loaded automatically already exists in kernel 3.7. This is indepent of my proposed patches to get rid of the vendor and device IDs and load hid-sensor-hub automatically for all USB HID sensor hubs.

With or without my proposed patches, only hid-sensor-hub is loaded automatically, but not the other drivers like hid-sensor-accel-3d, hid-sensor-als, hid-sensor-gyro-3d or hid-sensor-magn-3d (if the are build as modules).

Regards,

Alexander
