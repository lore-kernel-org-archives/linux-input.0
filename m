From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] Input: joydev fixes for 4.12
Date: Fri,  9 Jun 2017 13:35:46 -0700
Message-ID: <20170609203547.17691-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33253 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdFIUfv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 16:35:51 -0400
Received: by mail-qt0-f173.google.com with SMTP id u12so88858942qth.0
        for <linux-input@vger.kernel.org>; Fri, 09 Jun 2017 13:35:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

Earlier this week a user reported issues on 4.12 with DS3/DS4 for
which the motion sensor devices are picked up by joydev. In 4.12, the
hid-sony driver moved the motion sensors to a separate device node.
This patch makes blacklists accelorometer devices as they don't make
sense for classic joystick applications.

Thanks,
Roderick

Roderick Colenbrander (1):
  Input: joydev - ignore accelerometer devices

 drivers/input/joydev.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.9.3

