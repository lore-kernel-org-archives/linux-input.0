Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8B33EB17;
	Fri, 17 Jul 2026 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263776; cv=none; b=Aal9Hf3+rUEFW5kH/S7PoxkkFEy++AKyqo+jzppa7SzNOWl1xqBEGiPwySp/xqW2190bj8xYF5zsqji+8ld/bdYhRFwxEZS7hK8GPU25umgmMguWKtSKL3cX9YlJ7NrD4bbL/2HjnO4zHZFBUPQfSWCeJ3tH7lwcYV1nWmIIaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263776; c=relaxed/simple;
	bh=viyeS5O98OermsmFaHVKPxTDVM8smgSCLQqmXNsYysM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IArenCW6xZc+Hiq9l+46w6zIK6wq+9mumNuu5pelsGw/3WmmPc0KuJPMcGTK3SWn23cMpx6jNd3a86b9S9D1wp2YCAkSi7AbsU+u7JX5hrUwNzRgHo1tDKzq16ClTVCEfqrtlmw/zYH2XEwkWNF2lm4EPUuMDotCnNP/gI0kC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=m0KkcJ/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7/M0LoX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="m0KkcJ/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7/M0LoX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FE461D00099;
	Fri, 17 Jul 2026 00:49:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 00:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1784263773; x=1784350173; bh=x2
	ZTvVNuyBhPEvoUN774HQpYzIN9pEF8TCYE/3ITAzM=; b=m0KkcJ/g5nFBwBiAIK
	Z1UZ/afsPQ1pdH1rZhVV8QGI/Ucq0YXOlDY70Z7s5k5AC1IcuOhiOpeuSCekJxcr
	enzj5v3VL5t3+/3HDZHt2ycZkpzaIpu1Cmx32jJaaAyrFCIWngd0tTQcZnW1CF3h
	xEllUIH44/ddhKKbHDzonJTh2WJ0ISy3xRNMXS6WOm0AFM4HfU5iS6EnDka9D/Ve
	3jl4VAXmTg8a4AOpfoDiqt+Q3t4oM6UBCAIDtZThXzTHGfJ7EtnO4op0Rct8HsF3
	nElSA0jsmZLIwBiPFB4kReVChOqcVkwkmSWTi+kXwM0EcSDlo25m/0/KfbB2h0nz
	sNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784263773; x=1784350173; bh=x2ZTvVNuyBhPEvoUN774HQpYzIN9
	pEF8TCYE/3ITAzM=; b=Q7/M0LoXUTtzYsqd27x1r8g2s/hEhsin0PsueGLLjNDS
	dg9I/H2A/e5GBVwoqv1+HPvAJu/G2AKH7hVG7z9UczSr5p8Bez8HR5qPI0pqPJqr
	9ttFJDEBY3mV1U3FQ7kiXRWF0q2lKyu+L+Igcnw/1CQ1ArI2JT741oR9LqHDaTI6
	6F01MBOV+fsbUgym0IcIpVQZGmZBxeMe7a+cE6fVpiswbsOeBgKxeT5tkWIE/Yig
	v5rHMR9MVVBMS0nDJTVt7MRsFLTCyJQI3eXEf1Av0x4jRNrIWcLurYS+Yfaratj0
	NsUywv62m2TZkrb794eqy2DGG4NszISi8Lp8b6aXIQ==
X-ME-Sender: <xms:XLRZarmGRVNHdUzdpUm0pqI-p16oVLGzNZHc6N_vmT8gxhFp8XPfeg>
    <xme:XLRZaipn5dOp4B8m5nsQR2iiWWZTSIamUsEz3QrJb3OlZQPYGs8QrAy8dPTX6bwXO
    FCouD-b1vi4FOj8IwtiHVb8QLb6EgSJFXltvGIrXJmHb7jMETXzE6k>
X-ME-Received: <xmr:XLRZaqsIYiy639OkyG5rKuVUVIM0KokEZmqQo7iExHI1rzMVx0VjKBJ5xu9cLpqY56PBLPQV9iD_MjSQYoo-lMQKt7cgxW53UZyMKd1ZcEdGwQ>
X-ME-Proxy-Cause: dmFkZTGJhdAAwrtgxqmVAf78ryJ/vv935k5ufgy6nUE2la6f1dt7wQfTVVYYgViVR9/lJq
    GkSxyOIyzGznRiGbckqz4btQ+xLQz5Ef0I9j4fM4Rnz4+LP3rL3CkSeXfG4D+tLC3YlLdd
    jCL2LL28zE0ZAtowItocuGuENuwSLUtwEbBReW4LHW3y7AovgQ1mweAYaZu5qqGFfOCWV5
    MKAZADkcTl+zEihw8EJoIy+7BL8nbVgJR9/xaFb23sZYWv3XBPDZfdcWJaVJBqbfzaSUkg
    fHhrlFOZbCF/f6xvSGCwUzpgtn2eFKZ1aSRZV5iyTfKSMrASB2ty0fUJWrD17lhdguAQNY
    nDfBu4jCx5lWcR1pCRbb2YUlx10nUPWOyMKY5gzjEWKhtCHgx7Ev72jp8ufzojsyZqV32A
    GBtaG3GhPLjD2SZxRWVHw8+AqFDpZlDRJjJ4lESzcVckaTsWn4eXBTuhbsCtIy7HS7RvOd
    ESG64emdjjJXdPwam0OYhlQT3K0g5lynTAKKXG/SNSnHHRKc+tfX/k/rVV2haFUl+5B0SU
    y5w0tIGId2fst5tSZQrJOHiBL0E8Eu8aTyCb9y/jDPP+/zpB3zXQ8WPRplMh2IJ/I0pwMp
    CvH+wtX6Lys3si0JEHyBr9Y8zZHFSFDri4NCxlX5HmH/3cXNrAX3qX+6w/BQ
X-ME-Proxy: <xmx:XLRZanGuBbXGQUIaHRKkoIRyGHly1YKsdbpnxzlc9r8VTom1W7JqDA>
    <xmx:XLRZajbHuYoGHrCJ0BJyuXhw-CYi6SEpHxC5FwHYyv75haB5Y-1Ifw>
    <xmx:XLRZavUTaQf_-0hm9Rkd1kIrKdA-n8cAbdQvjFXl-Q7vd1QExaRKfA>
    <xmx:XLRZahm7cOAUDtH8XWmp5F9ukhJeG02At-O8wvKsptkTsrqVqcM1mg>
    <xmx:XbRZasxBcKksb6foPPjQKOd5KEkLDkVprFFd189fUpLZVgWWC5-S1S-6>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 00:49:30 -0400 (EDT)
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Fri, 17 Jul 2026 14:49:19 +1000
Subject: [PATCH] Input: uinput/uhid - disallow control characters in phys
 paths
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqEMBBF0a1IjS2I0hrorYiDaJf6JumQ8i/u3
 eDwDO69SCVClL7ZRVFWKP4+ocgz6ifnR2H8kqk0ZW1sYXlD4AU+LDOr85hxCofpUHZdV/fDx0h
 lLaU8RBmwv+umve8Ho7vZRmoAAAA=
X-Change-ID: 20260717-wip-uinput-sanitize-phys-abb6cf40e577
To: David Rheinsberg <david@readahead.eu>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784263770; l=3582;
 i=peter.hutterer@who-t.net; s=20251222; h=from:subject:message-id;
 bh=viyeS5O98OermsmFaHVKPxTDVM8smgSCLQqmXNsYysM=;
 b=bgq9f75uvkJTAqXo/hCdY7lCsDZaKmPp9IRZKKBLIjikgNz/0+18MslwJJsEpzRg0o46T1LjI
 rHHnNTCA28PClSj+jc3/remNzxDCMXkQQZe7IPeDVBAsGMogi7XZQVb
X-Developer-Key: i=peter.hutterer@who-t.net; a=ed25519;
 pk=QoL66HDbFudb9Xt36p2XxsSohZSHVHesRR9c0pI28a4=

There is no good reason to support those, no physical device will ever
produce those. Allowing \n in phys previously triggered CVE-2026-50292
in libinput - there the PHYS udev property value was used as part of
another udev property value. The linebreak then caused the property
to be split across two lines, allowing uinput devices to inject
malicious properties. While the bug is squarely inlibinput's court
there still isn't a good reason for control characters in uinput/uhid.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/uhid.c          |  1 +
 drivers/input/misc/uinput.c |  1 +
 include/linux/input.h       | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 37b60c3aaf66..baf1fe8290f7 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -513,16 +513,17 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		ret = PTR_ERR(hid);
 		goto err_free;
 	}
 
 	BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
 	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
 	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
 	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
+	input_sanitize_phys(hid->phys);
 	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
 	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;
 	hid->vendor = ev->u.create2.vendor;
 	hid->product = ev->u.create2.product;
 	hid->version = ev->u.create2.version;
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index d32fa4b508fc..70fe4f3e73bf 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -998,16 +998,17 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 
 		phys = strndup_user(p, 1024);
 		if (IS_ERR(phys)) {
 			retval = PTR_ERR(phys);
 			goto out;
 		}
 
 		kfree(udev->dev->phys);
+		input_sanitize_phys(phys);
 		udev->dev->phys = phys;
 		goto out;
 
 	case UI_BEGIN_FF_UPLOAD:
 		retval = uinput_ff_upload_from_user(p, &ff_up);
 		if (retval)
 			goto out;
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 76f7aa226202..6c182f5c783f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -527,16 +527,31 @@ int input_set_keycode(struct input_dev *dev,
 
 bool input_match_device_id(const struct input_dev *dev,
 			   const struct input_device_id *id);
 
 void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
 bool input_device_enabled(struct input_dev *dev);
 
+/**
+ * input_sanitize_phys - replace invalid characters in a phys string
+ * @phys: the phys path to sanitize (modified in place)
+ *
+ * Replaces any control characters and non-ASCII characters with '?'.
+ **/
+static inline void input_sanitize_phys(char *phys)
+{
+	char *p;
+
+	for (p = phys; *p; p++)
+		if (*p < 0x20 || *p > 0x7e)
+			*p = '?';
+}
+
 extern const struct class input_class;
 
 /**
  * struct ff_device - force-feedback part of an input device
  * @upload: Called to upload an new effect into device
  * @erase: Called to erase an effect from device
  * @playback: Called to request device to start playing specified effect
  * @set_gain: Called to set specified gain

---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
change-id: 20260717-wip-uinput-sanitize-phys-abb6cf40e577

Best regards,
-- 
Peter Hutterer <peter.hutterer@who-t.net>

