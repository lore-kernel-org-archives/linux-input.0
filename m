Return-Path: <SRS0=FCD5=ZZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A30C432C0
	for <linux-input@archiver.kernel.org>; Tue,  3 Dec 2019 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2676205ED
	for <linux-input@archiver.kernel.org>; Tue,  3 Dec 2019 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfLCQkC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:40:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:8246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfLCQkC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Dec 2019 11:40:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 08:40:01 -0800
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="293859563"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 08:39:58 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v3 09/12] HID: picoLCD: constify fb ops
Date:   Tue,  3 Dec 2019 18:38:51 +0200
Message-Id: <f415010cd52cce7d8a1250d4eca582ec64e67956.1575390741.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1575390740.git.jani.nikula@intel.com>
References: <cover.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Now that the fbops member of struct fb_info is const, we can start
making the ops const as well.

v2: fix	typo (Christophe de Dinechin)

Cc: Bruno Prémont <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Bruno Prémont <bonbons@linux-vserver.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/hid/hid-picolcd_fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index e162a668fb7e..a549c42e8c90 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -417,8 +417,7 @@ static int picolcd_set_par(struct fb_info *info)
 	return 0;
 }
 
-/* Note this can't be const because of struct fb_info definition */
-static struct fb_ops picolcdfb_ops = {
+static const struct fb_ops picolcdfb_ops = {
 	.owner        = THIS_MODULE,
 	.fb_destroy   = picolcd_fb_destroy,
 	.fb_read      = fb_sys_read,
-- 
2.20.1

