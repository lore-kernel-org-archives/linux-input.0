Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BC3D413C
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320403; cv=none; b=QufW5RMEVpf0kfEMwfz3H01Ox659a5uzVza6pmrmOroJ5NbrnhYGmABcBuWoDv8hE0c/fnqy/hOqUtNRy556EVeCGWEeqR9Jr5NTxNoMkBnwVIgpoogP/PcJEdgy6Bh7dDRYuPiTCy1Q4v86UUMiNaKFMdzoN68qAGWCoG3THl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320403; c=relaxed/simple;
	bh=/9jJroci2U2W/cLGUUAnMj5rSdaDkUk8alpovYx9b1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDBesS79oPcBpKCyz3negoiOK7cdwbvC/x62mb4G4lCupvhyAfVeinpxQYGhfr7+M2X5WpUXBK/5otpoWc22CfIdJw2nCh+lrkBmPoNz1bNivWSFZachbBgQg6ROgutSLRQme1Fyp5sOmW+UDqbDZAwVBGVpQwooTPdGVVBnzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSGOfGgW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSGOfGgW"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so967917a91.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320398; x=1792925198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTvdBTA1ASG/CLsQcCPNTtAezqD6MV1QwMPamzS3K+8=;
        b=qSGOfGgWrX6cpb7sKnahvisOstsNgVnUD8wjDv1vX57LGeatjcbNhmleYUXQkxlYBc
         sVcfNNTU5uLzw6D1gH8oGLzMI61RNEYQWzFUYUwuUFmbzWn0znvY10Pl6DuRNmRb9i2x
         9EdQ0To7n4OmXtpfe9n7rWupdCBXvFZbR1jGhUbjXe2v4rZYTBS+4cY8fsPdRL0MQzKm
         C/a+J2fhOOsM5OikGUDrkI2vdsy4/RqEiUBbmnHEOnRLBdojlDwkIYzFdG0PLoXvJFeh
         CdJ8gW7Q2yQElBRzXQ9PMEfgCYENhLksyL5iw7Qz+UiSrpkEixUrZS7ereYrGoDxa/hn
         N5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320398; x=1792925198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTvdBTA1ASG/CLsQcCPNTtAezqD6MV1QwMPamzS3K+8=;
        b=iE5JRjVZgvf9fv1R2GwuKNx5rmyobHbLjFhI6Bv0gROkj5sh8X7xY54P4uHmUhpueE
         PIrmDWu5Y5K9xjG57jsPVJqj4yD59Jo9SnF5Ud65dla39rL8o5IEtah7gBovzH6qHssk
         wogLux6dJAOBYeRPgeUDLwUj7X37pSl0ow+AHuoA2UqirdAvKLluMZM7NjC/OZSsV9ej
         YUT+voIyYDnV3ufUxmLepB3mFn9DnJfIJPS91qsa5wWLD/wFkwrq25r8cMBKPaUwd3Ps
         26bbOhJx1/Nn/obEorBG7wbLkYLg4rVahgWzG7pzk53HmsnUFy1hJmJHvWB9V+QBBNrU
         jp0w==
X-Forwarded-Encrypted: i=1; AKwUvBxCCfkr//a/azWwKXzKNthraZuZELgkN6+AUzu9rNzblPpGgtcnaNUvnqTJnfxPS7Pluw3+bCWfWYCJqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKN843ojZxXa8XoNEjvkAZxl4S+oohuoiRCuB/w52Ldw8DYlYLt
	4w3fsss2/5PSe7aqTCWJUrorNoQlgQKl2r4PiRUINUfKEjuaiozpRHyU
X-Gm-Gg: AYBFou1l53Ae6i7ZZD+akr8s0WWhtXV09x3uctuCHYqguN/OwEaq91U7lg5ywtkt1H7
	n46TLhOSWjQVeC27RXfaeDSWFnuVwXddP4bnK93jncAZC9Y4d0O8zrQhoTgK/ri451ZzIFHgQAG
	SPMi21YomfkojgPZxVWlj3rSllSSANtQJl7+JjJMM/thVMEQemrqkg/2peAZNAJolqgFCCAHCJO
	oeC1u+0lNZPtuESDsTgJmbhj3tfNNH2YDwXqDA8NnoAn7HlqzhDnGZYnVynhDWD7sFWOoe/NyKF
	tbA2tWi4+z07Xt0JipkGRPA/t2allJ6s7/GhMXZyHtdhfUKv9U6m63QePiRiQTD5rbBJAsJ2W+1
	nnQZPvvY5L37gUPWSd+ekMua8bGgAQMxRQyXC6s71BIRDrPtNTKXvgUu0q3olxgV7zYqzj5j6BI
	XWTpnx9NskgHjKoJeE34BQAKF4oMTgfd1u+XCF7SVk9wZOxlgxcym+NBgGOV1nLDp0W/oygUdA8
	ZS8tOwOBhysz5tiyVs3ZymjLm+Td/cLwg==
X-Received: by 2002:a17:90b:5825:b0:3ac:7c52:faf6 with SMTP id 98e67ed59e1d1-3acee2963bdmr3584156a91.1.1792320398213;
        Sun, 18 Oct 2026 03:46:38 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:37 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 5/5] HID: wacom: add NULL input guards to Bamboo touch/button handlers
Date: Sun, 18 Oct 2026 19:46:17 +0900
Message-ID: <20261018104617.743771-6-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018104617.743771-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_bpt_touch() dereferences both touch_input and pad_input.
wacom_bpt3_touch_msg() dereferences touch_input.
wacom_bpt3_button_msg() dereferences pad_input.

All three can be NULL when the corresponding
wacom_setup_{touch,pad}_input_capabilities() returns -ENODEV during a
successful probe. Add per-function guards.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 12a632ee1cbf..21c2504a085a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3148,6 +3148,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	if (data[0] != 0x02)
 	    return 0;
 
+	if (!input || !pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: input is NULL\n", __func__);
+		return 0;
+	}
+
 	for (i = 0; i < 2; i++) {
 		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
 		bool touch = report_touch_events(wacom)
@@ -3182,8 +3188,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->touch_input;
-	bool touch = data[1] & 0x80;
-	int slot = input_mt_get_slot_by_key(input, data[0]);
+	bool touch;
+	int slot;
+
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
+	touch = data[1] & 0x80;
+	slot = input_mt_get_slot_by_key(input, data[0]);
 
 	if (slot < 0)
 		return;
@@ -3226,6 +3241,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct input_dev *input = wacom->pad_input;
 	struct wacom_features *features = &wacom->features;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return;
+	}
+
 	if (features->type == INTUOSHT || features->type == INTUOSHT2) {
 		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
 		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
-- 
2.53.0

