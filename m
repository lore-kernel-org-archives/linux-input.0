From: <mika.penttila@nextfour.com>
Subject: [PATCH v4 0/2] Input: SiS 9200 family I2C touchscreen controller driver
Date: Tue, 1 Mar 2016 10:32:18 +0200
Message-ID: <1456821140-26720-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db3on0067.outbound.protection.outlook.com ([157.55.234.67]:25440
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751200AbcCAIcn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Mar 2016 03:32:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com

Hi,

Here are the v4 patches for SiS 9200 I2C multitouch controller.
All the issues from the review are addressed.

Rebased on 4.5.0-rc6.

Thanks,
Mika

[PATCH v2 1/2] Input: Driver for SiS 9200 family I2C touchscreen controller.
[PATCH v2 2/2] Input: SiS 9200 documentation parts.


 .../devicetree/bindings/input/touchscreen/sis_i2c.txt    |  22 ++
 Documentation/devicetree/bindings/vendor-prefixes.txt    |   1 +
 drivers/input/touchscreen/Kconfig                        |  11 +
 drivers/input/touchscreen/Makefile                       |   1 +
 drivers/input/touchscreen/sis_i2c.c                      | 461 ++++++++++++++++++++++++
 5 files changed, 496 insertions(+)

