Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305BECAAD5
	for <linux-input@archiver.kernel.org>; Fri,  2 Sep 2022 12:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiIBMru (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiIBMrU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2022 08:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C7FF1B68;
        Fri,  2 Sep 2022 05:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9640621C5;
        Fri,  2 Sep 2022 12:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B9CC433D6;
        Fri,  2 Sep 2022 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662121968;
        bh=Bs2CQBsnUjpIZ+XxHHFSiRhfkB928kkGSKMck2e8gws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2S7f3DLAcGIv/TbAkH8hmjUJtkK4Db4EdFarO78GYsnrHDzOoQ+0t54Lfv1TAnY5h
         m7DoUKjgHtFy36be93UiiEMqmd2ljIG5e7fB6hNPqLvIgEPWnkZnPi5mc4Dbm9nmRz
         TnfkRiEBxoeEY5OadduRKnL1YcUz8oZYffTYCDPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.15 27/73] HID: steam: Prevent NULL pointer dereference in steam_{recv,send}_report
Date:   Fri,  2 Sep 2022 14:18:51 +0200
Message-Id: <20220902121405.336885912@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121404.435662285@linuxfoundation.org>
References: <20220902121404.435662285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

commit cd11d1a6114bd4bc6450ae59f6e110ec47362126 upstream.

It is possible for a malicious device to forgo submitting a Feature
Report.  The HID Steam driver presently makes no prevision for this
and de-references the 'struct hid_report' pointer obtained from the
HID devices without first checking its validity.  Let's change that.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Fixes: c164d6abf3841 ("HID: add driver for Valve Steam Controller")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-steam.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -134,6 +134,11 @@ static int steam_recv_report(struct stea
 	int ret;
 
 	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
+	if (!r) {
+		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
+		return -EINVAL;
+	}
+
 	if (hid_report_len(r) < 64)
 		return -EINVAL;
 
@@ -165,6 +170,11 @@ static int steam_send_report(struct stea
 	int ret;
 
 	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
+	if (!r) {
+		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
+		return -EINVAL;
+	}
+
 	if (hid_report_len(r) < 64)
 		return -EINVAL;
 


