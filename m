From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: HID-sensor(-hub.c) and device IDs
Date: Wed, 5 Dec 2012 19:21:49 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91C95FE7C@ORSMSX108.amr.corp.intel.com>
References: <50BF961D.5080101@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58912 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096Ab2LETVw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 14:21:52 -0500
In-Reply-To: <50BF961D.5080101@ahsoftware.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

We have not tested on sensor hubs from different vendors except few. It is possible that some vendors are using sensor hub as raw devices . We can remove vendor product ids once we have a good list for support. 

Thanks,
Srinivas

-----Original Message-----
From: Alexander Holler [mailto:holler@ahsoftware.de] 
Sent: Wednesday, December 05, 2012 10:45 AM
To: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; Pandruvada, Srinivas
Subject: HID-sensor(-hub.c) and device IDs

Hello,

is there any special reason why vendor and devices IDs for HID-sensors must be listed in drivers/hid/hid-sensor-hub.c and drivers/hid/hid-core.c?

Maybe I'm missing something, but I don't think this is how HID is supposed to work.

Regards,

Alexander
