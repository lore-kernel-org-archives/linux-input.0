Return-Path: <SRS0=TKna=AZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653FFC433E4
	for <linux-input@archiver.kernel.org>; Tue, 14 Jul 2020 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6C422207
	for <linux-input@archiver.kernel.org>; Tue, 14 Jul 2020 10:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="IOj2CJTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGNKXk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:23:40 -0400
Received: from vps.xff.cz ([195.181.215.36]:46160 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgGNKXk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Jul 2020 06:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594722217; bh=b5ZA4YXSStj9NSEJKpR0EoBU9eCLYs5GBPxpk7Au4Jk=;
        h=From:To:Cc:Subject:Date:From;
        b=IOj2CJTFMM4foh6Z1bL6bN76aQ3IsZF6KzKGIuLDgwKASd6lE3sIDRQv/76ND9+BX
         rqLW9wJBgyvd5VA3nFg4GXphHvFr/pdQEdcE8Dv3y+q2cSLVgjuvs5B1SxBQxXIoUe
         tmTZaqUKBXg2vC69LsfMNpFnShBOCyhzHsK8LT9k=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] Add support for vibrator motor for TBS A711 Tablet
Date:   Tue, 14 Jul 2020 12:22:59 +0200
Message-Id: <20200714102303.3007896-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The tablet has a vibrator motor. This patch series exposes it via
input subsystem (EV_FF).

I'd like to ask input maintainers to take the patches 1 and 2.
Patches 3 and 4 should go via the sunxi tree.

The change to the vibrator driver is meant to enable toggling the
vibrator motor just via a power supply itself. There's not additional
gpio driven switch on this tablet between the power supply for the
motor and the motor.

Please take a look.

Changes in v4:
- Added DT reviewed-by tag
- Fixed motor typo

Changes in v3:
- Changed dt-binding to require at least one of enable/supply, dropped ack
- Changed driver to bail out if neither supply nor gpio is given

Changes in v2:
- Added DT ack tag
- Add more information to the commit log (re use of LDO for the power)


thank you and regards,
  Ondrej Jirman

Ondrej Jirman (4):
  dt-bindings: input: gpio-vibrator: Don't require enable-gpios
  input: gpio-vibra: Allow to use vcc-supply alone to control the
    vibrator
  ARM: dts: sun8i-a83t-tbs-a711: Add support for the vibrator motor
  ARM: dts: sun8i-a83t-tbs-a711: Increase voltage on the vibrator

 .../devicetree/bindings/input/gpio-vibrator.yaml   |  7 ++++++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |  9 +++++++--
 drivers/input/misc/gpio-vibra.c                    | 14 ++++++++++----
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.27.0

