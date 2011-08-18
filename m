From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 5/6] Input: elantech - clean up elantech_init
Date: Thu, 18 Aug 2011 14:34:57 +0800
Message-ID: <4E4CB291.5010102@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-6-git-send-email-jj_ding@emc.com.tw>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56490 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab1HRGgg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 02:36:36 -0400
In-Reply-To: <1313632629-23603-6-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On 08/18/2011 09:57 AM, JJ Ding wrote:
>   	if (elantech_set_absolute_mode(psmouse)) {
>   		pr_err("failed to put touchpad into absolute mode.\n");
>   		goto init_fail;
Hi JJ,
--
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index e13a719..675c236 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1069,7 +1069,7 @@ int elantech_init(struct psmouse *psmouse)

         return 0;

- init_fail:
+init_fail:
         kfree(etd);
         return -1;
  }
--

also has space before *init_fail*, you may do this in your next version.

Thanks
-Wanlong Gao
