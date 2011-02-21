From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380 accelerometers
Date: Mon, 21 Feb 2011 19:08:22 +0000
Message-ID: <4D62B826.2010201@cam.ac.uk>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54568 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab1BUTHz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Feb 2011 14:07:55 -0500
In-Reply-To: <20110214100622.2282.1584.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

Hi Alan,

As ever, it's my pet complaint... Complex device specific sysfs interfaces and
their documentation :)
...
> 
> 
> diff --git a/Documentation/ABI/testing/sysfs-i2c-bma023 b/Documentation/ABI/testing/sysfs-i2c-bma023
> new file mode 100644
> index 0000000..04a293c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-i2c-bma023
> @@ -0,0 +1,93 @@
> +*Note*: It is anticpated that if IIO ever makes it upstream that the
> +preferred general purpose non-input interface to this hardware will become IIO.
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/range
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Configure the sensing range of the device
> +		0: +/- 2G
> +		1: +/- 4G
> +		2: +/- 8G
Why the magic numbers? It would be trivial to just use the actual values so
why not do so?
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/bandwidth
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Digital filtering on ADC output data
> +		0: 25Hz
> +		1: 50Hz
> +		2: 100Hz
> +		3: 190Hz
> +		4: 375Hz
> +		5: 750Hz
> +		6: 1500Hz
This one is even worse.  It's pretty trivial to use meaningful numbers. With
the
25 [50] 100 190 etc
 syntax you don't even need a separate attribute to tell userspace
what is available.
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/new_data_int
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Generate an interrupt when the axes values are changed
> +		0: disable
> +		1: enable
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/hg_int
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Generate an interrupt when the high-g threshold is met
> +		0: disable
> +		1: enable
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/lg_int
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Generate an interrupt when the low-g threshold is met
> +		0: disable
> +		1: enable
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/hg_dur
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	High G duration required to trigger.
> +		(See the equations in the data sheet)
If possible, please direct people to a particular equation. Or given these
seem pretty simple, just put them in here.. I haven't checked the code, so
might have guessed wrong setting for counter_HG. Here I assume you went
with the reset counter version.

High G duration. The number of samples for which acceleration must be greater
than threshold for the interrupt to trigger.
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/hg_hyst
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	High G duration hysteresis
> +		(See the equations in the data sheet)
Hysterisis for reset of threshold. |acc_x|< (hg_thres - 32*hg_hyst)/255 *range

(which ought to convert to it just being a simple value with slightly odd units.
The only confusing bit is what the value of 'range' is in the equation). Looks 
like we get a divide by zero if we go with the 2g setting and assume it is the
register value. Hence I guess it is the 'g' value. Only have 3 bits hence text
might be something like.

Hysteresis for reset of high acceleration magnitude threshold interrupt. Range 0 - 7
corresponding to hysteresis of 0 to 0.878*range.

(0.878 = 7*32/255)
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/hg_thres
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	High G threshold
> +		(See the equations in the data sheet)
Again, ought to be trivial to figure out what this is looking at datasheet

> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/lg_dur
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Low G duration required to trigger
> +		(See the equations in the data sheet)
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/lg_hyst
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Low G duration hysteresis
> +		(See the equations in the data sheet)
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/lg_thres
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Low G threshold
> +		(See the equations in the data sheet)
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/power_mode
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Power mode
> +		0: Use runtime PM
> +		1: Forced on
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/accel_data
> +Date:		February 2011
> +Contact:	Alan Cox <alan@linux.intel.com>
> +Description:	Raw XYZ co-ordinate data, each ranges from -512 to +511,
> +		formatted as (x,y,z) to match existing similar interfaces
> 
