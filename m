Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380184;
	b=XXxMkc0FJT9FWqY7qNxvStJoipusXlV6ltQafRZ8AazxdTD7XFtQwAvT9F7yXv08pBhj
	 G8Q88wS2/oh+Apnm9FWIYcGZkfv7Ulz1aFvQOrhwQA9B2ejra26wTwEM4pSRemCi0HX7o
	 vmva0FHy3zDaQFhxMoNVdakt5/fkG5INUWADSunHL67tpbjBRIrbxp/uxdw2P3zpeLD3a
	 udFHyhC8GnE58uf8dOotHyxHFeRsNadRUh7neQ4MJO7EXMtVBxIFmxo7ASI8ytgbxl657
	 yuAmUdv3Q1NBuhPLRa0UKdRWXOXkl1W/hfKx8MdmShkGDzrbG8x6Qg9UjWh9sCGqUPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3WwYpXODrollnKl9doC+Ig4NeUhbbvobPTJNo/DEkIA=;
	b=unYEAk0Wod+ukmM1CC99zxEFmyenQvivpSZVMwoi8YZ2XJfiT6knJD70eb6SBP1t47D5
	 d2oXAwO+XkXmnHgsfId++ZhmqPzPIz+1036aGEou1ZlAIxK5U8iHeRJW/fVQmHLcFe+Dd
	 DtIdoyAwcsE1OIZNxWUXj6e+w1tXpcUFkOIxK4gUH+azVcaI0sUyvBh5ALAFMTF9R+N84
	 cfXp75x6G318NAJxLpYxeljujLBAwk3tjiG1LLQAyUtmjjkGKsJyWG7xlgupiwnveLJ3O
	 sJ2Jj96MP/P1DC/qqrtpEuAGgjId8cm4C7wII088iSPdLgXyeoGO9zcEMzOkBbOC34g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXCoiDdt;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6560A260E
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D6560A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXCoiDdt
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1438d9363fbso1693981c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380183; x=1794984983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WwYpXODrollnKl9doC+Ig4NeUhbbvobPTJNo/DEkIA=;
        b=tXCoiDdtwAe6e5LUqM+TZ75gFQdHTToiQ+MlZ0X2R+n8axPdUzIfrYICPYBEEI6OwY
         CZbY7ZHZ/KgvSJA5pGAueBmb2KzqNqDz1pp3hENzwfIfifPAoXrTciODGpLS7xmM+AHJ
         7VneEbNUUO1V0bglyx8EQgypDS79Bn+T/5h1MdqOUmst/q1mnAJEd7FkuJgJpU5oEbga
         oY+fGaVQg9cRGjfjJXyIjYC4EphH55Hx/JYpas2S/KXUsR0CsM23QL6D9I9T8OiDRPYD
         DQNNhVg1Kem98rXutd/TcsMs7TDhabTrhtwVL9MW/GOP3XYPAE098HPv6HqZbD6GAbA7
         z+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380183; x=1794984983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WwYpXODrollnKl9doC+Ig4NeUhbbvobPTJNo/DEkIA=;
        b=f07VZ90fZ1YoiQdm+3MDcs2Ug/IpoedC5KognjfFHsXWc72JECbNHBBsVduDYjFHcR
         L/3JOpURUJNaD2bqrCZyvMr0qVR3WY8zaGZwZodWIAhBMTKnxOOf07Xvcm5H/LMyM48D
         WFrFr+3Un19hwZa49SBrkhODJAlk0QVfjeumzRMfKF2SnIUuPyrBUoe90ttf0FZvGV7B
         m9Gng/6xEFiS8D0XER6ogzh9c/xexecqYGP0hP+nUR+kZ25GqoxqHfeHgXHga7qSALZE
         BA5/J8MryhZXcozqRslDnFIRPn4SxroEUWTLgeCMYzunPpZUz/aNtn+57P424zMXQvbu
         wZAA==
X-Forwarded-Encrypted: i=1; AL+hErGJh3sQBWUqAqXWD372Zkfpnz3OE0Hu6vKHKB0vho1vYbH+h9Fyi5mDk3x/rmiFa2b+eVO2FWHIr8UJpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8AH2ufGqozNwAL2eVG5egPhI49eQZ7xkjrCDOCEhb0dhABiYGD
	6IroO5qseNLQ1UfJ1ainjGzN2dLDSepmmlmxn/mPFtj5a9ELc0p6X+Ns
X-Gm-Gg: AYBFou0SNesnkHkJicOt9GwecNDWHw9rij1KO0/mmW0FfLDn80hARRZ7MKglz6Cu/1O
	BqU4/izeOUUKbcHJ8SnHJ4N8jBOyOO/ODI/F0GVqV8pjNPe95hBj+p2147mnap3hvyEqOAmz1jg
	vZ8jxumXpVEVCIbgm/8/Yp0fau8ITEK5CbrSkH2vPYNj+uUXhY9dgLSkAu9YfZc/s8hffA/1t7v
	w2cdVSpUiHgDYWrCpa4vL3LgZhLtiXtsTEq61ikgpiQbzNCJSg7KaiK+ihJZEYi8eNiQAr9Eww/
	xLlWpR9lqEeKZOp9P09xCN3r7Lk2R3GargpjzEvjkKiXdFTCfsvqAsWbYlyOeqbPH0qcK0J7Vb8
	O80EUdbui/w91IWFJtP17Y3sl6zHEL92LplZjsetQPE+JFxVDSG/8+advgTUhY6DJNA72u3eOGA
	2ILr2zv/Yz0un5CjPUOEtX6Tgr3K8OPbsYEHT0BOA9kI/hBiZWtdgWFcnp4CmwSGwnPb+w/kaLK
	mXm0SZ6JjOCtW+GQ0cOoOHv8n9cLLMJCuUP7YhKqW7exm9kgsRO7E1d5AnPDus6JB6i38WAx7cV
	gpw6fuAIGs/TWpcWOcBHxcYaapj0BUdpZEgmsbBZxq0HEayQMXb2iALvwqh242IBTYZ9CD3zMiS
	GNnnie81pp4UBjQnsCg==
X-Received: by 2002:a05:7023:e41:10b0:19f:cc98:f603 with SMTP id a92af1059eb24-1b3bee81671mr2167785c88.1.1794380183087;
        Tue, 10 Nov 2026 22:56:23 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:22 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:00 -0800
Subject: [PATCH v2 02/33] HID: logitech-hidpp: use GFP_ATOMIC in
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
Message-Id: <20261110-hid-logitech-hidpp-v2-2-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

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
2.56.0.542.g3ef89b7020-goog

