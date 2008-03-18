From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch for oops in a grabbed evdev after disconnect
Date: Mon, 17 Mar 2008 23:48:07 -0700
Message-ID: <20080317234807.42c72a76.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbYCRGw3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2008 02:52:29 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2I6qSIS018738
	for <linux-input@vger.kernel.org>; Tue, 18 Mar 2008 02:52:28 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2I6qSUA031029
	for <linux-input@vger.kernel.org>; Tue, 18 Mar 2008 02:52:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: zaitcev@redhat.com

If a device was grabbed through evdev and then became disconnected,
we oops on close. This happens because input_release_device uses memory
which was freed.

Fedora enabled evdev in X11 by default recently, and now anyone who
flips a KVM oopses when they log out (Fedora bug 436659).

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 0727b0a..c0874a3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -155,7 +155,8 @@ static int evdev_ungrab(struct evdev *evdev, struct evdev_client *client)
 
 	rcu_assign_pointer(evdev->grab, NULL);
 	synchronize_rcu();
-	input_release_device(&evdev->handle);
+	if (evdev->exist)
+		input_release_device(&evdev->handle);
 
 	return 0;
 }
