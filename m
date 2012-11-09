From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] input: stmpe-ts: Use devm_*() routines
Date: Fri, 9 Nov 2012 22:34:35 +0530
Message-ID: <CAKohpomC1KTLk=UVim4gdYhJ5kngTZHOUvUgckD75AVH1w+FHw@mail.gmail.com>
References: <3d6f34ca5960203a5efb761f4d56b4e10ee24827.1352474824.git.viresh.kumar@linaro.org>
	<52b9fe53a8bd8dff7105209c5b1fab9da7a1510d.1352474824.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52b9fe53a8bd8dff7105209c5b1fab9da7a1510d.1352474824.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-input@vger.kernel.org

On 9 November 2012 20:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch frees stmpe-ts driver from tension of freeing resources :)
> devm_* derivatives of multiple routines are used while allocating resources,
> which would be freed automatically by kernel.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Fixup:

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
