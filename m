From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: List corruption in hidraw_release in 3.11-rc4
Date: Wed, 7 Aug 2013 03:01:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308070258480.10817@pobox.suse.cz>
References: <6712128.bn50J4si9x@al>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35650 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756110Ab3HGBB3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Aug 2013 21:01:29 -0400
In-Reply-To: <6712128.bn50J4si9x@al>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
Cc: linux-input@vger.kernel.org, Manoj Chourasia <mchourasia@nvidia.com>, linux-kernel@vger.kernel.org, alnovak@suse.cz

On Tue, 6 Aug 2013, Peter Wu wrote:

> While debugging upowerd (with Logitech Unifying receiver via hidraw),
> I came across this list corruption warning.

Peter,

does the patch below fix the problem you are seeing?

---
 drivers/hid/hidraw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index a745163..6f1feb2 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -518,7 +518,6 @@ int hidraw_connect(struct hid_device *hid)
 		goto out;
 	}
 
-	mutex_unlock(&minors_lock);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->list);
 
@@ -528,6 +527,7 @@ int hidraw_connect(struct hid_device *hid)
 	dev->exist = 1;
 	hid->hidraw = dev;
 
+	mutex_unlock(&minors_lock);
 out:
 	return result;
 
-- 
Jiri Kosina
SUSE Labs
