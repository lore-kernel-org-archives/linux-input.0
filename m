Return-Path: <SRS0=p1C8=X2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB6ECE587
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A172086A
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="a+MNqrk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbfJAO3z (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:29:55 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:56392 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388919AbfJAO3z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Oct 2019 10:29:55 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 00CD4A0676;
        Tue,  1 Oct 2019 16:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1569940193;
        bh=undku+yPDH9gPcVjQfrGAf+OOa9EemHHNpeidCTysEM=;
        h=From:To:Cc:Subject:Date:From;
        b=a+MNqrk6mjiluDiLthjKVkoWjTBBIRdc52/8R2uwbHAIZadg4lbXMnBv1uXxVN+uS
         ZTZsmJaJs2Ei9CN2geZhgdeh9dlC8WAog5mwxI2VrENeuUV5CIQXgAWcSFtRvsGImf
         fu3+ZVyMwLmWbzNvlx6JA15ZOuv29FiuW/w5t+QU=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 0/5] Add polling mode to the MPR121 touchkey
Date:   Tue,  1 Oct 2019 16:29:35 +0200
Message-Id: <1569940180-11417-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This series is another attempt to use the MPR121 touch sensor
controller in polling mode. This version uses the brand new
input-poller API.

Michal Vokáč (5):
  dt-bindings: input: Add common input binding in json-schema
  dt-bindings: input: Convert mpr121 binding to json-schema
  dt-bindings: input: Add poll-interval property
  Input: mpr121: Add polling mode
  ARM: dts: imx6dl-yapp4: Enable the MPR121 touchkey controller on Hydra

 .../bindings/input/fsl,mpr121-touchkey.yaml        | 89 ++++++++++++++++++++++
 Documentation/devicetree/bindings/input/input.yaml | 29 +++++++
 .../devicetree/bindings/input/mpr121-touchkey.txt  | 30 --------
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi         | 13 ++++
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts           |  4 +
 drivers/input/keyboard/mpr121_touchkey.c           | 69 ++++++++++++-----
 6 files changed, 186 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
 create mode 100644 Documentation/devicetree/bindings/input/input.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt

-- 
2.1.4

