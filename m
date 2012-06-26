From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH, 0/6] HID-Sensors v3
Date: Tue, 26 Jun 2012 14:03:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206261402130.18612@pobox.suse.cz>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54084 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298Ab2FZMEC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 08:04:02 -0400
In-Reply-To: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, jic23.cam.ac.uk@suse.de, linux-input@vger.kernel.org

On Mon, 25 Jun 2012, srinivas pandruvada wrote:

> v3 :
> - Using TRIGGERRED BUFFER
> 
> - Using MFD framework
> The sensor hub driver is submiited to drivers/hid. This contains core processing of hid sensor
> usage table, registers as an hid driver and adds registration function for routing data
> to individual sensor driver. So core driver independent of user mode interface method (IIO/input etc.)
> 
> - Submiiting four drivers for Accelerometer-3D, Gyro-3D, Compass-3D and ALS. These uses IIO triggered
> buffer interface. They are childrens of hid sensor hub driver.
> They reside in iio/accel, iio/gyro iio/magnetometer and iio/light.
> 
> - Still using driver/staging/iio. Not able to test with driver/iio.
> 
> v2 :
> - Replaced Ring-SW with KFiFO
> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
> - SysFS (
> --- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
> --- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
> --- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
> )
> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
> sensor have only channels, sampling_frequency and hyst_raw as the ABI.
> - Additional patch to enable ST Micro sensor hub 
> 
> v1:
> Base implementation for comments

Could you perhaps please provide somewhere (Documentation/hid/* or 
whatever) some overview about the general infrastructure design?

It's not immediately obvious to me how exactly the interaction between 
your hid-sensor-hub driver, MFD and IIO is going to look like.

If I understand it correctly, hid-sensor-hub will have to bind to all the 
supported devices in any case, and the distribution to other drivers that 
will be doing the processing will be done through callbacks, right?

-- 
Jiri Kosina
SUSE Labs
