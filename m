From: Chris Wolfe <cwolfe@chromium.org>
Subject: Generalizing Kionix KXTJ9 driver
Date: Tue, 21 Jun 2011 11:35:22 -0400
Message-ID: <4E00BA3A.8030003@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:16129 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1FUPgO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 11:36:14 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p5LFa83B006050
	for <linux-input@vger.kernel.org>; Tue, 21 Jun 2011 08:36:08 -0700
Received: from ywm39 (ywm39.prod.google.com [10.192.13.39])
	by hpaq11.eem.corp.google.com with ESMTP id p5LFa6P3010917
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 21 Jun 2011 08:36:07 -0700
Received: by ywm39 with SMTP id 39so3474978ywm.10
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2011 08:36:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org

Hi folks,

I am working on a driver for the Kionix KXTF9 accelerometer. This is a 
fairly close relative of the KXTJ9 that Chris Hudson has been iterating 
in linux-input. Unfortunately I missed his driver when getting started, 
so I now have a fairly-complete IIO-based implementation instead.

As the KXTJ9 input driver has had more review, it makes sense for me to 
backtrack and build on that one. My proposal is to work on generalizing 
the driver enough to also support the KXTF9, and coordinate with Chris 
Hudson to avoid breaking his improvements.

While the I2C interfaces are fairly similar, the KXTF9 (and newer KXTI9) 
have more on-chip processing and a variety of added features. These 
include things like taps and coarse orientation, which I am not sure how 
to report in an upstream-friendly way. Any advice would be appreciated:

Tap: Single and double taps in six directions. The only example I can 
find is the ADXL34 driver, which seems to just report BTN_TOUCH for any 
tap (unless changed in platform data).

Tilt: Coarse orientation in six directions (face up, face down, left up, 
right up, top up, bottom up). Saw some discussion about this, but wasn't 
sure if there was agreement on how to report these events in a useful 
fashion.

Motion: Yes/no binary state.

Sampling Rate: KXTJ9 driver is using delay in ms to drive both 
interrupt-based and polling-based cases. Since the sysfs interfaces are 
string-based, am wondering if decimal Hz would be more intuitive. These 
would be converted to fixed-point in-kernel. Since there are five or six 
different rates to adjust, they needs to be easy to understand.

Timing Parameters: The tap/tilt/motion sensing is configured via a large 
number of user-configurable parameters. My thought for these is to 
expose them in sysfs as decimal numbers of seconds. I believe the actual 
values set on the chip need to change with the associated sampling rates.

Axis Parameters: Many of the modes need to be configured with a mask of 
directions (+x -x +y -y +z -z). Six sysfs attributes for each seems 
excessive and a bitmask feels error-prone. I wouldn't be averse to using 
a list of strings if that is acceptable (e.g. "x z" or "up down left 
forward"). Any other alternatives?

Thanks,
Chris

