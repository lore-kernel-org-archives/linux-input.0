Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC4399354
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462404; cv=none; b=PDg87urQ3xUJt/MkApAolTpFaOS+Wzc/q1yfuYcpo5et6ratPA4RCCddFn3dVYw+DnykG17RHqa9EJJ3wKFHe+hJqeNDUMTLJIjjI2tgH24Rii6S8h9hWoMdkNT5vncvRQIxmSkNxAcmvtN1AlebDATYS5cSyDlFrYzHHUd2XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462404; c=relaxed/simple;
	bh=n5OAOlKU5jHDfWtU+xfRBhbrbepKznAbUd4blgzBF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0s13FWpV5UngXhzojvs1y2lf1m89QcI+Z7cGLF+ovH2QTuOCGqS+ZOeywwPqxUNp/Aa7iL9bFs4BquCaHd44P1vLtooYHIvYs8aWGamqkEsTMbTVoPpF72lzxl0cbTmRbB/Rt67Rfivi1IeoG/w7xoKvOuAtmJqItwS3PzmAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RR54lvr5; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RR54lvr5"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 36FC2C009A;
	Tue, 15 Sep 2026 11:53:17 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:ea2:0:640:ef77:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 1F293C007B;
	Tue, 15 Sep 2026 11:53:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp) with ESMTPSA id FrPGVikd2a60-54TzSXjw;
	Tue, 15 Sep 2026 11:53:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789462396; bh=SZNVyUBB5uxnUOuNGwgtiAZTVkROPinS1S4mzZt6eMU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=RR54lvr5z4V6mMXPkwJtHPxHd1dE8P1watEiWBQPRRMgk9u4k0Qy5WQS46lk4/jTe
	 QKoc0uY08ZyRGsneV0SgqIAT2Cw1TveT+truy5rJ2A9QhhrVLQmbMm3trY+NLnM0H7
	 rUq56q3dd2WCMPTwdSF3gO5Reqyw4+w8ObU7LgmQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] HID: roccat: pass data size to roccat_report_event()
Date: Tue, 15 Sep 2026 11:53:11 +0300
Message-ID: <20260915085311.1819317-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust roccat_report_event() to take both report and report size.

The goal is to make roccat_report_event() lockfree. Since callers
are likely to pass stack-allocated event, it should be copied,
which requires to know event size. This size is recorded in
'report_size' of 'struct roccat_device', but taking the device
pointer is racy without taking global 'devices_lock', and taking
the latter from atomic context (from where roccat_report_event()
may be called) is definitely wrong.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
With this patch, roccat_report_event() may be implemented as follows:

struct roccat_event {
       struct work_struct work;
       int minor;
       u8 data[];
};

static void roccat_event_handler(struct work_struct *work)
{
	struct roccat_event *event;

	event = container_of(work, struct roccat_event, work);
	/* In this context, locking is safe. Get the device
	   pointer using event->minor and, if the device
	   is still present, do the rest of event reporting. */
}

int roccat_report_event(int minor, u8 const *data, int size)
{
	struct roccat_event *event;

	event = kzalloc_flex(*event, data, size, GFP_ATOMIC);
	if (!event)
		return -ENOMEM;
	INIT_WORK(&event->work, roccat_event_handler);
	memcpy(event->data, data, size);
	event->minor = minor;

	queue_work([likely dedicated single-threaded workqueue], &event->work);
	return 0;
}
---
 drivers/hid/hid-roccat-arvo.c     |  3 ++-
 drivers/hid/hid-roccat-isku.c     |  7 +++++--
 drivers/hid/hid-roccat-kone.c     | 10 +++++++---
 drivers/hid/hid-roccat-koneplus.c |  6 ++++--
 drivers/hid/hid-roccat-konepure.c |  2 +-
 drivers/hid/hid-roccat-kovaplus.c |  6 ++++--
 drivers/hid/hid-roccat-pyra.c     |  9 ++++++---
 drivers/hid/hid-roccat-ryos.c     |  2 +-
 drivers/hid/hid-roccat-savu.c     |  3 ++-
 drivers/hid/hid-roccat.c          |  3 ++-
 include/linux/hid-roccat.h        |  2 +-
 11 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 0cf2f0008c7f..2a4e42ad4aae 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -400,7 +400,8 @@ static void arvo_report_to_chrdev(struct arvo_device const *arvo,
 		roccat_report.action = ARVO_ROCCAT_REPORT_ACTION_RELEASE;
 
 	roccat_report_event(arvo->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 }
 
 static int arvo_raw_event(struct hid_device *hdev,
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 93a49c93ae8c..abda7551dd1f 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -98,7 +98,9 @@ static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
 	roccat_report.data1 = profile + 1;
 	roccat_report.data2 = 0;
 	roccat_report.profile = profile + 1;
-	roccat_report_event(isku->chrdev_minor, (uint8_t const *)&roccat_report);
+	roccat_report_event(isku->chrdev_minor,
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 
 	mutex_unlock(&isku->isku_lock);
 
@@ -395,7 +397,8 @@ static void isku_report_to_chrdev(struct isku_device const *isku,
 	roccat_report.data2 = button_report->data2;
 	roccat_report.profile = isku->actual_profile + 1;
 	roccat_report_event(isku->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 }
 
 static int isku_raw_event(struct hid_device *hdev,
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 3dae9eaa0b6f..38bed3cdd592 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -49,7 +49,9 @@ static void kone_profile_report(struct kone_device *kone, uint new_profile)
 	roccat_report.event = kone_mouse_event_switch_profile;
 	roccat_report.value = new_profile;
 	roccat_report.key = 0;
-	roccat_report_event(kone->chrdev_minor, (uint8_t *)&roccat_report);
+	roccat_report_event(kone->chrdev_minor,
+			    (uint8_t *)&roccat_report,
+			    sizeof(roccat_report));
 }
 
 static int kone_receive(struct usb_device *usb_dev, uint usb_command,
@@ -824,7 +826,8 @@ static void kone_report_to_chrdev(struct kone_device const *kone,
 		roccat_report.value = event->value;
 		roccat_report.key = 0;
 		roccat_report_event(kone->chrdev_minor,
-				(uint8_t *)&roccat_report);
+				    (uint8_t *)&roccat_report,
+				    sizeof(roccat_report));
 		break;
 	case kone_mouse_event_call_overlong_macro:
 	case kone_mouse_event_multimedia:
@@ -833,7 +836,8 @@ static void kone_report_to_chrdev(struct kone_device const *kone,
 			roccat_report.value = kone->actual_profile;
 			roccat_report.key = event->macro_key;
 			roccat_report_event(kone->chrdev_minor,
-					(uint8_t *)&roccat_report);
+					    (uint8_t *)&roccat_report,
+					    sizeof(roccat_report));
 		}
 		break;
 	}
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index f80a60539a96..77cb88957f8b 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -280,7 +280,8 @@ static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
 	roccat_report.data2 = 0;
 	roccat_report.profile = profile + 1;
 	roccat_report_event(koneplus->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 
 	mutex_unlock(&koneplus->koneplus_lock);
 
@@ -507,7 +508,8 @@ static void koneplus_report_to_chrdev(struct koneplus_device const *koneplus,
 	roccat_report.data2 = button_report->data2;
 	roccat_report.profile = koneplus->actual_profile + 1;
 	roccat_report_event(koneplus->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 }
 
 static int koneplus_raw_event(struct hid_device *hdev,
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 7f753dfc2a10..bed5e1e8a49e 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -185,7 +185,7 @@ static int konepure_raw_event(struct hid_device *hdev,
 		return 0;
 
 	if (konepure != NULL && konepure->roccat_claimed)
-		roccat_report_event(konepure->chrdev_minor, data);
+		roccat_report_event(konepure->chrdev_minor, data, size);
 
 	return 0;
 }
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 9ec42c218ef9..277a32313f45 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -310,7 +310,8 @@ static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
 	roccat_report.data1 = profile + 1;
 	roccat_report.data2 = 0;
 	roccat_report_event(kovaplus->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 
 	mutex_unlock(&kovaplus->kovaplus_lock);
 
@@ -598,7 +599,8 @@ static void kovaplus_report_to_chrdev(struct kovaplus_device const *kovaplus,
 	roccat_report.data2 = button_report->data2;
 
 	roccat_report_event(kovaplus->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 }
 
 static int kovaplus_raw_event(struct hid_device *hdev,
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 0d515995bb9d..eb1dcdc17c29 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -266,7 +266,8 @@ static ssize_t pyra_sysfs_write_settings(struct file *fp,
 	roccat_report.value = settings->startup_profile + 1;
 	roccat_report.key = 0;
 	roccat_report_event(pyra->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 
 	mutex_unlock(&pyra->pyra_lock);
 	return PYRA_SIZE_SETTINGS;
@@ -524,7 +525,8 @@ static void pyra_report_to_chrdev(struct pyra_device const *pyra,
 		roccat_report.value = button_event->data1;
 		roccat_report.key = 0;
 		roccat_report_event(pyra->chrdev_minor,
-				(uint8_t const *)&roccat_report);
+				    (uint8_t const *)&roccat_report,
+				    sizeof(roccat_report));
 		break;
 	case PYRA_MOUSE_EVENT_BUTTON_TYPE_MACRO:
 	case PYRA_MOUSE_EVENT_BUTTON_TYPE_SHORTCUT:
@@ -538,7 +540,8 @@ static void pyra_report_to_chrdev(struct pyra_device const *pyra,
 			 */
 			roccat_report.value = pyra->actual_profile + 1;
 			roccat_report_event(pyra->chrdev_minor,
-					(uint8_t const *)&roccat_report);
+					    (uint8_t const *)&roccat_report,
+					    sizeof(roccat_report));
 		}
 		break;
 	}
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index db83f42457da..6267dd49acc8 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -193,7 +193,7 @@ static int ryos_raw_event(struct hid_device *hdev,
 		return 0;
 
 	if (ryos != NULL && ryos->roccat_claimed)
-		roccat_report_event(ryos->chrdev_minor, data);
+		roccat_report_event(ryos->chrdev_minor, data, size);
 
 	return 0;
 }
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 679136933560..b3b812a1a38b 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -166,7 +166,8 @@ static void savu_report_to_chrdev(struct roccat_common2_device const *savu,
 	roccat_report.data[0] = special_report->data[0];
 	roccat_report.data[1] = special_report->data[1];
 	roccat_report_event(savu->chrdev_minor,
-			(uint8_t const *)&roccat_report);
+			    (uint8_t const *)&roccat_report,
+			    sizeof(roccat_report));
 }
 
 static int savu_raw_event(struct hid_device *hdev,
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 4f15eb951039..ca09820ee5d3 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -248,12 +248,13 @@ static int roccat_release(struct inode *inode, struct file *file)
  * roccat_report_event() - output data to readers
  * @minor: minor device number returned by roccat_connect()
  * @data: pointer to data
+ * @size: data size (expected to be equal to device->report_size)
  *
  * Return value is zero on success, a negative error code on failure.
  *
  * This is called from interrupt handler.
  */
-int roccat_report_event(int minor, u8 const *data)
+int roccat_report_event(int minor, u8 const *data, int size)
 {
 	struct roccat_device *device;
 	struct roccat_reader *reader;
diff --git a/include/linux/hid-roccat.h b/include/linux/hid-roccat.h
index 753654fff07f..2be48e3d92a9 100644
--- a/include/linux/hid-roccat.h
+++ b/include/linux/hid-roccat.h
@@ -19,7 +19,7 @@
 int roccat_connect(const struct class *klass, struct hid_device *hid,
 		int report_size);
 void roccat_disconnect(int minor);
-int roccat_report_event(int minor, u8 const *data);
+int roccat_report_event(int minor, u8 const *data, int size);
 
 #endif
 
-- 
2.55.0

