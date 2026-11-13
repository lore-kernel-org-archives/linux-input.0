Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605760;
	b=ALoSLGFI0dQk9VvhN+GmSPxf/711l+qu/zUcLjqrJCwRpo8mS8Yf72HNJh0eFOl5ZQQw
	 MofdzzpDGBhJ5af0/k/2qdBh3waIwrSetm0lAz0wgjVNgUOeIuok3tJtwQ50yc5A+K5Y7
	 61jIfB3hpMZGmVt/4IH1opYuvwZlVyk2eG8ISJmUNy7ngXgaAiGIEKiOK/0y4MoCxTZx3
	 WWRPHDpHa+FwNWloyY2wEyr8gGmAwPsrWtXCNZOTY5C1ohTQiDysAsoJzzxE1v8i6os5S
	 Cp94berQvZ248KzE1CcwTegfnMENqnn4fJ39Sp6Yw4teEzSPp8eXbq7qAAHzyKAoF8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=opyBjNtz0mnZ0lnM9ITEQmC7gqGtTlB/gqjahfGquh0=;
	b=qCn4InFHzIi+UcbUjZmNJRr9UJX2cR9EJKueZXNMexdllZZjYvk2L3yxTFfnFzzpK4pX
	 q4cldxa0z6UMOEQx2gYRl17YTuOe4Sh5hShMZo+H7QDSPTvRpiTADI1UKNQZmIZMuqgp/
	 /YKVyNuxhUuaQ5d8S2KbI6tgvheXXQbBb16P/dVXVJWB6eRWEcn62btgyZipwk5P3cnwa
	 Ct0FRQxiHu5pwT2nE+JC7ObNqbDGDF1RH4FBQUT6BPDQZiQDTiShtUlAHWMv3V8tF+m+Z
	 7I9DccUIY0GnpJolr9k2/wXOoyO8DX7/HK0Q/Yx55HLQqCpUbnxreIFmN426L38mHCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NmIjheVk;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B81F606A335
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 21:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B81F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NmIjheVk
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3791619605cso2989024eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605758; x=1795210558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opyBjNtz0mnZ0lnM9ITEQmC7gqGtTlB/gqjahfGquh0=;
        b=NmIjheVkH7jBCcLDDdWkFEiwViPqs/CqHuBvDdue/wF4TGqzVra2w8esUl1XFM/SlH
         O0pVpOG5gn+povnAo8GIZmQGenNUqtvIqF9jVtstKQ/AvmByU2KIup0soGB3xt7lVRLG
         8hRMPoHv1TB03/36N8DoN3m0VIOEhMjGQmlOgV+u3YJ6ToWnDwcCCGYHxRpSAjrrBeVB
         l9pYqcLgeQU3QSl6b3Ylsh97yJvgluLiv6n8p/9abzPZv5jWyznF8wUGpnSPvJyqFTnv
         D+s5UYFgCgnB9pFmT+iYum9bG8dox5p3hsuaOWgyZLqH3p58XvriFRsYWWK4EWyADGXr
         Vwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605758; x=1795210558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=opyBjNtz0mnZ0lnM9ITEQmC7gqGtTlB/gqjahfGquh0=;
        b=aBkQsZicXZEi7yN2EbhHqU5DsIiJMQniF7chY9TGrbP5XeksJt7Px8zQl6jCRVEmOa
         imhwUPZm2M1ea+7Qfr+1WYMaUaqOv2s5uakNSKTR0X24rumpI+iLoiTPJ+g1AqohHbvz
         u9pvYJUgoTMNZ1m5+XB8MGf6XjKymKVW/o6uypCsgDiPm8mwIUYqFyExrNFtsXOoahOA
         0Od+38BImagsXGFQ6GMxZGY/61yCpfPtCFqrDvDxYeNb3VpwgAJTGfV+oJzG7UwleDaO
         ckpE9i1jfOrXyC/3y/R3oyw8VCwlntRY+GMtSPjuMulEslIxwC9d+hDAt7EcLznE4Ryh
         hJvQ==
X-Gm-Message-State: APuU4Z/vVZzCUy4cfNjZcqQscDFlTQmtLXToLxSwtT4GOQNjAK8fX9dY
	S5+/4vkV9sBauWW3PIJGWmJQgcKD4lOP6hL5fem6oJbFW1VK/5Irg4V7UbCUk+y6
X-Gm-Gg: AYBFou2oomyxwJ8w4uk2ORfPn0dA4dm680QXmAsNoKoE3YwOvYuhlkmHxHZHk6TxmE1
	5tpPKvg4dhr/uo/B6gIR0sv88az06FQ4QMSFmRKAG498nD8wwtUQ0Ko4ptp+1wJ2qy3tbHkjR4S
	9/20xz9fhUWZ7e4wq/Ademvu0F33WZit0TrRj9Hp8Q1/abD+vOHtttnV3ptHQPJ6RzWUI+TsscD
	p5ZOW3bh/zvqRA73+yAR8xo6s37ihZNEsOvq37uVFI3JzDDTy/1b2UVvmlIei35y6VsrRUkCONO
	GwgJXT20JWwzLy+TOv5nNjNlA7KALY4KLMm9xW8WPc6M4ZCSrSQq5PokjZ4XZXJxl2cSBjB+YkU
	F151VC0fOxhbK4WluKETlZm0mM/c41oU8hw6plLvkTcXGykX5SUCNvQKhHV85KqzIYfRUo07PWK
	YEeeME8MSPvxh1zGp/MCy+JtpPg1pJtggZQMUXox4FVY5fhs9H9XKMRVNuoEUEbMGChhRl2ZG+v
	1wI74BcZOq9eIK5m23ZW1oX9gH4Erq9clyMC0X5gH4jNkz3t62BguJeU3uKXVxSWKaSNtUpxq90
	LMEWg0T5U4CBfBrTeryDssDwwV81Pyrh
X-Received: by 2002:a05:693c:87d7:20b0:35f:8c5d:5928 with SMTP id 5a478bee46e88-37967125e78mr2886545eec.30.1794605757993;
        Fri, 13 Nov 2026 13:35:57 -0800 (PST)
Received: from archlinux ([182.48.212.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm10137339eec.1.2026.11.13.13.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:35:57 -0800 (PST)
From: WhiteDoor6767 <gururajnaik166@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	Basavaraj.Natikar@amd.com,
	Sandeep.singh@amd.com,
	Gururaj Naik <gururajnaik166@gmail.com>
Subject: [PATCH 4/4] HID: amd_sfh: Add DMI quirk for Dell Inspiron 7405 2-in-1
Date: Sat, 14 Nov 2026 03:05:33 +0530
Message-ID: <20261113213533.13139-4-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113213533.13139-1-gururajnaik166@gmail.com>
References: <20261113213533.13139-1-gururajnaik166@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gururaj Naik <gururajnaik166@gmail.com>

Add DMI matching for Dell Inspiron 7405 2n1 convertible laptop
to ensure the MP2 sensor fusion hub is properly detected and initialized.

Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1234567..89abcdef 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -48,6 +48,13 @@ static const struct dmi_system_id dmi_nodev_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY x360 Convertible 15-ee0xxx"),
 		},
 	},
+	{
+		.ident = "Dell Inspiron 7405 2n1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7405 2n1"),
+		},
+	},
 	{ }
 };
-- 
2.48.1
