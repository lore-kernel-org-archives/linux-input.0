Return-Path: <SRS0=FvaY=6V=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B332C47257
	for <linux-input@archiver.kernel.org>; Thu,  7 May 2020 06:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BE2208D6
	for <linux-input@archiver.kernel.org>; Thu,  7 May 2020 06:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgEGGU0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 7 May 2020 02:20:26 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:35398 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGGU0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 7 May 2020 02:20:26 -0400
Received: from zenbar.fritz.box (pD95EF2E9.dip0.t-ipconnect.de [217.94.242.233])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 15C4F405546;
        Thu,  7 May 2020 06:17:44 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, m.felsch@pengutronix.de,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 0/3] Input: ads7846: pdata cleanups and devm init
Date:   Thu,  7 May 2020 08:20:10 +0200
Message-Id: <20200507062014.1780360-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

This is v3 of the patches to bring devm initialization to the ads7846
driver. I left the gpiod conversion patch out for now as it needs more
work, and it's also independent of the other changes.

v3:

* Added a patch to remove custom filter handling from pdata
* Added devm_add_action_or_reset() for regulator state maintaining
* Addressed minor nits pointed out by Marco Felsch

Daniel Mack (3):
  Input: ads7846: Add short-hand for spi->dev in probe() function
  Input: ads7846: Remove custom filter handling functions from pdata
  Input: ads7846: Switch to devm initialization

 drivers/input/touchscreen/ads7846.c | 185 +++++++++++-----------------
 include/linux/spi/ads7846.h         |  15 ---
 2 files changed, 72 insertions(+), 128 deletions(-)

-- 
2.26.2

