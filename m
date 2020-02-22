Return-Path: <SRS0=ep/6=4K=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA728C35675
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B6A208C3
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fCtF4hhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBVXV4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:21:56 -0500
Received: from vps.xff.cz ([195.181.215.36]:34182 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgBVXVz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582413271; bh=O+L3Dgir8ylc0hRKhh+YvNvVJjhY/rU659XZD2GVYnY=;
        h=From:To:Cc:Subject:Date:From;
        b=fCtF4hhmMcBT3t3pgLRjHBXlVS22ppcJg2B6akTO8amSo0XYfOoIBYZvmUnQ9kXk2
         Z13/B3H07CMJb+3mz8qmpzNj4dRSfc4AGdUmb3rTIfhf3MCpnlrLYtKYCrB7XdSC8j
         QfzFykHW+lf7whEzPV56NJ5N/20/re4ljiLnX5+U=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Tomas Novotny <tomas@novotny.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Add support for vibrator motor for TBS A711 Tablet
Date:   Sun, 23 Feb 2020 00:14:24 +0100
Message-Id: <20200222231428.233621-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The tablet has a vibrator. Expose it via input subsystem (EV_FF).

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (4):
  dt-bindings: input: gpio-vibrator: Don't require enable-gpios
  input: gpio-vibra: Allow to use vcc-supply alone to control the
    vibrator
  ARM: dts: sun8i-a83t-tbs-a711: Add support for the vibrator motor
  ARM: dts: sun8i-a83t-tbs-a711: Increase voltage on the vibrator

 .../devicetree/bindings/input/gpio-vibrator.yaml         | 1 -
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                | 9 +++++++--
 drivers/input/misc/gpio-vibra.c                          | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.25.1

