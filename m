From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs
Date: Sat, 23 Apr 2016 02:30:15 +0900
Message-ID: <1461346216-55780-1-git-send-email-mdl@60hz.org>
References: <20160422131746.GI4298@mwanda>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36508 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbcDVRan (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2016 13:30:43 -0400
Received: by mail-pa0-f67.google.com with SMTP id i5so9134082pag.3
        for <linux-input@vger.kernel.org>; Fri, 22 Apr 2016 10:30:43 -0700 (PDT)
In-Reply-To: <20160422131746.GI4298@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: haiyangz@microsoft.com, dan.carpenter@oracle.com
Cc: Mark Laws <mdl@60hz.org>, devel@linuxdriverproject.org, linux-input@vger.kernel.org

A few tripels later and the patch has been completely rewritten.
The problem symbols have been moved to a new module, libi8042.c, which
both libps2.c and i8042.c use.  libps2.c no longer depends on i8042.c,
and i8042.c no longer needs the gross hack of the previous patch.

Since I didn't write anything new, just shuffled things around, I
haven't changed any copyrights.  I have no idea what the right procedure
is here, so please let me know, since I'm probably screwing up somehow.

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
2.8.0

