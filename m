From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 0/8] i2c: Host Notify / i801 fixes
Date: Mon, 10 Oct 2016 18:42:27 +0200
Message-ID: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbcJJQmm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Oct 2016 12:42:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram, Dmitry,

this is a respin of the series "i2c: Host Notify / i801 fixes".
The changes have been driven by Dmitry who made me realise that using
.alert() was not good, while using an irqchip was a much better choice.

I have dropped in the series the fixes for i2c-smbus given that the code
gets removed. This new code is IMO simpler and provide a better interface
for everybody (adapter and clients), see patch 8/8.

Dmitry, the changes in the Elan driver are simple enough, and I wonder if
they could not go through Wolfram's tree. I have other pending patches for
elan_i2c (trackstick and binding from PS/2) so maybe this might not be the
best solution to have the I2C tree taking the changes.
Also, if this gets merged, that would mean for RMI4, only the HID backend
will not be using IRQ, but we could do the same IRQ reporting than here.

Cheers,
Benjamin

Benjamin Tissoires (8):
  i2c: i801: store and restore the SLVCMD register at load and unload
  i2c: i801: minor formatting issues
  i2c: i801: use BIT() macro for bits definition
  i2c: i801: use the BIT() macro for FEATURES_* also
  i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0
  i2c: use an IRQ to report Host Notify events, not alert
  Input: elan_i2c - store the irq in struct elan_tp_data
  Input: elan_i2c - add Host Notify support

 Documentation/i2c/smbus-protocol    |  10 +--
 drivers/i2c/busses/i2c-i801.c       | 120 ++++++++++++++++++------------------
 drivers/i2c/i2c-core.c              | 117 +++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-smbus.c             | 102 ------------------------------
 drivers/input/mouse/elan_i2c_core.c |  49 +++++++++++----
 include/linux/i2c-smbus.h           |  27 --------
 include/linux/i2c.h                 |   5 ++
 7 files changed, 224 insertions(+), 206 deletions(-)

-- 
2.7.4

