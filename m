Return-Path: <SRS0=gHlt=27=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8515C33CA4
	for <linux-input@archiver.kernel.org>; Fri, 10 Jan 2020 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFF120673
	for <linux-input@archiver.kernel.org>; Fri, 10 Jan 2020 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="buTMyw3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgAJQej (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:34:39 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50545 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgAJQei (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Jan 2020 11:34:38 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 11:34:38 EST
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 66D9846D63;
        Fri, 10 Jan 2020 16:26:58 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Add support for Goodix GT917S touch controller
Date:   Sat, 11 Jan 2020 00:26:05 +0800
Message-Id: <20200110162608.1066397-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1578673640;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=AEELeAYC9NorjTDpv0ZPmU+f+AUS/ubfkAjO8sKqkms=;
        b=buTMyw3xNyyea/7/JQOp3p5bcLP5d/Zj/pCu8JDVc5f05oqIs+giGnRdTJX02jndXItUPn
        Y2OpBjQofcUNML/uilEu8WZUYC0Sq3p4ZbhVdWMuh/SVXWiyn7i9Bl5HZ31zjyuyiV6YDg
        UQjHKqDpP2lQq1afHEPCZyccEZ6/YEI=
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

 .../bindings/input/touchscreen/goodix.txt     |  1 +
 drivers/input/touchscreen/goodix.c            | 41 +++++++++----------
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.23.0

