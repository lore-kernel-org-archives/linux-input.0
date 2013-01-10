From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend 0/2] Input: twl*-vibra probe cleanups (devm_* conversion)
Date: Thu, 10 Jan 2013 14:36:03 +0100
Message-ID: <1357824965-30614-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

This series seams to got lost:
https://lkml.org/lkml/2012/6/15/128

Can you take it for 3.9?

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

 drivers/input/misc/twl4030-vibra.c |  8 +--
 drivers/input/misc/twl6040-vibra.c | 99 +++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 60 deletions(-)

-- 
1.8.1
