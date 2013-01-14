From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/2] Input: twl6040-vibra cleanups (devm_* conversion, system wq)
Date: Mon, 14 Jan 2013 16:34:36 +0100
Message-ID: <1358177678-16509-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Changes since v2:
- twl4030-vibra patches are left out (they have been applied)
- Do not use devm_input_allocate_device() in twl6040-vibra

Changes since v1:
- Use devm_input_allocate_device()
- swtich drivers to use system workqueue

Cover letter from v1 (resend set):

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
  Input: twl6040-vibra: Code cleanup in probe with devm_* conversion
  input: twl6040-vibra: Use system workqueue

 drivers/input/misc/twl6040-vibra.c | 100 +++++++++++++++----------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

-- 
1.8.1
