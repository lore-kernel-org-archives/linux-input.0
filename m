From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Fri, 22 Apr 2016 16:17:46 +0300
Message-ID: <20160422131746.GI4298@mwanda>
References: <CADemMPMSYfdbt5U6mgj=kdbBQKP_nWrah3M5ZuyZZk6soWJGjg@mail.gmail.com>
 <1461330060-35567-1-git-send-email-mdl@60hz.org>
 <1461330060-35567-2-git-send-email-mdl@60hz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21245 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbcDVNSH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2016 09:18:07 -0400
Content-Disposition: inline
In-Reply-To: <1461330060-35567-2-git-send-email-mdl@60hz.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Laws <mdl@60hz.org>
Cc: haiyangz@microsoft.com, devel@linuxdriverproject.org, linux-input@vger.kernel.org

Why is platform_create_bundle() failing?  It didn't fail in the first
version of the patch.

Btw, I'm not asking rhetorical questions, if I ask a question it means I
legitimately don't know the answer.

But I don't like this patch.  Could you describe how you have tested it
with real hardware?  What I want to know is that you loaded the module
without the hardware installed and then installed the hardware and got
it to work.  You have made that more complicated and you've said that
you're willing to complicate life for those users slightly because it's
a trade off for fixing your bug...  But that's sort of annoying and no
one has even tested how it works.

What I was really wondering last time was why can we not just do this?
Testing to see if the hardware is present is normally done in the
probe() function and not the init() function.  I have not tested this
and I don't know what happens when we do this.  Apparently, it causes
platform_create_bundle() to fail but I'm not sure why...  Maybe the
create bundle call probe() and that fails?

How hard would it be to separate these things out into two modules
really?  You say that you'd have to duplicate everything but maybe we
could instead just make the common functions into a library type thing..

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 4541957..4f0bc7c 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1573,10 +1573,6 @@ static int __init i8042_init(void)
 	if (err)
 		return err;
 
-	err = i8042_controller_check();
-	if (err)
-		goto err_platform_exit;
-
 	pdev = platform_create_bundle(&i8042_driver, i8042_probe, NULL, 0, NULL, 0);
 	if (IS_ERR(pdev)) {
 		err = PTR_ERR(pdev);
