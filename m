From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/2] input: Add CSR SiRFSoC internal touchscreen driver
Date: Mon, 23 Jun 2014 17:42:59 +0800
Message-ID: <1403516581-12560-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37541 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaFWJoJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 05:44:09 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so5685532pad.28
        for <linux-input@vger.kernel.org>; Mon, 23 Jun 2014 02:44:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

patch "lib: int_sqrt: add int64_sqrt routine" add a int64_sqrt() API
which CSR SiRFSoC internal touchscreen driver needs. and patch "input:
sirfsoc_rs - add sirfsoc internal ADC-based touchscreen driver" adds
the new driver.

Guoying Zhang (1):
  input: sirfsoc_rs - add sirfsoc internal ADC-based touchscreen driver

Yibo Cai (1):
  lib: int_sqrt: add int64_sqrt routine

 drivers/input/touchscreen/Kconfig      |  10 +
 drivers/input/touchscreen/Makefile     |   1 +
 drivers/input/touchscreen/sirfsoc_ts.c | 658 +++++++++++++++++++++++++++++++++
 include/linux/kernel.h                 |   1 +
 lib/int_sqrt.c                         |  27 ++
 5 files changed, 697 insertions(+)
 create mode 100644 drivers/input/touchscreen/sirfsoc_ts.c

-- 
1.9.3

