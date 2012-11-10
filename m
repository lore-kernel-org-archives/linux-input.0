From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] input: stmpe-ts: Use devm_*() routines
Date: Sat, 10 Nov 2012 13:33:47 +0530
Message-ID: <CAKohponua2d95scdwmNsnVpG18nFYA1cuQa703kPfR7D8gF5fg@mail.gmail.com>
References: <3d6f34ca5960203a5efb761f4d56b4e10ee24827.1352474824.git.viresh.kumar@linaro.org>
	<52b9fe53a8bd8dff7105209c5b1fab9da7a1510d.1352474824.git.viresh.kumar@linaro.org>
	<CAKohpomC1KTLk=UVim4gdYhJ5kngTZHOUvUgckD75AVH1w+FHw@mail.gmail.com>
	<20121110080009.GA12015@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:44466 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab2KJIDr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Nov 2012 03:03:47 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so3284758iag.19
        for <linux-input@vger.kernel.org>; Sat, 10 Nov 2012 00:03:47 -0800 (PST)
In-Reply-To: <20121110080009.GA12015@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com

On 10 November 2012 13:30, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Sometimes your mailer does wrap long lines, please make sure to turn it
> off for patches.

I am using gmail for replying on mails and this fixup was done using that. Don't
know why it happened.

I am doing the same step again to verify what's playing with patches.
On this copy
i can see that this issue isn't there till now.

commit dda6d45808d65aaf8b0d4153e7a418b255365818
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Nov 9 22:28:26 2012 +0530

    fixup! input: stmpe-ts: Use devm_*() routines
---
 drivers/input/touchscreen/stmpe-ts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c
b/drivers/input/touchscreen/stmpe-ts.c
index 9896095..f2cb15d 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -344,8 +344,6 @@ static int __devexit stmpe_ts_remove(struct
platform_device *pdev)

        stmpe_disable(ts->stmpe, STMPE_BLOCK_TOUCHSCREEN);

-       input_unregister_device(ts->idev);
-
        return 0;
 }

--
viresh
