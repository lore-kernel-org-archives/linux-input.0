From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] Input: elan - add support for SMBus Host Notify and trackstick
Date: Wed, 28 Sep 2016 16:34:00 +0200
Message-ID: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932362AbcI1OeJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 10:34:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

So it looks like Elantech devices also suffer from issues when used over PS/2.
They also appear to behave properly when used over SMBus. On many systems, these
touchpads are not enumerated by ACPI, but they are actually correctly working
(after a few fixes from this series).

I have been working with an owner to automatically bind the touchpad from PS/2,
but mentoring a new comer takes time. Anyway, right now, it looks like adding
"echo elan_i2c 0x15 > /sys/bus/i2c/devices/i2c-N/new_device" (N being the SMBus
adapter number) at boot works well enough to have the touchpad bound.

Currently the trackstick needs to be manually added by an extra patch but the
information should be provided through PS/2 when the rest of the series comes.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1326577
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1313939

Cheers,
Benjamin

Benjamin Tissoires (4):
  Input: elan_i2c - fix return tests of i2c_smbus_read_block_data()
  Input: elan_i2c - always output the device information
  Input: elan_i2c - add Host Notify support
  Input: elan_i2c - add trackstick report

 drivers/input/mouse/elan_i2c.h       |  10 ++
 drivers/input/mouse/elan_i2c_core.c  | 193 ++++++++++++++++++++++++++++++-----
 drivers/input/mouse/elan_i2c_smbus.c |   6 +-
 3 files changed, 180 insertions(+), 29 deletions(-)

-- 
2.7.4

