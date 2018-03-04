From: Florent Flament <contact@florentflament.com>
Subject: [PATCH v2 0/1] Logitech K290: Add driver for the Logitech K290 USB keyboard
Date: Sun,  4 Mar 2018 23:14:24 +0100
Message-ID: <20180304221425.28611-1-contact@florentflament.com>
References: <20180304170004.26553-1-contact@florentflament.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180304170004.26553-1-contact@florentflament.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.shevchenko@gmail.com
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Florent Flament <contact@florentflament.com>
List-Id: linux-input@vger.kernel.org

Changes in v2:
* Using SPDX ID instead of licence statement
* Removed unnecessary includes (linux/moduleparam.h and linux/mod_devicetable.h)

ps: Sorry for having broken the previous thread and sent the previous
mail without proper versioning of the patch.

Florent Flament (1):
  HID: Logitech K290: Add driver for the Logitech K290 USB keyboard

 drivers/hid/Kconfig             |  18 ++++++++
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-ids.h           |   1 +
 drivers/hid/hid-logitech-k290.c | 100 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 drivers/hid/hid-logitech-k290.c

-- 
2.14.3
