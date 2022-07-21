Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C03CCA479
	for <linux-input@archiver.kernel.org>; Thu, 21 Jul 2022 08:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiGUIgT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiGUIgR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 Jul 2022 04:36:17 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3720A22BE4
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2022 01:36:15 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ERe9oJVIEtk1HEReJojXoF; Thu, 21 Jul 2022 10:35:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1658392514; bh=tkpOYpCcZE1Bre0jpfaelBhmDtGIU38n7jAmgeM3WnE=;
        h=From:To:Subject:Date:MIME-Version;
        b=Sy+c07Zc0k3k3x0s26gPqkwImTlH9c7j1i23dYDy9pC5DNohk1MF4tbCZJH8ayd8n
         6drRXXpgojntGk/ttyM+ZNuHv4TCwpJe70ALThC/6BI3oOXuOPgluUbQPcoAp8dko+
         NNu43Vzvb4APSDgwAIGYQDoM3UGhV0XV44ptw/vmQpFK0wH3F+/Mz4LRm+R2KrSXGR
         YF2SoApn0T2JEnIfa3XXP+jdafOruzdi8UDmyRE7vhf68SS8wBU0xe1OvvlHKSSPkl
         tbdkeHUQVPKBqKi+0IxgzUVeJ4jyj5hBiJbrm7SN10CVsvete9JsfwXiDQ3fRwRRU5
         EW68Cq/Le/+2A==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v2 1/3] ads7846: don't report pressure for ads7845
Date:   Thu, 21 Jul 2022 10:34:56 +0200
Message-Id: <20220721083458.6412-2-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO4plaYvd/DeQ97oMCVVt7FnIQg3nX7wTUDtAN49Y/Ac6fAjVU1BKV5UqYwa6hnQ/qiYBwYlGVUGU+dYdb6JN81WrbAeITsZuP61hdPIQTLsFm//pgIU
 bngsg0Kq1dnm6r7V9vNYMBlzbIn4MUOHBcifkRCe1Aw7S0QzMtUmg1Yj1OV9boY09T7A/FtzdMxOKmSIU432IJfmISb1QNMaWShNJHwlTFztuhoHIwFK60/R
 MsxuGXhpDy67/sl/28K5jW+SFtIrUPBO/ChuCLLp/RqmJnVguOEDdICX2F1LhUp2LrIOJyELDW2JHrPB88yH7ktUWgyPUt2EiLg1np9AjUDWsuSeswtAUmHL
 ZJaKc6OhcHC41FmUU9IA25fKwW5CnSJEVQm5jAwxp7D3lnLk9g6YW57w0+0g5McyNwaHi5PPZh+IVwFoEv10XPFdBpdRl/ot3lq5gsdjFX/xc4fx6D/krl9U
 nhNdFVenX5o6EOd0uTOmSEyqh+6T3zvNYgcMF7KrtTrgZv99jP0GV6YQkH4BSBv9g9bVCTR6aqHtGv2AT1cxKhCuuBIvdsfL2x//uBn9SRIFngK3ovTadvo0
 uS8=
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Luca Ellero <l.ellero@asem.it>

ADS7845 doesn't support pressure.
This patch avoids the following error reported by libinput-list-devices:
"ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
Changes for v2:
 - add missing period in commit message

 drivers/input/touchscreen/ads7846.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index bed68a68f330..24605c40d039 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1316,8 +1316,9 @@ static int ads7846_probe(struct spi_device *spi)
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+	if (ts->model != 7845)
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				pdata->pressure_min, pdata->pressure_max, 0, 0);
 
 	/*
 	 * Parse common framework properties. Must be done here to ensure the
-- 
2.25.1

