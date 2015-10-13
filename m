From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: [PATCH v5 0/2] input: rotary encoder: Add wake up support
Date: Tue, 13 Oct 2015 21:13:38 +0200
Message-ID: <1444763620-14652-1-git-send-email-sylvain.rochet@finsecur.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:60610 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbJMTNr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 15:13:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sylvain Rochet <sylvain.rochet@finsecur.com>

Changes since v4:
  * As suggested by Johan, Reverted the 
    device_set_wakeup_capable()/device_wakeup_enable() change,
    stick to device_init_wakeup()

Changes since v3:
  * Stick to the "wakeup-source" DT property, we are standardizing on it.
  * Improved wake-up support: This driver is always supporting wake up
    support, thus it is now calling device_set_wakeup_capable(dev, true)
    followed by device_wakeup_enable(dev) if wake up is enabled at boot
    time. This way the wakeup sysfs tree is always available to the user.
    Only calling device_init_wakeup(dev, false) totally disable wake up  
    support at boot tine with no way to enable wake up support furtherly,
    which isn't nice.                                                    

Changes since v2:
  * Using false instead of 0 on boolean
  * Splitted DT documentation in a separate patch

Changes since v1:
  * Using DT property wakeup-source instead of rotary-encoder,wakeup
  * Renamed int wakeup to bool wakeup_source
  * Patch cleanup (checkpatch.pl)

Sylvain Rochet (2):
  Documentation: input: rotary encoder: Add wakeup-source property
  input: rotary encoder: Add wake up support

 .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
 Documentation/input/rotary-encoder.txt             |  1 +
 drivers/input/misc/rotary_encoder.c                | 37 ++++++++++++++++++++++
 include/linux/rotary_encoder.h                     |  1 +
 4 files changed, 40 insertions(+)

-- 
2.5.1

