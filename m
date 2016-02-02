From: <mika.penttila@nextfour.com>
Subject: [PATCH v2 0/2] Input: SiS 9200 family I2C touchscreen controller driver
Date: Tue, 2 Feb 2016 09:06:11 +0200
Message-ID: <1454396773-29079-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-am1on0087.outbound.protection.outlook.com ([157.56.112.87]:12832
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752378AbcBBHG1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 02:06:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com

Hi,

Here are the refreshed patches for SiS 9200 I2C multitouch controller.
Rebased on 4.5.0-rc2.

Thanks,
Mika

[PATCH v2 1/2] Input: Driver for SiS 9200 family I2C touchscreen controller.
[PATCH v2 2/2] Input: SiS 9200 documentation parts.


 .../devicetree/bindings/input/touchscreen/sis_i2c.txt     |  22 +
 Documentation/devicetree/bindings/vendor-prefixes.txt     |   1 +
 drivers/input/touchscreen/Kconfig                         |  11 +
 drivers/input/touchscreen/Makefile                        |   1 +
 drivers/input/touchscreen/sis_i2c.c                       | 537 ++++++++++++++++++++++++
 5 files changed, 572 insertions(+)


