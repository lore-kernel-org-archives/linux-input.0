Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164272;
	b=iDkcLgsXhi9v1Zicj8k96IJTOzqxNmLTEwyjiQQhsAQYNbbxx8bCrkXPr7tXL3VjlHh6
	 eoNSfL9vLl9LETTjB4AXaaMqAcIr1w15/DdYOM1kpsceExL05K2ZmWannnYZ6c1AXX/p/
	 cfXfCP3L17D08C1b0ogJoh8CGXLqQ3Igo71AIdABSc0UXzrZ0hIPFZr3sznHFRDY5zKMO
	 HYoI++zhgFepr45bm5NycDyj5zOTDU41i9NApULePSQTjFJNA1VxaqlRAaN1KWRrx65qz
	 jg72h649DEHBWXXv0rH7CQmrpY08nzNHd9jVfeC3741Wp1VM9cFEs0A9o89czXx757A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+/fIbMmoDeQ4OJN2SfBB7j/uvxdVc+I0eSEPXeYB26w=;
	b=4zj2DGBv1P9eKPFSl+Uwa2rfMTw6WxTpccYtUZLwoEna7CCCW8Budj6VUY/J6CtonHrG
	 oz94qqXuAdXHxTH6d9Pvr55j+U8OKuxRcbNrcXUh7CVn+4R6B7lCgMc6dMm6jldtZb1JM
	 Jt0w5cSfREyoNK21OotqBZOnN+deWFUHxhu3K0saKUr2soGRaUyHXYoR6b+olLaJdsmYW
	 Yj0GFtKRnYECy4wI88stAt0T3KLcwJVn76jMwFbBb5liLCx4zKqSXQXO58RiNB6lcLx8g
	 H7hVR+m0ksfnyzk5CGZEKUwhFA2RtOwCneIcPyNWNNPUuEGzim22wf/YCP4NhHLi5Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkbU5zsx;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7674606A882
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7674606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkbU5zsx
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a8cc11ac42so876033c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164271; x=1795769071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/fIbMmoDeQ4OJN2SfBB7j/uvxdVc+I0eSEPXeYB26w=;
        b=hkbU5zsxy9xVcanTrGwWiC1MtJOYnpECyoOjtZ75LVuPDrJQpvsnpVZf+vmLX3e2li
         Uatk+1kwYAh7gu4oe4TOUHuOZo2Vz298RLYm8xVboKVHbAcOPTEEUkN5L877PfY1izWF
         1zLHRp5vNDbTca7V7adiRs7c+79Dhkn2NiZ6zTFCS3phsMLmvwQfc3XqTidzE9CqkUpo
         KNd/urq/brBqqldQYYpP60n4lI5oATEIs/xZwzSn3YHlgCTPzNocjteoBPorVOGrY3r5
         SaJS+tjI5iBvtf7hl5L2eU80X42UqorpfZQjZcv8boCRDzePbPPlsHb15YDkKbYJwErF
         h+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164271; x=1795769071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/fIbMmoDeQ4OJN2SfBB7j/uvxdVc+I0eSEPXeYB26w=;
        b=YQ3aJQwRBLBR2lgoNDcP7S10zttt14jK2yHkDiFtWXo67ud/+K3F3YD6AaPLLMaNk+
         D28N8RjeRQGNHVmf4qqzCecVhTxJx86+IxsfZAi6gLQMDSpuomtgkugg8jNp6mjk+oe5
         WC1nXDd6+NFXCaN8Dt2oxRYRXs4Cqc7o55UEGRzeB/6NDEQ1E5DcA84/4eXHamLwjpZS
         QrmdxkSSehiX1Vg1JhkdMz+E1S4wJsiF3Z4By8WHve2ogRmMZ+2h2kmSFCbmuVlrXyH6
         OQ1y16P2fnEjE5RbvXh5y3af02rmrsV5lK5wDpDV58OI/An7pvkuYTasdUly9qNPAiz3
         0fHg==
X-Forwarded-Encrypted: i=1; AL+hErG2LoujXiOcevleadBQ/2MEmOXugg2zQx0VAlob4+Y4tGjVH+sbtbJhwgYibtsHHELiJBUs5NjWIOdbKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cMgHnOPrVjlnpfcOc0TF0/9xNh/52Ld8xaPpkVuR0fSPzw5H6
	CQQgnhhmIVueHsIXRtCOxx2gEuwKaIr9wt/yKkTQ7eyiBfzs/J/Dv7aX
X-Gm-Gg: AYBFou2RoZOWVVXGBhB0vBLjeAbeF+UTwi+uFnSGxoxR4TGgyCA1fYyZtBUtQ3vGEiD
	+Opd6n19uQiVwNr+i2FcdOyOsG26SuXEbAf90yDBAYMc+t5L6/AGSuq/JE/KGVFYpqZcu6sT0sR
	QRDFlxSUMqxgTg8mWwDsZy/qCz4qmszrKk6pc+d+ZdVMPDMjGIoVYd/m0TnBrBG055EUEO5iGPY
	a7lWW5nvuvZrMBcekXFF6gDs97XV+Mb2asdJgXFuif/MfJig8Yc8Aai/Dd4vnjElR6pNwL4Q01q
	YlgCqXwMQs7BcscF62w9AwqKa6tIs81fLxwCmDlUfKa/sypQGinSIQ/fAcD7LkMmerb2i3FNkCN
	d4iaHD65lU9RpYmCKc0ZG3DMjTbfvSA/cujvUmQKeqKs5jr6pOLmfwaC29M8tU8QAJ1ADg6v6UF
	hSHVEic3AwFBqOmKxe23/pugTcXm17wbhCv/0trL/HxzhzTjwVoFbFne19/ajwpjmAXPIwKtaGa
	sslVXq9mscuPGG1w1+BTZFO5Zx5vMwIaDayYHOeQyN5SJinVYXCGab0hl29cgZRHFjVRqELvtxP
	WxCbioz3rniTDTBsyc3r1fKzetAsepau6rOMTucfbqXbxpS6NziPdWh/Rbw3tarDYoCVBsts6AW
	SjmkzWN0RiTH6l6IHPw==
X-Received: by 2002:a05:7022:e986:b0:1b5:58e:b544 with SMTP id a92af1059eb24-1b5568c524fmr2528962c88.18.1795164270862;
        Fri, 20 Nov 2026 00:44:30 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:30 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:04 -0800
Subject: [PATCH v3 13/18] HID: logitech-hidpp: use guard() for send_mutex
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-13-ba39242d4336@gmail.com>
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

Manual mutex_lock() and mutex_unlock() calls force early loop exits to
break to a shared unlock path instead of returning directly. Convert
hidpp_send_message_sync() to use guard(mutex) so lock release is bound
to the function scope and busy-retry exits can return immediately.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 053cbfe8cb6f..49f21d7adebb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -380,19 +380,17 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	int ret;
 	int max_retries = 3;
 
-	mutex_lock(&hidpp->send_mutex);
+	guard(mutex)(&hidpp->send_mutex);
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
 		if (ret != -EBUSY)
-			break;
+			return ret;
 
 		dbg_hid("%s:got busy hidpp error, retrying\n", __func__);
 	} while (--max_retries);
 
-	mutex_unlock(&hidpp->send_mutex);
 	return ret;
-
 }
 
 /*

-- 
2.56.1.750.gf70dc682cf-goog

