Return-Path: <SRS0=+R2U=4Q=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB15AC3F2CF
	for <linux-input@archiver.kernel.org>; Fri, 28 Feb 2020 01:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1679246AE
	for <linux-input@archiver.kernel.org>; Fri, 28 Feb 2020 01:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="g1qaJ/e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgB1BCO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:02:14 -0500
Received: from hermes.aosc.io ([199.195.250.187]:45202 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730148AbgB1BCN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Feb 2020 20:02:13 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 07DFF4B3D1;
        Fri, 28 Feb 2020 01:02:06 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 0/3] Add support for Goodix GT917S touch controller
Date:   Fri, 28 Feb 2020 09:01:43 +0800
Message-Id: <20200228010146.12215-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1582851732;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=p9FhNZqspr0hdbk4QbswXREOY7YXlfg+mUTuttYfbMs=;
        b=g1qaJ/e3KawJoHr6MztDcgrDvJCc7OkOcfTROk0o2hUxW2g5Zem1hW73owSk4mpDphTfD5
        zNO96F7qIFXzzqvvyARj0qu/sAxholyQ2XVyT+YbeMRyH8fFkHXpIo+KDI76rHDlnEb5uQ
        GWU32zts/ToVaUVEtIUVATyG27LAEag=
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patchset introduces support for Goodix GT917S touch controller.

The major difference with other touch controllers from Goodix is that
the ID string is no longer number-only (it contains a 'S'), so an
additional patch is introduced for migrating the ID to a string.

Icenowy Zheng (3):
  dt-bindings: input: touchscreen: add compatible string for Goodix
    GT917S
  Input: goodix - use string-based chip ID
  Input: goodix - Add support for Goodix GT917S

 .../bindings/input/touchscreen/goodix.yaml    |  1 +
 drivers/input/touchscreen/goodix.c            | 71 +++++++++++--------
 2 files changed, 43 insertions(+), 29 deletions(-)

-- 
2.24.1

