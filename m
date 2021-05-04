Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9536C433ED
	for <linux-input@archiver.kernel.org>; Tue,  4 May 2021 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905FE610E9
	for <linux-input@archiver.kernel.org>; Tue,  4 May 2021 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhEDTVN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 4 May 2021 15:21:13 -0400
Received: from mail-40138.protonmail.ch ([185.70.40.138]:62821 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhEDTVN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 May 2021 15:21:13 -0400
Date:   Tue, 04 May 2021 19:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620156014;
        bh=myymaIjj5ngJ2xpB8YfOd3Uo+ydeVz+wGUuzLWk88bg=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nZzpYnNw1Xmk44lT5y0HopPGEYDiTMO4fZy4ABRp7Y6GSdPhNmn2QXfXG29+6smUo
         9BomWONngShFDiWRFlmwWS/4W12q503Ex4YXN/qZ4BROOWTdg4P6xRm6Oy+kRHIZgB
         mPAOWyMqHXj/3Dgzo9x3ChOv9/SKJsxCGsuJhidc=
To:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 0/2] Input: cypress-sf - Add support for Cypress Streetfighter touchkeys
Message-ID: <235fu6MnvzCoMBgP3Wkhz2ZmKOIG2ZYDBzYNBEJlbk@cp4-web-036.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patchset adds support for the Cypress StreetFighter touchkey device.
This driver is based on the driver from the vendor kernel for the Xiaomi
Mi Note 2[1][2], which is also the device where this was tested.

[1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/scorpio-m-oss/d=
rivers/input/touchscreen/cyttsp_button.c
[2] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/scorpio-m-oss/a=
rch/arm/boot/dts/qcom/scorpio-msm8996-mtp.dtsi#L300-L322

Changes in v2:
 - Changed version variables in probe to int to allow storing error codes.
 - Fixed some issues in dt binding.

Yassine Oudjana (2):
  Input: cypress-sf - Add Cypress StreetFighter touchkey driver
  dt-bindings: input: Add binding for cypress-sf

 .../devicetree/bindings/input/cypress-sf.yaml |  61 +++++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/cypress-sf.c           | 219 ++++++++++++++++++
 4 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress-sf.yaml
 create mode 100644 drivers/input/keyboard/cypress-sf.c

--=20
2.31.1


