Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164061;
	b=4ZWsuaLsjo0xR2Kq+pt108L0bGALoLBBeC/TT2EXd7wa/gz2K36eHCGemrK14xvKZ+Gv
	 JsGqfjqeQwWqPLWQ6HNXFI4SlkmNjH3j+GUxcjrDor08EjmVV71i3qhHWmnGa0Bwodijq
	 +nS0IxtvdawPDJ9Fqg2p65Nf3/V3wyIHH+22NdnKV9slXCB58QBerGM/gaAMerpFf8yQW
	 fbkRmxgafHXNmP+4mPkX921AeVcVUqE1dBc6fXPV+3waw1Lhz6RwML0IXcsP3csBaOi/W
	 lZ0+HmmT+9qDKLaDfQ93T9Eu+0YYfvZE5gAwPmtWIH8D9RhCqKvvxz0Mz/ARm+VQjfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8fqgQ1PFUcTxqPkGPD9MBUjIl2fcMgF5433kwtmJbEc=;
	b=lbbjdhSGjm37oDvBPxDLAxVSO1AhNNGfyHuf7pQCfWh71uRVh/G5mhi3nYTfzhTLNNec
	 5eTAVLWazii6eDGkKYwOKE1wPkZfRwekWqJRVnvhErnz4lL8RVyN8xI7vri1eD3n8EiVN
	 jDlnYxGc0AADMqJRBraygItSShrVwp93Q1D/sEGwYQffuTmZB+K+pyyICqVhFlQiY5SVk
	 d/pA+ECO+vu5ZeBgROX1ZLzzqafhzFm8MCmgKwcs8j02zUxMZfbXnpqcFP+8Jp6bYs8jG
	 sD8+IvG74FzOzRUMQDWx6bOKF0kpFlj+LkOoivL8Bq9MTeKlyugfiH9GOzvx4Zj87ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qe31VwVD;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4C60A2604
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CB4C60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qe31VwVD
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38190551625so1040595eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164061; x=1795768861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fqgQ1PFUcTxqPkGPD9MBUjIl2fcMgF5433kwtmJbEc=;
        b=qe31VwVDp8c3pEPSPq/JYuCX2YmZfbdatj5jYB7hd1hWvLNkoUhMoxErK6dClYT5bl
         IA8waPcLiq8GtATzit7dSLxy5+u0ZTx2vajOATURkMy55sUThX8IDrdPat/1uUXGrZ05
         qdVgwRQj0xPSxfDwCu7E4vercKxHM4Xm2zOdnVhYvPfL6tMTeBs9PHy5LkPCLKOtysZc
         jumXAQ5HbgiqsuyZmfCQVBUPSZM+YAqLXyJp7cle7BUrM+XammIc0OG2TOh54MXntjn+
         fM21EVfO0YFP0CUvwdfDTRegAGNpvoT0HPvLQTYIiK0LiVGRbHl78A8LppjE8HlnY4iU
         zf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164061; x=1795768861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fqgQ1PFUcTxqPkGPD9MBUjIl2fcMgF5433kwtmJbEc=;
        b=JCwhUAllEDc/zFuwR8HZCR7UsjwoGb4hgTikP/94CUVgmj5F49FzBALQmwYP9aeNkV
         9HvwYcPyPCnW/FpW5GD68XLjY2utXpEcL1K34VUFUHEJf+mmV3mZwBMn3U7u9HOBor9d
         sRrXAdIYwLHN89A1PpeL9m3il9f5bn7xuK8zdCxSN+0AFaYmYHobpVU4d+41GY+hZ4An
         /1y9ZfO3ZU8zeMAZlCDEifwR9A+f2Z9LAK1eG+30mf/le8Ub26kPAVqmwUD03YxQDxTK
         EpUtXBRuf2RENoY63PV9Vbf2deadza/kNvH21EQX+jTSpIzQOYETF3rjM3W40raHAXEI
         I3cQ==
X-Forwarded-Encrypted: i=1; AL+hErHekH9aR2JZ81CCOwsVLJvhFJWhqXBUa3PM0QoMfLFMR1+nHLJHUQtQRQBUo5aFoWkOoWI0pOcatLltTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z+SrLXbk887LuOqK76WlpyBeo/BJMuIesi1d1yVYfRYInDHDn
	FhwUuTrxAk9bvaFJ2xJ5/fjNFJch+M1jFmHCQBvpABCUpwQgQlOW2d8a
X-Gm-Gg: AZFdTZfVF31tEziaHsRC2O52ftaFYcM5IY3RRcEb52oaHRCaWGIcGtn3w4/q8CacB96
	NWsngntWB9YXPZ6yy9AgT3RSgX0uSDKSHW8bgcVRaUbRBO46vXyK+3SPbjnlUf6jaUeqgmXAI/C
	SFwv8zUlpEFqKPTgFPeR2y6QLoDd2iTXmLAArJJlU/wMuqViF+UBTEPKQdDeER33W6jQ6KnpdC5
	IDy6EuwUhhWCZQ1FwHa01L9chhQEW+k6TYRw3nXuIkad/wM3zQX99HWTdYewOlNW1Y+/L7al+A1
	a9qqiT2OvncYDIdt4L75qp/PrX4DSzraqPwlpKUUQzd6ZKCgysJRb3X1DfbREX4FsglYL1N/rOf
	tmwBM47EO2aFaGlHFo5en5JVhUzXzzMQ/cTUf24O54Wj+lOV/1g8ml3UZN2UMS7YqAJ9IQNaHhD
	JRGeHPfkLaIKKn+LiCVC8AHPJoYghVgwZOKpCs3gZa75Im2xA/iZjxsiNnkQu10xhuwkcp41fyE
	lJEKnNWydTz+QjtvD1nMnBNZ4moh+IuYZOJoL2wcL8l6v5EH8qOq59gF80dy0/qnj3I6qimz4RW
	fKHeT5pV/CwYYhJ0NfRh1MppFdtc7UiZaXFWLKnB3GVUlaaVJ9SBXsNJWTFIwx6czAE4lcP2RbY
	5ypM8SVurMw+RTd/Rfw==
X-Received: by 2002:a05:7300:601e:b0:386:1e2e:ce0a with SMTP id 5a478bee46e88-3861e2ed1bcmr537091eec.27.1795164060701;
        Fri, 20 Nov 2026 00:41:00 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:00 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:50 -0800
Subject: [PATCH v3 02/14] HID: logitech-hidpp: use GFP_ATOMIC in
 hidpp_ff_queue_work()
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
Message-Id: <20261120-hid-logitech-hidpp-v3-2-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Force-feedback playback, gain, and autocenter updates are invoked by the
input force-feedback core while holding the input device event spinlock
with interrupts disabled. Allocating work items with GFP_KERNEL in
hidpp_ff_queue_work() can therefore sleep in atomic context.

Allocate work items with GFP_ATOMIC instead so force-feedback commands
can be queued safely while event locks are held.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 85d8d168ff15..d9342a3e8122 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2542,9 +2542,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 
 static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
 {
-	struct hidpp_ff_work_data *wd = kzalloc_obj(*wd);
+	struct hidpp_ff_work_data *wd;
 	int s;
 
+	wd = kzalloc_obj(*wd, GFP_ATOMIC);
 	if (!wd)
 		return -ENOMEM;
 

-- 
2.56.1.750.gf70dc682cf-goog

