From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/2] cap11xx: add LED support
Date: Wed, 17 Jun 2015 20:58:15 -0700
Message-ID: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: zonque@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Changes from v4:
 * Update docs to show proper address and size properties for DT bindings
 * Make all LEDs blank on startup, and remove racey schedule_work calls
   that did this in last revisions
 * Disable cap11xx_set_sleep() if any LEDs registered
   * TODO: Make cap11xx_set_sleep() able to detect if LEDs are in use and
     calculate which power state it should be in.

Matt Ranostay (2):
  dt: add cap11xx LED documentation
  cap11xx: add LED support

 .../devicetree/bindings/input/cap11xx.txt          |  25 ++++
 drivers/input/keyboard/cap11xx.c                   | 140 ++++++++++++++++++++-
 2 files changed, 162 insertions(+), 3 deletions(-)

-- 
1.9.1
