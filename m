Return-Path: <SRS0=al0s=2W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE2C2D0DC
	for <linux-input@archiver.kernel.org>; Wed,  1 Jan 2020 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956FB2072C
	for <linux-input@archiver.kernel.org>; Wed,  1 Jan 2020 14:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+WdmKY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAAOyn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 1 Jan 2020 09:54:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26855 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbgAAOym (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Jan 2020 09:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577890481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BhQSqzpr10ZOar3Svs2eR1Z1WBNA3SkO1g7okR08aQ=;
        b=T+WdmKY+xUw1Gbw/OfvsbKLxKoEi3C4HGAEQ+4cXFh8dlTUGdAXRmaia8kdgISBzNj5NLf
        KkGRhRAt9PJEVn3X174ZJPJMDlYt/Gg4p7RFZhzwvR26gdFTsv31dP7h3JMbL9oARsRBHW
        N5727ZbKHx6Pk7vxLQHny4qYQ0av7Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-m7VWrpslNwiH2VTNLMWNLg-1; Wed, 01 Jan 2020 09:54:41 -0500
X-MC-Unique: m7VWrpslNwiH2VTNLMWNLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2BE2477;
        Wed,  1 Jan 2020 14:54:39 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-55.ams2.redhat.com [10.36.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D28883C09;
        Wed,  1 Jan 2020 14:54:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        Dmitry Mastykin <mastichi@gmail.com>
Subject: [PATCH 07/10] Input: goodix - Move defines to above struct goodix_ts_data declaration
Date:   Wed,  1 Jan 2020 15:54:26 +0100
Message-Id: <20200101145429.16185-7-hdegoede@redhat.com>
In-Reply-To: <20200101145429.16185-1-hdegoede@redhat.com>
References: <20200101145429.16185-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Move the  defines to above the struct goodix_ts_data declaration, so
that the MAX defines can be used inside the struct goodix_ts_data
declaration. No functional changes, just moving a block of code.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1786317
BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D199207
Cc: Dmitry Mastykin <mastichi@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/goodix.c | 60 +++++++++++++++---------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscre=
en/goodix.c
index 784c4dd8c430..66d6bb74507d 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -29,6 +29,36 @@
 #include <linux/of.h>
 #include <asm/unaligned.h>
=20
+#define GOODIX_GPIO_INT_NAME		"irq"
+#define GOODIX_GPIO_RST_NAME		"reset"
+
+#define GOODIX_MAX_HEIGHT		4096
+#define GOODIX_MAX_WIDTH		4096
+#define GOODIX_INT_TRIGGER		1
+#define GOODIX_CONTACT_SIZE		8
+#define GOODIX_MAX_CONTACT_SIZE		9
+#define GOODIX_MAX_CONTACTS		10
+
+#define GOODIX_CONFIG_MAX_LENGTH	240
+#define GOODIX_CONFIG_911_LENGTH	186
+#define GOODIX_CONFIG_967_LENGTH	228
+
+/* Register defines */
+#define GOODIX_REG_COMMAND		0x8040
+#define GOODIX_CMD_SCREEN_OFF		0x05
+
+#define GOODIX_READ_COOR_ADDR		0x814E
+#define GOODIX_GT1X_REG_CONFIG_DATA	0x8050
+#define GOODIX_GT9X_REG_CONFIG_DATA	0x8047
+#define GOODIX_REG_ID			0x8140
+
+#define GOODIX_BUFFER_STATUS_READY	BIT(7)
+#define GOODIX_BUFFER_STATUS_TIMEOUT	20
+
+#define RESOLUTION_LOC		1
+#define MAX_CONTACTS_LOC	5
+#define TRIGGER_LOC		6
+
 struct goodix_ts_data;
=20
 enum goodix_irq_pin_access_method {
@@ -68,36 +98,6 @@ struct goodix_ts_data {
 	unsigned int contact_size;
 };
=20
-#define GOODIX_GPIO_INT_NAME		"irq"
-#define GOODIX_GPIO_RST_NAME		"reset"
-
-#define GOODIX_MAX_HEIGHT		4096
-#define GOODIX_MAX_WIDTH		4096
-#define GOODIX_INT_TRIGGER		1
-#define GOODIX_CONTACT_SIZE		8
-#define GOODIX_MAX_CONTACT_SIZE		9
-#define GOODIX_MAX_CONTACTS		10
-
-#define GOODIX_CONFIG_MAX_LENGTH	240
-#define GOODIX_CONFIG_911_LENGTH	186
-#define GOODIX_CONFIG_967_LENGTH	228
-
-/* Register defines */
-#define GOODIX_REG_COMMAND		0x8040
-#define GOODIX_CMD_SCREEN_OFF		0x05
-
-#define GOODIX_READ_COOR_ADDR		0x814E
-#define GOODIX_GT1X_REG_CONFIG_DATA	0x8050
-#define GOODIX_GT9X_REG_CONFIG_DATA	0x8047
-#define GOODIX_REG_ID			0x8140
-
-#define GOODIX_BUFFER_STATUS_READY	BIT(7)
-#define GOODIX_BUFFER_STATUS_TIMEOUT	20
-
-#define RESOLUTION_LOC		1
-#define MAX_CONTACTS_LOC	5
-#define TRIGGER_LOC		6
-
 static int goodix_check_cfg_8(struct goodix_ts_data *ts,
 			const struct firmware *cfg);
 static int goodix_check_cfg_16(struct goodix_ts_data *ts,
--=20
2.24.1

