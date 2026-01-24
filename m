Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F39223DC6
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219362; cv=none; b=CmP2ZlUXu/+FVnH/bXPlnqPUsGyvWDkHByERTMHNU5HAfpZst+taMHfN0y/8xG/jX83kzuHKidqYSRdFwHIolp2trUSVKO3VF2hUxwWaaM+ag1wVNlxg8fiEZMuE8s6ud0Yg982fuhB/0/sTcAydm/ufrBnMHuo1FfdMsB7HWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219362; c=relaxed/simple;
	bh=yyHWHTZ3q3DotbU1mpLzfWDbwKx97IS2+wB4iEtV00w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlpiXldmEhMe3jeommWho0VMS/cmDJcGGDg5y8XlXxz2mIPln6ZOrC/BdFhlE5rXplwVI0By/ig0+bCGJU/QabZup9nLQzv2kCLSBHCiqGK56QwDQkZBoDz5aA1sc7HDhyiOdiGJG0v809ED/oRPWv0xVhBP4P3D71e9gAC9cDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moF0QcdZ; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moF0QcdZ"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so2863794eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219359; x=1769824159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwReS+VyqVAE69wkUgUOvkftIiDVyESdfXyVkGzdV9k=;
        b=moF0QcdZe++W5ptyLNjzpFOLk+uc6uV2JpNxY1fKjb5POXB7wnP9rF4PLr+lyylmqA
         +yDzgpER8Gif2IhL/FtFs6b8aIBbSty2zhBaKKDXoh2MK9oYpTO5/tVSb2JpV1NVuvS2
         kQ17rDspaHSTnGETXnBBp6cWaMjYv3U83656aBNZre4Y9HQ4fNWknkoJVAG+LYYqyY0K
         7onJlFnRabP+4Rv7ogTs/asgZgHXsM5xqhpr5VUiTTxvzTbRgMF34Yq03kE9+aZQNg16
         vDUMxouA48XitdzRXnEvt38vXxFTlEPYWp4id+aUe99quA0L6R8IIvChmAXHuyyVmibv
         JAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219359; x=1769824159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwReS+VyqVAE69wkUgUOvkftIiDVyESdfXyVkGzdV9k=;
        b=VEXvH2guF1KEnpmGGzB/m+qspV5MlNgwbVhcO2nCrzlXgYZYSTRkiiiHaBVLRu7J+r
         CKccwGlkgIaM1GQJO6AqYBROv3gRQJ3VM3XvEi8K+4PhyPgoLG9QecasxfJWyXePcXs/
         XzfkgGIp6mNsYBjHa4bKNt7GvfsY9bEbSOD2iS2ttEngSdboaw4LB7pS/hGb3GBYckoH
         qJkvKTvdmAOCNDmWZi89sKa31cVUojAfrgCEqdIEXqZIegUmvloXxXXgvGANthy++S2i
         /9HmB1JYpRDTUxSHXZ9293lXlEzdN5fsHD2PkxWPREF0Rh/KDL9ISzgqtyK/Sb8wybrX
         zPqg==
X-Forwarded-Encrypted: i=1; AJvYcCVWtc2yLQTqx+HbztzynNfFbVsyfEyR1sGJp7f5pxBIGov68GYxDbKm09bI8hSBevhl+LVaBbhrylrF5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIleN6Au8ohW9Nzw4NlpNmr7SVvcWA6kVurAxTfBsblP3vv63
	1ITo1W8uBqenlHRO2aeJ5bBXVYyUJOrz+GZwTib7QDnPOatJug3ukAdL
X-Gm-Gg: AZuq6aIhN+OrhiIWhLy213qVklwmQWU0+5lHDNHKdOjtvJVIyqzwVnQgMSAQsVws6rZ
	BJyCkBAzrdz2b7J03kHFBJAiK9KSG7hhBzuWSZUrLS4H1IAP3dHgoz7GIyduSueQKu+AzAMoFx8
	Xfx//9wQ1qer8QJtpLdlMeG0ICGgPx3yS68SrIKt1krE/zoqv5z/So43d5sgyPM/u+wK9xGHsfS
	aV+5MBeDJErgvVfEPrMF3JoCVw0awKuiJSfG9asLsZj7UbYZXS3j4/+z2isdNBpEDUkK8hEBa2R
	FW6mlivP01JfgcmOvMGDbAOFfDxTbyg+fzs2uV79OTs8mZVpk3OyB0zyvDHTcaJSZbtgNn34Lin
	KEhcBqV7Xpm938HDS0c+V+QT+tgZ0gBM60lhqyYNf4oRfRwnqeSXH6Dq5QpGodv/Zuo2wQxJlLM
	srfnC3nWpefnCuoxvgKj/9M6aAlYzF9lRfrJ55KnaLHDrdWseB26t+5+z9lV8h/g0=
X-Received: by 2002:a05:7300:ed0e:b0:2a4:3592:c60e with SMTP id 5a478bee46e88-2b739b961cfmr2913536eec.31.1769219359370;
        Fri, 23 Jan 2026 17:49:19 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:19 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Richard Hughes <hughsient@gmail.com>
Subject: [PATCH v3 09/16] HID: Include firmware version in the uevent
Date: Sat, 24 Jan 2026 01:49:00 +0000
Message-ID: <20260124014907.991265-10-derekjohn.clark@gmail.com>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Userspace software fwupd probes some HID devices when the daemon starts
up to determine the current firmware version in order to be able to offer
updated firmware if the manufacturer has made it available.

In order to do this fwupd will detach the existing kernel driver if one
is present, send a HID command and then reattach the kernel driver.

This can be problematic if the user is using the HID device at the time
that fwupd probes the hardware and can cause a few frames of input to be
dropped.  In some cases HID drivers already have a command to look up the
firmware version, and so if that is exported to userspace fwupd can discover
it and avoid needing to detach the kernel driver until it's time to update
the device.

Introduce a new member in the struct hid_device for the version and export
a new uevent variable HID_FIRMWARE_VERSION that will display the version
that HID drivers obtained.

Cc: Richard Hughes <hughsient@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/hid-core.c | 5 +++++
 include/linux/hid.h    | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..524f2b9ed512 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2887,6 +2887,11 @@ static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "MODALIAS=hid:b%04Xg%04Xv%08Xp%08X",
 			   hdev->bus, hdev->group, hdev->vendor, hdev->product))
 		return -ENOMEM;
+	if (hdev->firmware_version) {
+		if (add_uevent_var(env, "HID_FIRMWARE_VERSION=0x%04llX",
+				   hdev->firmware_version))
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a4ddb94e3ee5..8249da55c9ba 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -698,6 +698,7 @@ struct hid_device {
 	char name[128];							/* Device name */
 	char phys[64];							/* Device physical location */
 	char uniq[64];							/* Device unique identifier (serial #) */
+	u64 firmware_version;						/* Firmware version */
 
 	void *driver_data;
 
-- 
2.52.0

