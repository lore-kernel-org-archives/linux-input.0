Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1283E8C68
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127783; cv=none; b=VVFblMEG7y81fuf/eYD3nHEcA9TwhQgO5uxPPvFoRjE280wVFIAovv7aRR+b7MFur6/IFUiSbdsfA20nVriGObQkKCt97eBa5sLiqjPqWcO4S6G6e5vNQFgm9x4dsMppzVVFFxzLYkP2xetna8iQpiPXO/9fTtL2BEvyzH4rhNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127783; c=relaxed/simple;
	bh=bpBQJR0Lh7t53ADUklCY+fVEC2VAWri9ShCtFOB9yXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfTAG03ATDjmdbR/uZlxdFWdVKtZX3Ute8A5a/WjWJkCrg3D9pKuKoWsO6sCKnw21Nv8kPPCDQXmKNLh3F2rWOXm08kdonS4n8GBRWhoIApxLm60DKZx7HJqZT1P1yv82bi4gGnBb09UYf7WA1DcknH5Mavfu5fp6j/+a59yrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmiPnC1A; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmiPnC1A"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso8313861eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127781; x=1773732581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XpzAJs17AL49DrJB7/7GFvQC9N3pX4aoTE0ck01glE=;
        b=CmiPnC1ADHVve5+P2uBi660XU8nmd0O7OKjZQIxEIaupAtgdg25ds4sd/8hAu2zgtX
         lx4cf2TUoAnom468+1WEjVfOTr4J4egqJmTndpBIztNzfEZSPRBh+fSVPDlcJTrk027S
         VoUYFxmOXpehBRrmWqcS5HolJn5eA0dq0SXwoa5JK4e0YXe2M5UVGO6St2C3UrzEVEud
         gmbbAs+zaLotT452odH5l2T74Md0DiHTiyVS41Rh1UAIlOcY4/xVSmOf+IHm8JAWrllw
         6xJXCFoNNT2kMGYLR6OP3PWEbNsF0aMM/DyJeKQmCtwg4bGZvhjHyd8LsqKiPy31PnUq
         Cydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127781; x=1773732581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XpzAJs17AL49DrJB7/7GFvQC9N3pX4aoTE0ck01glE=;
        b=i5AL5VWytFg+EYP8fxxaehQa/qkKCn5VEowKGMenoV8MoO0dnkD15IBZMXrZQoO+Z2
         yg4rjkfk+tqlMpgxfjWtY7tei1Z1aKhMprHdOaBBJFof6qtmtEau//TMnvDwZHfKwT2I
         t365R9DHe42dncfiBatotL6xHuGV1H616Tv+5Bfbhq51bNcPN/h9/tR2ZEPMjYfhfs8u
         W4QbB+GUpfPXJa1wQJucvo+8yosA8iJhJvePgocdfNmjAZGsI8ZWhrYgpTTv3gUCjSkQ
         jW8z7Rxm1jo9v9b2kJ41vrVyDEmp+PJi8PtxjfQxkYaqruT76bQpH0GFmgc+KCwD8AY+
         Oqkw==
X-Forwarded-Encrypted: i=1; AJvYcCVAboJgVNbZjZfXSjQgsUgAfP0P0yxSv5JA7a5tRMFuk4FRPghoVUxafKADmfnC41ElDrdUEOoevnK6MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygMv6ROnjKrrSYTY3lB3GBD+NckPO+BIz60QAdQNeAQiBZ+UgD
	1Pu0JKnck83qcI3FMfap3eLH1fRaJ0UpxrEjX7K/ICFYZ0ju4sVY7+1h
X-Gm-Gg: ATEYQzwD1/JQ71iAmYDxDaBI6xiypVooMIupbS4zzXPr2kEjeLglkT8X5v2IRG4JOA/
	gAranel6snAtQzDD8fuVHfk4ToLw9ySfl/TfQ3bYb9QG+EffSKSpSxL2qmqeuOmeAqDORyZdzB5
	mhqBErb9CqLpKUx2ay35PcaW4e0a0boM0BtrovsKFPO8rGju69oE0N+lL/pWcii+awv/FVX1Bly
	J3gO+v0nLJSakVftY2T2Z2wLXAqqBkgNZTcDNSbKAro2N6UsGOuFaMBgFN8v5UTCdx46c2ehuS+
	bkAutnA3J/7Nx5AgJtBPN9jkMZsOmmbjM2sBP3j4tbIK9ln8N4YUvfwzikLhY4z160xmoSsGX0u
	CEcEA3DY7IIkNUtjLqBwZcDG+LZbf8pylD0RxlsE+c47+8S+geGK39f7HJp/1Utzj7bTN/fIKPN
	yy0+b19TAJRR7Q5GamkBcH1WdVHWE1CMU4hj0tNaKYP/vDE9penBQVI2ltwjPfqrigRfkK6rjfA
	dyH
X-Received: by 2002:a05:7300:5712:b0:2ba:9cc4:aebb with SMTP id 5a478bee46e88-2be7a0ff626mr852103eec.10.1773127781051;
        Tue, 10 Mar 2026 00:29:41 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:40 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 01/19] include: device.h: Add named device attributes
Date: Tue, 10 Mar 2026 07:29:19 +0000
Message-ID: <20260310072937.3295875-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
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

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e6..381463baed6d 100644
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
2.53.0

