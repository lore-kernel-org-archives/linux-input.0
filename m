From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Thu, 29 Nov 2012 01:20:04 +0100
Message-ID: <1655801.HZ7A866RlZ@vostro.rjw.lan>
References: <8159607.SRZZrRIPNF@orthese> <1418196.mMF7t2R2GI@orthese> <alpine.LNX.2.00.1211272123370.3933@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35636 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756391Ab2K2APU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 19:15:20 -0500
In-Reply-To: <alpine.LNX.2.00.1211272123370.3933@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Matthias Braun <jan_braun@gmx.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

On Tuesday, November 27, 2012 09:26:11 PM Jiri Kosina wrote:
> On Sun, 25 Nov 2012, Jan-Matthias Braun wrote:
> 
> > Hi all,
> > 
> > sorry for the e-mail address hopping. Answers to both addresses are okay.
> > 
> > I have now done a git bisection from 3.0 to 3.1 and have found commit
> > 1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race conditions between runtime PM and system sleep (v2)
> > to be the first one to introduce the necessity of a module reload after resume.

So with that commit your device doesn't work after resume from system suspend
unless you reload the driver?

> > I hope that this helps in finding a solution. As I (again) don't immediatly
> > know how to go on, I kindly ask you to give me some hints for testing/patching
> > or even a possible solution. :-)

Can you apply the patch below to the current mainline kernel and see if it makes any
difference, please?

Rafael


---
 drivers/base/power/main.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c
+++ linux/drivers/base/power/main.c
@@ -589,8 +589,6 @@ static int device_resume(struct device *
 	if (!dev->power.is_suspended)
 		goto Unlock;
 
-	pm_runtime_enable(dev);
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -1136,8 +1134,6 @@ static int __device_suspend(struct devic
 
 	if (error)
 		async_error = error;
-	else if (dev->power.is_suspended)
-		__pm_runtime_disable(dev, false);
 
 	return error;
 }


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
