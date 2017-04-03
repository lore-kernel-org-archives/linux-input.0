From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 0/4] input: add support for high resolution wheel found on some Logitech devices
Date: Mon,  3 Apr 2017 16:35:28 -0300
Message-ID: <cover.1491247515.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbdDCTf4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 15:35:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Stuart Yoder <stuart.yoder@nxp.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Kamil Debski <kamil@wypas.org>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Peter Hutterer <peter.hutterer@who-t.net>

Some Logitech mouses (MX Anyware 2, MX Master) have a wheel with two
resolutions. It initializes in low resolution mode, but can be changed to high
resolution. It also supports free wheel mode, where there's no tactile
feedback at the wheel, nor it offers resistence to movements. Such mode is
enabled/disabled by clicking at the wheel (on this wheel, the middle button
is a separate button).

Add support for it.

PS.: this patch series come after a patch series I sent during the weekend,
with converts the input documentation to ReST format:

    [PATCH 00/33] Convert input documentation to ReST
    https://www.spinics.net/lists/linux-input/msg50659.html

Both patch series can be seen at:
   https://git.linuxtv.org/mchehab/experimental.git/log/?h=input-docs

And the documentation, formatted in HTML, at:
   https://www.infradead.org/~mchehab/kernel_docs/input/

Mauro Carvalho Chehab (4):
  input: add an EV_REL event for high-res vertical wheel
  input: add a EV_SW event for ratchet switch
  hid-logitech-hidpp: add support for high res wheel
  hid-logitech-hidpp: add support for ratchet switch

 Documentation/input/event-codes.rst    |  32 ++++-
 drivers/hid/hid-logitech-hidpp.c       | 218 +++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h        |   2 +-
 include/uapi/linux/input-event-codes.h |   5 +-
 4 files changed, 252 insertions(+), 5 deletions(-)

-- 
2.9.3


