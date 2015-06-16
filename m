From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/2] cap118x: add LED support
Date: Mon, 15 Jun 2015 19:46:08 -0700
Message-ID: <1434422770-26896-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: zonque@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Changes from v3:
 * Fix race condition in work_queue
 * Make 0 value (0% duty cycle) an invalid brightness option
 * Document why LED brightness is only set global but ON/OFF state isn't

Matt Ranostay (2):
  dt: add cap11xx LED documentation
  cap11xx: add LED support

 .../devicetree/bindings/input/cap11xx.txt          |  23 ++++
 drivers/input/keyboard/cap11xx.c                   | 128 ++++++++++++++++++++-
 2 files changed, 148 insertions(+), 3 deletions(-)

-- 
1.9.1
