Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546E35F612
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793224; cv=none; b=d5Ie+usFc5NlRUxOmWlw3a83RQkGWHegwwpP21m3RMyXw1+ypQ1A6vm1oIY21pSWQ0Be/dY5YpdIo/xxiHu1c+Gb+A1D9sFYwXWukjCu79cnNd3xnqzGCpJu22zy/0xsjFq709JDBlTaHHmvZmn32+IsTYHv0s7SEik4uBuK/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793224; c=relaxed/simple;
	bh=vfVmkzd8A0z6HncLF1fH136j0IdduRSTxvmyw33nVC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7AmJBTAAfIKmsycj7oDcMY7Y9KX/bBcEjVk9eD03n1yU7kIePuLdFw6zyjLhFwz/N3l5F4uTn6Xs1z/osalW25ZyE3RzNaJeJOhxlvJ4MkjbfxlA3DEZGm2OMrQj9uGh/K8glkHfBTWs3/ycpkmYkVRCjjNih/HvSGw3OJt4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdC82Uc4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdC82Uc4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9705613ddso18091895ad.1
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793223; x=1778398023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIb+W7y+bKsv9LM1iUZJZSIdILe100/J90mWVD85NJc=;
        b=KdC82Uc4RxV63zouQlJBoAiLSlIbk+EHp9xVB6Y9Lmr+4Wew9bv3DToJo2Vfg7J1A7
         gecK7yQP6B1CqUb4VPIQsj82S+YtQ+W8859htiC0oTo76vl3+v9rE94MuFFWH9WEOkhe
         az3KiZZspxvT2IKn4Bkp4nYdoqorePoR80gzVtnqDthqB1Urg7ipUxY5fbSd9SH+gXDj
         Oo9e7C/ixr6wUNuwY2AaszwnvT0/fVBoeXSGIVxB+/PdlVQR3INhuuys+IFighvgt0fu
         sBr8xVDASg3bhoNVoV4b2ytLdvv5zi7Od5eYtHVvg3VCU6wLS8q2c8a2+krC1ku5TycP
         Vp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793223; x=1778398023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIb+W7y+bKsv9LM1iUZJZSIdILe100/J90mWVD85NJc=;
        b=ppBW+GA6TBG+NzV370unX9o3Tfx9AvRQZXfORsRL7BVRvydQWrcKy1wqOoFqkMuAg6
         /VCS2/NFCeqZgUKhoTJTUcU0Tg2SFxTA+3P3fzqwLUosU2CSvukOvDmwauqBcKUgSeCw
         o/rlXEk5WycvKXNplp/WlaUvMWNoCpa0+7ytaDgJRjklByPVn5cgEGdKZNseSikIy8vj
         p1jihuBSuTcv+J6f3trliNYvK+j7lpG2VoS9+adW2vx3tCbU3P2QNZ3IytBGh1bWpyYp
         PU8om8jXnzg5BI0qf3+9FKQet3/6bvowAmlJdv3K/PQS+pAftpYWwb/oaT2Rwp87oBbc
         zsEg==
X-Gm-Message-State: AOJu0YxA+w/thjlvmWBCbTJEemcxWvcLnc427b5o0LQAAxjvjLEmYrTj
	PQ3mR7iknHZ5wbfG7HKKtuFmlUwkgkzDNSfie6YFftPyMuuuYAMsR8Rm
X-Gm-Gg: AeBDies5P+csBcH0LyFCaDyCtnQ9MIUhPxcyi2gklHYUhC9Sx4+M38zI4RTX6V5KlYO
	GrjknSqk1r7sinyn+33EnLl/RXfPZ28ROuNUJvJv/2S16uETaIWQ/gHUIqLGkEsh555umuuDP7F
	9q/syzmu8G8TiqoHMGIDH9RxCSSUDqtOYaJICjISkm6bcQtO7vSEYaKaCLd3I+7FWB152sUS3rW
	EBVSAVmqNldPCrty91ivPys3vpZiUmxYMYfVL9XBWQXY9DQKbM1FUxtdxZNPTf5FNJDJ5PYw0Dm
	fP+pIMyQJuK0bOeadSONLXmTgrUPL+G1CrN87RAw0zZXiwj1+SiGC0KQxFrovbyswJTtgufmpZ/
	2s0sRWcNzFVyP9FhCMcONFNbxb1rVBgdYL3ZBiED9LmJQ3G64U3Pa7TFiuk1FYfzymUyqWrA9p8
	jxgtDpkaIk6cWrgeWg9b5vQ1uJ4AzQrEJXdsWj4SMgF0/gdViUtLbFlTXLesXC5DPEKAfNig==
X-Received: by 2002:a17:903:3c43:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2b9f260d7b2mr55819115ad.23.1777793222705;
        Sun, 03 May 2026 00:27:02 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:27:02 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	lee@kernel.org,
	pavel@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	denis.benato@linux.dev,
	James Ye <jye836@gmail.com>
Subject: [PATCH 2/6] HID: asus: check feature reports when determining is_vendor
Date: Sun,  3 May 2026 17:26:39 +1000
Message-ID: <20260503072643.2774762-3-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503072643.2774762-1-jye836@gmail.com>
References: <20260503072643.2774762-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUS T3304 Soft Keyboard has these reports on its touchpad interface,
which will be bound to hid_multitouch. To support a quirk allowing
hid_asus to configure the keyboard interface, feature reports should be
checked in addition to input reports, as is already the case in
asus_has_report_id.

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/hid/hid-asus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..ef9d5eba4dc9 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1282,10 +1282,12 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	/* Check for vendor for RGB init and handle generic devices properly. */
-	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
-	list_for_each_entry(rep, &rep_enum->report_list, list) {
-		if ((rep->application & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR)
-			is_vendor = true;
+	for (int t = HID_INPUT_REPORT; t <= HID_FEATURE_REPORT; t++) {
+		rep_enum = &hdev->report_enum[t];
+		list_for_each_entry(rep, &rep_enum->report_list, list) {
+			if ((rep->application & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR)
+				is_vendor = true;
+		}
 	}
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-- 
2.54.0

