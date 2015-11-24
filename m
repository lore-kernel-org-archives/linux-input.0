From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH v3 0/2] Fixes for ELAN touchscreens
Date: Tue, 24 Nov 2015 14:49:06 +0100
Message-ID: <1448372948-8861-1-git-send-email-adrienverge@gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is the third version of a patchset which originally aimed to fix a=
 buggy
touchscreen from ELAN Microelectronics.

Thanks to feedback from Jiri Kosina and Oliver Neukum, the ALWAYS_POLL =
quirk is
now applied to all ELAN devices by default.

Adrien Verg=C3=A9 (2):
  USB: quirks: Fix another ELAN touchscreen
  USB: quirks: Apply ALWAYS_POLL to all ELAN devices

 drivers/hid/hid-ids.h           |  5 -----
 drivers/hid/usbhid/hid-quirks.c | 43 +++++++++++++++++++++++++++------=
--------
 drivers/usb/core/quirks.c       |  3 +++
 3 files changed, 32 insertions(+), 19 deletions(-)

--=20
2.4.3
