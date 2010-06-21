From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 0/4] Add keypad support for SMDK6410, SMDKC100 and SMDKV210
Date: Tue, 22 Jun 2010 08:43:51 +0900
Message-ID: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org
Cc: ben-linux@fluff.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

This patches add keypad support for SMDK6410, SMDKC100 and SMDKV210.

NOTE: depends on Joonyoung Shim's 'Add samsung keypad'

[PATCH 1/4] ARM: S5PV210: Add keypad device to the SMDKV210 board
[PATCH 2/4] ARM: S3C64XX: Add keypad device to the SMDK6410 board
[PATCH 3/4] ARM: S5PC100: Rename keypad clock for S5PC100.
[PATCH 4/4] ARM: S5PC100: Add keypad device to the SMDKC100 board
