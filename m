From: Matt Hsu <matt@0xlab.org>
Subject: Duplicated driver for LIS302-like device.
Date: Fri, 11 Dec 2009 10:52:59 +0800
Message-ID: <4B21B40B.2010007@0xlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39015 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762223AbZLKCxE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 21:53:04 -0500
Received: by yxe17 with SMTP id 17so438933yxe.33
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 18:53:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Hi all,

Recently I was managed to make LIS302DL device work on Beagleboard.
It's almost done.

The last thing I would like to do is to commit the driver to upstream.
Here comes a problem. I found there's a similar driver named lis3lv02d.c.
which is located drivers/hwmon/. They are pretty much the same.
Only registers mapping is different slightly.

Originally, I plan to use this driver directly instead of implementing 
another lis302dl-like driver.
Unfortunately, this driver is dependent on ACPI subsystem.
The target platform for this device is based on ARM.
Therefore, I could not re-use this driver for my work
and re-implement it based on I2C interface.

My question is, is this a duplicated driver for upstream
if I send patches for this driver without any ACPI dependency?

Cheers,
Matt



