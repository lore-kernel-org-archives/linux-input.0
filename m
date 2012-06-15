From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] Input: twl*-vibra probe cleanups (devm_* conversion)
Date: Fri, 15 Jun 2012 13:22:10 +0300
Message-ID: <1339755732-23774-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com
List-Id: linux-input@vger.kernel.org

Hello,

Convert the twl4030, twl6040 vibra drivers to use devm_ at probe time to clean
up the code a bit.
The twl6040-vibra driver needed bigger change since the ordering of the
initialization was not correct.

Regards,
Peter
---
Peter Ujfalusi (2):
  Input: twl4030-vibra: Convert to use devm_* in probe
  Input: twl6040-vibra: Code cleanup in probe with devm_* conversion

 drivers/input/misc/twl4030-vibra.c |    8 +--
 drivers/input/misc/twl6040-vibra.c |   99 ++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 60 deletions(-)

-- 
1.7.8.6
