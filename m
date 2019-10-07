From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 0/3] Logitech G920 fixes
Date: Sun,  6 Oct 2019 22:12:37 -0700
Message-ID: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Everyone:

This series contains patches to fix a couple of regressions in G920
wheel support by hid-logitech-hidpp driver. Without the patches the
wheel remains stuck in autocentering mode ("resisting" any attempt to
trun) as well as missing support for any FF action.

Thanks,
Andrey Smirnov

Andrey Smirnov (3):
  HID: logitech-hidpp: use devres to manage FF private data
  HID: logitech-hidpp: split g920_get_config()
  HID: logitech-hidpp: add G920 device validation quirk

 drivers/hid/hid-logitech-hidpp.c | 193 +++++++++++++++++++------------
 1 file changed, 120 insertions(+), 73 deletions(-)

-- 
2.21.0
