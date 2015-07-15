From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Connecting input driver to underlying uart
Date: Wed, 15 Jul 2015 11:22:06 -0700
Message-ID: <359253492.mQaq5M2qFo@jclayton-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36109 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbbGOSWK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2015 14:22:10 -0400
Received: by pachj5 with SMTP id hj5so28223526pac.3
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2015 11:22:10 -0700 (PDT)
Received: from jclayton-pc.localnet (68-185-59-186.static.knwc.wa.charter.com. [68.185.59.186])
        by smtp.gmail.com with ESMTPSA id qo6sm5414577pab.23.2015.07.15.11.22.08
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 11:22:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi list,
I'm starting work on an input driver.
the device is connected to an RS232 uart in my freescale imx6q arm system, 
which has 2 serial ports, one of which is a console

It is not anything like a ps2/at device.
How can I get it to take over the uart device? A devicetree entry?

I do not understand serio probing, and don't understand if I should use serio 
for a non ps2 compatible device.

Any pointers would be helpful.

The input device documentation is great if I can just figure out how to 
connect it to my hardware.

-- 
~Joshua Clayton
