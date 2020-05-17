Return-Path: <SRS0=rVKj=67=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E58C433E0
	for <linux-input@archiver.kernel.org>; Sun, 17 May 2020 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F8520674
	for <linux-input@archiver.kernel.org>; Sun, 17 May 2020 16:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEQQvv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 17 May 2020 12:51:51 -0400
Received: from traxus.robots.org.uk ([37.139.10.94]:56522 "EHLO
        traxus.robots.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgEQQvv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 May 2020 12:51:51 -0400
X-Greylist: delayed 2780 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 12:51:51 EDT
Received: from sam by traxus with local (Exim 4.92)
        (envelope-from <4badbd47580c65e3daf7ff5099fb72de98fc5c5e@traxus.robots.org.uk>)
        id 1jaLn7-0002Wb-V1
        for linux-input@vger.kernel.org; Sun, 17 May 2020 16:05:29 +0000
From:   Sam Morris <sam@robots.org.uk>
Date:   Sun, 17 May 2020 15:56:06 +0100
Subject: [PATCH] Use RMI/SMbus for Dynabook (Toshiba) X30/X40
To:     linux-input@vger.kernel.org
Message-Id: <E1jaLn7-0002Wb-V1@traxus>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Prevents a stream of garbage button press events from being emitted
whenever a hapless user touches the AccuPoint (pointing stick).

https://bugzilla.kernel.org/show_bug.cgi?id=205817

SynPD.inf from the Windows driver has a list of ACPI devices that may
also use InterTouch:

* ACPI\TOS0203
* ACPI\TOS0204
* ACPI\TOS0211
* ACPI\TOS0212
* ACPI\TOS0213
* ACPI\TOS0214
* ACPI\TOS1100
* ACPI\TOS110C
* ACPI\TOS110E
* ACPI\TOS1110
* ACPI\TOS1120
* ACPI\TOS1130
* ACPI\TOS1131
* ACPI\TOS1140
* ACPI\TOS1150
* ACPI\TOS1151
* ACPI\TOS1160
* ACPI\TOS1161
* ACPI\TOS1162
* ACPI\TOS2020
* ACPI\TTP1606
* ACPI\TTP1607

Signed-off-by: Sam Morris <sam@robots.org.uk>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 4d2036209b45..76812475de57 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -187,6 +187,7 @@ static const char * const smbus_pnp_ids[] = {
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
 	"SYN3257", /* HP Envy 13-ad105ng */
+	"TOS0213", /* Dynabook (Toshiba) X30, X40 */
 	NULL
 };
 
-- 
Sam Morris
<https://robots.org.uk/>
