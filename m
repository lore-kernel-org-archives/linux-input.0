Return-Path: <SRS0=xHC6=7B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017BEC433DF
	for <linux-input@archiver.kernel.org>; Tue, 19 May 2020 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5D2207D3
	for <linux-input@archiver.kernel.org>; Tue, 19 May 2020 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgESSZt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 19 May 2020 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESSZt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 May 2020 14:25:49 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4FBC08C5C0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2020 11:25:48 -0700 (PDT)
Received: from zenbar.fritz.box (pd95ef292.dip0.t-ipconnect.de [217.94.242.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1E56F298AD5;
        Tue, 19 May 2020 18:22:52 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, m.felsch@pengutronix.de,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 0/3] Input: ads7846: pdata cleanups and devm init
Date:   Tue, 19 May 2020 20:25:37 +0200
Message-Id: <20200519182540.219027-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

This is v4 of the patches to bring devm initialization to the ads7846
driver. I left the gpiod conversion patch out for now as it needs more
work, and it's also independent of the other changes.

v3:

* Added a patch to remove custom filter handling from pdata
* Added devm_add_action_or_reset() for regulator state maintaining
* Addressed minor nits pointed out by Marco Felsch

v4:

* Call ads7846_stop() rather than ads7846_disable() in the unbind
  path to avoid regulator refcount confusion, Thanks to Marco Felsch.

Daniel Mack (3):
  Input: ads7846: Add short-hand for spi->dev in probe() function
  Input: ads7846: Remove custom filter handling functions from pdata
  Input: ads7846: Switch to devm initialization

 drivers/input/touchscreen/ads7846.c | 187 +++++++++++-----------------
 include/linux/spi/ads7846.h         |  15 ---
 2 files changed, 73 insertions(+), 129 deletions(-)

-- 
2.26.2

