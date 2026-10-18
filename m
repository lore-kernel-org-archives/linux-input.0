Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01746DFE8
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327705; cv=none; b=eRTSpyv51dl01YFt4pnmXUl9xSHPx5Bg81I8uQCP4z3fcqBT2GktuUQnLJIdYZNTL7wWBUf/8N6CDRhlpHOJ9OmWw0AUQ6sruC494/qOV+m9vTzS2ZJPCHhmMbUIsaK9YG4ly17GHQtbKt/QGR4lnOiPzhUs9DdvytYPmvwUz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327705; c=relaxed/simple;
	bh=sz4GE5UZkFlUYZOEejeNShGGHZyb/yr9VaGXbV0JW3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDrHMWR276dQd6LuogPEpcAwO2gliV/Dc3QeWZ5I28OnIg4H/Y0uNmudDDTBQAvY+EN8OLpcKY6kjIjORIAlx71eEx7ID/vZE6t7n8GJdl685dPLQiEV0Paq4FAjcrIsLc9D7+dWRe7NKMDdGheZD/axpY1w6EnxSyGKjHSrSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtLXN3tG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtLXN3tG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a0678c47f9so55912b3a.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327703; x=1792932503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnheYDRM6vYnCG89OFLcuiT1asg22kwip+wXziGfAlM=;
        b=RtLXN3tG3URGJV11DxejzEe81zujVlzksMwyUgMKIU9I4mS4T+68MqxObJpy+HDLnT
         2Xqj3OuyqxCHxK9S97WMRaRzcZHpgfWNiFm0ghpUZyO4dxVUUd1lbK9fqx1oRjWfe++j
         aH/yWpypRorEgNEA1atZg1KHHAE9JED6CWSNJQzLKDfSjfbqcMghbNzO6Eddi9+6HfBQ
         IJLs5LrX7bKZDz1huK0h6ALFZiLTBuKI2D07fiXFZRZQjQhLz49udqgdq6qcFfM17ml+
         uOEX4TsG/S2eRU29nUk1D3qsr8OAeMhMHVzMo+kC+lkGv2P2/sVek+pLT+9wQ9uK4w42
         9UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327703; x=1792932503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnheYDRM6vYnCG89OFLcuiT1asg22kwip+wXziGfAlM=;
        b=rk5bYpeYPG7vKzoa0iuTUPrBMPFwa9iARE/Hy7oTgYGc5DJ5S3QkCpgqXD309MTD48
         Vd6Y6SSk8CfuP6JJktqlfxIXZ6E9+qZ8MGjXHFK3f6V6IsxMf4sBhhoIilSk54Y9LWes
         z/v/9MG9x3ygKKMsrrCMEV+1SuzFOJni/2pUwt6B1KlLX9EhTciAL1XGAI5mgag61oQ0
         yo2rO/SvlHH2Hx77n7ihe9nNcYYSdrDmAwCklw9wau0UhkseBDN/hzFFrkl8sk2IgwQ7
         M4Lw3ToGonrWDu19OJGyxYnVec6gGcUQL8chbq3m1h69hVez9ag3Qp4NRqXzKbb11cd/
         4qIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1B+0aRG9p688Fa0rBxDLOSoa0jLoASs4zHCK1Q2W4MTp6ytP0uOi/PgzWzaDcZoUNRY8aoRjGnbL/XA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJxwEUtTstPZXqAbvIG0im1s3e43JI0w7svmon4A2N1uWs+q+s7
	vUdusaaux9fnY2Apl+irO5Phs2tA59+FJhjg6jhnyXC4M96CkXxC+5EB
X-Gm-Gg: AYBFou33yGpbIW9H0O2b111vFKo9k8wMxnxFeaiDqesYvQUs+25Svw2D5O0kIu+FTYh
	j5bhs7vIo0+dX6cU1EuEsTdoHXFsZBpXEeP+LH9F9OmlwXmU8UaarF7qoOWEPUrFUqw6G4E9yJ8
	it0TOkCKko/ROeGCFlLmh6EHJSSd9ejzfHFoN+eeWdCdOrNCGBxMzlx5Hk5NCPqRkRcD7fP80b3
	nP7Q+DwTe/nEDS+sDbRmpCdminMDKAAyGC1SqXXKi7dDYYe6qZVled27GopNJ4JhegTFV2e/zIx
	yiH4jHwcmW105deLJopEaocN6Ox5pX4xD152aHfiVKTfy0KYp2vf401U2LoTSLM+PR75DQtpcUD
	bv+M+OfO89nFAeFuciagMBmRmz9nT/ArosjPQlkKST8WITeAJ59Dz3bZsRX+mtydDjurw0CA+3i
	fJHr9OCcKnc7jLN8IvOhOgv3c8sKduBI3dZomZNHBEenVSHijLFsw9QS3p92YaBvEJwY7htEeQL
	9cZhk71CcDqaYtL2IkwKqw=
X-Received: by 2002:a05:6a20:43a7:b0:3dd:85a9:55b7 with SMTP id adf61e73a8af0-3e225f84339mr3880841637.34.1792327703067;
        Sun, 18 Oct 2026 05:48:23 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:21 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 6/6] HID: wacom: add NULL touch_input guards to remaining touch handlers
Date: Sun, 18 Oct 2026 21:47:55 +0900
Message-ID: <20261018124755.850888-7-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_24hdt_irq() (also handles WACOM_27QHDT), wacom_intuos_pro2_bt_touch(),
and wacom_bamboo_pad_touch_event() dereference wacom->touch_input without
checking it.

As with the other handlers in this series, touch_input can be NULL when
wacom_setup_touch_input_capabilities() returns -ENODEV during an
otherwise successful probe.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a34db1505625..e3fff2471d43 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1483,6 +1483,12 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 	int num_contacts_left = 5;
 	int i, j;
 
+	if (!touch_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < finger_frames; i++) {
 		unsigned char *frame = &data[i*finger_frame_len + 109];
 		int current_num_contacts = frame[0] & 0x7F;
@@ -1654,6 +1660,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (touch_is_muted(wacom) && !wacom->shared->touch_down)
 		return 0;
 
@@ -3418,6 +3430,12 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 	int x, y;
 	bool valid;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	prefix = data[0];
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
-- 
2.53.0

