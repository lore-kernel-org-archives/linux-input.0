From: simon.budig@kernelconcepts.de
Subject: [PATCH v7] Touchscreen driver for FT5x06 based EDT displays
Date: Sun,  1 Jul 2012 22:36:45 +0200
Message-ID: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:57650 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab2GAUg5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Jul 2012 16:36:57 -0400
In-Reply-To: <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi all.

This is a new iteration of the driver for the edt ft5x06 based
polytouch series of touchscreens.

This version moves the raw data stuff into debugfs, ratelimits messages
in the irq handler, adds error checking for mt_init_slots, adds the
crc check for the touch data and allows for picking up the defaults
from the board file. (There is an extra variable in there allowing to skip
this and use the defaults from the sensor. This is necessary, since for
some values 0 is a valid value and I don't want to have unspecified
values in the platform data suddenly become defaults...)

I also slightly trimmed some function names making the driver a bit easier
on the eyes...  :)

Note that the dev_err_ratelimited() used for ratelimiting is not available
in some earlier kernels. You can work around this by adding the following
code to the beginning of the driver:

#ifndef dev_err_ratelimited
#define dev_level_ratelimited(dev_level, dev, fmt, ...)                        
do {                                                                    \
        static DEFINE_RATELIMIT_STATE(_rs,                              \
                                      DEFAULT_RATELIMIT_INTERVAL,       \
                                      DEFAULT_RATELIMIT_BURST);         \
        if (__ratelimit(&_rs))                                          \
                dev_level(dev, fmt, ##__VA_ARGS__);                     \
} while (0)

#define dev_err_ratelimited(dev, fmt, ...)                              \
        dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
#endif


Please give feedback on problems or on further plans for inclusion into
mainline.

Thanks,
        Simon

