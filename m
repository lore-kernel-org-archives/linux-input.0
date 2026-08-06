Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EADA31F983
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785995550; cv=none; b=Pu7YiIATvDSnxcPhNTGfYfcNUky/NBfWkMjZikUMuQD3aj7awtG8EfChF9nGNOPChY5IgwbsvmTb9u91gmmaLSKIheJ8vGRa07iyN2uE4Fq/J2usrwIZGnnFeh1B/h1M1VX3UkBOY/qA8lbsRR6EOa4TPXZCRgJWp9yywE566Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785995550; c=relaxed/simple;
	bh=2AXd0QCUkhNbgBbc180DV9AhiysthlhRHBZTSwf2bHU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hd1h413aGuQxpwiu9rfAqumd1+2GcVL6y/3knTk78uTisIjpJUpUhyuy5HTW8p+nnFrj+tYKKG2PL/rioPnyX8+v5FJwZzz3XAITb1UBOoIGGrrrtfA6Zz8zD5Yj+0/8xCO4oGdTHnppfus0GStyqBoV8Wj/hxkHBTbmy0NMY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqNGRFEc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqNGRFEc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc73e322dbso21314655ad.1
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785995549; x=1786600349; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jZ23w7GfQc3eQ7VCO4oVKKe1P7gXWLzuG3JrExJvEo=;
        b=QqNGRFEc10nmf8knM1HbYXtTgqV8fHLQXyNlg4grADe68rYsQ8gCBERYPtiUgcNm8C
         8Fs9XclUhLUoMVCkZ0lsPergS+K5knaKhuE4zwynqLhr8j0G7XC+zSBELQcYILuSJ8lo
         BzfYcxAvlQtAdsT/QB4UxJi7q6WidVHWjlW6M1RAZgToQ3dDiDQQ/dLfzB/cdW5YJjnN
         dLMOcPtzmVuM56tSX/FBEYHx8I2A5IWbQlbhKIFJA2SxufH7i13LfiChPcO/AfjncO8U
         ieyXVtFpi6q3v9tjdY10ohyYToWpLJS+oEpXe95L9aIe6wSyEh72OuJmZp8z7Sb15ttJ
         rMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785995549; x=1786600349;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jZ23w7GfQc3eQ7VCO4oVKKe1P7gXWLzuG3JrExJvEo=;
        b=gqyHRvUVvRbKh+vedhrW9Tdl0y4mIrqTx6DvoLaMQ/0BU9kztxObpfgv1EN01OY1rz
         HET9QuTm+c+lYLEdNyAH5h/P7EhNNg/C0UIMSLpZx21zbsVEt8G7C+wsP7fDumGjyaWe
         K8KK+xB08yOgOKtB4Zt+VeP0vaoaxJ5VdeyXqCYv7Ho4jRP783tt4ZoJGVDS5gtFQvGO
         EdaqRXDICJFvE3mfUdjgNOa9e/g9OvvMx8C8ccvOKVGTujlVj285zM/P/A+5MGNYceMS
         K5Y+rX2inqLCCmgLzrNf6XIuvA7u7bf1RDFiMrw56cmHaKqwma6wuIBP1e35yRDfT8zt
         kmsg==
X-Gm-Message-State: AOJu0YwFGD7ydzuuL3DrNKAPzcsHgRcUHsaFlpxYjfFfcD6PKTFo7hW9
	OO2f+OHX6gyAwH2CLde5Yk4WmR73uIz+t7Urnuh9lJrWmxCkf7TpmNKl96wM+Q==
X-Gm-Gg: AR+sD10hJKpuRlYKHR5qfRYnRS0DwmWqiDCUF6ynlflRhnqHVIFhfZ+PyjqGIGRwgNC
	AdY7wV+xmmTDGOGmtZjBtiFeGyFn0qUxt/7DsMXt4hXO2m6oGv9XneYzRUaEJB5qAeVHrlyoQ7H
	RRdlk760ArwmdfvjAcBYArEWVrlc1iafaycfvitmpDjWXeSGUK6k2kWBFvwuG/S6FpxpxK9yaoW
	81zFoyQL91CiQwokYgAcltrboRs+mk5RkbTUW5JM1IeBlsL+sptl0lxnXQV9Qkc0huRfiIXXBvv
	KKZ0y4SctHz7sElYqw5Zj0OUdoeoGJM/nLL84h9nkz/YQT5tyExshTDuf6MxkaHcWXwZAzN87dx
	rXsPfRKms6kmrNV9UTjv1XtVwLrKgdmLlicovQMZBQx0/Aj/vsPg5cJG9G5Kcnmx2WHrLE9kq0r
	2C/tP/4RazGe3xOD4OB8cHsr0epomGCzO6DVKxgXP7dKMfKs+x8LyalLigP+Ragago/K/cb8teC
	2p8SgXTOmYEupIqSyGCW+FhUVkT1FXT9L1h8OU=
X-Received: by 2002:a05:6a21:3390:b0:3c3:93ce:663 with SMTP id adf61e73a8af0-3cb85f4a26emr13527585637.26.1785995548644;
        Wed, 05 Aug 2026 22:52:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d081:36b2:965:e66f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df88csm18435051c88.11.2026.08.05.22.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:52:27 -0700 (PDT)
Date: Wed, 5 Aug 2026 22:52:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: atkbd - factor out atkbd_recreate_device() helper
Message-ID: <anQg6dtUwQ1Fx4hM@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The sysfs attribute setters atkbd_set_extra() and atkbd_set_set() contain
identical logic for unregistering the old input device, allocating a new
one, updating state, and registering the new device.

Factor out this common logic into an atkbd_recreate_device() helper to
reduce code duplication.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 109 ++++++++++++++-------------------
 1 file changed, 46 insertions(+), 63 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 5736f4bc5a50..3ff7e9dea9fe 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1444,6 +1444,47 @@ static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t
 	return -EINTR;
 }
 
+static int atkbd_recreate_device(struct atkbd *atkbd,
+				 unsigned char new_set, bool new_extra)
+{
+	struct input_dev *new_dev, *old_dev = atkbd->dev;
+	bool old_extra = atkbd->extra;
+	u8 old_set = atkbd->set;
+	int err;
+
+	/*
+	 * Since device's properties will change we need to unregister
+	 * the old device. But allocate and register the new one first
+	 * to make sure we have it.
+	 */
+	new_dev = input_allocate_device();
+	if (!new_dev)
+		return -ENOMEM;
+
+	atkbd->dev = new_dev;
+	atkbd->set = atkbd_select_set(atkbd, new_set, new_extra);
+	atkbd_reset_state(atkbd);
+	atkbd_activate(atkbd);
+	atkbd_set_keycode_table(atkbd);
+	atkbd_set_device_attrs(atkbd);
+
+	err = input_register_device(atkbd->dev);
+	if (err) {
+		input_free_device(new_dev);
+
+		atkbd->dev = old_dev;
+		atkbd->set = atkbd_select_set(atkbd, old_set, old_extra);
+		atkbd_set_keycode_table(atkbd);
+		atkbd_set_device_attrs(atkbd);
+
+		return err;
+	}
+
+	input_unregister_device(old_dev);
+
+	return 0;
+}
+
 static ssize_t atkbd_show_extra(struct atkbd *atkbd, char *buf)
 {
 	return sprintf(buf, "%d\n", atkbd->extra ? 1 : 0);
@@ -1451,11 +1492,8 @@ static ssize_t atkbd_show_extra(struct atkbd *atkbd, char *buf)
 
 static ssize_t atkbd_set_extra(struct atkbd *atkbd, const char *buf, size_t count)
 {
-	struct input_dev *old_dev, *new_dev;
 	unsigned int value;
 	int err;
-	bool old_extra;
-	u8 old_set;
 
 	if (!atkbd->write)
 		return -EIO;
@@ -1468,38 +1506,9 @@ static ssize_t atkbd_set_extra(struct atkbd *atkbd, const char *buf, size_t coun
 		return -EINVAL;
 
 	if (atkbd->extra != value) {
-		/*
-		 * Since device's properties will change we need to
-		 * unregister old device. But allocate and register
-		 * new one first to make sure we have it.
-		 */
-		old_dev = atkbd->dev;
-		old_extra = atkbd->extra;
-		old_set = atkbd->set;
-
-		new_dev = input_allocate_device();
-		if (!new_dev)
-			return -ENOMEM;
-
-		atkbd->dev = new_dev;
-		atkbd->set = atkbd_select_set(atkbd, atkbd->set, value);
-		atkbd_reset_state(atkbd);
-		atkbd_activate(atkbd);
-		atkbd_set_keycode_table(atkbd);
-		atkbd_set_device_attrs(atkbd);
-
-		err = input_register_device(atkbd->dev);
-		if (err) {
-			input_free_device(new_dev);
-
-			atkbd->dev = old_dev;
-			atkbd->set = atkbd_select_set(atkbd, old_set, old_extra);
-			atkbd_set_keycode_table(atkbd);
-			atkbd_set_device_attrs(atkbd);
-
+		err = atkbd_recreate_device(atkbd, atkbd->set, value);
+		if (err)
 			return err;
-		}
-		input_unregister_device(old_dev);
 	}
 
 	return count;
@@ -1586,11 +1595,8 @@ static ssize_t atkbd_show_set(struct atkbd *atkbd, char *buf)
 
 static ssize_t atkbd_set_set(struct atkbd *atkbd, const char *buf, size_t count)
 {
-	struct input_dev *old_dev, *new_dev;
 	unsigned int value;
 	int err;
-	u8 old_set;
-	bool old_extra;
 
 	if (!atkbd->write)
 		return -EIO;
@@ -1603,34 +1609,11 @@ static ssize_t atkbd_set_set(struct atkbd *atkbd, const char *buf, size_t count)
 		return -EINVAL;
 
 	if (atkbd->set != value) {
-		old_dev = atkbd->dev;
-		old_extra = atkbd->extra;
-		old_set = atkbd->set;
-
-		new_dev = input_allocate_device();
-		if (!new_dev)
-			return -ENOMEM;
-
-		atkbd->dev = new_dev;
-		atkbd->set = atkbd_select_set(atkbd, value, atkbd->extra);
-		atkbd_reset_state(atkbd);
-		atkbd_activate(atkbd);
-		atkbd_set_keycode_table(atkbd);
-		atkbd_set_device_attrs(atkbd);
-
-		err = input_register_device(atkbd->dev);
-		if (err) {
-			input_free_device(new_dev);
-
-			atkbd->dev = old_dev;
-			atkbd->set = atkbd_select_set(atkbd, old_set, old_extra);
-			atkbd_set_keycode_table(atkbd);
-			atkbd_set_device_attrs(atkbd);
-
+		err = atkbd_recreate_device(atkbd, value, atkbd->extra);
+		if (err)
 			return err;
-		}
-		input_unregister_device(old_dev);
 	}
+
 	return count;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog


-- 
Dmitry
