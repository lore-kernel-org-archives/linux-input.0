Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164275;
	b=W6/vTmLloeuzEjTrOFejvSEjadizAbwyY5CBLsjx6Iy9E5Eb4aANZ4CvsZPul+fztkIx
	 pz+AMjsQvZGOLISBCmQk2zEw69gEAgz6IycHYaBGkfbtAI/41aA5zZwtze6CF82PTts2/
	 hmg0bnxDVKXOwqftLD3AcvfduGh1uWYHsajBKgsZCOC9UD6k22QFzPo63nkGfFsiRPCNW
	 zmtDZ22TzllQPo2na/P6keJEirixF6fCMn4uE6QUbGUQR5W6rMlU5MNDWB6D0iovKhyMN
	 03Dpp3zTy3l36V5nTJXPWUF+KQG+dQc9/289x6dit8NXwbs6AAZCXhtYla5V6PoYRRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=npTE2fiYMjbTekobIqGGljMdib3MOVJF3ledKQqDdEU=;
	b=zL2bpxqN6oJZCuSYHJTXgeg3mnE/29RzhJINVmDdKdvzngPzMhdE5PZk4K6DlQWWX0+S
	 EKJHX/1igZUsniobef498qeh1itmzCK4qjBy3dBqzRHTAPwRsYYG9eXdmgn1wKr0zFQrm
	 aV+5J7FW0JYhAxCUZ579Usl8WC5TXDBr5NfRfh85jMWOg6pIBGvFuf2i8roGpnNG67wCC
	 0fYw+RARoQv/GPPXISWUYa4buDkHWERknq4Uuzr47XhYkSxTcsGt2JlgA2pbiTGic0cbx
	 s8HksS3wZueSZ9OWw4eY13HCNbNeIx8MrdnJqGs1+igvA8s6cG5Ku2n1m7FVJlhhBsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVOygCWT;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0F606A7E7
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D0F606A7E7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVOygCWT
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1285412c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164274; x=1795769074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npTE2fiYMjbTekobIqGGljMdib3MOVJF3ledKQqDdEU=;
        b=ZVOygCWTym/96cTN/M5WJpxlvTDlnudUy8qJK8TWWRIKY15N2mV2idSzvGQbOFeP8I
         UA3b68TbYmKIewum+7tXIkOLtAA4TlWYNhQIl/t0YaWmHo/HsjjBbxlujaecAIAA48mn
         Dxz3qrNOOKhW4BT9cof94v37SpsGa4OZiUjCRyDpZe67YS3XI9Q6OLWL0mEe+Df5DdCO
         BrtVdjb80NtViw8efdsv0dcUiDO1M+lxFiSMZJluO92FCcQGO8LLWnE8WR/Roiq042Ub
         Uiw9v6qXe52OJ8C9c+pAfGl0ejkVItidQ8tMyujyOUQNa4LQBzkiwnGSY/xlLsBYaJcK
         6YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164274; x=1795769074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npTE2fiYMjbTekobIqGGljMdib3MOVJF3ledKQqDdEU=;
        b=ppA7hf2Vh8UGQwyXCPJGJQzKhRvO52P8g1RdSat8H/9HtMOGHISlPpnaXDn2LEfu/Y
         O5rUI3/PSSlhFtoFyC4K8+9in4jbJp1Rdb5toMbT+JL5RUEhYDIjNfSnwvdl3BzF8ha8
         wFt734mYBC80n81Wzbtv52BQf2VF4OLN3KUqgHrcRZzkyPwYPSB8XYuz4eX2np2vRyG5
         LtVFkzAaJjzmFgLOt/NJNJ5pBYR1cDExOnONQyDO0lDpP1p1WjuoxlH3XNpPw1/zbDQT
         AgytLMS4JBon5tkNHf0ZCoTCGkBoxbcPyRojM/YIDgzw6PrYMTJyZSQVUbt6mGyIw5zj
         L9Og==
X-Forwarded-Encrypted: i=1; AL+hErH7aVwpZ70kEd0yuUP2zLjiG1LBMaKyl+c2ZINE22XKyeBhbOJCJshcJrIL0JIwMq82xBWiYETY9Df0Gg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Czy1ZBHZxjreGAisyUyPFroYkjO6WaIzt5N04Aq0B+iWxGKox
	Y8SzEExEUigdfHu+MwAgWu23KelLnQDNjqfT2/CBOSGrznYKiAlvlAjR
X-Gm-Gg: AYBFou3Z87/b9HseiNlBx92wFMiIIaQQ5Cm/v5WfDp4IW7q7Hj1lXxbUIDIeW86669+
	tRdbRQIvOESrnuhDVz2N3U48arvCGGCkSsyQ7xP8C4nRvaHNSWOVbiwINFlC4dIymEznY1X+Hqy
	7iiLEr2Pv0eieg781HOnegTH3iQfs2FX3AwkfOzN78igmtktnKGqkHc4K1TTl5jl8BPP/UQqO8g
	b/WsES//ZXCig4lG2V0fdQ+924r2X5CB0DK9riPjdxM4CAuGlHCsRpZ+CneLyHtMKI+FwqTz8PU
	LD+TEmDmEDN1+E8C3r+nrbejndRxaTfzJqxBGD41iohL7krDZzP68bU+gblU6XJ0OZfdDxCOCtR
	qiBVVMM98wxhiCJ+PGb6XtjksT2Q+nj3PZeZazmiuTeWlwaNJnw6nvLoN9yMIV+hd8jmVoQC13j
	zlkDagRZHlWWEl+Ng14+FxzHYoMFFBM6mABTsQ0sdg94J+jQhqcjQiWXBaj9qnIxojx5ET+IKWw
	F9SltcXRGPbvD6EDU7fC3KbcYi1tCfDka/CA0TzL141iSaNa/m1LjGvAP5rZF2WCoA283JSDwcV
	D5kk1RG6mqp9ud3+uWB1DiSHC10hDKDVjG+RBON3Uyv2jo4nZa6Rs9Vyps8unHpW2o6VFj4IVL1
	sFayAFtmx0Oxyt717o7DaDLnTlJtlfMjoMYRD9Fg=
X-Received: by 2002:a05:701b:4212:20b0:195:49ee:94c7 with SMTP id a92af1059eb24-1b556877b4bmr2456175c88.8.1795164273890;
        Fri, 20 Nov 2026 00:44:33 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:33 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:06 -0800
Subject: [PATCH v3 15/18] HID: logitech-hidpp: use
 alloc_ordered_workqueue() for FF queue
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-next-v3-15-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

create_singlethread_workqueue() is a deprecated wrapper around
alloc_ordered_workqueue() that unconditionally enables WQ_MEM_RECLAIM,
allocating a rescuer thread. Force-feedback packet submission does not
run on a memory-reclaim path, so allocate the send queue with
alloc_ordered_workqueue() and zero flags to preserve strict in-order
execution without unnecessary rescuer overhead.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 12b499fe08e7..de9087459273 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2778,7 +2778,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	/* init the hardware command queue */
 	atomic_set(&data->workqueue_size, 0);
 
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	data->wq = alloc_ordered_workqueue("hidpp-ff-sendqueue", 0);
 	if (!data->wq)
 		return -ENOMEM;
 

-- 
2.56.1.750.gf70dc682cf-goog

