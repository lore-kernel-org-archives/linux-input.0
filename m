From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs
Date: Mon, 13 Jun 2016 23:38:40 +0900
Message-ID: <20160613143841.531-1-mdl@60hz.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36855 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbcFMOjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2016 10:39:18 -0400
Received: by mail-pa0-f65.google.com with SMTP id fg1so10636095pad.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2016 07:39:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mark Laws <mdl@60hz.org>, kys@microsoft.com, haiyangz@microsoft.com, dmitry.torokhov@gmail.com

Some minor reorganizations to i8042.c in order to fix a bug that could prevent
the keyboard from working at the Hyper-V virtual console (see patch for a more
detailed explanation).

Thanks for looking this over, KY--sorry for the delay in resending it!

Mark Laws (1):
  Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs

 drivers/input/serio/Kconfig    |  7 ++++-
 drivers/input/serio/Makefile   |  1 +
 drivers/input/serio/i8042.c    | 48 ---------------------------------
 drivers/input/serio/i8042.h    |  7 -----
 drivers/input/serio/libi8042.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/input/serio/libps2.c   |  2 +-
 include/linux/i8042.h          | 17 +-----------
 include/linux/libi8042.h       | 55 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 124 insertions(+), 73 deletions(-)
 create mode 100644 drivers/input/serio/libi8042.c
 create mode 100644 include/linux/libi8042.h

-- 
2.8.3

