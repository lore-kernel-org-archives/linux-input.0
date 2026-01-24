Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CD1531C8
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219355; cv=none; b=A/My4AHnzKPXSUvsbLd3PJ1Sx1qSmTCtUnyIHGHqMj/sPgOwSWgsE+G/3pCEu5OdkBM9BIkMTZv/sd+EtAdAFh2BpprbggSiSR0C1r7+QHZAkk7wxscGiKpbGKqw6VfxApVbzpqtnN21YtJ5AOvjfQ+xZrDLo5xtY2vmRhTKUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219355; c=relaxed/simple;
	bh=9P2X6lBhLKEX370B2D3nfIFaS4rm86UkbX+g3x5l7u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVlLxBGfIlVzyMBHu6345XUmLuckSMQWdK0rzcz4NACIwPoav+V5oNs4m8ROobchtg6Q/7nsKf+TXoEiEMWzEW8bt6eJL4z62gWUy3Rb8nFcSSYg0ztu4I+utiAXeXO0jqZPyOfvaLQ/602ewQvHjX9ninvEVzMms6sqRwjk2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONnHl3n1; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONnHl3n1"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so4831163eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219353; x=1769824153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF99/uWCYPK4U9PbgOwY3pTx4yNCxW3AAGZV8/M/3yc=;
        b=ONnHl3n1R+KgAHPPumQ1QEM8Z0oAbLiL+loOTS5k3fPFHuy0bK3TWN/btHhbLDDaXW
         zQt65McIZo5Kp4RKr8Wng1SW5F80+V3V60LCn7ClxVwEbmb0dlWCUTaQfBFhmCabTOVn
         +jlYp30irZ9wcN7BiTXck1z3Awe2BW1x7BGx4nsIVNRZqgqhTLdvnQax3WrcMZE03OBw
         Dbm5UT30Rj41BLYchXi2aTp1qbZ/te0/JEriiz50UP/hN7DqFeVLG4TSWl1wnDR5rr3t
         RgIQTXVyv35/EJJ446u4mgJPEjo0uk0C++7LCHIWE1agg4ZS3b2yOV4+r5YDY2bxaW97
         g1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219353; x=1769824153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZF99/uWCYPK4U9PbgOwY3pTx4yNCxW3AAGZV8/M/3yc=;
        b=r3nonNqlzpyy0Vrs+hG5zonSafehbGD9MWlwPai3C5blECknENJRu4A6kayx+7UR7j
         I5ygVgx0MOS+5H1jwhvqfIQr5GRNHp3hSNv7PLUne/Qu0Ydfm8ZfqExD3I65xqfJjvk0
         xUaZmlZ65QuP5v6zMGughuB7SrJb6cdHbAuZHQjdd2XPC5JVKx6cRA/FI9LLI77Fb2u0
         mRXt8Oy1MmpGgqzJBwrcD5ujUt2XgYznsUhdNyAh+OcRI32411EffDyLleM5nW4WgyrW
         YAuFCFi4gLZ3jBjivtj0mOqpEuWB/RY5FBQZH94Qb838pI0CLENzj6hlbe2VdKxlm6YX
         U0PA==
X-Forwarded-Encrypted: i=1; AJvYcCWDPs+sRhx8DMCBfB1MWnI0fYrpiDj5vo7SSs4sTp0qra0D3sBKw7II8yhbHXlCXqJ7iaC4u2OuLtn+aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvUeGzN3gaK0quRxF6DGiQt02G0AE1rRrt9mb+kUuS30Yi0cn
	HtwU+UjCjb18upfRlY5yAHbv4VoHCvTEjix8pewTPJc1aMMd12uM8+4O
X-Gm-Gg: AZuq6aI+LngrdvZ8dtvgGX7/gtrCKP30R8Q651pCySM7RcUR63x9YI9OKV8d2v5Vknb
	IRjBSAGyakIYys8yNbp3n9S6uWx0wipqte/t53TgErmma5x34C9uXV7Ex14T/TLv5G9fAFh41R5
	AXbjH+cPhvU5oYb7T0OAbrrOlrZD4r4BZlKNi9AB6UaxoUdMsUm5g59nOjaWD3omSn/+YSwpn6E
	/ZjcDayLvy/F07wHaU8Bu8yd5B+/7mLp79YxohdOEindfvslM3vOPyifymJG9xjeMGXiE3xEJyI
	uT81xZ1OmWoQAhtxC63FKEXRsAe6AapfRXCmUo7f7vEcoogo0XNX+e3TFL+Qr/VpN+u25CUQ4cP
	KehBWUnnXKO4P8BaN/c86Z73K7RBHrkQ+8d122kBlubxlzwDQIBKKJXhk0KH0UPUZ6zbh/ji5Je
	kFlgRPI2ZzqY3SyGsrmnBUKPALAcPf8LAoIEeUmKustkqoW4wxoHOKa+tWvwZD7umkJDWYeg/nI
	g==
X-Received: by 2002:a05:693c:2296:b0:2b7:19f2:6b59 with SMTP id 5a478bee46e88-2b73995f8c3mr3558092eec.9.1769219352977;
        Fri, 23 Jan 2026 17:49:12 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:12 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/16] include: device.h: Add named device attributes
Date: Sat, 24 Jan 2026 01:48:52 +0000
Message-ID: <20260124014907.991265-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124014907.991265-1-derekjohn.clark@gmail.com>
References: <20260124014907.991265-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds DEVICE_ATTR_[RW|RO|WO]_NAMED macros for adding attributes that
reuse the same sysfs name in a driver under separate subdirectories.

When dealing with some devices it can be useful to be able to reuse
the same name for similar attributes under a different subdirectory.
For example, a single logical HID endpoint may provide a configuration
interface for multiple physical devices. In such a case it is useful to
provide symmetrical attribute names under different subdirectories on
the configuration device. The Lenovo Legion Go is one such device,
providing configuration to a detachable left controller, detachable
right controller, the wireless transmission dongle, and the MCU. It is
therefore beneficial to treat each of these as individual devices in
the driver, providing a subdirectory for each physical device in the
sysfs. As some attributes are reused by each physical device, it
provides a much cleaner interface if the same driver can reuse the same
attribute name in sysfs while uniquely distinguishing the store/show
functions in the driver, rather than repeat string portions.

Example new WO attrs:
ATTRS{left_handle/reset}=="(not readable)"
ATTRS{right_handle/reset}=="(not readable)"
ATTRS{tx_dongle/reset}=="(not readable)"

vs old WO attrs in a subdir:
ATTRS{left_handle/left_handle_reset}=="(not readable)"
ATTRS{right_handle/right_handle_reset}=="(not readable)"
ATTRS{tx_dongle/tx_dongle_reset}=="(not readable)"

or old WO attrs with no subdir:
ATTRS{left_handle_reset}=="(not readable)"
ATTRS{right_handle_reset}=="(not readable)"
ATTRS{tx_dongle_reset}=="(not readable)"

While the third option is usable, it doesn't logically break up the
physical devices and creates a device directory with over 80 attributes
once all attrs are defined.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 include/linux/device.h | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index b031ff71a5bd..76f485e6b24c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -189,6 +189,22 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
 #define DEVICE_ATTR_ADMIN_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
 
+/**
+ * DEVICE_ATTR_RW_NAMED - Define a read-write device attribute with a sysfs name
+ * that differs from the function name.
+ * @_name: Attribute function preface
+ * @_attrname: Attribute name as it wil be exposed in the sysfs.
+ *
+ * Like DEVICE_ATTR_RW(), but allows for reusing names under separate paths in
+ * the same driver.
+ */
+#define DEVICE_ATTR_RW_NAMED(_name, _attrname)                            \
+	struct device_attribute dev_attr_##_name = {                      \
+		.attr = { .name = _attrname, .mode = 0644 }, \
+		.show = _name##_show,                                     \
+		.store = _name##_store,                                   \
+	}
+
 /**
  * DEVICE_ATTR_RO - Define a readable device attribute.
  * @_name: Attribute name.
@@ -207,6 +223,21 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
 #define DEVICE_ATTR_ADMIN_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
 
+/**
+ * DEVICE_ATTR_RO_NAMED - Define a read-only device attribute with a sysfs name
+ * that differs from the function name.
+ * @_name: Attribute function preface
+ * @_attrname: Attribute name as it wil be exposed in the sysfs.
+ *
+ * Like DEVICE_ATTR_RO(), but allows for reusing names under separate paths in
+ * the same driver.
+ */
+#define DEVICE_ATTR_RO_NAMED(_name, _attrname)                            \
+	struct device_attribute dev_attr_##_name = {                      \
+		.attr = { .name = _attrname, .mode = 0444 }, \
+		.show = _name##_show,                                     \
+	}
+
 /**
  * DEVICE_ATTR_WO - Define an admin-only writable device attribute.
  * @_name: Attribute name.
@@ -216,6 +247,21 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
 #define DEVICE_ATTR_WO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
 
+/**
+ * DEVICE_ATTR_WO_NAMED - Define a read-only device attribute with a sysfs name
+ * that differs from the function name.
+ * @_name: Attribute function preface
+ * @_attrname: Attribute name as it wil be exposed in the sysfs.
+ *
+ * Like DEVICE_ATTR_WO(), but allows for reusing names under separate paths in
+ * the same driver.
+ */
+#define DEVICE_ATTR_WO_NAMED(_name, _attrname)                            \
+	struct device_attribute dev_attr_##_name = {                      \
+		.attr = { .name = _attrname, .mode = 0200 }, \
+		.store = _name##_store,                                   \
+	}
+
 /**
  * DEVICE_ULONG_ATTR - Define a device attribute backed by an unsigned long.
  * @_name: Attribute name.
-- 
2.52.0

