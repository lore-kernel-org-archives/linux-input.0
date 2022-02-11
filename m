Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA4C433F5
	for <linux-input@archiver.kernel.org>; Fri, 11 Feb 2022 23:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiBKXbp (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 11 Feb 2022 18:31:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBKXbo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Feb 2022 18:31:44 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94EECEF;
        Fri, 11 Feb 2022 15:31:42 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
Subject: dt-bindings: ps2-gpio: convert binding to json-schema
Date:   Sat, 12 Feb 2022 00:31:35 +0100
Message-Id: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This series converts the ps2-gpio dt-binding to the json-schema.

Additionally, it documents (in the dt-binding) and enforces to flag the
given gpios as open drain, since the PS/2 bus is open drain by
definition.


