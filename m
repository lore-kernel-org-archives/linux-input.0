From: <mika.penttila@nextfour.com>
Subject: [PATCH 0/2] INPUT: SiS 9200 family I2C touchscreen controller driver
Date: Mon, 23 Nov 2015 14:01:33 +0200
Message-ID: <1448280095-27680-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db3on0080.outbound.protection.outlook.com ([157.55.234.80]:31280
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750853AbbKWMf5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 07:35:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com

Hi,

Here are patches for SiS 9200 family of multitouch controller.         =
            =20
They are in use on a soon to be published ARM- based product.

Patches are based on some early work from SiS for Android.
Compared to some previous versions this has complete configuration
via bindings from device tree (reset and irq gpios) and the=20
bindings are documented.

MT-B protocol handling/state is done with mt stack so no
driver level housekeeping needed.

=46eedback from SiS folks and others appreciated...

Thanks,
Mika

Mika Penttil=C3=A4 (2):
      Driver for SiS 9200 family I2C touchscreen controller.
      Documentation parts and maintainers entry.


 .../devicetree/bindings/input/touchscreen/sis_i2c.txt  |  22 +
 Documentation/devicetree/bindings/vendor-prefixes.txt  |   1 +
 MAINTAINERS                                            |   7 +
 drivers/input/touchscreen/Kconfig                      |  11 +
 drivers/input/touchscreen/Makefile                     |   1 +
 drivers/input/touchscreen/sis_i2c.c                    | 583 +++++++++=
++++++++++++++
 6 files changed, 625 insertions(+)


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
