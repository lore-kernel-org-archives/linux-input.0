From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Wed, 13 Apr 2011 15:21:52 +0100
Message-ID: <4DA5B180.2090000@cam.ac.uk>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>	<4DA57B40.2000402@cam.ac.uk> <20110413140711.260e04b8@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:56666 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab1DMOUD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 10:20:03 -0400
In-Reply-To: <20110413140711.260e04b8@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@linux.jf.intel.com>, linux-input@vger.kernel.org

On 04/13/11 14:07, Alan Cox wrote:
>> Could just fix the length in this. You only ever use it with the
>> value 6. Hardly seems worth it's own function.  I guess this may be
>> because it gets used for other things in the full version?  If so it
>> doesn't do any harm here so might as well leave it alone.
> 
> In its current form, but there may well be future reasons for people to
> update that depending upon their application of the device.
It's conceivable, but seems to me that calling a function called xyz_read_reg
to do anything other than ready x y and z would be somewhat odd.
> 
>>> +	u8 buffer[6];
>>> +	buffer[0] = MPU3050_XOUT_H;
>>> +	mpu3050_xyz_read_reg(client, buffer, 6);
>>> +	coords->x = buffer[0];
>>> +	coords->x = coords->x << 8 | buffer[1];
>>
>> Better to use le16_tocpu or similar rather than
>> hand rolling these.
> 
> le16_to_cpu takes an u16 or similar input which means buffer then has
> to be a u16[] array for alignment which means you need a separate input
> and output buffer or to do uglies setting XOUT_H
Given the specific nature of that read you could just have an appropriate
u8 inside the function.  Would to my mind give more readable code,
particularly as you could indeed then have a u16 array. Could just mark
the u8 array as __attribute((aligned(2))) (I think) as a simpler alternative.

Oops, I can think of a few cases in my driver where I haven't enforced
that... Time for some fixes... 

> 
> (Normally I'd agree with you but in this case I'm unconvinced)
> 
> Alan

