From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH, 0/6] HID-Sensors v3
Date: Tue, 26 Jun 2012 15:59:13 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91933EBBB@ORSMSX104.amr.corp.intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
 <alpine.LNX.2.00.1206261402130.18612@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8923 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757918Ab2FZP7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 11:59:15 -0400
In-Reply-To: <alpine.LNX.2.00.1206261402130.18612@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jic23.cam.ac.uk@suse.de" <jic23.cam.ac.uk@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

That is a good idea. I will submit a patch for documentation.

Thanks,
Srinivas

-----Original Message-----
From: Jiri Kosina [mailto:jkosina@suse.cz] 
Sent: Tuesday, June 26, 2012 5:04 AM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; jic23.cam.ac.uk@suse.de; linux-input@vger.kernel.org
Subject: Re: [PATCH, 0/6] HID-Sensors v3

On Mon, 25 Jun 2012, srinivas pandruvada wrote:

> v3 :
> - Using TRIGGERRED BUFFER
> 
> - Using MFD framework
> The sensor hub driver is submiited to drivers/hid. This contains core 
> processing of hid sensor usage table, registers as an hid driver and 
> adds registration function for routing data to individual sensor 
> driver. So core driver independent of user mode interface method 
> (IIO/input etc.)
> 
> - Submiiting four drivers for Accelerometer-3D, Gyro-3D, Compass-3D 
> and ALS. These uses IIO triggered buffer interface. They are childrens of hid sensor hub driver.
> They reside in iio/accel, iio/gyro iio/magnetometer and iio/light.
> 
> - Still using driver/staging/iio. Not able to test with driver/iio.
> 
> v2 :
> - Replaced Ring-SW with KFiFO
> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y 
> and Z
> - SysFS (
> --- Changed "polling_interval" to sampling_frequency 
> (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
> --- Changed "sensitivity" to hyst_raw, which is already used by some 
> ADC modules
> --- Removed "Activate". No longer need this. Using trigger state to 
> activate/deactivate
> )
> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in 
> read_raw. So each sensor have only channels, sampling_frequency and hyst_raw as the ABI.
> - Additional patch to enable ST Micro sensor hub
> 
> v1:
> Base implementation for comments

Could you perhaps please provide somewhere (Documentation/hid/* or
whatever) some overview about the general infrastructure design?

It's not immediately obvious to me how exactly the interaction between your hid-sensor-hub driver, MFD and IIO is going to look like.

If I understand it correctly, hid-sensor-hub will have to bind to all the supported devices in any case, and the distribution to other drivers that will be doing the processing will be done through callbacks, right?

--
Jiri Kosina
SUSE Labs
