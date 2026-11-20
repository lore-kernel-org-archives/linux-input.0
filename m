Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164261;
	b=lRvQbchk4ltk77RtgZ2Zd142xoQEoElXVJpsgdOw+Z/t1xM7DDzpNY+XaVnCKJoWS8vO
	 Zu9QYo2OCelN59mbKFRI3ZhUj/dsew4t23crkVk7+7196ldTvwmoy6NJikVhLpXyPFSri
	 Y5sWlsYoaoxkd6wUdDKVBP8fzQVA12JALUT2vcziP1mNp+b1XDIS+F5UoE5ZD5ZWmFsSP
	 3/m0z9g15og8+j8TPwVrnbz87kQpda7/u7CZSi91vVfoS+gfERYUf9O/EICMmmW7oDj0Y
	 NThzWm15to2tw80XZbMXaGOXlerx1DUYwJ6SDi1lneBz0V03C5w2/Nv+lYnwUhG640w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7DeemdZLIhx/5jLSpJJ+WPwy9ZHOFCasR0T6JfI13Q4=;
	b=qFpUYQ7A3VhV+qZZf3ZvnrirAQg6ORoXVapknmJrJ6o3lqORAX2zIJp+ri6jIhM7zfiP
	 4VN3ViSzTblES1d+tulyk/Jub3AgUvQY7ddusuouJetwAUizuVoj7kGinr3BQgsy/rGLn
	 04gC1Klv1Dp6fQe0zlWrCTTzGce2AZvR6vW0Jrjo2nPnrWggNEFCRCeMSWs0cznLy55uR
	 qVS4GlU9ZZh29/DGY0GD9zu+Fk6IJJC42ok1gMGI557xZNAH3jR4qaxjul5BoE4nncrDx
	 xUJY5F739JoEfSnoRkswN9TWtyBg3o/JONwNBC91bH8UfM89agxzh52RNKSCUJeYZ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AxvA3R63;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A560A3807
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806A560A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AxvA3R63
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b244fb7fffso646696c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164260; x=1795769060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DeemdZLIhx/5jLSpJJ+WPwy9ZHOFCasR0T6JfI13Q4=;
        b=AxvA3R63wMA0+a/F2E89T9p/cl7WNbLcVtKmXMnIhtsgAK55GQrNxeZ3sVVR6dEeav
         omaOfWqDIFN7OzXRRklrcpMJ7p25SaaRbr8VW4u7+xFRgAr9rCJQDBNoOiCYZ0zUjS+8
         S/tUcYB4h8xcih0Qmo31haV7p25i7MKy4emI7xgYcpNbbHsPykx7PUpyRbQI6YC1JEA/
         W4W8cGPOUJbZ4twG8GNV6yjc7T+0F1KGYkwZ82RRBhFMyXk0TmKmNS4/OCx6Q+uiO12/
         dPSyxxHQitQEuDcQ8rpL1nHViRkwqU/VjZFa01KlxjGX9LYVrctI2m0pL+du2QL0NZ7z
         pq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164260; x=1795769060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7DeemdZLIhx/5jLSpJJ+WPwy9ZHOFCasR0T6JfI13Q4=;
        b=BqFmrNplg6Y0PwlDelEhjUrYGIumrhvJPPRqGFoVqyLJXcvoE64Ho7sT5ZN4b5QYW2
         4mki/uZI0Fq3nt6z5S6Kv9CC4ARt4bRwTQL3cK1SDf8vjkYzzgewn0ecdZIOOw557MAI
         YYi7gJWfeINOBaSVn6BFsR2gw9iSmyTFUaDy1Axva2ymVD/632xFabpsoqU4DzLJ7uPv
         0wFrFWgkVHXKxu+nf11eF5NBMbrgbMKmxIbqmdxIGEpeQys3jjsSlb/984P70jlGtPvV
         bwHEF1Rsl6k40BCKzMnRMxA9rGmKZmUYCtc1gU+VWhikpVjsQegdCFt32uA9o4PlVYph
         QOvw==
X-Forwarded-Encrypted: i=1; AL+hErF1n0IGqDBBBQtcvO+5e3fzdyPGFielNE5035Nl29zWD+UIT+UGG4vs97DeIJ+hlGZb9WWdcsxrFPa5TQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/D/9Fe9LVVCxyXXGViwe7lsL8EE8NxrsskuYhKmf4WSkfRuLXA
	y251coJak0N26OMKxih1RikvtrGtBw8abW42wtIkz+9HzMOWU7PoSvzC
X-Gm-Gg: AYBFou1ztYnUNRZAkSNopCXgRfIU4+5igNjzIJzWDCyt9hKe8a8fX+sM9u/XpkhqO1P
	Lza6B2uaneMG8wK1e5O7sBtTXgGO/MCKtche6GumnxIP+aa7KWNK/3SMuzTNIBDBvnzM+s+ib/Z
	yPmcQxBC1uiu2BXigUlwokWhWCljcgu0xyB1x1EOpka1JSVlWOb/HFTEs/haOzbe0fvHudOgcqv
	9t1lNRQncgyBOsp2swCXNzfl0LhTLnYrW5QzKkG2b10Nt0fzdaL396m7TZQkh8wJU64NVUWgW07
	QBZeRU0uFtnoKFZQH+5Fyee0sDYu8oSIB5P7xticN383Hdc4j3k0OuqD7lsx81kKT1WS5y4iLvH
	x3/Dup/fkNQJMJYFBU8UYpZkKVK7eyAx5RCD8df2/RcAh5vfq/sVqOO8JT11uh/f9WiQwCEN1Qv
	vycODCcQ+lue3RcF4bz3ntDIO97Db1llYzzJcr0aCZRm+oPN7Pu3Tse1xt6seVsRycqkAmtY36K
	q9k7so63SLhXrEgRMZXXY+/l3IE6Aam5osY9Tn4YBUspDRmlutvfTPKnPWJeB3K0h3YDU2Qi5/l
	H4o98UawxLhlwc//Uoq4g3Pg1AEGsOauGPJKjlJ0jPnwEIID5mIaOZBwXOJo0s8MhGzabS0q75h
	hUAnPgOKJMZnqLOu4lw==
X-Received: by 2002:a05:701b:4510:20b0:1b5:595f:4236 with SMTP id a92af1059eb24-1b5595f4800mr1081274c88.35.1795164259605;
        Fri, 20 Nov 2026 00:44:19 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:18 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:43:57 -0800
Subject: [PATCH v3 06/18] HID: logitech-hidpp: manage G920 range sysfs
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-6-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
index 58f7cf84b995..1376d5bc3fbb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2752,16 +2752,47 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 
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
@@ -2848,11 +2879,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	dev->open = g920_input_open;
 	dev->close = g920_input_close;
 
-	/* Create sysfs interface */
-	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
-	if (error)
-		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d!\n", error);
-
 	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
 		 version);
 
@@ -4991,6 +5017,9 @@ static struct hid_driver hidpp_driver = {
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
+	.driver = {
+		.dev_groups = hidpp_dev_groups,
+	},
 };
 
 module_hid_driver(hidpp_driver);

-- 
2.56.1.750.gf70dc682cf-goog

