From: Mark Butsch <mbutsch@syntech-fuelmaster.com>
Subject: Question about /dev/hidraw*
Date: Fri, 11 Dec 2009 15:03:52 -0500
Message-ID: <6C2434209962DC46B88345CA85C334A2858711C53F@Courier.syntech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchsrvr.syntech-fuelmaster.com ([199.44.250.2]:30576 "EHLO
	courier.syntech-fuelmaster.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750735AbZLKUJQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 15:09:16 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

I am going to be developing several USB devices and am interested in utilizing the '/dev/hidraw*' interface to make it easier, i.e. don't need to write drivers.

I have a few questions about the /dev/hidraw interface:

1. Is there a list of best practices and/or example for using /dev/hidraw?

2. Will a vendor-specific HID always have a /dev/hidraw available (provided kernel is built for it)?

3. For an HID that identifies itself as a keyboard (for example), is there a way to not have it function as a normal keyboard (with the input subsystem) yet have access to it via the /dev/hidraw? I tried unbinding it, but then the /dev/hidraw went away also.

4. I did some reading of the HID driver source code and looks like if there was some way to clear the HID_CLAIMED_INPUT bit, that would keep the input subsystem from processing the event. Is there a reason that something like that could/should not be done?

Thanks,

Mark Butsch
