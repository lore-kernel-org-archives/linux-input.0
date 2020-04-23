Return-Path: <SRS0=ZRwI=6H=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B3C54FCB
	for <linux-input@archiver.kernel.org>; Thu, 23 Apr 2020 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F1720736
	for <linux-input@archiver.kernel.org>; Thu, 23 Apr 2020 17:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgDWRil (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:38:41 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:46436 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbgDWRil (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Apr 2020 13:38:41 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7DD752491C;
        Thu, 23 Apr 2020 19:33:25 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Chen <james.chen@emc.com.tw>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Liu <scott.liu@emc.com.tw>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/1] dt-bindings: input: touchscreen: elants_i2c: convert to YAML
Date:   Thu, 23 Apr 2020 19:32:52 +0200
Message-Id: <20200423173253.711725-1-david@ixit.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Depends elants_i2c series from Michal [1].

[1] https://patchwork.kernel.org/project/linux-input/list/?series=270071

David Heidelberg (1):
  dt-bindings: input: touchscreen: elants_i2c: convert to YAML

 .../devicetree/bindings/input/elants_i2c.txt  | 34 ---------
 .../input/touchscreen/elan,elants_i2c.yaml    | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/elants_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml

-- 
2.26.2

