Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380229;
	b=BWw6b4HOfIGOGNqnNB2v7F5qZ8eev0SkpQaWSQ+BGyghyM6hLReQWgXF02d1+WjDckOz
	 vtDquPTVT58eh/a4uN7blzGSp22G4+ZepjBSGH4/3lNwk108THUo17XG+jG7+mbD4q6XQ
	 QpyIxVt82rFozPEKU9WP/tt/kRK8u6Vd5Gxyqk75m/M8jwLsYMISxPnAQPxsaHGoYdrib
	 hj9vixZLe5xZ6nXKlkTQeFNzsFoWb7hFWJEmbNUxW5iILANbLJ6URUHdCMsqaY0jDeFc3
	 JoLUsrP4C/l+cP3LkrSSlZxzKebHWnKyaKBV1IZnmkaB8PiAyivxTZXbrE4Ki2lIHfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wvhnAC7SrNPA1IezryM9B4GeDXBzhih+NbqStJTienk=;
	b=o0IJdoJ3l/3tnbhR6tOGO5aMcN1pD7t/wu/cjhOsDKKYpq8zq6ZpASG6VY6cLntBQmga
	 UlQdwEcOgBSCC9Blc+356hTLTQnaLg+1qwhEL1Crny7V5BXZGQDW+H7ye+xkJA/zTVV/F
	 N9QpLoyeYqzBVSX0Cn6OD/fM5eyNJdKjMOLoU9hcIAw3jUBmIBpJJ/NVnjIvIj4AK/Py8
	 fjrNmLYjOph4NNGw2ljWwsmeVIuALrX5vQTmFmCywCo90cbHUvfddLyys5VnN5vYzgEry
	 nU8kuWH3/1osLAQrvPSY8hHMyqnQ0UHB7S0j0of4PhozROFx2K037fmG1uEED2L6i/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4RXHGn0;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D53606E201
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D53606E201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4RXHGn0
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so4165828c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380228; x=1794985028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvhnAC7SrNPA1IezryM9B4GeDXBzhih+NbqStJTienk=;
        b=B4RXHGn0wuxKptvyXxOkT8G0RimCNlH1mxyYQqNTyFZRstM6hb6EXUynYpBYGdTpcv
         3FWWZDn4ewlTMfDoa+sTFQP9iJi16AKgBEBV3HymVs+WvlWoaf5jgDlmE2qAgqyULANl
         DJ8+V4CJv31UAtdsw1qE791sIze4CblGy6Gy94R2GUdCtFqe2mx4tG1gYXZ++GUBzcdv
         9aFQoFp6PrjZtaBtPyHba9r1NobVDNtCS0X+xK76ONjDpxWYt+tAaRkrJEPUMAaofUaF
         aajanxTYFLhJCSimi5WP0On+1e/YMXqJqE1PhBI9MZ+pg0Gf9WPTk+W0WZOif/1eZkXe
         L9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380228; x=1794985028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvhnAC7SrNPA1IezryM9B4GeDXBzhih+NbqStJTienk=;
        b=WzZYs7PiKUcDZ8pZV139X8f1Zvviw+vrpp2+YCiFjWi0f4x/dA11+aCb69NZYm+qYK
         GTwRXqJ82vcWfnPnoRdUVMzWT/6oGyTa9RF5XhDYLFpzV2XXHadU2+5KSVyiGAIRZAfx
         FdPjfELKvUyhLSJU5G5m1ORXusRrIKOr4c0UIB7cQkg2A1jleSL8wUSSsq0U7c/4I4rV
         UXaYokF+CEQ1VzX4fGu0najpF++JG1U/whsUJU05rj22GjCrlIz5sX/ABoztIoUxWW9o
         kZQJxO7Yf83vvoJSbq7Hg7FR5iwq0kCQt/oej+y4eMEfGO+2KguxPRuDMwpBCTOqAKzr
         FWvQ==
X-Forwarded-Encrypted: i=1; AL+hErHLMTSzw7SpbdaJ+W1HFjoK/Cxl5nE/5odDIXUGgAnWqZaMK221pZO2lpQYdlX/glsgXpC/nX9S1IHYNg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/MMxWUa6D26asD+cE4xLy2hBKHyNGgRNyzoP2TJnK2+J9iaoIX
	sCqclmq42Cv4IKNfLth5gflF5t4o+XSS7Aqm7wdhaae+ilVJugwrUYpYK48WSg==
X-Gm-Gg: AYBFou1zUbxRrDvrb3i6f6ilKPSXTrGrptHwtvCmw+SelDNQsCYr75Py4b9k+aiglZG
	QqAtIsHcdL56EjyOeppsZyMJKFs8QC/aSwG5QefA7diws2SXTm3T//2iq+KL3MzsVmshv4Y0fbv
	gsSfMTt1YclmiQUYuWDQ+nE+aHddEGcwgwAk6VvLAxbfvTRQDCMZi395bKri4cuMjUjr7OPNz/w
	xL0iQrgZURqE9GLLGsnHI9KB43MuCEO/C6W10GX29S2AbgTEm+ZCEYOiQurUTEDkcCj0b4MiiI6
	nJ37g8LbMgQ+D1xDD/ATVPuKtA6zcOvr/Y/kE4bE9bhzUVgH7U32rU0BUEYOpmnUN8VFGFZj0bC
	iyffjD8Iv+l5bQlPEDXHSIb3MKYlSad7IFjoo8S/FGfNT9HgizyxxK3KtnBKpTrHNq9pCsMxJmL
	0xzn1I+OwGmM3+R+C9M6lAwVFyV/C4AgIpi+rKGfbyUxcPQJJRbjUf31464zrvMYbqFLU185BYd
	efrZTVxuMvEKxfMD4cN+YOZ7SDVvt7+TftlHk2yqrdUDHHy0b0LwWyYLGLVZNeIXQrqefhAueLY
	qYrO52Rn9w4ork0TJntDVkxHVX3yi6N1tt41m2r49QweYPXUJG7nXnqcsmngVVGbYYKPSzYmEWi
	dnyfJ1BXOcpBynzzI8w==
X-Received: by 2002:a05:7022:ea8d:b0:181:ccdd:ed2a with SMTP id a92af1059eb24-1b3c036ee70mr1539668c88.43.1794380228376;
        Tue, 10 Nov 2026 22:57:08 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:07 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:26 -0800
Subject: [PATCH v2 28/33] HID: logitech-hidpp: use guard() for send_mutex
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
Message-Id: <20261110-hid-logitech-hidpp-v2-28-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

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
index 181b791b3e0c..8f2a9d3e0f74 100644
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
2.56.0.542.g3ef89b7020-goog

