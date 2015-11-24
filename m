From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH v4 0/2] Fixes for ELAN touchscreens
Date: Tue, 24 Nov 2015 16:02:03 +0100
Message-ID: <1448377325-4725-1-git-send-email-adrienverge@gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38663 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbKXPCi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 10:02:38 -0500
In-Reply-To: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

This is the fourth version of a patchset which originally aimed to fix =
a buggy
touchscreen from ELAN Microelectronics.

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

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
