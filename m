From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Wed, 13 Apr 2011 15:30:21 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D59177137546EFA20@LIMKCMBX1.ad.analog.com>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>
	<4DA57B40.2000402@cam.ac.uk> <20110413140711.260e04b8@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:41031 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab1DMOaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 10:30:25 -0400
In-Reply-To: <20110413140711.260e04b8@bob.linux.org.uk>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: Alan Cox <alan@linux.jf.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Alan Cox wrote on 2011-04-13:
>> Could just fix the length in this. You only ever use it with the value
>> 6. Hardly seems worth it's own function.  I guess this may be because
>> it gets used for other things in the full version?  If so it doesn't do
>> any harm here so might as well leave it alone.
>
> In its current form, but there may well be future reasons for people
> to update that depending upon their application of the device.
>
>>> +   u8 buffer[6];
>>> +   buffer[0] = MPU3050_XOUT_H;
>>> +   mpu3050_xyz_read_reg(client, buffer, 6);
>>> +   coords->x = buffer[0];
>>> +   coords->x = coords->x << 8 | buffer[1];
>>
>> Better to use le16_tocpu or similar rather than hand rolling these.
>
> le16_to_cpu takes an u16 or similar input which means buffer then has
> to be a u16[] array for alignment which means you need a separate
> input and output buffer or to do uglies setting XOUT_H

How about get_unaligned_be16(&buffer[0]) ?

> (Normally I'd agree with you but in this case I'm unconvinced)
>
> Alan

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif

