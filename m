From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 0/6] HID: sony: Various minor 4.12 fixes and improvements
Date: Fri, 24 Mar 2017 15:17:44 -0700
Message-ID: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36924 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdCXWRz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:17:55 -0400
Received: by mail-it0-f53.google.com with SMTP id 190so3885279itm.0
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:17:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

This patch series contains a couple of small fixes and improvements
for DS3, DS4 and navigation controller.

DS3 changes:
- Use MAC address as unique identifier

DS4 changes:
- Use brighter default LED colors.
- Bit flag improvements on DS4 output report.
- Make the DS4 BT poll interval adjustable. The device used 1kHz
  previously and now we default to 4ms (250Hz) which is the same
  as USB. Users can override behaviour through sysfs.

Navigation changes:
- Fix the axis/button mapping and hide axes and buttons which are
  not physically available although they are in the report, because
  the device utilizes the DS3 HID reports.

Thanks,
Roderick

Roderick Colenbrander (6):
  HID: sony: Use DS3 MAC address as unique identifier on USB
  HID: sony: Improve navigation controller axis/button mapping
  HID: sony: DS4 use brighter LED colors
  HID: sony: Set proper bit flags on DS4 output report
  HID: sony: Make DS4 bt poll interval adjustable
  HID: sony: Make sure to unregister sensors on failure

 drivers/hid/hid-sony.c | 286 +++++++++++++++++++++++++++++--------------------
 1 file changed, 167 insertions(+), 119 deletions(-)

-- 
2.9.3

