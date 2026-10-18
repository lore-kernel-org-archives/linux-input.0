Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800449BD63
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327697; cv=none; b=fuOC/jVKyZSFuxB71ZBHfww7ng3GPwDbeVTh3FxPylgoNj+WMTtaVK5vJZPtZf18vHQIl7H7brzm/8qPSoqos4hmC/ymCtfNXfXhlq3TIcSrpa9wUhwOcRrNIEzCUjq+KfWETEJGyMSG4+e97R6jUsq62uxd64+CdNg0ydeHDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327697; c=relaxed/simple;
	bh=WHfKqs47WRFyxZKZD0j330jkPnh+adg61QI7v5/oMMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2CHmPLMH+kBaPzfR13h8n3xx3gm7tyf9sVt9dbSWhqaOqQkujBWWTJ9QFrPfdbE69PQdwfRFoWEUK9gV9yoao7DdMvZJ31Fs0YGzFF/SP8BNnlQpkslWr/hepZh3kTvSZ0gfZet2eU/tkU5Mswca2pDiZSwEC2hhuNMwFOkSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XToaIPoT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XToaIPoT"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so229646b3a.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327694; x=1792932494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lm6hadMr/YvEaZWMdI0VsBY5S1pV7Un37ouu2piB0RE=;
        b=XToaIPoTxj5rRiFL8x9PFh5WFfwqI3CaLeWiGUKM34jAtLJ9pa1Hzzc6sm6/ceVafF
         Dsh/MYkZVjwqqivf4k0nWZDwMyd/NPwOuHCONKWfGy+MlHFUjPa8Iu9n2nr3uofyQ+wz
         NA9BA2xg7snI1BtQAJG7NAz8ouy5HCyItCEMQiKQdVC1Lzj1yocMfoIfpuTa8r0/IYuy
         pqhNL1+Gzk7xQLrLroGue28vMgqSJW+VlC/TVUS9OdN6haNqODhH7oWp8VFDVu3lKW1f
         DVnUj1RCc+E/gsM+dGCPSIkCLBVkFTd6aQUQTaqaHNvxYhwfPCMLB7lRni87kCtuoolf
         VJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327694; x=1792932494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lm6hadMr/YvEaZWMdI0VsBY5S1pV7Un37ouu2piB0RE=;
        b=IHGfCfx02Ny/GGSsGl5QQlgf8dqxIvDJx44RyguE4PGVTTaFnDyhI1jjfhBNSmQozx
         qbBsCAep7EQ07zwcoG5iTauRAsoGBHPN4iHgrz1tJBzHxixPA7JdICBRxS27/y1goVgJ
         B/hSRDq/MbpwsHGOTzZa4jVgjZvpahqjO9ffU+VNI0Xnj3ezgq1vCRCN2QJKBfR8SZq0
         tJI3Me3V4B/sEKsJDX6fas+Mjr8oFvQB/8iTwqFI6e4Tzavvvp3Gsl0ouxT09QE/YVl2
         rp8OqKtd3Zh58ZiZI7qDLkKuh6dpfcSosDJwuXBu+W8VUYA2DFcU1HTbXMpRFkGimbo0
         9QQw==
X-Forwarded-Encrypted: i=1; AKwUvBz14NVLQO6PNWy27gBgp7wKkTGfZX139omp2+XAbMhStJt7iFKGd3gLZ9yDT1wWgNsjLVYIz8CQ6V6m/w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLCH3x49lhgXd3Moh2fT6G/52lSH3W9yxZIBSYa3TalTn51U2ra
	25CDnPQlhg7VhnnhKS9q/Fnx1PmyxasJr1xH9L/lK1dSAUAN68m1djzU
X-Gm-Gg: AYBFou0wPmoFz5IHjWO4hX3U3QEnFyrvYpUVwp+UHxIPrMdkvf5i+3DdK5TMLa0cjhR
	/3SgU3kXnRDYmu6rGJOtpXA0zmtd3ybIVSk54pXnJt+K362ooqKSAgEmUg9QugVVbLmxKG1/4At
	ck7dw6lbnp3zCO5u74ho9Xn9Tz3DRU7SRaT59ZwfO7Xzt7hltmSrlSa4KlkC2/1KgRr8rM+3D2U
	GkLsZ74FOcmQ0iJVXpDbAMn0V02balRyVyWFUvsI0iGxQcsFHdjuxUEz8K9kpbqPgCn0dVQ1kDh
	MknmGIrC5Dzz7xYqkjXdvk7zcHXapblXWqmVmQ8EHOAGKODywQpW97u3deCF2X1DPukfTsD1Odw
	mqYGP3tnC+GqixfXeW5v+emAk1emD5lgj67/SGzoxQKMR9Ms8LaE/2jS14yNxGV9dxdaD8iXgPh
	Zmng+/RHE+BACeCH4mHdlQsNDGo9BYsFI4yFORiPTDzVz9ZQb9TrzJGXI1baKOJhWNNrM5z4q+J
	e0GHn+qnxJRl92TmrPprpsXnEAmTNm2Wg==
X-Received: by 2002:a05:6a20:2591:b0:3e2:4c65:5905 with SMTP id adf61e73a8af0-3e24c655b0cmr425923637.60.1792327694156;
        Sun, 18 Oct 2026 05:48:14 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:13 -0700 (PDT)
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
Subject: [PATCH v3 4/6] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Sun, 18 Oct 2026 21:47:53 +0900
Message-ID: <20261018124755.850888-5-jinmo44.yang@gmail.com>
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

wacom_intuos_bt_irq() dereferences wacom->pen_input in every switch
branch, both directly for dev_warn/dev_dbg and indirectly through
wacom_intuos_bt_process_data() which calls input_sync(pen_input).
pad_input is also used in wacom_intuos_bt_process_data().

Both can be NULL when the corresponding setup_*_input_capabilities()
returns -ENODEV during a successful probe. For INTUOS4WL, pen and pad
are always expected together, so guard both at function entry.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 65829de86363..e0bf03123cf9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.53.0

