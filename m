Return-Path: <SRS0=pnPe=CQ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3DC433E2
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30FF21582
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 20:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIGUkv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:40:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43990 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIGUkv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2020 16:40:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 70E2E290B19
Received: by jupiter.universe (Postfix, from userid 1000)
        id 02CDF480113; Mon,  7 Sep 2020 22:40:46 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 0/4] Rotary Encoder Push Button Support
Date:   Mon,  7 Sep 2020 22:40:41 +0200
Message-Id: <20200907204045.95530-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

The aim of this series is to add support for reporting push
events from rotary encoders with integrated push button
functionality (which are quite common).

I added a few more additional cleanup patches, since I worked
on the driver anyways.

Changes since PATCHv1 [0]:
 * Added patch converting the binding to YAML
 * Added patch fixing the steps default value
 * Added patch introducing dev_err_probe usage
 * Updated gpio push button patch from Mylène
  - use linux,push-code to be clear this is about the push button
  - add linux,push-type to support switches in addition to buttons
  - cleanup code a bit
   o 100 character line length
   o use dev_err_probe()
  - use EV_KEY and KEY_ENTER as default and make properties optional
  - use push-gpios instead of push-gpio in binding

[0] https://lore.kernel.org/linux-input/20190614133651.28396-1-mylene.josserand@bootlin.com/

-- Sebastian

Mylène Josserand (1):
  Input: rotary-encoder - Add gpio as push button

Sebastian Reichel (3):
  dt-bindings: input: Convert rotary-encoder bindings to schema
  Input: rotary-encoder - Fix steps property reading
  Input: rotary-encoder - Use dev_err_probe

 .../bindings/input/rotary-encoder.txt         |  50 --------
 .../bindings/input/rotary-encoder.yaml        | 121 ++++++++++++++++++
 drivers/input/misc/rotary_encoder.c           |  56 +++++++-
 3 files changed, 171 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/rotary-encoder.txt
 create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder.yaml

-- 
2.28.0

