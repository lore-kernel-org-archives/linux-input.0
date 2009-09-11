From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] Series short description
Date: Thu, 10 Sep 2009 22:41:48 -0700
Message-ID: <20090911054136.27115.20927.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:33665 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZIKFlv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:41:51 -0400
Received: by pxi27 with SMTP id 27so618074pxi.15
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:41:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rjw@sisk.pl

The following series implements...

---

Dmitry Torokhov (2):
      Input: atkbd - rely on input core to restore state on resume
      Input: libps2 - additional locking for i8042 ports


 drivers/input/input.c           |   64 ++++++++++++++++++++++++++++++++++++++-
 drivers/input/keyboard/atkbd.c  |   25 ---------------
 drivers/input/mouse/sentelic.c  |   18 ++++++-----
 drivers/input/serio/i8042.c     |   40 ++++++++++++++++++++++++
 drivers/input/serio/libps2.c    |   28 +++++++++++++++--
 drivers/leds/leds-clevo-mail.c  |    8 +++++
 drivers/platform/x86/acer-wmi.c |    2 +
 include/linux/i8042.h           |   30 ++++++++++++++++++
 include/linux/input.h           |    2 +
 include/linux/libps2.h          |    2 +
 10 files changed, 180 insertions(+), 39 deletions(-)

-- 
Signature
