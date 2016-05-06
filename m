From: <mika.penttila@nextfour.com>
Subject: [PATCH v5 0/2] Input: SiS 9200 family I2C touchscreen controller driver
Date: Fri, 6 May 2016 08:22:15 +0300
Message-ID: <1462512137-28807-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

Hi,

Here are the v5 patches for SiS 9200 I2C multitouch controller.
All the issues raised so far are addressed in this version.

Rebased on 4.6.0-rc6.

Thanks,
Mika

[PATCH v5 1/2] Input: Driver for SiS 9200 family I2C touchscreen controller.
[PATCH v5 2/2] Input: SiS 9200 documentation parts.

 .../devicetree/bindings/input/touchscreen/sis_i2c.txt    |  22 ++
 Documentation/devicetree/bindings/vendor-prefixes.txt    |   1 +
 drivers/input/touchscreen/Kconfig                        |  12 +
 drivers/input/touchscreen/Makefile                       |   1 +
 drivers/input/touchscreen/sis_i2c.c                      | 461 ++++++++++++++++++++++++
