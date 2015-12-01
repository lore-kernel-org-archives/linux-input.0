From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH v5 0/2] Fixes for ELAN touchscreens
Date: Tue,  1 Dec 2015 19:56:46 +0100
Message-ID: <1448996208-19713-1-git-send-email-adrienverge@gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is the fifth version of a patchset which originally aimed to fix a=
 buggy
touchscreen from ELAN Microelectronics.

Changes since v4:
- Cast HID_ANY_ID to an __u16 so to keep gcc happy on AVR32 arch.

Changes since v3:
- Use HID_ANY_ID to define a vendor-ID-global quirk, as suggested by
  Benjamin Tissoires.

Changes since v2:
- Apply ALWAYS_POLL quirk to all ELAN devices by default, as suggested =
by
  Jiri Kosina and Oliver Neukum.

Adrien Verg=C3=A9 (2):
  USB: quirks: Fix another ELAN touchscreen
  USB: quirks: Apply ALWAYS_POLL to all ELAN devices

 drivers/hid/hid-ids.h           | 5 -----
 drivers/hid/usbhid/hid-quirks.c | 9 +++------
 drivers/usb/core/quirks.c       | 3 +++
 3 files changed, 6 insertions(+), 11 deletions(-)

--=20
2.4.3
