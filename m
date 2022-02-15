Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11684C433F5
	for <linux-input@archiver.kernel.org>; Tue, 15 Feb 2022 18:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiBOSIo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Feb 2022 13:08:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiBOSIn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Feb 2022 13:08:43 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50E4DD97B;
        Tue, 15 Feb 2022 10:08:33 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     krzysztof.kozlowski@canonical.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
Subject: dt-bindings: ps2-gpio: convert binding to json-schema
Date:   Tue, 15 Feb 2022 19:08:26 +0100
Message-Id: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Changes since v1
================
  - binding as separate patch (driver patch will be sent outside the scope of
    this patch series)
  - fixes requested by Krzysztof
  - fix warnings/errors reported by 'make dt_binding_check'

Changes since v2
================
  - add the driver patch to enforce open drain GPIO flags again
  - fix additionalProperties: false

This series converts the ps2-gpio dt-binding to the json-schema.

Additionally, it documents (in the dt-binding) and enforces to flag the
given gpios as open drain, since the PS/2 bus is open drain by
definition.

Danilo Krummrich (3):
      dt-bindings: ps2-gpio: convert binding to json-schema
      dt-bindings: ps2-gpio: document bus signals open drain
      input: ps2-gpio: enforce GPIOs flag open drain

 Documentation/devicetree/bindings/serio/ps2-gpio.txt  | 23 -----------------------
 Documentation/devicetree/bindings/serio/ps2-gpio.yaml | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/serio/ps2-gpio.c                        |  9 +++++++--
 3 files changed, 71 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml


