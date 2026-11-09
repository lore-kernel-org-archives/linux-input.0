Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204685;
	b=hbIJldJAvkruvvFXNxXtqwFD0mO5mMcNDlxMGI869hcHOOBRZdTEwxK1qye5tpeOVK7b
	 kL+7r3wePDWnBxGLMWgVbMF63CfXBJ0fA5ywi1mNoSGREa7C3z5gtadT+oxdNfh5qYcuD
	 q7FOF2KusRC+UbapvkAVqXah1G6EmJHA/7ILCemvT61ClVn7ugAkXDIrqCUBCuyo9AroS
	 86JSwrzq7wE/ZUexzoQ80jTSxpvIu91nY6ySb2BasU6d62ijLSM5y/C277CNuVhTV7fa1
	 cbkmiUYABwdE4Xonh+9Lz69KGvLRIFicKjM1iAA75I6rmkgbpLtvoMV+gnxzfP6Xcjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xqMaXN3opWhg7YX0G/0+bqesHCg4V/j9sDFtsLvE4LM=;
	b=Vt3UNTKthseTTGN663QrK6wOZ6jrMI0/AjC3Ws0273QPIv8soVaBtX7a4r7Q9d7idMDf
	 CuYjUY6yU/9FPgVK455KlIe0vUsQZfsQ31sCv1doq6emfYroGsJsdwiFvCYMds2ZC+Cvi
	 7Tk6rHMhNPoXmQPDqgChHOK7Wa4Z0ZBAgKu7wDI1kp/CNYmPuqneGlx2vlS693+qkM86H
	 LgGcBwaWQS1qSx4EtUJzaZjsUUp6jfFGSieVdNgeKHJjVZh5WueULVs/WrAl/2m3pBeEG
	 ZMyPIlV+D1OejKS+3EufANp3rhlkQ7/SqbAj4pA5Bjhtk4LCUZwKi9hXVQynBmM5u/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMBKbC1W;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746C606D83A
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2746C606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMBKbC1W
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3720addb068so765139eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204684; x=1794809484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqMaXN3opWhg7YX0G/0+bqesHCg4V/j9sDFtsLvE4LM=;
        b=EMBKbC1WoB42pg1HIzHkXJuoKcwt88k2DYv2HPGBX7b61Akx8ZeODON5tRkd4DDGSm
         PmixkCP5dlQlB8Ikif6ScL9L/mWJHy6yo7AO3FniRp0gdgIVPMlT2KQ3qkEoElLjXlps
         LzZ4LIQmf7VoFp+9465f27Zlt5cDvKlOboqWeBNl8rUtWAY3ogRPAd9mKpRIvmEf8Rh5
         AovOAKNAW7/XCNMdGvqaG3wz0PSQNvdiCaUV4SegEOJMGOT8bBJjR3CxxejzQDSG+who
         4/y78kscpICeBrnADnvqSQg9frf0djospDM0994HJu+FYGXI40jaSgVFdH0JZD+LDods
         FdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204684; x=1794809484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqMaXN3opWhg7YX0G/0+bqesHCg4V/j9sDFtsLvE4LM=;
        b=P1rF2hYbEMOWUWc5tBdPAti0MNjqnyHkn523SAy+RhGreieFjikwb+9etZRPy5CACQ
         BZZO0+70B93yRE3Wfwsej19GDLla72vxSqEHllAK7LfZF4XyY3lxXVsnOwLWbQEF1NiI
         WcPYH0vXXAGO7hC2ZVlgHaJYuscIxDmWSxd8sneJ9kEbzHQLnr7Nj/YBPaxgktbwcAP5
         +nt42uxxmaEFdcOO+KW4yPquM+SYwhmZIZrYa1ZmoiyBgVOwPohbRTEcx2xsqmazdrZL
         Vh/KJKch0j2x56R7Z+2nO/5XjEvqexMbB3x9il34ieXpmxQ6COWdNuBKzWSWuAA7nKSb
         g2OQ==
X-Forwarded-Encrypted: i=1; AL+hErHeb395tdZsfZsCXo46qYZ7zew88P/RoQqv701AFStxaMJGKsXYDBiVE1CCiPl2EtQ2L/gKQ2Y8l7STHQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1eD7DuYhSBlRtfrkwZ5CHfyxP0//HrFT7l7UWscW2iQNG00jZ
	RjpNG29DeWy8aVPcj+RzwCKX21XEMJnhcE/woStsWN8k/F+LQB4UJHhs
X-Gm-Gg: AYBFou2WrcWGYZDy3ASlqow8t7+aYVVAc6Udqo+o4ydd7431EJQKv4r1UxMGeeV8Q72
	2WA9dnerc135jh+BPQcR4Pdo+cdm2F/EyvXbVKu2o5dwUD/6mO0IVYs6w8GyCrRdzBx7+lVdff+
	nPhkRHOlDy77wyzNnx3voUgSWUl4/ZBEO5o1dGnIRNSUs1XZUcATkERLMXRRJBFObxDOd1jk9e1
	uBWydVE/yFWxXtIX8dMZg9+KUzrsVaxrDNizJ5iUjhOPjfAaAiJ82TuN5lRi+qWlOVcpYYHMLA3
	gson6hctaCqnWaKzYQwDqOcSuqx0F4rGsLOQurCOq3GGyPzdVHcTUcpyeR7x3CI7TlLCs31hS/Z
	lUJWj5ZmplCZvmYtP0nE3sYGTMcKrViaXljOHSfhXkwNPSYHRMtBfj4KhGFSEAG5deWcYbtyKtZ
	gEPy810i9fvUPc4eOQPn5l3dQRIpnB/Az6T+ZAlhELMegl6wJ0+2n68arGnt5ZpaGrDSkfYP1MJ
	5r6OSrdIj6l5zzjdltOQnd1yq4kRHeBpCTLhxbBkWFJ0PljHW3KBRUZRtQVwXURkbwCYSiLCgs2
	7Gzgbzd0rci0J87onaSDZ4hS1Fkl1Wi7Wd+BnF53gxsqW5IuwtSWn3NcPoT36SYZ66ijjr3k/Hk
	T6gd74RMJ7435+X+s
X-Received: by 2002:a05:693c:6203:b0:351:7e5d:2de9 with SMTP id 5a478bee46e88-372542bc425mr8548828eec.1.1794204684029;
        Sun, 08 Nov 2026 22:11:24 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:23 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] HID: logitech-hidpp: manage G920 range sysfs attribute via dev_groups
Date: Sun,  8 Nov 2026 22:10:54 -0800
Message-ID: <20261109061103.2887636-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating and removing the G920 range attribute manually inside force
feedback initialization and destruction ties sysfs cleanup to input
device release rather than driver unbind, leaving a dangling attribute
if userspace holds an open event handle across disconnect. Manual sysfs
management also adds avoidable boilerplate.

Register the attribute group through driver dev_groups with a visibility
callback checking initialized G920 force-feedback state, allowing driver
core to create and tear down the attribute cleanly around probe and
remove.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 45 ++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1ed940352fd2..ad3edd15cdd2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2807,16 +2807,47 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 
 static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, hidpp_ff_range_show, hidpp_ff_range_store);
 
+static struct attribute *g920_range_attrs[] = {
+	&dev_attr_range.attr,
+	NULL
+};
+
+static umode_t g920_range_attr_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct hid_device *hdev = to_hid_device(dev);
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct g920_data *g920;
+
+	if (!hidpp || !(hidpp->quirks & HIDPP_QUIRK_CLASS_G920))
+		return 0;
+
+	g920 = hidpp->private_data;
+	if (!g920 || !g920->ff)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group g920_range_group = {
+	.attrs = g920_range_attrs,
+	.is_visible = g920_range_attr_is_visible,
+};
+
+static const struct attribute_group *hidpp_dev_groups[] = {
+	&g920_range_group,
+	NULL
+};
+
 static void hidpp_ff_destroy(struct ff_device *ff)
 {
 	struct hidpp_ff_private_data *data = ff->private;
 	struct hidpp_device *hidpp = data->hidpp;
-	struct hid_device *hid = hidpp->hid_dev;
 	struct g920_data *g920 = hidpp->private_data;
 
-	hid_info(hid, "Unloading HID++ force feedback.\n");
+	hid_info(hidpp->hid_dev, "Unloading HID++ force feedback.\n");
 
-	device_remove_file(&hid->dev, &dev_attr_range);
 	destroy_workqueue(data->wq);
 	g920->ff = NULL;
 }
@@ -2895,11 +2926,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 
 	dev->close = hidpp_ff_close;
 
-	/* Create sysfs interface */
-	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
-	if (error)
-		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d!\n", error);
-
 	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
 		 version);
 
@@ -5033,6 +5059,9 @@ static struct hid_driver hidpp_driver = {
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
+	.driver = {
+		.dev_groups = hidpp_dev_groups,
+	},
 };
 
 module_hid_driver(hidpp_driver);
-- 
2.56.0.506.g506a7eabc5-goog

