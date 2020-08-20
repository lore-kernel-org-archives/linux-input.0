Return-Path: <SRS0=lYs1=B6=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B5DC433E1
	for <linux-input@archiver.kernel.org>; Thu, 20 Aug 2020 00:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA6E207DA
	for <linux-input@archiver.kernel.org>; Thu, 20 Aug 2020 00:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882306;
	bh=bTH5iXVwhap6MKUOjysl2NNrLylw8YNHEzLt+9lZNL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8AP5IQci1BZZLydr61OFbDakwmII+5RCksQvQtg71xK7esSlZ1YLpiF7fvr9fJbT
	 AAk4PZ6AGVDLLFALKpe2WuIiWrtQVgdFsCxW7fUhUaZA7LDcQOBI1F9lwvAoVO4rO0
	 4D3G+4q67K5ESowdrA/e9S/8r83yGbE1vcM9os2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHTAL0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgHTACF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC00621775;
        Thu, 20 Aug 2020 00:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881725;
        bh=bTH5iXVwhap6MKUOjysl2NNrLylw8YNHEzLt+9lZNL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1R/BcfHrVvUQ4o5ce3SbP5sNnOg9ppT63yRFmaGGW3JyBu1yOT0gikm2b1Kruclfx
         68M9sShx+a8Vp3MoypRWdY+f5FADeEYuGELNk7rwsUgpQsEpMuISmN1h68i4rK4+fx
         XyoStLisv/NO7DaRLyGx2+EhnhMhe5o2RtnNvFfk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 07/24] Input: psmouse - add a newline when printing 'proto' by sysfs
Date:   Wed, 19 Aug 2020 20:01:38 -0400
Message-Id: <20200820000155.215089-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000155.215089-1-sashal@kernel.org>
References: <20200820000155.215089-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit 4aec14de3a15cf9789a0e19c847f164776f49473 ]

When I cat parameter 'proto' by sysfs, it displays as follows. It's
better to add a newline for easy reading.

root@syzkaller:~# cat /sys/module/psmouse/parameters/proto
autoroot@syzkaller:~#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/20200720073846.120724-1-wangxiongfeng2@huawei.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/psmouse-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 527ae0b9a191e..0b4a3039f312f 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -2042,7 +2042,7 @@ static int psmouse_get_maxproto(char *buffer, const struct kernel_param *kp)
 {
 	int type = *((unsigned int *)kp->arg);
 
-	return sprintf(buffer, "%s", psmouse_protocol_by_type(type)->name);
+	return sprintf(buffer, "%s\n", psmouse_protocol_by_type(type)->name);
 }
 
 static int __init psmouse_init(void)
-- 
2.25.1

