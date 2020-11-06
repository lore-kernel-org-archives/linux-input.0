Return-Path: <SRS0=gGDZ=EM=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F706C5517A
	for <linux-input@archiver.kernel.org>; Fri,  6 Nov 2020 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0ADF20720
	for <linux-input@archiver.kernel.org>; Fri,  6 Nov 2020 10:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgKFKMd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:12:33 -0500
Received: from david.siemens.de ([192.35.17.14]:52750 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgKFKMc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Nov 2020 05:12:32 -0500
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0A6ACI4K009414
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 11:12:18 +0100
Received: from dev.vm7.ccp.siemens.com ([139.22.40.104])
        by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id 0A6ACHKU025430;
        Fri, 6 Nov 2020 11:12:17 +0100
Received: from dev.vm7.ccp.siemens.com (localhost [127.0.0.1])
        by dev.vm7.ccp.siemens.com (Postfix) with ESMTP id A67B170BAB5;
        Fri,  6 Nov 2020 11:05:55 +0100 (CET)
From:   Andrej Valek <andrej.valek@siemens.com>
To:     robh@kernel.org, nick@shmanahar.org, hadess@hadess.net,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrej Valek <andrej.valek@siemens.com>
Subject: [PATCH v2 0/3] Firmware loading option
Date:   Fri,  6 Nov 2020 11:05:36 +0100
Message-Id: <20201106100539.6646-1-andrej.valek@siemens.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029170313.25529-1-andrej.valek@siemens.com>
References: <20201029170313.25529-1-andrej.valek@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add option to prevent firmware/configuration loading during each boot.

Andrej Valek (3):
  Input: st1232 - add support resolution reading
  dt-bindings: goodix
  Input: goodix - add option to disable firmware loading

 .../bindings/input/touchscreen/goodix.yaml    |  2 +-
 drivers/input/touchscreen/goodix.c            |  2 +-
 drivers/input/touchscreen/st1232.c            | 52 +++++++++++++------
 3 files changed, 38 insertions(+), 18 deletions(-)

-- 
2.20.1

