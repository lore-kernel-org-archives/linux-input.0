From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: HID: hid-multitouch: Switch to device groups
Date: Wed, 8 Aug 2012 21:54:29 +0200
Message-ID: <20120808195429.GA1425@polaris.bitmath.org>
References: <20120808134408.GA25857@elgon.mountain>
 <20120808172829.GA1001@polaris.bitmath.org>
 <20120808180758.GC3734@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:46321 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030484Ab2HHTvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 15:51:17 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 8014EEA0BC
	for <linux-input@vger.kernel.org>; Wed,  8 Aug 2012 21:51:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120808180758.GC3734@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

On Wed, Aug 08, 2012 at 09:07:58PM +0300, Dan Carpenter wrote:
> On Wed, Aug 08, 2012 at 07:28:29PM +0200, Henrik Rydberg wrote:
> > Hi Dan,
> > 
> > > This is a semi-automatic email about new static checker warnings.
> > > 
> > > The patch 4fa3a5837b84: "HID: hid-multitouch: Switch to device 
> > > groups" from May 1, 2012, leads to the following Smatch complaint:
> > > 
> > > drivers/hid/hid-multitouch.c:735 mt_probe()
> > > 	 error: we previously assumed 'id' could be null (see line 694)
> > 
> > Yes, and the same patch also removes the reason 'id' could be null.
> 
> Great.  Could you remove the unneeded check in mt_probe() and give
> me a Reported-by: tag?

Ok, now I get it - I was pretty sure that test was not in mainline
anymore, but obviously I was wrong. Jiri, here is a patch for it, at
your convenience.

Thanks,
Henrik

---

>From 9e763540dd474648544da165955e44549a3990a0 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 8 Aug 2012 21:45:50 +0200
Subject: [PATCH] HID: hid-multitouch: Remove misleading null test

A null test was left behind during the autoloading work;
the test was introduced by 8d179a9e, but was never completely
reverted.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-multitouch.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 59c8b5c..f027cc9 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -691,12 +691,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct mt_device *td;
 	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
-	if (id) {
-		for (i = 0; mt_classes[i].name ; i++) {
-			if (id->driver_data == mt_classes[i].name) {
-				mtclass = &(mt_classes[i]);
-				break;
-			}
+	for (i = 0; mt_classes[i].name ; i++) {
+		if (id->driver_data == mt_classes[i].name) {
+			mtclass = &(mt_classes[i]);
+			break;
 		}
 	}
 
-- 
1.7.11.4

