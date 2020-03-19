Return-Path: <SRS0=5of2=5E=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21028C4332B
	for <linux-input@archiver.kernel.org>; Thu, 19 Mar 2020 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0338A20CC7
	for <linux-input@archiver.kernel.org>; Thu, 19 Mar 2020 15:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCSPCo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:02:44 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:5502 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgCSPCn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Mar 2020 11:02:43 -0400
IronPort-SDR: vlsjRHpcXiLoa3gqLqNLp/lDS8T+cj+P/9dzLE+M9v5SFZZUW1a5a2p6SaLa1Bcz84QdYqQPBY
 2PWRHGrLGjtoX/ONQa7e3aOUFAAhYoXItRVjVz6XdgEvbJUUli9rqCWub9mgLmvhX1SRpbVakM
 NIFEFzG94QoxrMfSPkaQCiAMtUiry09iEMyuh0fj5Kh/XAeyYedFEZ1Pv6ca/YEPrttOYVKEgD
 vFiv5c3AN/lgVxmsA4soIYrVBEZJg1R3aK5Sg9/NOcnMKTHbTepTfyfYPa3XYo6RNXQ2EfMBYM
 7L8=
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="46818860"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 19 Mar 2020 07:02:43 -0800
IronPort-SDR: CKCIL9tpA0XvZJErtxAM/Y2cQM+DlSH5z4UWVmX/DRvwv0KMdlF+J2Ais3BczfXUIUVrZBhYJj
 0Jr0VGPgyIkxuJ/mwPBK4GWjT+ufMXga7jRoHCERclxlG/kUM0eZKCzr6x2ZA8h/EhvK6cl34l
 sK6+EgHRLpKbYsKgvVRu0OH/r1esUX/ygoJsec3lSeL6j5L0EjJmtM/1dhqnW8aGdAJXP0hAaj
 TGvdIMspGANEWyWkQb/77GmIlFCL+bvnjF4Ayc7ayCtPenykgQMSEr4JpqPvXoHa9rov+rIdYT
 9hk=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <bsz@semihalf.com>, <rydberg@bitmath.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v8 36/52] input: atmel_mxt_ts: export GPIO reset line via sysfs
Date:   Thu, 19 Mar 2020 08:00:00 -0700
Message-ID: <20200319150016.61398-37-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319150016.61398-1-jiada_wang@mentor.com>
References: <20200319150016.61398-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: "George G. Davis" <george_davis@mentor.com>

N.B. Modifying the atmel_mxt_ts GPIO reset line during operation will
cause problems with normal driver operation.  This feature is provided
as a diagnostic debug aid.  It does not take into consideration any
pending operations which may be in progress.  Modifying the atmel_mxt_ts
GPIO reset line at any time will inevitably cause the driver to fail.

Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Rajeev Kumar <rajeev_kumar@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 18372e8d1ef2..fd3db4f8d55d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -4083,6 +4083,19 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
+	if (data->reset_gpio) {
+		error = gpiod_export(data->reset_gpio, 0);
+		if (error)
+			return error;
+
+		error = gpiod_export_link(&client->dev, "reset",
+					  data->reset_gpio);
+		if (error) {
+			gpiod_unexport(data->reset_gpio);
+			return error;
+		}
+	}
+
 	if (data->suspend_mode == MXT_SUSPEND_REGULATOR) {
 		error = mxt_acquire_irq(data);
 		if (error)
@@ -4115,6 +4128,10 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 err_free_object:
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
+	if (data->reset_gpio) {
+		sysfs_remove_link(&client->dev.kobj, "reset");
+		gpiod_unexport(data->reset_gpio);
+	}
 	return error;
 }
 
@@ -4124,6 +4141,10 @@ static int mxt_remove(struct i2c_client *client)
 
 	disable_irq(data->irq);
 	sysfs_remove_group(&client->dev.kobj, &mxt_fw_attr_group);
+	if (data->reset_gpio) {
+		sysfs_remove_link(&client->dev.kobj, "reset");
+		gpiod_unexport(data->reset_gpio);
+	}
 	mxt_debug_msg_remove(data);
 	mxt_sysfs_remove(data);
 	mxt_free_input_device(data);
-- 
2.17.1

