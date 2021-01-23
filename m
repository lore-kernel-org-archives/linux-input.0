Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B168FC43381
	for <linux-input@archiver.kernel.org>; Sat, 23 Jan 2021 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F76C23331
	for <linux-input@archiver.kernel.org>; Sat, 23 Jan 2021 13:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbhAWNuR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:50:17 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:60617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbhAWNuJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 23 Jan 2021 08:50:09 -0500
Received: from envy.fritz.box ([82.207.207.243]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhlbM-1lh3rZ0Sjw-00dpzC; Sat, 23 Jan 2021 14:47:25 +0100
From:   mail@richard-neumann.de
To:     nehal-bakulchandra.shah@amd.com, sandeep.singh@amd.com,
        mail@richard-neumann.de, corbet@lwn.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/8] Updated Makefile
Date:   Sat, 23 Jan 2021 14:47:12 +0100
Message-Id: <20210123134716.13414-5-mail@richard-neumann.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210123134716.13414-1-mail@richard-neumann.de>
References: <20210123134716.13414-1-mail@richard-neumann.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VwrSBYKorwDHOeIg/AGsvyN70RnyfjeQSYaG39E2wsbd3cZHP6+
 2w/N967PzmVDsE53VMftBMYHcWI8QQxFMskoQZ9KPFW8FsO5mQQVc5E8mCvOo4/BXrEeSJf
 BbnaaCIDgwhZKQg4WCaFjjMMe5MgIYloZ9QP/UOMSVwWsUGfny6btcUQ/gqg/xPWl5neBAa
 5wxq4nIsvCufUJy6Tldng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2CL1vanCAg=:WkB01232CWw1PwH5fIA3KY
 On3xn+RqapTzo/b0Nhon1eLJsMQitRvyfolgQjb9kV0btuiwNkF0hZCn+cLgsROXreAGRGm1G
 PMn/AmU77b1uAI7ERvoy9rc/ozonqCHtkgWWL9Uf8fwtTcjrpGs+9GI/9JDRVt+7tsj4KhJPi
 ZilVScFspE0rHZi/e+MojLQqSuGKmLmF/mipPGBRgbD2D04ZQL5kwwDNkqfnqFWeKkLEhoUi+
 rFhpRbiT4usb7Xz6WzOWQ9Z1rTzRGqR6aVrxApOFurxjk7V5cvKuIlKrCBTsV6W+QuapiMFEn
 QAUeWyCG0giw2M9SZDSidwnHBUvurlWwWfzqyXwRYmhB6pgiHbrO4n1d3dbFUxxNf7lW/B0NM
 hxI6GdPCw/xpqaamYt+yBaLrPTGPswpX2ZPtlxrTVXTjeGW0N/TDJ5MFoafF0G88B2KvZcRhx
 CycNhwhu7A==
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Richard Neumann <mail@richard-neumann.de>

Updated Makefile of the AMD SFH driver.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 drivers/hid/amd-sfh-hid/Makefile | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
index 35e704da5612..303ee8f9aac5 100644
--- a/drivers/hid/amd-sfh-hid/Makefile
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -1,13 +1,9 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile - AMD SFH HID drivers
-# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
+# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
 #
 #
-obj-$(CONFIG_AMD_SFH_HID) += amd_sfh.o
-amd_sfh-objs := amd_sfh_hid.o
-amd_sfh-objs += amd_sfh_client.o
-amd_sfh-objs += amd_sfh_pcie.o
-amd_sfh-objs += hid_descriptor/amd_sfh_hid_desc.o
-
-ccflags-y += -I $(srctree)/$(src)/
+ccflags-m := -Werror
+obj-$(CONFIG_AMD_SFH_HID) += amd-sfh-pci.o amd-sfh-hid.o
+amd-sfh-hid-objs += amd-sfh-plat.o amd-sfh-hid-ll-drv.o amd-sfh-hid-reports.o
-- 
2.30.0

