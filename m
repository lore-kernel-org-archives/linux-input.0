Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55796C432C3
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251A12072D
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402518;
	bh=72si8NNBzDHWEy6P8LB/sxnbv3JGkev8Astuf7ElLT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHZ5t6AyHA7abMvQ+hng07fY7ypMBURe+YIC+238e4PJV8N61GPW7kFKwZ+G6ck0K
	 +wnxHj82DUEcNtoz7XeEbgOXmgsTJW6+tE1buJb7nV5bUafIajTuQepgzQiWw872KP
	 mLJmkZw6oE1LosfCsmxTVY+5/D8UcW5mZqjl+6g4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfKVGB4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfKVGBz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828B52070B;
        Fri, 22 Nov 2019 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402515;
        bh=72si8NNBzDHWEy6P8LB/sxnbv3JGkev8Astuf7ElLT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHnaP7Cjety9pc+KiQQVJVGvgHG52wGh6UQ2Ns11C3GsLzKIVCgX26x4uDOwEAPr1
         Olo7Xe8T+3f25vu6l70LfsLeuR8GdXXU5L7zilPdVu/sve/LCP0kO4lvF6sivDO0uL
         vfI0cC8vM9TfXm2Hdw051Wvaf0jGNgdizU0FVbWw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 24/91] HID: intel-ish-hid: fixes incorrect error handling
Date:   Fri, 22 Nov 2019 01:00:22 -0500
Message-Id: <20191122060129.4239-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 6e0856d317440a950b17c00a9283114f025e5699 ]

The memory chunk allocated by hid_allocate_device() should be released
by hid_destroy_device(), not kfree().

Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 277983aa1d90a..d0b902285fc3a 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 err_hid_device:
 	kfree(hid_data);
 err_hid_data:
-	kfree(hid);
+	hid_destroy_device(hid);
 	return rv;
 }
 
-- 
2.20.1

