From: <mika.penttila@nextfour.com>
Subject: [PATCH RESEND 0/2] Input: SiS 9200 family I2C touchscreen controller driver
Date: Wed, 13 Jan 2016 07:51:51 +0200
Message-ID: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db3on0095.outbound.protection.outlook.com ([157.55.234.95]:59016
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751369AbcAMHYb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 02:24:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com, mika.penttila@nextfour.com

Hi,

Here are the patches for SiS 9200 I2C multitouch controller.
Rebased on linux-4.4.0, please consider for inclusion.

Signed-off-by: mika.penttila@nextfour.com

Thanks,
Mika

Mika Penttil=C3=A4 (2):
     Driver for SiS 9200 family multitouch controller.
     Documentation and MAINTAINERS parts.


 drivers/input/touchscreen/Kconfig   |  11 ++
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sis_i2c.c | 583 ++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++
 drivers/input/touchscreen/sis_i2c.h | 141 ++++++++++++++
 4 files changed, 736 insertions(+)
 create mode 100644 drivers/input/touchscreen/sis_i2c.c
 create mode 100644 drivers/input/touchscreen/sis_i2c.h


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
