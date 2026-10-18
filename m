Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0D43DA49
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320399; cv=none; b=IoixDfSGUWDekY1yXJc06iAh5orS4cnzI/lR6frYxiZUdX8FQy1zjdRpn6xxmUZPZW6l9tpa68syKOiDd30u77+iO5qODwCslNC+LsnskdYX/uKhrwRkAw9ikp2u7F7Hb+xSmAEfru/PBdxGnkqORU6M3DmLL3YyutolmIF98HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320399; c=relaxed/simple;
	bh=kbhP4xgKoVhLpHyGw3FQY82AhitXCtUAH9uXFDXIWCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkXEFdpSLyHXI8x6aJIdOUNBINhl7ZjEkS6yX/Ki8Gs+kKw/SyPkZ9P6yKsYomrkdtR0OXct4JyMvkX91re1uNhNIewMzb9IWivuGhFA4Xt22Uh0a4TPtqMYxMcrLTJXCzKC6ev5tL95/IdMKWeowT9H2AkoccdJQQFePHqzVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKJIA1ha; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKJIA1ha"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e934449bb0so10772135ad.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320395; x=1792925195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOaSt3OidYEeIBYJx+qFc4OoZOMLXmzzOzrHvaHMKHY=;
        b=lKJIA1hat7wADIr5+wQf2dK+rhJ/C56DunyjSGVpTa6nTpVmtB4vYKc7XtKHfMcHTV
         qIRfH6CeQT5w9+xpJwhpdOvyFrzX32DmluKYhV2HOPYYzXn4vq1n9OsFjmqhIF9xsT58
         G6OhqVzgSgDQUcOKMKU00ujTxtqk46Wg8VLRrqG6FHowVZqFf+bx/JyaeFR/HjtDEnWY
         1oN2K+Cf6nQoPrPd7MNxMYnsWCJubQQ/T2Hf1D//pHGOLrfnoH8gkThkM5H/RB8p2+fq
         ef1Lh2UUEKoVVfEm2K6lF1sH/KBLnSoirTeT/B1HK6MuMQwAcE7MAPvO8M49JomKGH6C
         PbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320395; x=1792925195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOaSt3OidYEeIBYJx+qFc4OoZOMLXmzzOzrHvaHMKHY=;
        b=lgMMq3/3J1QdBOCbNLgZXK8K2k/8egHvZAto+HKasF7chR/+uLRYSXP6YCQwY+DI/O
         aQe/i6332o448W0v1DR6ZbA19qS1IC5+5RpVVioddsk/Y1CWuQnGZWWfp44sF49a24l8
         lnT9zT726Ad3OMqUuObGDcZLlpzDltaXmmoxSK9y/j+MyNn425uFnFsOCTtaw5Ea4f/L
         2ERfKkTs33jfV2Cs0Ii65mHPHTsbx0GvHyfPjXAoVKkbwdHGw0Kp3+f2RFqaeMRDQPcg
         3HdJFFJka8LB8A91qvWkPubBNYjU51pH6PvS74xfWaBiZ2ccAUBct28d+TyE0n6dKdSd
         6uYw==
X-Forwarded-Encrypted: i=1; AKwUvBy2hhfMIREtM/8HNeqbM/r+QESSSh0IhyRBLqio9LBnQSywFCHfTs6Xc7v8tOLYoM0vYatJcJ3Cao+rzw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIod0sGeqE++a9UZqXQOwd2PrRbyz68mB8S7lxjlp6rcbWDvmOV
	9mKJkvcJ3b52iNQyolJ49vqTzmM0uIqwoP3X/n/90RrIdZGmPphe9eA8
X-Gm-Gg: AYBFou0iC5XAqsnSE7FCQ6tCGgpcrBlR9qbB70YeYkDlGANPd8JbrRzpVCv5O0dGVqc
	h+Dx79/gRYdX9PtkMzzmH8ZUdepWrmNoBKU5PnJwmqeQDlu7kQ9kdmYyQDSOJdzYMW+Lo2tozOV
	HxSMkIoVPyPQPohk1W/JnRFkVSP0AO0tc1OC+j5Dbls6ijVMO4cAFeQxs3ZNbM5nkFsZ0/3YHj3
	qvhSSQrBNAhFGsK8IpDVo+2607aL+UEW4iFYzR5KEkQc2PoIulcV9T9vA90n2F65SniYke4OXUH
	OwSsnqvAnU1SvBJFSfKp1J6YUFMjlHCHzs4aJBwqkeG/yEMsYKPgMYQV2jc/wVFfJVcD54F7m5I
	WMC52sq7Ci4d0MtrdRfayZ2X1lhLeXRxI4HwtbjqlohzhS/IBo3Z2NsvC2iugegQzY3lv0+tVD+
	P1tr4HUY9/EPxzVcvU/278bqUhmK9P+3ODzqLNCvQBu6lK9AsenjlOFiqlgI37yZoeW17NFx/lp
	y1z7kZ4d26xlNj1WD2Fqow=
X-Received: by 2002:a17:90a:c110:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3acef0e4640mr3774371a91.37.1792320395329;
        Sun, 18 Oct 2026 03:46:35 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:34 -0700 (PDT)
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
Subject: [PATCH v2 4/5] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Sun, 18 Oct 2026 19:46:16 +0900
Message-ID: <20261018104617.743771-5-jinmo44.yang@gmail.com>
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
index acf24360d547..12a632ee1cbf 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1260,6 +1260,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
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

