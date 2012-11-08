From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: fix input-mt kernel-doc warning
Date: Thu, 8 Nov 2012 18:56:09 +0100
Message-ID: <20121108175609.GA11114@polaris.bitmath.org>
References: <5099B45E.8080105@infradead.org>
 <20121107194617.GA3738@polaris.bitmath.org>
 <20121108170431.GD8877@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:43335 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab2KHRuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 12:50:22 -0500
Content-Disposition: inline
In-Reply-To: <20121108170431.GD8877@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Dmitry,

> > > From: Randy Dunlap <rdunlap@infradead.org>
> > > 
> > > Fix new kernel-doc warning in input-mt.c:
> > > 
> > > Warning(drivers/input/input-mt.c:38): No description found for parameter 'flags'
> > 
> > Thanks for the patch. It seemed reasonable to expand the function
> > documentation a bit as well, hope you are alright with the patch
> > below, Dmitry, care to pick this up for 3.7? Otherwise I can carry it
> > for 3.8.
> 
> Randy, Henrik,
> 
> I'll try getting it in 3.7.

Seems there were more warnings introduced in 3.7-rc1... adding the
patch below seems to fix all of them. I guess you want to merge the
former patch into this one.

Thanks,
Henrik

>From 1ba1d5e18057260a3203625eaee22cc94393fda3 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Thu, 8 Nov 2012 18:48:22 +0100
Subject: [PATCH] Input: Document new struct members

Fixes kernel-doc warnings for the members added in 3.7-rc1.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 include/linux/input.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/input.h b/include/linux/input.h
index cab994b..2d55e55 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -112,6 +112,9 @@ struct input_value {
  * @h_list: list of input handles associated with the device. When
  *	accessing the list dev->mutex must be held
  * @node: used to place the device onto input_dev_list
+ * @num_vals: number of values queued in the current frame
+ * @max_vals: maximum number of values queued in a frame
+ * @vals: array of values queued in the current frame
  */
 struct input_dev {
 	const char *name;
-- 
1.8.0

