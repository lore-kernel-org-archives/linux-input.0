Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D02D7817
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571160; cv=none; b=M3pZs9xF5p8Pt8pKIAzHzdA9tWSYe3THalsz/Du6hXbJvWUPkRHQNJ+AdVKIzYDZpJIa2oKkkrCv4QTN9D1Yuis0Yx77jOEdNvgvdZWZWZRNedZmhSv4hTdklHRqDfj3U5fsukJXg5eq1jVJrIZVDE31T4qYMC0QLnXYNwHRg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571160; c=relaxed/simple;
	bh=+4nfO/MXU83pOeG2DXV/A8HvHCPLmR6w67tZZuPB84I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRQQP9O9BjZBTBzfrW9Moloj6ZqRPjjyvsQoK4MbV8p0KDkD0p4nWCmRtGX3U1h2PBDzo1hdqs9SAG6KGI9AVxvDUe+oueGznz9njBmgwskFBMZEgCF18ej3kCCf2iHsjpSHwe1tiHkEFNk/fLx0q4u5eLZQfroEGWkCLM9OKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9HuPT7I; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9HuPT7I"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b82c605dbdso174728eec.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771571157; x=1772175957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCIGvEeI9Tq/VaiBgRhw0In7nNopiUbXBw8UFPFZx+I=;
        b=Y9HuPT7I1O/YS9sBVuowtWIpzq+IK3hu1XcX6Qtk/Sv0/trHeuvDk6a+wwzze2oiQz
         +bGN3XceFn0VP891/I54QZArzIK3fWQRWmNPXtZDt9hVHQxpswuf+EiFznYvGpYxsvU1
         RdrNf6WsvfGzoQMsPoDWRC77uRaQ8fKcRwqPbG/j/OtJXVeFjHTFWPDzbPKCotYbnY3Y
         IjJzdW8IfBOD5+HMT537p7k2mEdh8g6GAR5Z2g4gNvvrVWH4C+SDN+ZtqMxolpgTd2mF
         i73Gtn72noPqm2szZqyI/rTqGqif9LmMmVLIKHPVc1hWBSfI1zv75GBfkqsMDKA0f49T
         5XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771571157; x=1772175957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCIGvEeI9Tq/VaiBgRhw0In7nNopiUbXBw8UFPFZx+I=;
        b=o+5LxkXbz6ZNZaUCfqLM4HrGqehFnx70eah3v6SSOK5tpKbaUqN8/5RbUfcEt0Ag/r
         070hllt0fahMfw5MENasB362d6h87W19th+HLIu5BQ5RNoBB9g0GGO+ar+UlpWIEq+Dg
         oC5N7ub8o/372T1G3sJS32A1YYRRPTbgNeGzA40/Rp7/Opn2fIGh1FrDKcKmOXprAqtJ
         5jPKcPkL8IBon8+QgePXjDkkBZbHsHL6zRUkmf/Twzi8+nhJ+l1gI4xlEI5YPwLgq9Gm
         y3MfXgBaggDfCmpVSzBzL+SdGDlBfdBfKZdmNvBk8YldvhseWLUB0+lF2EvKmo4krUyi
         9YEA==
X-Forwarded-Encrypted: i=1; AJvYcCV+otf9ozMafzgJiovCChficm24Pv3Sn7dRcYL5KP2eV4tE682rs+TKn/eE2snsrh8vwgtbZrt74m3EYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqjNwRN/0vh1Ex+eN9kY35eJUYKwAZ98r+Y7dXKpov0vqqTEy
	8pLioVCRD5Gd5qqvqkUVH4dBf8ax/0fhfjVME7ZXkJwsrk2C0SAtlNVF
X-Gm-Gg: AZuq6aKEqUQJl+J912sucqkGiHTZPgABV3dcUCtOQxbkc1+/TCB/oY/EoMXSsbIx3SF
	s+KWpr07yl7h8sYbzO4/UMbgPvpbsqaJaC/E+PE2pz385K2maZa/rZcRMS74nV2cKT7FE7tGft8
	eHatgsXXVewscisoPlOOSi/0RvOnCm7Hs6sDbnhLmKXkOUm+53jHIHfz2Xj1Gi2jn9WXM72phFS
	G4nIDvTou9CEcRUDRTGxu8w6aZjbBGuHn8JjqYPu6EMhjVPrCy1gr2AGwLqXL14YiGFAlLgfldM
	L8DYHtnjCgv8HduFzk8OyU2vbquvImhly69lNYjz2OI1yJgCeDEtxXYbR1R0qjlfYx2GhPJgule
	2dX9pz/q6jFYbsLbLqiMjQZcvV7h9vYcNMY+89FfxxNkWUJTC2HhkI0ovyl6FrEJZUA+lBVgPr9
	XV/+6FA1R9T/tPOSWU1pTP3jj/cPL82et8bokgOBab8cwJeydWAmgqeUW8mZiyLhP8Ji0hl763j
	9Y=
X-Received: by 2002:a05:7300:508:b0:2ba:72b1:40c7 with SMTP id 5a478bee46e88-2bd4ffe8e34mr5486846eec.4.1771571157271;
        Thu, 19 Feb 2026 23:05:57 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm22163335eec.23.2026.02.19.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 23:05:56 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] include: device.h: Add named device attributes
Date: Fri, 20 Feb 2026 07:05:14 +0000
Message-ID: <20260220070533.4083667-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
References: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
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
the driver by providing a subdirectory for each physical device in the
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

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 include/linux/device.h | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e61..381463baed6d3 100644
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

