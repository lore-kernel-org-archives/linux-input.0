From: <mika.penttila@nextfour.com>
Subject: [PATCH v3 0/2] Input: SiS 9200 family I2C touchscreen controller driver
Date: Thu, 4 Feb 2016 13:53:38 +0200
Message-ID: <1454586820-22157-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-am1on0087.outbound.protection.outlook.com ([157.56.112.87]:16360
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753377AbcBDLxy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Feb 2016 06:53:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com

Hi,

v3 of the SiS I2C touch patch includes only cleanups and
acks from SiS folks. Bases on v4.5-rc2.

Thanks,
Mika


[PATCH v3 1/2] Input: Driver for SiS 9200 family I2C touchscreen controller.
[PATCH v3 2/2] Input: SiS 9200 documentation parts.

 .../devicetree/bindings/input/touchscreen/sis_i2c.txt     |  22 ++
 Documentation/devicetree/bindings/vendor-prefixes.txt     |   1 +
 drivers/input/touchscreen/Kconfig                         |  11 +
 drivers/input/touchscreen/Makefile                        |   1 +
 drivers/input/touchscreen/sis_i2c.c                       | 493 ++++++++++++++++++++++++
 5 files changed, 528 insertions(+)


