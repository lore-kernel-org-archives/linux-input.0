Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFA38C42F;
	Mon,  8 Jun 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936432; cv=none; b=tMK2zhdM03/R1QV3QXRuV388ymSflXRsjlILPPymU59IZ5a1ZBFPeNBCYi1UqV6Zag3Lqc0p8vVCmFw+3/CJ4iheu9bRc1VhR16YcOtJQG4o8MwvqnNLVXXb2Cicw/3XIm9mgwQ+cRpnpx4pUnotuAUtYQgsimJxIbMxUYWz7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936432; c=relaxed/simple;
	bh=vzk6nHC7HBWS3E8mqGwt2sGAoesJUsidPUiu+998yLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=df0Xf+MnvE6QTwOmAz3Evbw3ZyGFnFzZf43h8d14r+v1r6EyMtLK79T9+UBgJ2cYsgJGODaQgKwQ+6p6TAbcG9ZM2FZQcLp64Z4NUAOL+vbF8Npx/aAk+7oUSrRy3E01OSnY5UUps4ncuB0DpwsACFK5i8/MCEyb+e2PJf/+LFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TU0YdJ9E; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TU0YdJ9E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=veZazjgLHkJKQtJ6MkyaRVQjmX7eAEDZ/rMJq5OUpR8=; b=TU0YdJ9EJPy/q+3ssINf8tUOa3
	OcpDK8S/x7cJs8kONT7aD+ui5Hu6+QHy613f6g3h2bgdbdlV/caBZ3FKTESsAAZ7FM56jIUQRVc+f
	r/svE8OfZoo4YaNbUW1Rl741MEN5KBfvjcCDDucK7Saz9Qe/KgO34goGD9B7ZIm+994Omr4seKHzk
	N2g3q10mXUCQffqtFr2z7ykZgsUFgc2zQr1yTEtJVqRorkKNN58j/goAzeoo/yM/PTGdMmlMTNkcZ
	uxxSeLO8j1P57gAyfXqY3xnT51cD1MienoKNhyvgiT2/5ceIG7Bm1PN00eEIYk9NQdVao3PFBJT/O
	XKpxV8fQ==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wWcv4-00ETaf-2Q; Mon, 08 Jun 2026 18:33:46 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 08 Jun 2026 13:33:03 -0300
Subject: [PATCH] HID: hiddev: Use kref to track struct hiddev lifetime
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hiddev_kref-v1-1-cd240c95423f@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM4QpAMBSG4VvR+W01h1FuRRJ2cCi0sdRy74afz
 1ff68GSYbJQRh4MOba8rQFJHEE/tetIgnUwoMRc5jIVE2tNrlkMDULhoJQsdEYZQnjsYeTrq1X
 1b3t2M/XHm4D7fgDLi3QTbwAAAA==
X-Change-ID: 20260603-hiddev_kref-52f5507d4e42
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: kernel-dev@igalia.com, linux-usb@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2

If a USB HID device is disconnected while userspace still holds the
hiddev node open, hiddev_disconnect() and hiddev_release() can race on
the embedded existancelock mutex. Syzbot has triggered this with kfree()
happening during the mutex slow path.

Fix by introducing a kref in struct hiddev, and moving kfree() into a
dedicated release callback. This way, struct hiddev will only be freed
after both hiddev_release() and hiddev_disconnect() are done.

Fixes: 6cb4b040795c ("HID: hiddev: fix race between hiddev_disconnect and hiddev_release")
Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/hid/usbhid/hiddev.c | 36 ++++++++++++++++++++++++------------
 include/linux/hiddev.h      |  1 +
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 6378801b22c6..1f2802920bee 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -46,6 +46,13 @@ struct hiddev_list {
 	struct mutex thread_lock;
 };
 
+static void hiddev_kref_free(struct kref *kref)
+{
+	struct hiddev *hiddev = container_of(kref, struct hiddev, kref);
+
+	kfree(hiddev);
+}
+
 /*
  * Find a report, given the report's type and ID.  The ID can be specified
  * indirectly by REPORT_ID_FIRST (which returns the first report of the given
@@ -227,15 +234,11 @@ static int hiddev_release(struct inode * inode, struct file * file)
 		if (list->hiddev->exist) {
 			hid_hw_close(list->hiddev->hid);
 			hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
-		} else {
-			mutex_unlock(&list->hiddev->existancelock);
-			kfree(list->hiddev);
-			vfree(list);
-			return 0;
 		}
 	}
-
 	mutex_unlock(&list->hiddev->existancelock);
+
+	kref_put(&list->hiddev->kref, hiddev_kref_free);
 	vfree(list);
 
 	return 0;
@@ -298,10 +301,20 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	hid = usb_get_intfdata(intf);
 	hiddev = hid->hiddev;
 
+	/*
+	 * kref_get_unless_zero() checks if we've already dropped
+	 * the last reference; bail out early in this case
+	 */
+	if (!hiddev || !kref_get_unless_zero(&hiddev->kref))
+		return -ENODEV;
+
 	mutex_lock(&hiddev->existancelock);
 	res = hiddev->exist ? __hiddev_open(hiddev, file) : -ENODEV;
 	mutex_unlock(&hiddev->existancelock);
 
+	if (res < 0)
+		kref_put(&hiddev->kref, hiddev_kref_free);
+
 	return res;
 }
 
@@ -893,6 +906,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	if (!(hiddev = kzalloc_obj(struct hiddev)))
 		return -ENOMEM;
 
+	kref_init(&hiddev->kref);
 	init_waitqueue_head(&hiddev->wait);
 	INIT_LIST_HEAD(&hiddev->list);
 	spin_lock_init(&hiddev->list_lock);
@@ -904,7 +918,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	if (retval) {
 		hid_err(hid, "Not able to get a minor for this device\n");
 		hid->hiddev = NULL;
-		kfree(hiddev);
+		kref_put(&hiddev->kref, hiddev_kref_free);
 		return retval;
 	}
 
@@ -933,13 +947,11 @@ void hiddev_disconnect(struct hid_device *hid)
 
 	mutex_lock(&hiddev->existancelock);
 	hiddev->exist = 0;
-
 	if (hiddev->open) {
 		hid_hw_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
-		mutex_unlock(&hiddev->existancelock);
-	} else {
-		mutex_unlock(&hiddev->existancelock);
-		kfree(hiddev);
 	}
+	mutex_unlock(&hiddev->existancelock);
+
+	kref_put(&hiddev->kref, hiddev_kref_free);
 }
diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
index 2164c03d2c72..1613c9c37ab7 100644
--- a/include/linux/hiddev.h
+++ b/include/linux/hiddev.h
@@ -24,6 +24,7 @@ struct hiddev {
 	int minor;
 	int exist;
 	int open;
+	struct kref kref;
 	struct mutex existancelock;
 	wait_queue_head_t wait;
 	struct hid_device *hid;

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260603-hiddev_kref-52f5507d4e42

Best regards,
--  
Heitor Alves de Siqueira <halves@igalia.com>

