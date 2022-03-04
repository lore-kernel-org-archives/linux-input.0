Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF023C433F5
	for <linux-input@archiver.kernel.org>; Fri,  4 Mar 2022 10:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiCDKlw (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiCDKlw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2022 05:41:52 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61821AAA41;
        Fri,  4 Mar 2022 02:41:00 -0800 (PST)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 25F4B2007F;
        Fri,  4 Mar 2022 11:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1646390459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gi3oag741MmfzNLj56sOKtyORMvHf4rZPmjeOraX1bc=;
        b=EhvHq2flWaQOrst+UhAEkjP3h48l7aex/820wc7aoecs5QQzb2/RS1qC5oEW9rXKF+Ut4B
        pDb4hUqo/y73GS3ffQ2sWSCMcIzc92ov+WttjIQLbJwM1pU3ZjUgIYyarWUdIBtEydT40t
        tKKtVkXwmNmIDQsyJ5iH9txgIq/azWo=
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics: change initialization error into warning
Date:   Fri,  4 Mar 2022 11:40:55 +0100
Message-Id: <20220304104055.9048-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Since touchpad work on Dell XPS 9360 as expected while using
Synopsys DesignWare driver, let's assume
warning about not loading driver can be lowered from error to warning.

Lower in some cases useless errors like these to warnings:
psmouse serio1: synaptics: Unable to query device: -5

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/mouse/synaptics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ffad142801b3..ffb13055c7dc 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1668,7 +1668,7 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 
 	error = synaptics_query_hardware(psmouse, &info);
 	if (error) {
-		psmouse_err(psmouse, "Unable to query device: %d\n", error);
+		psmouse_warn(psmouse, "Unable to query device: %d\n", error);
 		return error;
 	}
 
@@ -1824,7 +1824,7 @@ int synaptics_init_smbus(struct psmouse *psmouse)
 
 	error = synaptics_query_hardware(psmouse, &info);
 	if (error) {
-		psmouse_err(psmouse, "Unable to query device: %d\n", error);
+		psmouse_warn(psmouse, "Unable to query device: %d\n", error);
 		return error;
 	}
 
@@ -1864,7 +1864,7 @@ int synaptics_init(struct psmouse *psmouse)
 
 	error = synaptics_query_hardware(psmouse, &info);
 	if (error) {
-		psmouse_err(psmouse, "Unable to query device: %d\n", error);
+		psmouse_warn(psmouse, "Unable to query device: %d\n", error);
 		return error;
 	}
 
-- 
2.34.1

