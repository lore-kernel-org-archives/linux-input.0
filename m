From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Mon, 14 Mar 2011 20:14:52 +0000
Message-ID: <20110314201452.1bf4cec8@lxorguk.ukuu.org.uk>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
	<4D7E36BA.2010007@cam.ac.uk>
	<20110314182456.33a591dc@lxorguk.ukuu.org.uk>
	<4D7E6C83.3040602@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47264 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751320Ab1CNUPG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 16:15:06 -0400
In-Reply-To: <4D7E6C83.3040602@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Torokhov <dmitry.torokhov@gmail.com>

> > It's not even ADC counts - the mpu3050 has its own processing.
> Oh goody..
> 
> Just had a look at the datasheet. 'Interesting'
> 
> I'm particularly looking forward to seeing use of the on gyro master
> i2c bus for talking to an external accelerometer :)

A lot depends on the firmware in use. I don't have a test case for adding
using the i2c bus as a sort of bypass for the mpu3050 alas, although it
did occur to me.


> There are quoted conversion parameters for going from the raw readings
> to degree's per sec.  You 'could' apply them in kernel I guess, or maybe
> provide details of what they are to userspace....

Not sure how that is best done really - I guess I should at least
document the "probable" conversions - again it seems it will be firmware
specific in some cases.
