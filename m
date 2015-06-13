From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/2] cap11xx: Add LED support to driver
Date: Fri, 12 Jun 2015 21:17:32 -0700
Message-ID: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: zonque@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Changes from v2:
 * Use LED subsystem correctly, and dynamically allot used LEDs
 * Add LED trigger support (e.g. heartbeat, mmc trigger, etc)
 * Add DT properties for configuring LED usage, labels, and brightness


Matt Ranostay (2):
  dt: add cap11xx LED documentation
  cap11xx: add LED support

 .../devicetree/bindings/input/cap11xx.txt          |  23 ++++
 drivers/input/keyboard/cap11xx.c                   | 121 ++++++++++++++++++++-
 2 files changed, 141 insertions(+), 3 deletions(-)

-- 
1.9.1
