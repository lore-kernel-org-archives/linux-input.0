From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 0/3] Input: Cypress TTSP device driver
Date: Tue, 8 Nov 2011 00:17:01 -0800
Message-ID: <20111108081701.GC1837@core.coreip.homeip.net>
References: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
 <CAAwP0s0g8pu8zz8J+wEeD6iqH8XN8bqzT-rOQwPYA9jyw8RL7g@mail.gmail.com>
 <20111101152015.GA2183@polaris.bitmath.org>
 <CAAwP0s3qfTKFngj3bXgZdOHVqDPEuqNB2MxezkCp7+WTaiEwLw@mail.gmail.com>
 <CAAwP0s0H5-cpGGn-x9+5praGs2+7kTyG==k36Y7zB_-d8SHO7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58760 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1KHIRL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 03:17:11 -0500
Received: by qao25 with SMTP id 25so112361qao.19
        for <linux-input@vger.kernel.org>; Tue, 08 Nov 2011 00:17:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAwP0s0H5-cpGGn-x9+5praGs2+7kTyG==k36Y7zB_-d8SHO7Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Hi Javier,

On Mon, Nov 07, 2011 at 09:17:57AM +0100, Javier Martinez Canillas wrote:
 
> Hello Dmitry,
> 
> Do you have any comments on this issue?
> 

Sorry for the delay and I promise your driver is next on my list.

The driver seems in much better shape than it was last time I looked at
it. Below are 2 tiny patches I still have from last time I tried
going over the code.

Thanks.

-- 
Dmitry


Input: cyttsp - fix use-after-free in syttsp_release

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Once input_unregister_device() is called we may not assume that
ts->input contains valid pointer. Besides, input core takes care of
freeing MT slot memory.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp/cyttsp_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_core.c b/drivers/input/touchscreen/cyttsp/cyttsp_core.c
index 103ac39..240998d 100644
--- a/drivers/input/touchscreen/cyttsp/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp/cyttsp_core.c
@@ -660,7 +660,6 @@ void cyttsp_core_release(void *handle)
 		input_unregister_device(ts->input);
 		if (ts->platform_data->exit)
 			ts->platform_data->exit();
-		input_mt_destroy_slots(ts->input);
 		kfree(ts);
 	}
 }



Input: cyttsp - remove ext() method from bus ops

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

It is not used anywhere and so is not needed

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp/cyttsp_core.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_core.h b/drivers/input/touchscreen/cyttsp/cyttsp_core.h
index efefdb9..c4c7d9e 100644
--- a/drivers/input/touchscreen/cyttsp/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp/cyttsp_core.h
@@ -44,7 +44,6 @@
 struct cyttsp_bus_ops {
 	s32 (*write)(void *handle, u8 addr, u8 length, const void *values);
 	s32 (*read)(void *handle, u8 addr, u8 length, void *values);
-	s32 (*ext)(void *handle, void *values);
 	struct device *dev;
 };
 
