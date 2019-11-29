Return-Path: <SRS0=jluN=ZV=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D793C432C0
	for <linux-input@archiver.kernel.org>; Fri, 29 Nov 2019 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A892086A
	for <linux-input@archiver.kernel.org>; Fri, 29 Nov 2019 13:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfK2NfQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:35:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfK2NfQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Nov 2019 08:35:16 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iagQV-0005EG-3h; Fri, 29 Nov 2019 14:35:15 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH] Input: synaptics-rmi4 - re-enable IRQs in f34v7_do_reflash
Date:   Fri, 29 Nov 2019 14:35:14 +0100
Message-Id: <20191129133514.23224-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

F34 is a bit special as it reinitializes the device and related driver
structs during the firmware update. This clears the fn_irq_mask which
will then prevent F34 from receiving further interrupts, leading to
timeouts during the firmware update. Make sure to reinitialize the
IRQ enables at the appropriate times.

The issue is in F34 code, but the commit in the fixes tag exposed the
issue, as before this commit things would work by accident.

Fixes: 363c53875aef (Input: synaptics-rmi4 - avoid processing unknown IRQs)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/input/rmi4/rmi_f34v7.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index a4cabf52740c..74f7c6f214ff 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1189,6 +1189,9 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 {
 	int ret;
 
+	f34->fn->rmi_dev->driver->set_irq_bits(f34->fn->rmi_dev,
+					       f34->fn->irq_mask);
+
 	rmi_f34v7_read_queries_bl_version(f34);
 
 	f34->v7.image = fw->data;
-- 
2.20.1

