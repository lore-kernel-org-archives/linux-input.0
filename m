From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] input: hp_sdc_rtc should depend on serio
Date: Fri, 3 Apr 2009 15:16:21 +0400
Message-ID: <20090403111621.GA29023@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:49606 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680AbZDCLQg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Apr 2009 07:16:36 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Fix this build error when CONFIG_SERIO is not set
hp_sdc_rtc.c:691: undefined reference to `hp_sdc_request_timer_irq'
and so on..

"select should be used with care. select will force
a symbol to a value without visiting the dependencies."

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/input/misc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 203abac..ae5d7dc 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -215,6 +215,7 @@ config INPUT_SGI_BTNS
 config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on GSC || HP300
+	select SERIO
 	select HP_SDC
 	help
 	  Say Y here if you want to support the built-in real time clock
