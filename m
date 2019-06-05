From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH v2 0/4] Read battery voltage from G403 and G900 mice
Date: Wed,  5 Jun 2019 15:45:29 -0400
Message-ID: <20190605194533.18717-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The gaming line of Logitech devices doesn't use the old hidpp20 feature
for battery level reporting. Instead, they report the current voltage
of the battery, in millivolts.

This patch set handles this case by adding a quirk to the devices we know
to have this new feature, in both wired and wireless mode.

This version of the patch set is better split, as well as adding the
quirk to make sure we don't needlessly probe every device connected.

Pedro Vanzella (4):
  HID: hid-logitech-hidpp: add quirk to handle battery voltage
  HID: hid-logitech-hidpp: add function to query battery voltage
  HID: hid-logitech-hidpp: report battery voltage to the power supply
  HID: hid-logitech-hidpp: subscribe to battery voltage events

 drivers/hid/hid-logitech-hidpp.c | 150 ++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)

-- 
2.21.0
