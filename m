Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380209;
	b=oucbb/Harv50mtpEyUHe+MkK4pGW2j8D4rTrk3dU7d57P/JwBpMMqUGMXhloE1nAVnEg
	 h0w6Wq5zXrJmPczwgu95I0TWC/gyPIb+NjPQVJhZNSHJeiR5QfxcmWD0NpmLZFMQjRS5H
	 jfVdlp6veaP5+q34mEC0rgA/pSPXYwd+eURSQ5N2nsi54Jx0U7wHz5wcb2RBv42vB9reV
	 UTnRJtN5nKzUuVpSEPRxoN9q+XZMIiYYl6UDmdCZUfRb41QiXBcLCYMJK83h8UK84MpUQ
	 9f+Dwzu71lCk9WWyeSIrMZG/KrbMMpxfLBiZuYY+QUCgQXuYJVjShrqY8rtm/kq0b1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4M7nJi8IiH7CMDUuicQQJv0+rBT/1hrBP8Gb/geFbRs=;
	b=Wf5CcvbLgEkkjah4+aAU7nve88WSdC2WVejPP2LDQNG/dwszHK1viPW87nrv++VEMaQi
	 OQZg+/I5NwRQeLHW/jaOkGvgYA4V12tBcpPmkubdQRXgnHKD+09nM2acmZL1fxAd3daus
	 PydLl7iLFW4OZ9PMvJ3Q21l7DCjMaoJj7GCjYLK53YuYyktPkSkZH5gLA79fuNsnpuJN4
	 Mqid8FSJf712L1Fhuur6nTm+caDSJxiHAdmnBh874RBJOQ19uhWYtsdP1/OKh9O96juwz
	 2iA1WSr4i1QtokKXDMwmZxhzxgoxOmD8vCx9qlzKgoB+PD4/iKcQq5wNzGek89SjAlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nmBV8nFI;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB760A2636
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0BB760A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nmBV8nFI
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso4176263c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380208; x=1794985008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4M7nJi8IiH7CMDUuicQQJv0+rBT/1hrBP8Gb/geFbRs=;
        b=nmBV8nFIjkZ9LKM+sU2s2JOyR5oMeFeEXSlgRz1aLnfGjpGl/gtBFHyfMKfrsk4KEJ
         LuagfGM/KFg3AH49CgkoOGyiE1dgzUq8G/czOAvKWiQwQa0czkTe7tjMm3asDH9OiyQV
         sppD3hADC0svpLfCSslUAu34KLzh5xkvl8xuNw5SX2mxsT790hE+q/W9kiz7zeKl0jFm
         oYTBFxbNUVWZOC1ZpyTNAqYMbaX/1FN58sAJYJYA5Q3ppzEm2/QehJPJGcALSrWQXIvT
         hOMw+v65e3lzMsYchmZbqRlswb2zOgBPPK1qd1Y0XA+AUxVkUJ9RoEbNrsh+3Zcb8DOr
         p7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380208; x=1794985008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4M7nJi8IiH7CMDUuicQQJv0+rBT/1hrBP8Gb/geFbRs=;
        b=xrdEmpH0CRtmNM5OqSuAlHZetAH63ll8zKIeUzIZm3FqrNX05GDCftvYwSdNXLvHAn
         w4viLhfCGCcyTlGSBPvi3tow5nlaUvBD7+pcMBy5EU7grLt4w2DGRi/tm0i7NlDVdFWb
         e9w6MxYOCx1PtONCkMe4PjaHIR7q9jKIX5JFqSMH2VEx5oemBw1ytPAMz8TNmtoIVoeQ
         EpIFgUi8ARg0DyDCsP7gKR82sMoDQNVHcCr9cZYvHiZo+xHkXPGQR9wKgASSzu3AHaL3
         +O5BSVS9Wnjjir9+j+csQdfAyJ/4E85P2f8Drd0idlE4MJSN0X036Ifvm4DdQnpLQd/1
         IoSw==
X-Forwarded-Encrypted: i=1; AL+hErE8D+6GvvSjJkn+DtKvnPImNRKRlJ5l7rwWYXakX+rYgtoGrpnb1gXI3FnN6bV1beWAPIAoyshrkGD8KA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AmpQogHsXsikkNYOipOT/7zArBgjulrr92MYg+gMW8HxhJNmV
	Qp6ZsvD1EYwseVozFBfqscD4h4oWC9NTYVdu3DbpqiTGXQUj3xIU10wk
X-Gm-Gg: AYBFou1fJhsBA3YLj8EjcwSfFusGxvb7G4ikq+9svKRY/zp1CxQ89feuTOnBWbghftn
	zFRMJwqs+Kqk568SITfVZORJGPH8W5+rIeYd6uwc8SMZIGi+YejcGSXPoHpCSL/MzdNtLHsELov
	HrXyy1IfEFNfj5pVwtCAjrXbRCxq0rHyUZ6gZFOlzDSZ4GjGG7yshWz/RG1I6P+gV/MsOc5NEgv
	sBLa/kiCLy9Hz6pAFnEWVk8WO5GQE5M1UA2FvMkfbKWqoubHGk7MPOWITsMF5UKJWdbHSEzqzH8
	wXXsUKiOzas9Kxkgpe/IYksCv00qoNcKmyiuQvKt3WY8y4PVPTQ4gX+dYEd+G9raHnQvqgh/IYn
	XyMDLkIhM68BXlC7m1XahSDB8oGN5uwcjr/QJL/jdnQP1al64BbAgevizthZ6DIfYm5GCgox7qt
	E4Qh7OemI5+0uKrTTq7F6UkR/JKhnClTRQtFMnER/V8D82VQBDvkpUpekcwUflqwjGYlftpLomL
	t/8DE4MAW0Ax/Oydi00m3FVejvGAIqOMn2kfa5ISrn5onhNLNRWQagOSaUGIHlaON1FMypB9peu
	CFMHdrBSILjd2RHvtHbGJebuo0NCdymJpaqJvsLDHlGNIwThmoO2m5mUj9KUz75JKDEXdu9wowQ
	t7KikL0CTSwyVQego3w==
X-Received: by 2002:a05:701b:4541:10b0:143:2967:c0b1 with SMTP id a92af1059eb24-1b3c0318589mr1481679c88.25.1794380207843;
        Tue, 10 Nov 2026 22:56:47 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:47 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:14 -0800
Subject: [PATCH v2 16/33] HID: logitech-hidpp: preserve transport error
 codes in __hidpp_send_report()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-16-30743e91d83b@gmail.com>
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

__hidpp_send_report() returns -1 (-EPERM) whenever the underlying HID
transport write does not match the expected report length. This discards
genuine negative error codes returned by hid_hw_output_report() and
hid_hw_raw_request() (such as -ENODEV, -ESHUTDOWN, or -EPIPE), masking
device disconnection and transport failure from callers.

Preserve negative error codes from the transport call, and return -EIO
instead of -1 when a short write occurs.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15fe9dcbca6c..3745d95f5bba 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -279,7 +279,7 @@ static int __hidpp_send_report(struct hid_device *hdev,
 			HID_REQ_SET_REPORT);
 	}
 
-	return ret == fields_count ? 0 : -1;
+	return ret == fields_count ? 0 : (ret < 0 ? ret : -EIO);
 }
 
 /*

-- 
2.56.0.542.g3ef89b7020-goog

