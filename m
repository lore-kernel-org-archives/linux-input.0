Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E983B813C
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483972; cv=none; b=OTcx4dWIyGwUzEVcL09ylOMCiTcd3PiXX8lCWvEnleARqFbFC79oswk95+x44CT56L1WQmLQFRMgG9sjon2vY5DsKrC9I032jKoZMBHFYeeU01BuRN+XNCnN+93pyEScvhra6SEJK07BcEa5YX7XsLF2Jjb7cTbXbAco7Dw8EXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483972; c=relaxed/simple;
	bh=YhMG3fUk/XjIoLHujEEjCo8Xx/HTzgB3tQ6DnSl55zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXVO7QxX41aEiyQtezp2KSpyQEWQX4PhZKwPUrza/fg+pTCHuwz6GvnR2H5ZBAmTHF3g1YYVtuMRJPFMEVPwCi805NHKfgA/AluAKzehVpq0q2xKvayfs2O5XRWmlzPZ2pqgdvU3tJzQmyrh0+Xlh2iL4gmEnTbfxXFCNW0Uo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSIbLynl; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSIbLynl"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982db8d3b79so722728241.1
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789483968; x=1790088768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F87Nj6cbUlhN8QRz95TtuecHNAPdmCP6EjjN+M7wdxM=;
        b=MSIbLynlHZ8B6MpNrb7NQ6YMUvpug/Afg25eeHj/I7tIl0u2A2YF6P03IwZIz9vkKy
         5mdaHLXYsvZzkQ6SeKHbiQig+r2TSywFGB6Zy3nwqyeGrKndSxCjImmcc92bH/bRPpQb
         HF4VDGWwGmFkuO46L+8I5uyTKhI3TkyyQurPuQn+NzThChPDkEwY0QpC+w6bB59mSk0n
         Mfd5h/wD/kV8NipVGntbIy3tbkWgKsSf2KmZ2C/PMdXLLKQIK7XvI/ufyZv7rLSJ5wg0
         JKfjGDSzl91+zO5WiExCBP6QIf+H+ceypuQ4yIrnyPkNzxhDziDTMiesQUH1UtgaZy/N
         sZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789483968; x=1790088768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F87Nj6cbUlhN8QRz95TtuecHNAPdmCP6EjjN+M7wdxM=;
        b=x31IM9ztZ5Et5zo9DNEc7FL1IPdc+zyculvOMfv9Rs2xcNrgKDPLS/OtG9aY/S2ngV
         NReFRRTLDUYusC0i7RBfRvFNnfHF6utsLsAnUvS2+7hdlRq7WFg/KAILLEJQkghX+8JZ
         IyrBPa2Lw7TfeC/a6ya5iFbLYexr1lajW0UuwHZ/Gu1k2CcY/lzp2rTYF2BlPwOjtfnV
         PBoThIv59KlasQAJNW7Ze+leoujEpRqIBNVeHpFnO6BlXcIfeks2A3cQPEf9Dat8AQJ8
         icbzhlUXyQ4ITittiqQcftCc8nMmScDJeoo5H/jnpXZyUFzhtdSghIVPMvmMqWSRiAKk
         JhLw==
X-Forwarded-Encrypted: i=1; AKwUvBy7ILe/nWg3DoXsxMf2+Wm6FUyzpZgvpN4VIA2lcVM6qaQUzRb66D8tpKe7zDYsjBdg3UmCQVLhKo3VUg==@vger.kernel.org
X-Gm-Message-State: AFuF++mwc8NsB6RNQndByv28LDuPcPXGucuenUQt5U/us58jaQrkDkbI
	d/8JCq/bgVSE8P0pnwgacOC/sJ++gD+grF4HKwlZACDYHVSm94mFjKyt
X-Gm-Gg: AYBFou0xxRDS8KMbomtojLhqgtVR2y+9uEiiBnsYo5l4u4HcKY1/pfVn+kibUo2ZuhM
	IFmmdb+EXHLLKuPwspJCa8VfliHZhhY7ustcs/JjOWH3uogZTuL6OyJn+V0trWk5F3UrDsU0j6A
	VFiQAfgbae00HSL3zBy2QNOyj3rISJ2y09VaeYjJAI+bfq1nRg6G9KwTw9nWhhnngMJO4HEagp+
	OZJRO5so83/vkLYF+ofs0UHVR6JLlJGDCI1dPGgEVBXc3ai6rEatOqs/A0gxKUoQf/Nsg+PjnRS
	TsAdmzZzc+1OdSDDun5q0O2UlqNOOpO9gkK0igrI48+dPR0M0094M7u9kcmYDR1IRodfOYLTlig
	qMmw2r3Zc8YypYHDX2fg3lIoEa2OZnv4MnhVJfN3QqEu74cRpPwltrpE7yztY3aLJV0rn1RyIVc
	DKZejYoVi+lwz1MpGNOPBhgeqFQPcG+sl+hjDDdLbml6rgpO7nu1gETJ89z+xT9DUY
X-Received: by 2002:a05:6122:4f91:b0:5c6:58df:5826 with SMTP id 71dfb90a1353d-5c981d5fca1mr10648335e0c.5.1789483968151;
        Tue, 15 Sep 2026 07:52:48 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm15063108e0c.15.2026.09.15.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:52:47 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] HID: wacom: avoid overflows in sequence number tracking
Date: Tue, 15 Sep 2026 11:52:29 -0300
Message-ID: <20260915145229.3036596-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915111448.2726869-1-qwe.aldo@gmail.com>
References: <20260915111448.2726869-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dropped-packet calculation derives the sequence range in signed int
arithmetic. A sequence field whose logical range spans all 32-bit values
makes the range calculation wrap to zero, so the following modulo triggers
a divide exception.

Normalize the maximum and current value according to the HID parser's
signedness rule, and keep the sequence state and arithmetic in s64. Use
div64_s64() for the remainder to avoid __moddi3 link failures on 32-bit
architectures. This also avoids overflowing value + 1 at the logical
maximum.

Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-bit")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v3:
  - Replace raw s64 modulo with div64_s64()-based remainder to avoid
    __moddi3 link failure on 32-bit architectures (i386, arm32).
    Reported by Sashiko AI review.

Changes in v2:
  - Normalize logical_maximum/value as unsigned when logical_minimum >= 0,
    matching HID parser signedness. Store sequence state as s64.
    Fixes unsigned 0..UINT32_MAX range that broke v1.

 drivers/hid/wacom_wac.c | 33 ++++++++++++++++++++++++---------
 drivers/hid/wacom_wac.h |  2 +-
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea856..af94f59a5d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -7,6 +7,7 @@
 #include "wacom.h"
 #include <linux/input/mt.h>
 #include <linux/jiffies.h>
+#include <linux/math64.h>

 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -2527,18 +2528,33 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	case WACOM_HID_WD_BARRELSWITCH3:
 		wacom_wac->hid_data.barrelswitch3 = value;
 		return;
-	case WACOM_HID_WD_SEQUENCENUMBER:
-		if (wacom_wac->hid_data.sequence_number != value &&
+	case WACOM_HID_WD_SEQUENCENUMBER: {
+		s64 sequence_minimum = field->logical_minimum;
+		s64 sequence_maximum = sequence_minimum < 0 ?
+			(s64)field->logical_maximum :
+			(s64)(u32)field->logical_maximum;
+		s64 sequence_value = sequence_minimum < 0 ?
+			(s64)value : (s64)(u32)value;
+
+		if (wacom_wac->hid_data.sequence_number != sequence_value &&
 		    wacom_wac->hid_data.sequence_number >= 0) {
-			int sequence_size = field->logical_maximum - field->logical_minimum + 1;
-			int drop_count = (value - wacom_wac->hid_data.sequence_number) % sequence_size;
-			hid_warn(hdev, "Dropped %d packets", drop_count);
+			s64 sequence_size = sequence_maximum -
+					    sequence_minimum + 1;
+			s64 drop_count = sequence_value -
+					 wacom_wac->hid_data.sequence_number;
+
+			drop_count -= div64_s64(drop_count, sequence_size) *
+				      sequence_size;
+			if (drop_count < 0)
+				drop_count += sequence_size;
+			hid_warn(hdev, "Dropped %lld packets",
+				 (long long)drop_count);
 		}
-		wacom_wac->hid_data.sequence_number = value + 1;
-		if (wacom_wac->hid_data.sequence_number > field->logical_maximum)
-			wacom_wac->hid_data.sequence_number = field->logical_minimum;
+		if (sequence_value >= sequence_maximum)
+			wacom_wac->hid_data.sequence_number = sequence_minimum;
+		else
+			wacom_wac->hid_data.sequence_number = sequence_value + 1;
 		return;
 	}
+	}

 	/* send pen events only when touch is up or forced out
 	 * or touch arbitration is off
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 126bec6e5c..74e7c5a04a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,7 +324,7 @@ struct hid_data {
 	int bat_connected;
 	int ps_connected;
 	bool pad_input_event_flag;
-	int sequence_number;
+	s64 sequence_number;
 	ktime_t time_delayed;
 };

--
2.43.0
