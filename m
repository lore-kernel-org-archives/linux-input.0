From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Thu, 29 Nov 2012 23:28:55 +0100
Message-ID: <2305931.9GBOrRiDsv@vostro.rjw.lan>
References: <8159607.SRZZrRIPNF@orthese> <1655801.HZ7A866RlZ@vostro.rjw.lan> <3334839.0y63iIARTX@orthese>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36509 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776Ab2K2WYK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 17:24:10 -0500
In-Reply-To: <3334839.0y63iIARTX@orthese>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Matthias Braun <jan_braun@gmx.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

On Thursday, November 29, 2012 03:03:04 PM Jan-Matthias Braun wrote:
> Hi Rafael,
> 
> thanks for looking into this.
> 
> Am Donnerstag, 29. November 2012, 01:20:04 schrieb Rafael J. Wysocki:
> > On Tuesday, November 27, 2012 09:26:11 PM Jiri Kosina wrote:
> > > On Sun, 25 Nov 2012, Jan-Matthias Braun wrote:
> > > > I have now done a git bisection from 3.0 to 3.1 and have found commit
> > > > 1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race conditions between runtime PM and system sleep (v2)
> > > > to be the first one to introduce the necessity of a module reload after resume.
> > 
> > So with that commit your device doesn't work after resume from system suspend
> > unless you reload the driver?
> 
> Yes. Additionally, with later kernel revisions even this won't help, but I could imagine this to be a consequence of the same problem.
> 
> > > > I hope that this helps in finding a solution. As I (again) don't immediatly
> > > > know how to go on, I kindly ask you to give me some hints for testing/patching
> > > > or even a possible solution. :-)
> > 
> > Can you apply the patch below to the current mainline kernel and see if it makes any
> > difference, please?
> 
> It does: Current mainline kernel (version >3.7.0-rc7 from git) is not showing
> the problem, if the patch is applied.

If you apply the patch below instead of the previous one, does it make
the problem return, or is it still good?

Rafael


---
 drivers/base/power/main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c
+++ linux/drivers/base/power/main.c
@@ -513,6 +513,8 @@ static int device_resume_early(struct de
 
  Out:
 	TRACE_RESUME(error);
+
+	pm_runtime_enable(dev);
 	return error;
 }
 
@@ -589,8 +591,6 @@ static int device_resume(struct device *
 	if (!dev->power.is_suspended)
 		goto Unlock;
 
-	pm_runtime_enable(dev);
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -930,6 +930,8 @@ static int device_suspend_late(struct de
 	pm_callback_t callback = NULL;
 	char *info = NULL;
 
+	__pm_runtime_disable(dev, false);
+
 	if (dev->power.syscore)
 		return 0;
 
@@ -1133,11 +1135,8 @@ static int __device_suspend(struct devic
 
  Complete:
 	complete_all(&dev->power.completion);
-
 	if (error)
 		async_error = error;
-	else if (dev->power.is_suspended)
-		__pm_runtime_disable(dev, false);
 
 	return error;
 }



-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
