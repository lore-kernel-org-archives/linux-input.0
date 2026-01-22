Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6322D0C94
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086193; cv=none; b=fFvsTi0SCFe9vrGXuATkr1G2rb/XtZ8o4uvcI8NPkLrWMH6Ob8zfb+O0SVMN9OEllTeaFKCjekWFjgCXQOO9dGHsMpLuDQ67yS6xxZhStpBruGrAB0AlDZYdGqDLjENorz+ixF/NRoqzMVqHRK2dOTNY57g9oHgvH/IXVs670bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086193; c=relaxed/simple;
	bh=6SwBFIzoAvyd6PedNOXfyh0xiT0W+ooeNO88QPYIEmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXzC+QDR/bBIPvY/U5RcX1JB6M5nMe79XmNhuqeaK4Ih2dplo8L36eXVlRTPwwgjP4R1IOAuwL3YM9OwLEHV7BsBBZHIYeIwb3PKrzTIhixUOhEuq7KZxZHwBrtVDUsmyKFLD2e4IYaHRUNpnCJW+2mvuKoI85vpilB3vLI1BcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021097.outbound.protection.outlook.com [52.101.95.97])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-11-XIkvaretNb-YmThZZ8NSNw-1; Thu,
 22 Jan 2026 12:48:37 +0000
X-MC-Unique: XIkvaretNb-YmThZZ8NSNw-1
X-Mimecast-MFC-AGG-ID: XIkvaretNb-YmThZZ8NSNw_1769086117
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LOAP123MB8292.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 12:48:36 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:48:36 +0000
From: AThomas63 <andrew.thomas@touchnetix.com>
To: dmitry.torokhov@gmail.com
CC: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.satterthwaite@touchnetix.com,
	andrew.thomas@touchnetix.com,
	m.felsch@pengutronix.de,
	kamel.bouhara@bootlin.com
Subject: [PATCH 1/1] Adding support for aXiom touchscreen controller
Date: Thu, 22 Jan 2026 12:48:19 +0000
Message-ID: <20260122124819.273188-2-andrew.thomas@touchnetix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
X-ClientProxiedBy: LO4P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::7) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LOAP123MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 9029e896-46da-40ca-23e1-08de59b48ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|18082099003
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YvXZp1IFemgkhDxPOJz9q21TUYR+U+q/hLqboIXt1I4/HNTgKonrYVIx14gx?=
 =?us-ascii?Q?djKxVtIxR5bucFKRtfY2qVF9Llu0HM2ipurpdJ+eC/keBGMfQ93NcT8o3UH7?=
 =?us-ascii?Q?j+iU2+mBMckhmkA1Z7bKxaEtsjkD8xEC5SQbXH+fxdfwq3UZ++7M1BobTL1l?=
 =?us-ascii?Q?3/ZafPRxtmoAiNTWTf8BF60dRhTJBbc7C/ne9qHzUtzCpkk+roGBjtXb/yhE?=
 =?us-ascii?Q?r6QIZCOrgTYZNMslQuxHLC3WXjANuRXmNZfWgGrA7Svb2ZDGztEvDaPDt0Jo?=
 =?us-ascii?Q?vIr/Giw8WRmUFJdd57/Dd7oOzro8a9XvA6o9NiXtWY6gb339mdPluaBYWvNk?=
 =?us-ascii?Q?fhUJT8aLjSv6bcwePzNcz2otEaCagi6k0e1Qh7Qpz0QRTY4++2YBJ3zRxfKn?=
 =?us-ascii?Q?yNdJoHNCBgPQc9xUqiS9B6giN/S6gTCluwcVng4WrjagQACI9CtUMMokOmPA?=
 =?us-ascii?Q?B49cv01VwDWMPXlLMBLGdsrUxw8mhC8l90/Epo7uEyqJ+ifGqM2QhKV89ejL?=
 =?us-ascii?Q?l0BQVimBPtAFWjbSd78EuXGO/rpneVyZ5PjRcNJRsJVr1YDdtBZqpXeKobJF?=
 =?us-ascii?Q?vyjKKXc/nIHzclz0fXM9gXLRJJiNYwXkKe1TVCMqT0ET6F7x5DEtl/2lKuhg?=
 =?us-ascii?Q?fTgiF+hajdiLK/tEYhwG5RQp1swprbVb7tn05Bj2TXuqkyodHuUUsB+XIMBy?=
 =?us-ascii?Q?QU1jlWkIvFtTkujmd3XWVTkFmZccQAm1rrw8kyZQe73pqpZyKPt9bXQxf0bQ?=
 =?us-ascii?Q?tsL298aVZ8129XNEk8sBI00WiFRDrg4sffnxfFICa+77I0P3LQR9yJs3eXsQ?=
 =?us-ascii?Q?pPAa2/eBel4p3eu32JJ6IYhmMW7tB2lWQ+q9CrZoTurg2gCw56Q/B8iyCYCb?=
 =?us-ascii?Q?I3yXGKa87coTjJnjpNCHrUX0e6c3JPxEGEN9NC5WQmd8aLz1VnMUfU9ekUKq?=
 =?us-ascii?Q?OZySjfp3gsSqN66YawsdcY9TyTUDI6ByN80pTtbHtqfcP3bkHm4gPAFCrNVQ?=
 =?us-ascii?Q?7plCKyYjudHlFakUAW9JgQ60K6HEdgqjrgKKlz26MSH1Y6RuweUBzHL1ew6m?=
 =?us-ascii?Q?9YVa4iKERUBsNqie0LAp9wgRvIRP3CCAz37eBO7Wxres6pjJSeFwGzK6nC3P?=
 =?us-ascii?Q?llnYFZioDD7fx72Sez93UnSoLXkGmx9IMK7AC1WmIZd1t5yylZC89CukGe8i?=
 =?us-ascii?Q?qB/tMtpH7gfkHTypB72JWzWBTsg6RJ/WPgADQ93OgfGPYC54v3aA+KmK11G2?=
 =?us-ascii?Q?qj6/l0sQq3H+xebTMdzrhU7XkaLKc+Z9lrX6TPVtqenw6lPqXCyh2VrOodCc?=
 =?us-ascii?Q?aLXSm7qK8kJbMLVikjF4k/xRgMmqodYn67hdgLYYvCY+T82H4BKfj1MrvOlp?=
 =?us-ascii?Q?6qwfb7o8KbCragba92DYkWpeTSi8SQuYgLGt9flaNT3dAnnZvZOpkdBBbc1v?=
 =?us-ascii?Q?fGTpEa9iyr7okioYajKxSRxxjdcFCi+2pR5jFzeHAL0OjvS/ALLUwZNfO4z/?=
 =?us-ascii?Q?zDfxC066kugccCwh1SsMUbWf0f6zdJy5cJ2tM/zkXYiiQ+6FFfJrLCBw1vya?=
 =?us-ascii?Q?H6AplQ8NJ8MaMQwvh0FgQe0Sd5DqYdTLzL2yqcUZbPScN0qXd7DWcDI0LNCM?=
 =?us-ascii?Q?KO7bYmwXDwII2m7Jbpd56Xg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18082099003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCm1JeMyuxcjumJa6AIKAS/CgEdqz9XJAX5fHcwpXv6y+BKAv5QDVLxj4HBi?=
 =?us-ascii?Q?R8gKLhub3PbxF+g5WS9tpVMPKC24fPc1ZC46SIlJ/NrXdqeeWsR+4mWQJN6r?=
 =?us-ascii?Q?OFKEZef32N/9EpYBh0TGprKDsPlFnY/YrVAL5TG/qoIO3qJsWZAJGJ1OI0dY?=
 =?us-ascii?Q?qc4ecwBXb6gC5isr0MMje+wgKeub2Zn9Ffp6+xX4500ERb6TiWC4oT9PBP6f?=
 =?us-ascii?Q?s9/f+uj7OCAr82p15ipGor0UTACYqsj48GDesN68TjRaC9Zy85jHkiC5DAPA?=
 =?us-ascii?Q?6baKYkRUskfutjYc9JN01GmdpH13am9NvjC9qIDRXBkFpOWJ2oU+Tu0jrVvp?=
 =?us-ascii?Q?w+Ph18U2B99iNt9rHZixIukl30Q+HDgJuObTP3vDNvhDWiErhK7X1+BKEKJQ?=
 =?us-ascii?Q?qYtDci12HqqYkFcgVbTG86yDSa4gMpi6nM6nN5wEFOZuz3txGm97yR88Dsjb?=
 =?us-ascii?Q?xb4Lrik4qrR0kfSJig3OdNoFGZEFJenF01KmTMPVboIJlvGmkZGcZZ8ZIEdW?=
 =?us-ascii?Q?gFKGHgsDFUhYPe8I9jfdKYi/vupFgZZlaaEb0oDQmtb9CJX+xlvNlcGPR9uE?=
 =?us-ascii?Q?dPHLut4T053AFDx3d+oL8WpOOWM5vKAYKFNOMTdVayhEuLlXU21v+FLxG1z/?=
 =?us-ascii?Q?N7ZtCV8QSZlfJc8c/BtEWtyvHFFhACcvTyuN/2Kk+fbkgtwwLNTLFOSV7vdX?=
 =?us-ascii?Q?9MaVtAtTDeKOaadC/8wnVomGji7ua88GWCCLyO3jZV8wWwiYDHj03ZnKvYxK?=
 =?us-ascii?Q?K7M4l6EB0cwW2SZsXPUvx036rcFcsp5gkfr3+lDd3Sg/UZcPOIXiSbXGhta2?=
 =?us-ascii?Q?F22HXTbBG3hNe1mEY7QcblkejChklDLDKOiE9n7WbengnrjRsn4hPUdg3Zji?=
 =?us-ascii?Q?6sVLSS0XN7SJOtiYuz07mZWz/oMekKu8q/R8BDEexYEPPpuzuOc8NUmBLTi4?=
 =?us-ascii?Q?1+yOiwuSgMbFcJbaQ6hn2MS3M0OOnxZN3Z4PWiFJsKGqo2LFVghQoJydUZjE?=
 =?us-ascii?Q?KbzIUOByZFi4qQq5LXZZypBW8NMJ86twshPxJ2wmfPRu2g5ZZSxX5ZPvt+0g?=
 =?us-ascii?Q?8CUK5aCqMpxRmLEQX/MsxBlh5qQ632pu4CyhuyuqD4BIi75fH8i/mCWyt7Px?=
 =?us-ascii?Q?+7vNUwP2PisMd0BzOuYe5t7LR+eB26ji7B21cQTi6iSZ0/KGNuVlFtEEASzs?=
 =?us-ascii?Q?WetRImiZ0wbecxlAl0JcpGlGrtczxZCtLJS93W44IbhC3vdOpXL6q1+U79du?=
 =?us-ascii?Q?7pqeaTqMhDFXKMyVe/BozOmRm29I6/0kh2APT65wKxUGUkwccNNTDWxl9lZJ?=
 =?us-ascii?Q?+4WSOXFaIJBfD9cvq4fElKTq7PTq1GgR0TV8zpxd+JoACiRzJilDB/o5Gm9Q?=
 =?us-ascii?Q?1h7yetBDrEc6MwVQlF/IY/vXE48NmJVUgoy8RIBdocb2YvBnzr/++3UQCksJ?=
 =?us-ascii?Q?KM25N3pAHtn9KqQexgH5gi5NFmqW3+FJrUDsZPOlG3wpyVAbmL8Trn5Vg585?=
 =?us-ascii?Q?P1Rmo45CP7+z/g1bcpQi44UF1VW3fbQbPRG+HDudWfjACzZIdHwoLYOLtnyH?=
 =?us-ascii?Q?fbFHveczDCERNhx0gqOQ/wjcm0jhBeIDn/VRwcpweyTKuQKSbt+kZX89+8m3?=
 =?us-ascii?Q?kYQGYRyGONzvsF2CFqus31neRQoNMFpIyvk2UEWzbBg5kzBMBuBD9rpbPNKh?=
 =?us-ascii?Q?gb3YWuPThKGzfoZOp585fU1fvqaO0F4pB9/sSWUxJvous4wVwXJn7D6A4PNw?=
 =?us-ascii?Q?wmEsh6dKe0GXF0bl2qoJSaOQKOVso5Y=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029e896-46da-40ca-23e1-08de59b48ed8
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:48:35.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yddozgPypgaHESzoIE2I0V59K+2HF6eFyGPC+E8rGadOiko7s88zHxvT3SY0zge29sA26Dd7gFaqt4+J9ff/VbMo4F5vLTXcqMqvSWJSUYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8292
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9HR6Q-OlE6LoOg3WDZ6JedGOk6kkruCynCIuQj7xTfk_1769086117
X-Mimecast-Originator: touchnetix.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252

Signed-off-by: AThomas63 <andrew.thomas@touchnetix.com>
---
 drivers/input/touchscreen/Kconfig      |  30 ++
 drivers/input/touchscreen/Makefile     |   3 +
 drivers/input/touchscreen/axiom_core.c | 482 +++++++++++++++++++++++++
 drivers/input/touchscreen/axiom_core.h | 128 +++++++
 drivers/input/touchscreen/axiom_i2c.c  | 152 ++++++++
 drivers/input/touchscreen/axiom_spi.c  | 159 ++++++++
 6 files changed, 954 insertions(+)
 create mode 100644 drivers/input/touchscreen/axiom_core.c
 create mode 100644 drivers/input/touchscreen/axiom_core.h
 create mode 100644 drivers/input/touchscreen/axiom_i2c.c
 create mode 100644 drivers/input/touchscreen/axiom_spi.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 7d5b72ee07fa..f2b4fb317bdd 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -162,6 +162,36 @@ config TOUCHSCREEN_AUO_PIXCIR
 =09  To compile this driver as a module, choose M here: the
 =09  module will be called auo-pixcir-ts.
=20
+config TOUCHSCREEN_AXIOM_CORE
+=09tristate "TouchNetix Axiom touchscreen"
+=09help
+=09  Say Y here if you have an Axiom touchscreen connected
+=09  to your system. You will also need to select appropriate
+=09  bus connection below.
+
+=09  If unsure, say N.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called axiom_core.
+
+config TOUCHSCREEN_AXIOM_I2C
+=09tristate "support I2C bus connection"
+=09depends on TOUCHSCREEN_AXIOM_CORE && I2C
+=09help
+=09  Say Y here if the touchscreen is connected via I2C bus.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called axiom_spi.
+
+config TOUCHSCREEN_AXIOM_SPI
+=09tristate "support SPI bus connection"
+=09depends on TOUCHSCREEN_AXIOM_CORE && SPI
+=09help
+=09  Say Y here if the touchscreen is connected via SPI bus.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called axiom_spi.
+
 config TOUCHSCREEN_BU21013
 =09tristate "BU21013 based touch panel controllers"
 =09depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index ab9abd151078..9b7d572c4589 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -19,6 +19,9 @@ obj-$(CONFIG_TOUCHSCREEN_APPLE_Z2)=09+=3D apple_z2.o
 obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)=09+=3D ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)=09+=3D atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)=09+=3D auo-pixcir-ts.o
+obj-$(CONFIG_TOUCHSCREEN_AXIOM_CORE)=09+=3D axiom_core.o
+obj-$(CONFIG_TOUCHSCREEN_AXIOM_I2C)=09+=3D axiom_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_AXIOM_SPI)=09+=3D axiom_spi.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)=09+=3D bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_BU21029)=09+=3D bu21029_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CHIPONE_ICN8318)=09+=3D chipone_icn8318.o
diff --git a/drivers/input/touchscreen/axiom_core.c b/drivers/input/touchsc=
reen/axiom_core.c
new file mode 100644
index 000000000000..7983effe40f7
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_core.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify i=
t
+ * under  the terms of  the GNU General  Public License as published by th=
e
+ * Free Software Foundation;  either version 2 of the  License, or (at you=
r
+ * option) any later version.
+ *
+ */
+
+// #define DEBUG // Enable debug messages
+
+#include <linux/device.h>
+#include <linux/input/mt.h>
+#include <linux/crc16.h>
+#include <linux/property.h>
+#include <linux/interrupt.h>
+#include <linux/unaligned.h>
+#include "axiom_core.h"
+
+/* u31 device info masks */
+#define AX_DEV_ID_MASK GENMASK(14, 0)
+#define AX_MODE BIT(15)
+#define AX_FW_REV_MINOR_MASK GENMASK(7, 0)
+#define AX_FW_REV_MAJOR_MASK GENMASK(15, 8)
+#define AX_VARIANT_MASK GENMASK(5, 0)
+#define AX_FW_STATUS BIT(7)
+#define AX_TCP_REV_MASK GENMASK(15, 8)
+#define AX_BOOT_REV_MINOR_MASK GENMASK(7, 0)
+#define AX_BOOT_REV_MAJOR_MASK GENMASK(15, 8)
+#define AX_NUM_USAGES_MASK GENMASK(7, 0)
+#define AX_SILICON_REV_MASK GENMASK(11, 8)
+#define AX_RUNTIME_FW_PATCH_MASK GENMASK(15, 12)
+
+/* u31 usage table entry masks */
+#define AX_U31_USAGE_NUM_MASK GENMASK(7, 0)
+#define AX_U31_START_PAGE_MASK GENMASK(15, 8)
+#define AX_U31_NUM_PAGES_MASK GENMASK(7, 0)
+#define AX_U31_MAX_OFFSET_MASK GENMASK(14, 8)
+#define AX_U31_OFFSET_TYPE_BIT BIT(15)
+#define AX_U31_UIF_REV_MASK GENMASK(7, 0)
+#define AX_U31_USAGE_TYPE_MASK GENMASK(15, 8)
+
+/* u34 report masks */
+#define AX_U34_LEN_MASK GENMASK(6, 0)
+#define AX_U34_OVERFLOW BIT(7)
+#define AX_U34_USAGE_MASK GENMASK(15, 8)
+#define AX_U34_PAYLOAD_BUFFER 2
+
+/* u41 report masks */
+#define AX_U41_PRESENT_MASK GENMASK(9, 0)
+#define U41_X_Y_OFFSET (2)
+#define U41_COORD_SIZE (4)
+#define U41_Z_OFFSET (42)
+
+static const char *const fw_variants[] =3D { "3D", "2D", "FORCE",
+=09=09=09=09=09   "0D", "XL", "TOUCHPAD" };
+
+static int axiom_set_capabilities(struct input_dev *input_dev)
+{
+=09input_dev->name =3D "TouchNetix aXiom Touchscreen";
+=09input_dev->phys =3D "input/axiom_ts";
+
+=09// Single Touch
+=09input_set_abs_params(input_dev, ABS_X, 0, 65535, 0, 0);
+=09input_set_abs_params(input_dev, ABS_Y, 0, 65535, 0, 0);
+
+=09// Multi Touch
+=09// Min, Max, Fuzz (expected noise in px, try 4?) and Flat
+=09input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
+=09// Min, Max, Fuzz (expected noise in px, try 4?) and Flat
+=09input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
+=09input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0)=
;
+=09input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
+=09input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
+
+=09input_mt_init_slots(input_dev, U41_MAX_TARGETS, INPUT_MT_DIRECT);
+
+=09return 0;
+}
+
+static struct u31_usage_entry *usage_find_entry(struct axiom *ax, u16 usag=
e)
+{
+=09u16 i;
+
+=09for (i =3D 0; i < ax->dev_info.num_usages; i++) {
+=09=09if (ax->usage_table[i].usage_num =3D=3D usage)
+=09=09=09return &ax->usage_table[i];
+=09}
+
+=09pr_err("aXiom-core: Usage u%02x not found in usage table\n", usage);
+=09return ERR_PTR(-EINVAL);
+}
+
+static void axiom_unpack_device_info(const u8 *buf,
+=09=09=09=09     struct axiom_device_info *info)
+{
+=09u16 w;
+
+=09w =3D get_unaligned_le16(buf);
+=09info->device_id =3D FIELD_GET(AX_DEV_ID_MASK, w);
+=09info->mode =3D !!(w & AX_MODE);
+
+=09w =3D get_unaligned_le16(buf + 2);
+=09info->runtime_fw_rev_minor =3D FIELD_GET(AX_FW_REV_MINOR_MASK, w);
+=09info->runtime_fw_rev_major =3D FIELD_GET(AX_FW_REV_MAJOR_MASK, w);
+
+=09w =3D get_unaligned_le16(buf + 4);
+=09info->device_build_variant =3D FIELD_GET(AX_VARIANT_MASK, w);
+=09info->runtime_fw_status =3D !!(w & AX_FW_STATUS);
+=09info->tcp_revision =3D FIELD_GET(AX_TCP_REV_MASK, w);
+
+=09w =3D get_unaligned_le16(buf + 6);
+=09info->bootloader_fw_rev_minor =3D FIELD_GET(AX_BOOT_REV_MINOR_MASK, w);
+=09info->bootloader_fw_rev_major =3D FIELD_GET(AX_BOOT_REV_MAJOR_MASK, w);
+
+=09info->jedec_id =3D get_unaligned_le16(buf + 8);
+
+=09w =3D get_unaligned_le16(buf + 10);
+=09info->num_usages =3D FIELD_GET(AX_NUM_USAGES_MASK, w);
+=09info->silicon_revision =3D FIELD_GET(AX_SILICON_REV_MASK, w);
+=09info->runtime_fw_rev_patch =3D FIELD_GET(AX_RUNTIME_FW_PATCH_MASK, w);
+}
+
+static void axiom_unpack_usage_table(u8 *buf, struct axiom *ax)
+{
+=09u8 *ptr;
+=09struct u31_usage_entry *entry;
+=09int i;
+=09u16 w;
+=09u16 report_len;
+
+=09for (i =3D 0; i < ax->dev_info.num_usages && i < U31_MAX_USAGES; i++) {
+=09=09entry =3D &ax->usage_table[i];
+=09=09/* Calculate offset for this specific entry */
+=09=09ptr =3D buf + (i * SIZE_U31_USAGE_ENTRY);
+
+=09=09w =3D get_unaligned_le16(ptr);
+=09=09entry->usage_num =3D FIELD_GET(AX_U31_USAGE_NUM_MASK, w);
+=09=09entry->start_page =3D FIELD_GET(AX_U31_START_PAGE_MASK, w);
+
+=09=09w =3D get_unaligned_le16(ptr + 2);
+=09=09entry->num_pages =3D FIELD_GET(AX_U31_NUM_PAGES_MASK, w);
+=09=09entry->max_offset =3D FIELD_GET(AX_U31_MAX_OFFSET_MASK, w);
+=09=09entry->offset_type =3D !!(w & AX_U31_OFFSET_TYPE_BIT);
+
+=09=09w =3D get_unaligned_le16(ptr + 4);
+=09=09entry->uifrevision =3D FIELD_GET(AX_U31_UIF_REV_MASK, w);
+=09=09entry->usage_type =3D FIELD_GET(AX_U31_USAGE_TYPE_MASK, w);
+
+=09=09// Convert words to bytes
+=09=09report_len =3D (entry->max_offset + 1) * 2;
+=09=09if ((entry->usage_type =3D=3D REPORT) &&
+=09=09    (report_len > ax->max_report_len)) {
+=09=09=09ax->max_report_len =3D report_len;
+=09=09}
+=09}
+}
+
+static int axiom_init_dev_info(struct axiom *ax)
+{
+=09int i;
+=09struct u31_usage_entry *u;
+=09int err;
+=09const char *variant_str;
+
+=09/* Read page 0 of u31 */
+=09err =3D ax->bus_ops->read(ax->dev, 0x0, SIZE_U31_DEVICE_INFO,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09return -EIO;
+
+=09axiom_unpack_device_info(ax->read_buf, &ax->dev_info);
+
+=09if (ax->dev_info.device_build_variant < ARRAY_SIZE(fw_variants)) {
+=09=09variant_str =3D fw_variants[ax->dev_info.device_build_variant];
+=09} else {
+=09=09variant_str =3D "UNKNOWN";
+=09}
+=09char silicon_rev =3D (char)(0x41 + ax->dev_info.silicon_revision);
+
+=09dev_info(ax->dev, "Firmware Info:\n");
+=09dev_info(ax->dev, "  BL Mode     : %u\n", ax->dev_info.mode);
+=09dev_info(ax->dev, "  Device ID   : %04x\n", ax->dev_info.device_id);
+=09dev_info(ax->dev, "  FW Revision : %u.%u.%u-%s %s\n",
+=09=09 ax->dev_info.runtime_fw_rev_major,
+=09=09 ax->dev_info.runtime_fw_rev_minor,
+=09=09 ax->dev_info.runtime_fw_rev_patch,
+=09=09 (ax->dev_info.runtime_fw_status =3D=3D 0) ? "eng" : "prod",
+=09=09 variant_str);
+=09dev_info(ax->dev, "  BL Revision : %02x.%02x\n",
+=09=09 ax->dev_info.bootloader_fw_rev_major,
+=09=09 ax->dev_info.bootloader_fw_rev_minor);
+=09dev_info(ax->dev, "  Silicon     : 0x%04X (Rev %c)\n",
+=09=09 ax->dev_info.jedec_id, silicon_rev);
+=09dev_info(ax->dev, "  Num Usages  : %u\n", ax->dev_info.num_usages);
+
+=09if (ax->dev_info.num_usages > U31_MAX_USAGES) {
+=09=09dev_err(ax->dev,
+=09=09=09"Num usages (%u) exceeds maximum supported (%u)\n",
+=09=09=09ax->dev_info.num_usages, U31_MAX_USAGES);
+=09=09return -EINVAL;
+=09}
+
+=09/* Read the second page of u31 to get the usage table */
+=09err =3D ax->bus_ops->read(ax->dev, 0x100,
+=09=09=09=09sizeof(ax->usage_table[0]) *
+=09=09=09=09=09ax->dev_info.num_usages,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09return -EIO;
+
+=09axiom_unpack_usage_table(ax->read_buf, ax);
+
+=09dev_info(ax->dev, "Usage Table:\n");
+=09for (i =3D 0; i < ax->dev_info.num_usages; i++) {
+=09=09u =3D &ax->usage_table[i];
+
+=09=09dev_info(
+=09=09=09ax->dev,
+=09=09=09"  Usage: u%02x  Rev: %3u  Page: 0x%02x00  Num Pages: %3u\n",
+=09=09=09u->usage_num, u->uifrevision, u->start_page,
+=09=09=09u->num_pages);
+=09}
+=09dev_info(ax->dev, "Max Report Length: %u\n", ax->max_report_len);
+
+=09if (ax->max_report_len > AXIOM_MAX_READ_SIZE) {
+=09=09dev_err(ax->dev,
+=09=09=09"aXiom maximum report length (%u) greater than allocated buffer s=
ize (%u).",
+=09=09=09ax->max_report_len, AXIOM_MAX_READ_SIZE);
+=09=09return -EINVAL;
+=09}
+
+=09/* Set u34 address to allow direct access to report reading address */
+=09u =3D usage_find_entry(ax, 0x34);
+=09if (IS_ERR(u))
+=09=09return PTR_ERR(u);
+=09ax->u34_address =3D u->start_page << 8;
+
+=09return 0;
+}
+
+static int axiom_process_u41_report(struct axiom *ax, u8 *report)
+{
+=09int i;
+=09u16 target_present;
+=09bool active;
+=09u8 offset;
+=09enum u41_target_state_e state;
+=09u16 x;
+=09u16 y;
+=09s8 z;
+
+=09target_present =3D
+=09=09FIELD_GET(AX_U41_PRESENT_MASK, get_unaligned_le16(&report[0]));
+
+=09for (i =3D 0; i < U41_MAX_TARGETS; i++) {
+=09=09active =3D !!((target_present >> i) & 1);
+
+=09=09offset =3D U41_X_Y_OFFSET + (i * U41_COORD_SIZE);
+=09=09x =3D get_unaligned_le16(&report[offset]);
+=09=09y =3D get_unaligned_le16(&report[offset + 2]);
+=09=09z =3D report[U41_Z_OFFSET + i];
+
+=09=09if (!active)
+=09=09=09state =3D Target_State_Not_Present;
+=09=09else if (z >=3D 0)
+=09=09=09state =3D Target_State_Touching;
+=09=09else if ((z > U41_PROX_LEVEL) && (z < 0))
+=09=09=09state =3D Target_State_Hover;
+=09=09else if (z =3D=3D U41_PROX_LEVEL)
+=09=09=09state =3D Target_State_Prox;
+=09=09else
+=09=09=09state =3D Target_State_Not_Present;
+
+=09=09dev_dbg(ax->dev, "Target %d: x=3D%u y=3D%u z=3D%d present=3D%d\n", i=
, x,
+=09=09=09y, z, active);
+
+=09=09switch (state) {
+=09=09case Target_State_Not_Present:
+=09=09case Target_State_Prox:
+
+=09=09=09input_mt_slot(ax->input, i);
+=09=09=09input_mt_report_slot_inactive(ax->input);
+=09=09=09break;
+
+=09=09case Target_State_Hover:
+=09=09case Target_State_Touching:
+
+=09=09=09input_mt_slot(ax->input, i);
+=09=09=09input_report_abs(ax->input, ABS_MT_TRACKING_ID, i);
+=09=09=09input_report_abs(ax->input, ABS_MT_POSITION_X, x);
+=09=09=09input_report_abs(ax->input, ABS_MT_POSITION_Y, y);
+
+=09=09=09if (state =3D=3D Target_State_Touching) {
+=09=09=09=09input_report_abs(ax->input, ABS_MT_DISTANCE, 0);
+=09=09=09=09input_report_abs(ax->input, ABS_MT_PRESSURE, z);
+=09=09=09} else { /* Hover */
+=09=09=09=09input_report_abs(ax->input, ABS_MT_DISTANCE, -z);
+=09=09=09=09input_report_abs(ax->input, ABS_MT_PRESSURE, 0);
+=09=09=09}
+=09=09=09break;
+
+=09=09default:
+=09=09=09break;
+=09=09}
+=09}
+
+=09input_mt_sync_frame(ax->input);
+=09input_sync(ax->input);
+
+=09return 0;
+}
+
+static int axiom_process_report(struct axiom *ax, u8 *report)
+{
+=09int err;
+=09struct u34_report_header hdr;
+=09u16 crc_calc;
+=09u16 crc_report;
+=09u8 len;
+=09u16 hdr_buf =3D get_unaligned_le16(&report[0]);
+
+=09dev_dbg(ax->dev, "Payload Data %*ph\n", ax->max_report_len, report);
+
+=09hdr.report_length =3D FIELD_GET(AX_U34_LEN_MASK, hdr_buf);
+=09hdr.overflow =3D !!(hdr_buf & AX_U34_OVERFLOW);
+=09hdr.report_usage =3D FIELD_GET(AX_U34_USAGE_MASK, hdr_buf);
+
+=09len =3D hdr.report_length << 1;
+=09if (hdr.report_length =3D=3D 0) {
+=09=09dev_err(ax->dev, "Zero length report discarded.\n");
+=09=09return -EIO;
+=09}
+
+=09// Length is 16 bit words and remove the size of the CRC16 itself
+=09crc_report =3D (report[len - 1] << 8) | (report[len - 2]);
+=09crc_calc =3D crc16(0, report, (len - 2));
+
+=09if (crc_calc !=3D crc_report) {
+=09=09dev_err(ax->dev,
+=09=09=09"CRC mismatch! Expected: %04X, Calculated CRC: %04X. Report disca=
rded.\n",
+=09=09=09crc_report, crc_calc);
+=09=09return -EIO;
+=09}
+
+=09switch (hdr.report_usage) {
+=09case AX_2DCTS_REPORT_ID:
+=09=09err =3D axiom_process_u41_report(ax,
+=09=09=09=09=09       &report[AX_U34_PAYLOAD_BUFFER]);
+=09=09break;
+
+=09default:
+=09=09break;
+=09}
+
+=09return err;
+}
+
+static void axiom_poll(struct input_dev *input_dev)
+{
+=09struct axiom *ax =3D input_get_drvdata(input_dev);
+=09int err;
+
+=09/* Read touch reports from u34 */
+=09err =3D ax->bus_ops->read(ax->dev, ax->u34_address, ax->max_report_len,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09return;
+
+=09err =3D axiom_process_report(ax, ax->read_buf);
+=09if (err)
+=09=09dev_err(ax->dev, "Failed to process report: %d\n", err);
+}
+
+static irqreturn_t axiom_irq(int irq, void *handle)
+{
+=09struct axiom *ax =3D handle;
+=09int err;
+
+=09/* Read touch reports from u34 */
+=09err =3D ax->bus_ops->read(ax->dev, ax->u34_address, ax->max_report_len,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09goto out;
+
+=09err =3D axiom_process_report(ax, ax->read_buf);
+=09if (err)
+=09=09dev_err(ax->dev, "Failed to process report: %d\n", err);
+
+out:
+=09return IRQ_HANDLED;
+}
+
+struct axiom *axiom_probe(const struct axiom_bus_ops *bus_ops,
+=09=09=09  struct device *dev, int irq)
+{
+=09struct axiom *ax;
+=09struct input_dev *input_dev;
+=09int err;
+=09bool poll_enable =3D false;
+=09u8 poll_period =3D 0;
+
+=09ax =3D devm_kzalloc(dev, sizeof(*ax), GFP_KERNEL);
+=09if (!ax)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09input_dev =3D devm_input_allocate_device(dev);
+=09if (!input_dev) {
+=09=09pr_err("ERROR: aXiom-core: Failed to allocate memory for input devic=
e!\n");
+=09=09return ERR_PTR(-ENOMEM);
+=09}
+
+=09poll_enable =3D device_property_read_bool(dev, "axiom,poll-enable");
+
+=09device_property_read_u8(dev, "axiom,poll-period", &poll_period);
+=09if (!poll_period)
+=09=09poll_period =3D AX_POLLING_PERIOD_MS;
+
+=09ax->dev =3D dev;
+=09ax->input =3D input_dev;
+=09ax->bus_ops =3D bus_ops;
+=09ax->irq =3D irq;
+
+=09dev_info(dev, "aXiom Probe\n");
+=09if (poll_enable)
+=09=09dev_info(dev, "Polling Period : %u\n", poll_period);
+=09else
+=09=09dev_info(dev, "Device IRQ : %u\n", ax->irq);
+
+=09axiom_set_capabilities(input_dev);
+
+=09err =3D axiom_init_dev_info(ax);
+=09if (err) {
+=09=09dev_err(ax->dev, "Failed to read device info, err: %d\n", err);
+=09=09return ERR_PTR(err);
+=09}
+
+=09if (poll_enable) {
+=09=09err =3D input_setup_polling(input_dev, axiom_poll);
+=09=09if (err) {
+=09=09=09dev_err(ax->dev, "could not set up polling mode, %d\n",
+=09=09=09=09err);
+=09=09=09return ERR_PTR(err);
+=09=09}
+
+=09=09input_set_poll_interval(input_dev, poll_period);
+=09} else {
+=09=09err =3D devm_request_threaded_irq(ax->dev, ax->irq, NULL,
+=09=09=09=09=09=09axiom_irq,
+=09=09=09=09=09=09IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+=09=09=09=09=09=09"axiom_irq", ax);
+=09=09if (err)
+=09=09=09return ERR_PTR(err);
+=09}
+
+=09err =3D input_register_device(input_dev);
+=09if (err) {
+=09=09dev_err(ax->dev, "Failed to register input device: %d\n", err);
+=09=09return ERR_PTR(err);
+=09}
+
+=09input_set_drvdata(input_dev, ax);
+
+=09return ax;
+}
+EXPORT_SYMBOL_GPL(axiom_probe);
+
+MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
+MODULE_DESCRIPTION("aXiom touchscreen core logic");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("axiom");
+MODULE_VERSION("1.0.0");
diff --git a/drivers/input/touchscreen/axiom_core.h b/drivers/input/touchsc=
reen/axiom_core.h
new file mode 100644
index 000000000000..ca77f9038cb1
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_core.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify i=
t
+ * under  the terms of  the GNU General  Public License as published by th=
e
+ * Free Software Foundation;  either version 2 of the  License, or (at you=
r
+ * option) any later version.
+ *
+ */
+
+#ifndef __AXIOM_CORE_H
+#define __AXIOM_CORE_H
+
+#include <linux/input.h>
+
+#define AX_POLLING_PERIOD_MS (10)
+
+#define AXIOM_USE_TOUCHSCREEN_INTERFACE // registers the axiom device as a=
 touch screen instead of as a mouse pointer
+#define U46_ENABLE_RAW_FORCE_DATA // enables the raw data for up to 4 forc=
e channels to be sent to the input subsystem
+
+#define AXIOM_PAGE_SIZE (256)
+// u31 has 2 pages for usage table entries. (2 * PAGE_SIZE) / U31_BYTES_PE=
R_USAGE =3D 85
+#define AXIOM_MAX_READ_SIZE (2 * AXIOM_PAGE_SIZE)
+#define SIZE_U31_DEVICE_INFO (12)
+#define SIZE_U31_USAGE_ENTRY (6)
+#define U31_MAX_USAGES (85U)
+#define U41_MAX_TARGETS (10U)
+#define U41_PROX_LEVEL (-128)
+#define AXIOM_HOLDOFF_DELAY_US (40)
+
+enum ax_comms_op_e { AX_WR_OP =3D 0, AX_RD_OP =3D 1 };
+
+enum report_ids_e {
+=09AX_2DCTS_REPORT_ID =3D 0x41,
+};
+
+enum axiom_mode_e {
+=09AX_RUNTIME_STATE =3D 0,
+=09AX_BOOTLOADER_STATE =3D 1,
+};
+
+enum usage_type_e {
+=09UNKNOWN =3D 0,
+=09OTHER =3D 1,
+=09REPORT =3D 2,
+=09REGISTER =3D 3,
+=09REGISTER_READ_ONLY_ =3D 4,
+=09CDU =3D 5,
+=09CDU_READ_ONLY_ =3D 6,
+};
+
+struct axiom_device_info {
+=09u16 device_id;
+=09u8 mode;
+=09u8 runtime_fw_rev_minor;
+=09u8 runtime_fw_rev_major;
+=09u8 device_build_variant;
+=09u8 runtime_fw_status;
+=09u8 tcp_revision;
+=09u8 bootloader_fw_rev_minor;
+=09u8 bootloader_fw_rev_major;
+=09u8 jedec_id;
+=09u8 num_usages;
+=09u8 silicon_revision;
+=09u8 runtime_fw_rev_patch;
+};
+
+struct u31_usage_entry {
+=09u8 usage_num;
+=09u8 start_page;
+=09u8 num_pages;
+=09u8 max_offset;
+=09u8 offset_type;
+=09u8 uifrevision;
+=09u8 usage_type;
+};
+
+struct axiom_cmd_header {
+=09u16 target_address;
+=09u16 length : 15;
+=09u16 rd_wr : 1;
+};
+
+struct axiom_bus_ops {
+=09u16 bustype;
+=09int (*write)(struct device *dev, u16 addr, u16 length, void *values);
+=09int (*read)(struct device *dev, u16 addr, u16 length, void *values);
+};
+
+enum u41_target_state_e {
+=09Target_State_Not_Present =3D 0,
+=09Target_State_Prox =3D 1,
+=09Target_State_Hover =3D 2,
+=09Target_State_Touching =3D 3,
+};
+
+struct axiom {
+=09struct device *dev;
+=09int irq;
+=09struct input_dev *input;
+=09const struct axiom_bus_ops *bus_ops;
+=09struct axiom_device_info dev_info;
+=09struct u31_usage_entry usage_table[U31_MAX_USAGES];
+=09u16 max_report_len;
+=09u16 u34_address;
+
+=09u8 read_buf[AXIOM_MAX_READ_SIZE];
+};
+
+struct u34_report_header {
+=09u8 report_length;
+=09u8 overflow;
+=09u8 report_usage;
+};
+
+struct axiom *axiom_probe(const struct axiom_bus_ops *bus_ops,
+=09=09=09  struct device *dev, int irq);
+
+#endif /* __AXIOM_CORE_H */
diff --git a/drivers/input/touchscreen/axiom_i2c.c b/drivers/input/touchscr=
een/axiom_i2c.c
new file mode 100644
index 000000000000..66071cc0f7b3
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_i2c.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Bart Prescott <bartp@baasheep.co.uk>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify i=
t
+ * under  the terms of  the GNU General  Public License as published by th=
e
+ * Free Software Foundation;  either version 2 of the  License, or (at you=
r
+ * option) any later version.
+ *
+ */
+
+// #define DEBUG // Enable debug messages
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include "axiom_core.h"
+
+static int axiom_i2c_read_block_data(struct device *dev, u16 addr, u16 len=
gth,
+=09=09=09=09     void *values)
+{
+=09int error;
+=09struct i2c_client *client =3D to_i2c_client(dev);
+=09struct axiom_cmd_header cmd_header =3D { .target_address =3D addr,
+=09=09=09=09=09       .length =3D length,
+=09=09=09=09=09       .rd_wr =3D AX_RD_OP };
+
+=09struct i2c_msg msgs[] =3D {
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D 0,
+=09=09=09.len =3D sizeof(cmd_header),
+=09=09=09.buf =3D (u8 *)&cmd_header,
+=09=09},
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D I2C_M_RD,
+=09=09=09.len =3D length,
+=09=09=09.buf =3D values,
+=09=09},
+=09};
+
+=09error =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+=09if (error < 0) {
+=09=09dev_err(dev, "I2C transfer error: %d\n", error);
+=09=09return error;
+=09}
+
+=09udelay(AXIOM_HOLDOFF_DELAY_US);
+
+=09return error !=3D ARRAY_SIZE(msgs) ? -EIO : 0;
+}
+
+static int axiom_i2c_write_block_data(struct device *dev, u16 addr, u16 le=
ngth,
+=09=09=09=09      void *values)
+{
+=09int error;
+=09struct i2c_client *client =3D to_i2c_client(dev);
+=09struct axiom_cmd_header cmd_header =3D { .target_address =3D addr,
+=09=09=09=09=09       .length =3D length,
+=09=09=09=09=09       .rd_wr =3D AX_WR_OP };
+
+=09struct i2c_msg msgs[] =3D {
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D 0,
+=09=09=09.len =3D sizeof(cmd_header),
+=09=09=09.buf =3D (u8 *)&cmd_header,
+=09=09},
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D 0,
+=09=09=09.len =3D length,
+=09=09=09.buf =3D values,
+=09=09},
+=09};
+
+=09error =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+=09if (error < 0) {
+=09=09dev_err(dev, "I2C transfer error: %d\n", error);
+=09=09return error;
+=09}
+
+=09udelay(AXIOM_HOLDOFF_DELAY_US);
+
+=09return error !=3D ARRAY_SIZE(msgs) ? -EIO : 0;
+}
+
+static const struct axiom_bus_ops axiom_i2c_bus_ops =3D {
+=09.bustype =3D BUS_I2C,
+=09.write =3D axiom_i2c_write_block_data,
+=09.read =3D axiom_i2c_read_block_data,
+};
+
+static int axiom_i2c_probe(struct i2c_client *client)
+{
+=09struct axiom *axiom;
+
+=09if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+=09=09dev_err(&client->dev, "I2C functionality not Supported\n");
+=09=09return -EIO;
+=09}
+
+=09axiom =3D axiom_probe(&axiom_i2c_bus_ops, &client->dev, client->irq);
+=09if (IS_ERR(axiom))
+=09=09return dev_err_probe(&client->dev, PTR_ERR(axiom),
+=09=09=09=09     "failed to register input device\n");
+
+=09return 0;
+}
+
+static const struct i2c_device_id axiom_i2c_id_table[] =3D {
+=09{ "axiom-i2c" },
+=09{},
+};
+MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
+
+static const struct of_device_id axiom_i2c_dt_ids[] =3D {
+=09{
+=09=09.compatible =3D "tnx,axiom-i2c",
+=09=09.data =3D "axiom",
+=09},
+=09{}
+};
+MODULE_DEVICE_TABLE(of, axiom_i2c_dt_ids);
+
+static struct i2c_driver axiom_i2c_driver =3D {
+=09.driver =3D {
+=09=09.name =3D "axiom_i2c",
+=09=09.of_match_table =3D of_match_ptr(axiom_i2c_dt_ids),
+=09},
+=09.id_table =3D axiom_i2c_id_table,
+=09.probe =3D axiom_i2c_probe,
+};
+
+module_i2c_driver(axiom_i2c_driver);
+
+MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
+MODULE_DESCRIPTION("aXiom touchscreen I2C bus driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("axiom");
+MODULE_VERSION("1.0.0");
diff --git a/drivers/input/touchscreen/axiom_spi.c b/drivers/input/touchscr=
een/axiom_spi.c
new file mode 100644
index 000000000000..a67ad3645689
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_spi.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2018-2023 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify i=
t
+ * under  the terms of  the GNU General  Public License as published by th=
e
+ * Free Software Foundation;  either version 2 of the  License, or (at you=
r
+ * option) any later version.
+ *
+ */
+
+// #define DEBUG // Enable debug messages
+
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/input.h>
+#include "axiom_core.h"
+
+#define SPI_PADDING_LEN 32
+
+static int axiom_spi_transfer(struct device *dev, enum ax_comms_op_e op,
+=09=09=09      u16 addr, u16 length, void *values)
+{
+=09int ret;
+=09struct spi_device *spi =3D to_spi_device(dev);
+=09struct spi_transfer xfr_header;
+=09struct spi_transfer xfr_padding;
+=09struct spi_transfer xfr_payload;
+=09struct spi_message msg;
+=09struct axiom_cmd_header cmd_header =3D { .target_address =3D addr,
+=09=09=09=09=09       .length =3D length,
+=09=09=09=09=09       .rd_wr =3D op };
+=09u8 pad_buf[SPI_PADDING_LEN] =3D { 0 };
+
+=09memset(&xfr_header, 0, sizeof(xfr_header));
+=09memset(&xfr_padding, 0, sizeof(xfr_padding));
+=09memset(&xfr_payload, 0, sizeof(xfr_payload));
+
+=09/* Setup the SPI transfer operations */
+=09xfr_header.tx_buf =3D &cmd_header;
+=09xfr_header.len =3D sizeof(cmd_header);
+
+=09xfr_padding.tx_buf =3D pad_buf;
+=09xfr_padding.len =3D sizeof(pad_buf);
+
+=09switch (op) {
+=09case AX_WR_OP:
+=09=09xfr_payload.tx_buf =3D values;
+=09=09break;
+=09case AX_RD_OP:
+=09=09xfr_payload.rx_buf =3D values;
+=09=09break;
+=09default:
+=09=09dev_err(dev, "%s: invalid operation: %d\n", __func__, op);
+=09=09return -EINVAL;
+=09}
+=09xfr_payload.len =3D length;
+
+=09spi_message_init(&msg);
+=09spi_message_add_tail(&xfr_header, &msg);
+=09spi_message_add_tail(&xfr_padding, &msg);
+=09spi_message_add_tail(&xfr_payload, &msg);
+
+=09ret =3D spi_sync(spi, &msg);
+=09if (ret < 0) {
+=09=09dev_err(&spi->dev, "Failed to SPI transfer, error: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09udelay(AXIOM_HOLDOFF_DELAY_US);
+
+=09return 0;
+}
+
+static int axiom_spi_read_block_data(struct device *dev, u16 addr, u16 len=
gth,
+=09=09=09=09     void *values)
+{
+=09return axiom_spi_transfer(dev, AX_RD_OP, addr, length, values);
+}
+
+static int axiom_spi_write_block_data(struct device *dev, u16 addr, u16 le=
ngth,
+=09=09=09=09      void *values)
+{
+=09return axiom_spi_transfer(dev, AX_WR_OP, addr, length, values);
+}
+
+static const struct axiom_bus_ops axiom_spi_bus_ops =3D {
+=09.bustype =3D BUS_SPI,
+=09.write =3D axiom_spi_write_block_data,
+=09.read =3D axiom_spi_read_block_data,
+};
+
+static int axiom_spi_probe(struct spi_device *spi)
+{
+=09struct axiom *axiom;
+=09int error;
+
+=09/* Set up SPI */
+=09spi->bits_per_word =3D 8;
+=09spi->mode =3D SPI_MODE_0;
+=09spi->max_speed_hz =3D 4000000;
+
+=09if (spi->irq =3D=3D 0)
+=09=09dev_err(&spi->dev, "No IRQ specified!\n");
+
+=09error =3D spi_setup(spi);
+=09if (error < 0) {
+=09=09dev_err(&spi->dev, "%s: SPI setup error %d\n", __func__, error);
+=09=09return error;
+=09}
+=09axiom =3D axiom_probe(&axiom_spi_bus_ops, &spi->dev, spi->irq);
+=09if (IS_ERR(axiom))
+=09=09return dev_err_probe(&spi->dev, PTR_ERR(axiom),
+=09=09=09=09     "failed to register input device\n");
+
+=09return 0;
+}
+
+static const struct spi_device_id axiom_spi_id_table[] =3D {
+=09{ "axiom-spi" },
+=09{},
+};
+MODULE_DEVICE_TABLE(spi, axiom_spi_id_table);
+
+static const struct of_device_id axiom_spi_dt_ids[] =3D {
+=09{
+=09=09.compatible =3D "tnx,axiom-spi",
+=09=09.data =3D "axiom",
+=09},
+=09{}
+};
+MODULE_DEVICE_TABLE(of, axiom_spi_dt_ids);
+
+static struct spi_driver axiom_spi_driver =3D {
+=09.id_table =3D axiom_spi_id_table,
+=09.driver =3D {
+=09=09.name =3D "axiom_spi",
+=09=09.of_match_table =3D of_match_ptr(axiom_spi_dt_ids),
+=09},
+=09.probe =3D axiom_spi_probe,
+};
+
+module_spi_driver(axiom_spi_driver);
+
+MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
+MODULE_DESCRIPTION("aXiom touchscreen SPI bus driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("axiom");
+MODULE_VERSION("1.0.0");
--=20
2.43.0

