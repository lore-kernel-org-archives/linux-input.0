Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614D23815B
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896746; cv=none; b=e/HX0umw67dvvvX6sJM4pHcl80YbKpJsf4Ufbil5WFwcR6MthXPzwWGARvRAtbeFFBpZW53w6XYWYp6Ioood9LQEt3UVMNNjHUnYegPKCmLUrMssb8c1sljuoWHwonpq2rIfEByuv22lia8Iu99WlBJs26qzTFHX7BrlPQ3O2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896746; c=relaxed/simple;
	bh=duKkFzC00NILWdTsFDQ6jxgfrljHThYgPkLQs602iSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTubO0Gf9/XcVYdTJW+FoXi+UI10aHMvYJpfiwuBM6AI0tmcaxDRMwPX1DYPs1IcPAKzRVcQONAl6KOOfdypTx3Zw5JMojZ+qGtHh7m+Ws0DOsnNyrhBU+iM9gyIUqdIDJ9oNbCCn2t2Xumw0ITz8I66dHYqXIblskz5sLyKAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9fAQVrI; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9fAQVrI"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba88e53b46so2729041eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896743; x=1772501543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv5oSk0V/ZX3YgLXFixXf44tV2AKjxOWJjiuXpaRukM=;
        b=G9fAQVrI7WafhLbX718/eTrsiWwA6quxcUuhsAe+0+To25tvWl1KMojEEZfteZ/zG4
         fPBjPNouuorhApgB7fD+dfJRrYIu2+UV6+UE7368EMHaBTnSenQQ1K4EXqLAnJRSwsfc
         qS/XsKdosYJDrQplCFVYJgiG3vHD7j9BhdeJERl3XjGa5A22bAI4YGPOZRjiS5YB7mql
         Pc2+1TXlM+mY1ZVCPjmRILNODHkgfl8fDM07eQecRybCgcML8WnpYVLsRbb61ISLbiRw
         aM4X28XGuR4HSi3/Y+JFogzyxkr0qJOlq7t3OBEJjuU8FzPe9PyCXTxm+RLm9MkQy5zo
         nfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896743; x=1772501543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zv5oSk0V/ZX3YgLXFixXf44tV2AKjxOWJjiuXpaRukM=;
        b=DJLIqkQuG9HZXAgtSJDJPTPajvPNZHNojwebAZ/G8bErQ1P8kauR/J+kbOzE0XvLMw
         GD4/vgzyAG0sJ+/rQAqJgeC8y0Q9kUsYgEbyeSaoylMiFCREPIrfdMTBRpwe+ATLdBHn
         c4GtJlWbTJrV25l2dbCtR0jjFp/5GbB2TOCNCU5Rd4Qdb/CSWGMbkAp0xNLm/GeXdpsI
         zTEY+UThoCcB7qK2vG9zyvuWACNScqG6GLXZKY3oSrLnwPyD0StqFLgTXnV4z1d0cWT6
         0QPwK3njFomz+a9nrVpeYNP+/yHkrt/vYYFYVdkg/fxSGKaJmGt82kIwmn6MbFWu/MUW
         6fqw==
X-Forwarded-Encrypted: i=1; AJvYcCW8bFktMgwcY2i0oNwrb8/wH6m5SZHC9uazPEiKfKWUExHTERUvv7aCSwKQkp4hsErQ6w1Dald1DfPDQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fkA/C/I8MOgREE9xpB5QXIfM5nQgKrPNaooi84qh3X2HPFKg
	9fU9JnpyGzMdx8hLw+gNfPWnlP5KUuozPRRluFlKnbwVeJd3eg7HSXLP
X-Gm-Gg: ATEYQzwSh13Z/teSvJ/QTpZAMgA2lJA0OjDzDWafZ8RUcxgZtMStyBbiqozKpGLXmFD
	NJKStElDqD05nmhL14U9EE3t+BdOE5ZJD/AUaOGE4dT7Um1TZyM4ENgOATmKghW+ybnNU4fD9QZ
	9V/MqehQptyRN1isi9Y3vIc/6UP0iDq2yD6xuFUtCfV+JQ9+BMIK3LpK7FQugKFcrZpiB5SPs3t
	97ZoealXMyQlT8EBOusLXEMdj94+KanOFTVs2Jd7TJRsvJVoWNpBfTfiRof5UG1PLzl7zZjxsea
	CpyxxEjZVP81a1bs7VjDqP8wJ3y0w/g0J4fura50d1bGxEfu3ddRvc6ufdlx07D/bIf5HsF2YVe
	/Dt7Tk6P/wP2r+VTO4nHYfk4isaT26lvWa1xoxqzRJEhejOgUEErzrY491jq66tMSH4rqdFp9IN
	1+ErpztH1hgBiStZ0HA/1p1Pu88LxHzihLS8bNDn7M56Gi9UlEKi4WRjEBFLXhRHFivKyK+XDMG
	Rc=
X-Received: by 2002:a05:7300:80c7:b0:2ba:a387:92f6 with SMTP id 5a478bee46e88-2bd607e8679mr6380408eec.13.1771896742472;
        Mon, 23 Feb 2026 17:32:22 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:22 -0800 (PST)
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
Subject: [PATCH v5 01/16] include: device.h: Add named device attributes
Date: Tue, 24 Feb 2026 01:32:02 +0000
Message-ID: <20260224013217.1363996-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
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
---
v4:
  - Use dmabuf per request instead of devm allocated static buffer.
    Resolves bug with side effects during suspend.
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

