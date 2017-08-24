From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v3 0/4] Input/HID: introduce joydev ignore feature
Date: Thu, 24 Aug 2017 16:11:49 -0700
Message-ID: <20170824231153.8809-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:37776 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbdHXXMA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Aug 2017 19:12:00 -0400
Received: by mail-qt0-f180.google.com with SMTP id d15so4510074qta.4
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2017 16:11:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

This is a revised version of a patch set, which was originally meant
to prevent devices ds3/ds4 motion sensors to get picked up by joydev.

Originally we added a filter based on INPUT_PROP_ACCELEROMETER, but
in review it was felt not to be narrow enough. It was suggested to
only limit in case of composite devices, which led to a revised
series.

The v2 series added a new property INPUT_PROP_COMPOSITE based on the
feedback, but the discussion led to the ability to enumerate composite
devices (a very useful use case) e.g. by means of an ioctl.

Tackling the composite device problem is an interesting problem, but
needs a bit of thought. For ds3/ds4 in particular, we have reports
(even on reddit) of various users having problems with joydev picking
up the device, so ideally for 4.14 (and maybe even 4.13) we need some
solution as it will be used in the next wave of distributions.

For v3, we are going back to the basics. Instead as Bastien suggested
we are adding a flag INPUT_PROP_JOYDEV_IGNORE, which devices can use
to get blacklist from joydev. We think such a flag is helpful as the
heuristics in joydev are generic and in some exceptional cases it is
tricky to find a generic way to narrow devices down. In addition
as requested by Bastien we are also setting the ignore flag for the
udraw-ps3 driver.

Thanks,
Roderick

Roderick Colenbrander (4):
  Input: Add new property INPUT_PROP_JOYDEV_IGNORE
  HID: sony: Set INPUT_PROP_JOYDEV_IGNORE flag for motion sensors.
  HID: udraw-ps3: Set INPUT_PROP_JOYDEV_IGNORE for motion sensor
  Input: joydev - ignore devices which don't want joydev

 Documentation/input/event-codes.rst    | 9 +++++++++
 drivers/hid/hid-sony.c                 | 1 +
 drivers/hid/hid-udraw-ps3.c            | 1 +
 drivers/input/joydev.c                 | 4 ++++
 include/uapi/linux/input-event-codes.h | 1 +
 5 files changed, 16 insertions(+)

-- 
2.9.4

