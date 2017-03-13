From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/7] Input: fix NULL-derefs at probe
Date: Mon, 13 Mar 2017 13:35:32 +0100
Message-ID: <20170313123539.28103-1-johan@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34599 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdCMMgL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 08:36:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

This series fixes a number of NULL-pointer dereferences due to missing
endpoint sanity checks that can be triggered by a malicious USB device.

Johan


Johan Hovold (7):
  Input: iforce - fix NULL-deref at probe
  Input: cm109 - fix NULL-deref at probe
  Input: ims-pcu - fix NULL-deref at probe
  Input: yealink - fix NULL-deref at probe
  Input: hanwang - fix NULL-deref at probe
  Input: kbtab - fix NULL-deref at probe
  Input: sur40 - fix NULL-deref at probe

 drivers/input/joystick/iforce/iforce-usb.c | 3 +++
 drivers/input/misc/cm109.c                 | 4 ++++
 drivers/input/misc/ims-pcu.c               | 4 ++++
 drivers/input/misc/yealink.c               | 4 ++++
 drivers/input/tablet/hanwang.c             | 3 +++
 drivers/input/tablet/kbtab.c               | 3 +++
 drivers/input/touchscreen/sur40.c          | 3 +++
 7 files changed, 24 insertions(+)

-- 
2.12.0

