Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380215;
	b=DBpZ+M2g8KRnKIB8qffpBUJ2oYwdc9kcvt+BZirgQzOhMoEWx3mviJpCisQMnigPZ+cD
	 QmljEUOcr1WHym0xqRbFNv0veH5LuQ157YWJebpA6JvhGw92cB/Z6vAnTyTJsVA2mvsFB
	 W9ApYy1lbL78hf5xLns056uUAyRE5DBPruVTO9W4JoJ5RlDrT49PrEju7WlnpU2XVVsoh
	 54n5T8sBg8ppuL7TmhuQj2voCzCmVysBykVaAqxJfZi3n+H0jPSAkVv+T2CsjcPZdx3sY
	 y915x7t2hu7fBIIdDSQtDyF9SFbNhSfCJKUL0prjZ39ehDJixf68IUNJb/NJUCxwEQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=uXatp3CQ/U/8sPWo9k+x7ZCgVJOzTYATBGbDznP95hA=;
	b=2U/2mcmXVHHOe+AjYYbdQRycymVeQuDBOXUIEQHCTuixcW0pEbB1VSGk5tGMcxAKlCvA
	 6ay3iIUa/9rPgpPTTNbx683oOAQOdfMuWcQ5GY9hN1j+PdO7FJEVgoJMU0Hudd2/lMdvN
	 9Bl1/1l2Tk4miBte7CWd6GY/HWHewiMX/2T1L4OyhIXVLqdfRKmmVQW/18xX2wDEA1w3M
	 m07kkJyYPQefbhP6STZjo2SPX3Pdpwez7mUuR2JIsG6cRl1dRYlBdRbtLQE4+6iSkJPnF
	 SOkaqeauw7OAx3wKnloNemYYQCUCTIzkjWRvSCfJts+KksvEiS4k5UvZdmnYPauQuig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2jXXfW+;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCE60A263A
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82DCE60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2jXXfW+
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b244fb7fffso3533001c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380215; x=1794985015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXatp3CQ/U/8sPWo9k+x7ZCgVJOzTYATBGbDznP95hA=;
        b=Q2jXXfW+G3OAac7PW6JwmNe0P/HzqYfthm8GmgGAZehEpnDybIUsAkxL2VgfRbB6ZK
         1Iu3ZgZCPbMO/L0dtz4943WYW+pJf3wj3Wf1ORmkh2VQKxXDFPvjgOGZylkaOKHTVOdi
         cb0IV6kGqI/m/0E4XhQk3QIePmrmZ5kwFR7xQBPFQvLtWwplnVbmC0XMsAGamL24wmBx
         Sywpdm7rCVWF12w5fS+U/y8VNWB2kWX2n8jim4f65UEiPsjW2URDqZR12XcKhlIf0okN
         pdzIkOW8ACQClbFsB4RHCPnAN35rjhJr+8LR/vkZM7j27hi1aKqEFQxetC6ngxYK1CYR
         uL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380215; x=1794985015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXatp3CQ/U/8sPWo9k+x7ZCgVJOzTYATBGbDznP95hA=;
        b=G1CN7Tf8NisIwrvX3Rv7ha1JHjaS71YWqA8+U8uUkVD0KD03bJTypZbXdn3yhzY42+
         vTcyaUahRelKO/ytMDMxBGWfwPfMkVw9fBaSQSP6rySYgGAAVDe66WpEJbpxm6cSIT05
         N98RwWEWq7BrFSdFWi6XCb8gsHF6UPe9BPXWJlTmHkVwkMZ+VwLPIhrbidNUT0+KGpOY
         ruSvvXz1hVbg5/9o/+Nv30b8voi5biWY0Ei0oA82qSbuhQVFGEo0cDr94N+CkgqCtwcs
         iFxaDnafq5Jjc0BOdg+wDcvFjiNSKb495PRlLMKcI3MwylSZLNlUugF37cYeord4ecd9
         MZJg==
X-Forwarded-Encrypted: i=1; AL+hErHwgFul4keVjKFK3vJRtPK12AlYKJ+UltGD4hWV6IJ9r6wjzYlfnMEnaEyN3OvcqlIKGA5DFLnhN1CwiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ffDhPDcEXWMgv6m0qyajMHVqfhZj3pS0VEvUj9ovUKtezbdMS
	mj8taAmXI9mEXUyKCFqiiSMaDfR2VD8LYTHQRJuLl1GhRTtku60bsCwx
X-Gm-Gg: AYBFou3LuBPWdxvZZkn0fRIU1YKgIIEx2vxGzk+fkSwkG/nKaMwWTMSSudizJoFTv2z
	nAUjWWzvb6OaHdh8RQzEaWJ8L6x6AGRS2K1RSrNb7CYIIKlT6EqvaHxqawy2UZleAIP3fwZ/Z5M
	xXMyit+hu+5Jm0bgn03OBk7/Z4v0EOy/DDxBgVA4/DfNwrpCUMqCvYUcXwRmiiT7jquEJJrEt7f
	uL06IL4WmJJ0OsgXfbVFeUHqSr2JoIsKQpEyLYscyeoFGlfOoKzq3RjWL6cxbt5cNcTgOeqjVFP
	IUqZXJFpjZV6hhLhSWgjWcg+0+vJ0GbyVrnODn6Og9n2k6bndQgYmk/8OE7u2FM5Gvp8r+tQ81P
	U8147A7bv6GHqM37ZxmuFXSCGCjIMrkmWIrvH4BmJJX0aJz4cNIdsqcgruu9me7tk6d2Dh3ifHV
	JzGO3dQdBBivLNV2Dc/+CoOczFUtG2K01lgbKxj5j3AjjM+PbVZLn8uaY+i+XJlE22BzSOarMp/
	TGL8kaCLacCxtNNSJklI+jc9JqKsVOUFXJ2I2iNbnRQd40Dff20q1vmJoKzleKkcvx9b1492d+x
	SXxva0O0ibV26nRXN5g4yS4Xz++7vhEFxsF8q/gnGt4oRx8DtTnwX/kaBHs3E2qFkaomR2jJIqJ
	sgG7YZBUzC8WVNtmiUA==
X-Received: by 2002:a05:701b:2514:b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1b3c030745fmr1216047c88.17.1794380214379;
        Tue, 10 Nov 2026 22:56:54 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:53 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:18 -0800
Subject: [PATCH v2 20/33] HID: logitech-hidpp: manage G920 range sysfs
 attribute via dev_groups
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-20-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Creating and removing the G920 range attribute manually inside force
feedback initialization and destruction ties sysfs cleanup to input
device release rather than driver unbind, leaving a dangling attribute
if userspace holds an open event handle across disconnect. Manual sysfs
management also adds avoidable boilerplate.

Register the attribute group through driver dev_groups with a visibility
callback checking initialized G920 force-feedback state, allowing driver
core to create and tear down the attribute cleanly around probe and
remove.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 45 +++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 03d2e9077675..f24fa70d272e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2747,16 +2747,47 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 
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
@@ -2843,11 +2874,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	dev->open = g920_input_open;
 	dev->close = g920_input_close;
 
-	/* Create sysfs interface */
-	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
-	if (error)
-		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d!\n", error);
-
 	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
 		 version);
 
@@ -4985,6 +5011,9 @@ static struct hid_driver hidpp_driver = {
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
+	.driver = {
+		.dev_groups = hidpp_dev_groups,
+	},
 };
 
 module_hid_driver(hidpp_driver);

-- 
2.56.0.542.g3ef89b7020-goog

