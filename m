Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267D3BB107
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101835; cv=none; b=QxDaY4qFmp8d1VvQyXw6R6O+jobkGOEkfaNyj69DSvaToeeHBx5hIyFnWKOtbybNPLUHpJGqwzjxEYsSvG/GH2n8YfTxwsk0aOng8TH7NlbJYhUHZISheQxQeMIne7Z1tBX43C4V86nl9TIcaDUzQB2tIRpVZKfmPqVJvwiDPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101835; c=relaxed/simple;
	bh=aEjxZJwZLa+q7K9xSjUy2o9VFRy7tyW3hxCACheKEzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG1JTBaYRzo2h/QrlltfV6CyQ1RA7bL3CQuwDjZO4rmLdsPKDwQ/08n5Bpe5CcYG6whSjfLzo1msBmoAArXgEol4mRCP1o8685Dvwe6N7ttfSIL9yBGIbbRdy6RY1bYo25ZidGCmlxYr+igFlwJ0t2XT/X4+bX4SfqSlFiV7Aw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZicajQin; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZicajQin"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so1842815a12.2
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788101833; x=1788706633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWOAHh0q81CutOvcz4kXnkwApjt4e2WZQIvquKf0gdA=;
        b=ZicajQinxa2vtMxCTblpqKmx+/7DS/HGvaL6BgUWdvvG9/W8nGVfs4s9pEBNuq8D9o
         dYyyKxKmUvzZ2y4WvOpSX7DgCaCq0pjZZYyyrsj2mWUeagjvDJ6XRzeTPvF+G9e2v8y5
         7uefCM2UgDQo6pQL/HK63NbVdndN6BNyQXLseU8WcKrG8xtT1tC8cXwjU2L4BshqmJPB
         waQT86taUIHKWb2kcRyBg/4Q2+4ve9unYN/aN4tw1ULgCiZStd0r4z74cd17HAVrBgTo
         EkBz3u4PLJXdaNpoLFfBhOX2LW6nmiahUa+sBn4Qg6NQT6dODIS1af8bgd4FjRw5KUTc
         mIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101833; x=1788706633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWOAHh0q81CutOvcz4kXnkwApjt4e2WZQIvquKf0gdA=;
        b=BGYRosLWq3R/YBTmCs2cmXar6GeeG9gLLT2SXFOsbucPoIhQlkKec0L5Ar+jrMvrQz
         lXuKAADq2aw1Q4XoKr+eeVmNMIY21/AU7611ftbqG7/PbnfUS5cQXUYIJCFYd6nerOT/
         ja03EEjUUKyvZ8r9SKvj7OTlnditB3nI2INDSxlATHPZlSDqDx5i2QAO9M3ziVesLFGB
         zktefkx7UE8D1/VbdLNOXRa7JEbx0RqWgcLOhNlQpmZrsH91WI7AX1XJbfz4ewvPzbf+
         ewoeTGPQZM54wUNhI81mldhYl9NK3CpvsjyJpUN4LZa7ORQ+wgVD8+nC/4dWQPWy40S6
         YNAg==
X-Gm-Message-State: AFuF++mkM5VaVTWeBAKdLpsiMQMuabdHwMxhGlb5tPK8gcnikDavc5Ci
	KNxkrbmOL23as+etASDDoW74JzQHBbjNY10DpuNdb2rsUL4r1mMKcdYx
X-Gm-Gg: AR+sD10U8yCpu1+vrvvcsf16u3IlspJXbsDEMgQGnxA/qqkRSjb93o9tD7qYBvC4PQA
	g59sqroggSIRFmL/Xppn7LwFm8gvpng5zlAuAwoMQBfhFeg54ROKdpMlt9z4z20UgHvqoUbM4R1
	EuK1poqK+xZjZSKqWA45AA36p1MTP4aehVwkPDbwQCzO/vl2tqYJbZPKC0CQI8GZNcScps1yQdq
	aHkCBSziJ+L6iIW8U8oqQaY5LSkhkfBtmZZgPiIe+mi/htnkqaeSWlUjZvpcM0YUKiJC+Sne1VI
	N0cA2FvyfUv1h9iJA8ZC/0QXG4fXKGcqKB1WJOBTBxf6To9d6z3M85DTIUvaWE/FtiHw9CNMo0S
	495CiroQqoxvy/Yv1EAJ9eTZ3BPnltlesnO7oYXDk6ZEmoLKjwebPMUgblp8vbBu0fLCwVETQ8s
	1rH7TGjz4jGIfUZHhNkAChM5LS9K+2LqP9Etcre4F2t+CFmXKFDcuGRf1g5CgGzEKUmFDqHgMg9
	c3vjxr+Plm5I4MlqAQ=
X-Received: by 2002:a05:6a20:b7a7:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3d268ef9e07mr35570313637.9.1788101833386;
        Sun, 30 Aug 2026 07:57:13 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm23198024eec.15.2026.08.30.07.57.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 07:57:12 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] HID: hid-lenovo-go: use the right controller selectors
Date: Sun, 30 Aug 2026 20:26:54 +0530
Message-ID: <876cc33bede49d8ed2437278f0696010df98643c.1788096667.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788096666.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The right imu_enabled attribute selects FEATURE_IMU_BYPASS, and the right
reset attribute targets the left controller.

Select FEATURE_IMU_ENABLE for the right imu_enabled attribute. Target the
right controller for a right reset.

Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index b8248bf8965c..b937d11dd6f6 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -1999,13 +1999,13 @@ LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass_enabled", RIGHT_CONTROLLER,
 		    index, feature_status);
 static DEVICE_ATTR_RO_NAMED(imu_bypass_right_index, "imu_bypass_enabled_index");
 
-static struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_BYPASS };
+static struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_ENABLE };
 LEGO_DEVICE_ATTR_RW(imu_enabled_right, "imu_enabled", RIGHT_CONTROLLER, index,
 		    feature_status);
 static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index");
 
 static struct go_cfg_attr reset_right = { FEATURE_RESET_GAMEPAD };
-LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_status);
+LEGO_DEVICE_ATTR_WO(reset_right, "reset", RIGHT_CONTROLLER, feature_status);
 
 static struct go_cfg_attr rumble_mode_right = { RUMBLE_MODE };
 LEGO_DEVICE_ATTR_RW(rumble_mode_right, "rumble_mode", RIGHT_CONTROLLER, index,
-- 
2.55.0

