From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] [PATCH] Input: i8042 - Fix console keyboard support on
Date: Tue, 14 Jun 2016 05:45:50 +0900
Message-ID: <20160613204551.1746-1-mdl@60hz.org>
References: <20160613143841.531-2-mdl@60hz.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36722 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422893AbcFMUqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2016 16:46:13 -0400
Received: by mail-pf0-f178.google.com with SMTP id t190so49537984pfb.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2016 13:46:13 -0700 (PDT)
In-Reply-To: <20160613143841.531-2-mdl@60hz.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mark Laws <mdl@60hz.org>, kys@microsoft.com, dmitry.torokhov@gmail.com, arjan.van.de.ven@intel.com

Small fix to drivers/input/keyboard/Kconfig: select SERIO_LIBI8042 (not
SERIO_I8042) under config KEYBOARD_ATKBD so that i8042 can be a module
when hyperv-keyboard is linked in.

Mark Laws (1):
  Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs

 drivers/input/keyboard/Kconfig |  2 +-
 drivers/input/serio/Kconfig    |  7 ++++-
 drivers/input/serio/Makefile   |  1 +
 drivers/input/serio/i8042.c    | 48 ---------------------------------
 drivers/input/serio/i8042.h    |  7 -----
 drivers/input/serio/libi8042.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/input/serio/libps2.c   |  2 +-
 include/linux/i8042.h          | 17 +-----------
 include/linux/libi8042.h       | 55 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 125 insertions(+), 74 deletions(-)
 create mode 100644 drivers/input/serio/libi8042.c
 create mode 100644 include/linux/libi8042.h

-- 
2.8.3

