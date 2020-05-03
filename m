Return-Path: <SRS0=LbEz=6R=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D9C28CBC
	for <linux-input@archiver.kernel.org>; Sun,  3 May 2020 20:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4C520721
	for <linux-input@archiver.kernel.org>; Sun,  3 May 2020 20:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgECUMo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 3 May 2020 16:12:44 -0400
Received: from v6.sk ([167.172.42.174]:35958 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgECUMo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 3 May 2020 16:12:44 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 54D90610C9;
        Sun,  3 May 2020 20:12:42 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add driver for power button on Dell Wyse 3020
Date:   Sun,  3 May 2020 22:12:35 +0200
Message-Id: <20200503201237.413864-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

please consider applying the patches chained to this message. It's a
rather simple driver for a power button on Dell Ariel board along with
the Device Tree binding document.

Thank you
Lubo


