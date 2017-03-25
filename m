From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH RFC 0/4] Improve support for Logitech MX Anywhere 2
Date: Sat, 25 Mar 2017 19:49:38 -0300
Message-ID: <cover.1490481944.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35081 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdCYWub (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 18:50:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans Verkuil <hans.verkuil@cisco.com>, Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stuart Yoder <stuart.yoder@nxp.com>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Douglas Anderson <dianders@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Kamil Debski <kamil@wypas.org>, Ping Cheng <pinglinux@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>

Logitech MX Anywhere 2 and MX Master have a high res wheel, with
is currently supported only in legacy low-resolution mode.

Add the needed bits to support it.

Note: The approach taken here were to add a new EV_REL event
when the device generates output in high-resolution mode, as it
would not require any changes on userspace for low resolution.

Implementing support for high resolution mode should also be simple.

Mauro Carvalho Chehab (4):
  input: add an EV_REL event for high-res vertical wheel
  hid-logitech-hidpp: add support for high res wheel
  input: add a EV_SW event for ratchet switch
  hid-logitech-hidpp: add support for ratchet switch

 drivers/hid/hid-logitech-hidpp.c       | 216 +++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h        |   2 +-
 include/uapi/linux/input-event-codes.h |   5 +-
 3 files changed, 221 insertions(+), 2 deletions(-)

-- 
2.9.3


