From: ulrik.debie-os@e2big.org
Subject: Elantech touchpad does not work on Asus
Date: Thu, 19 Mar 2015 23:05:46 +0100
Message-ID: <20150319220546.GA4999@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:35373 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbbCSWuv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 18:50:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: George Moutsopoulos <gmoutso@yahoo.co.uk>

Hi all,

I looked at the bugzilla bugreport on 
https://bugzilla.kernel.org/show_bug.cgi?id=84491
"Elantech touchpad does not work on Asus TransformerBook Flip 500"

There are problems reported on two variants:
Asus TransformerBook Flip TP500LN
Asus TP500LN

George (in CC:) helped me to investigate on his hardware what happened
by trying a few patches and reporting what happens.

It seems that the absolute mode setting somehow gets cancelled after the
elantech drivers initializes. This results in relative motion packets
coming in, elantech driver not recognizing them and consequentially
"lost sync at byte 6" messages.

When one, after the psmouse driver is loaded, does the following:
echo 1 > /sys/devices/platform/i8042/serio4/reg_07
,the touchpad will work like a charm until suspend2ram. After a 
suspend2ram, another echo is required. 

This exact same value is written during initialization of v4 hardware. 
As a test, I even read it back in elantech_set_absolute_mode after 
writing and at that moment in the driver the value 1 is read.

But when one performs the read later on the commandline of reg_07, value
0 is read, so probably for a reason unknown to me, the value goes to
0 because of some timeout or serio communiation.

I also tried putting elantech_set_input_params call in front of
elantech_set_absolute_mode, but that didn't help either.

Also the suspend2ram seems to result in the same thing.

Anyone an idea why this reg_07 1 value could become a 0 between the time
the function elantech_set_absolute_mode during loading of the psmouse
module and the time when reading the value from sysfs from the 
command line ?

Kind regards,
Thanks,
Ulrik

