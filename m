From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Mon, 14 Mar 2011 19:29:07 +0000
Message-ID: <4D7E6C83.3040602@cam.ac.uk>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>	<4D7E36BA.2010007@cam.ac.uk> <20110314182456.33a591dc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:34289 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1CNT2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 15:28:07 -0400
In-Reply-To: <20110314182456.33a591dc@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Torokhov <dmitry.torokhov@gmail.com>

On 03/14/11 18:24, Alan Cox wrote:
>> It is a slim sysfs interface so for once I'm not going to moan  (much...)
>> I'd prefer something with actual units rather than adc
>> counts but can live with having this interface alongside something more
>> generalizable.
> 
> It's not even ADC counts - the mpu3050 has its own processing.
Oh goody..

Just had a look at the datasheet. 'Interesting'

I'm particularly looking forward to seeing use of the on gyro master
i2c bus for talking to an external accelerometer :)

There are quoted conversion parameters for going from the raw readings
to degree's per sec.  You 'could' apply them in kernel I guess, or maybe
provide details of what they are to userspace....

