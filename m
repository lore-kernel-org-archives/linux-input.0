Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164254;
	b=5SJI26TnuozeFE22lfgUzaqB794dowpn10lzu11sXwfs9g5pXwLdPj2kkMqCVUv4iTq1
	 FwcC9s6KFyxUqcnBXmJ+Ybd6gdnwKa6UN2NbLYOfautJFZdlTM0juUThTx7QRzWOF/gpo
	 qm/F9fNQll746NXKgbyssI7LVLfBQ1HyQjLrwjrE0R3JLJlfV+fpmc9cs3cyhyN+sHkOP
	 179QoD5UpGH6Y89ATcQBkJxVIRf2gfHL3+CWJCXNvCY30qIfSQhr4NhUueV3NcJ8SwMSh
	 hBNX58/HXJGDglAqDRsXlq/oybRHwNnv+CvPPtoAGZVvU91RKLAy6AkXYAYDHlxCh8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vifw4fiaBMoMaU14T/U2tcebz59ueL1q/twov8GGvKg=;
	b=KRYUItASANEd6vwgz7Zv0aySI6qgzJ7H8w/Dc8Obc3s6G+aUUbFSLQuLzRhPo2wM1WrP
	 j1NaRwwq6M+NgqMbu/84rAKIb8dR/XukSiCvgo03zsWWW4oQQ5SN5FMRY2l7L8Ky4EL4f
	 Xdok2COvk1WTMY0DcxutglzDRXr0Qnw6Cpch8vEr1G4yObwrAYHE4yL0FXaGoLUR9Yllb
	 HkvSx989XTC8uEMgocn+41UHc2bdw4InYrSitD4r8oGc1Ewc4SFj81L5NveRDwFKxCQYJ
	 UW08xKtgD3FQWsbY3DNkjf8Y/SW0NNJER5o7sU8BuTZtFmS38gG3T5YyzyWeKoD6Hwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0BvxZVpL;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB28606B49F
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB28606B49F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0BvxZVpL
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1284834c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164253; x=1795769053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vifw4fiaBMoMaU14T/U2tcebz59ueL1q/twov8GGvKg=;
        b=0BvxZVpLfn0e0mGwo5Bu4bR+k1ckmHiqq3xf/M8s/nH8zs1hMTE6J3JGyTKMGF1ncL
         bnY+gYTlZx4Qz9MLbqoXX6oh8zFiigiupufW4d9xIikHnGeXfSqrodGAlcOToMKNEXXY
         z00nkgxN7McsoCfhtXvuDmYj2DV7jnZ21vJ+bF27cAKLkZ1W1h2EtDZ3rAFiNS/CDfH7
         43AA55uMOp+Ebd8BzdhKw3c3mXN0qOIoNuQsibswvAwocN6Il9EeqJRsZEPoHUoTg41U
         4QtkDqpPgU+Gni6eWlDtCqlyZKvR/MLejfc8igbuqsYWQPnAMHBIAQP5zKrycLpCFgqC
         WVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164253; x=1795769053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vifw4fiaBMoMaU14T/U2tcebz59ueL1q/twov8GGvKg=;
        b=jqPgKS4KQaYjhhecQFyGB8Sv3Y8J7V+aRP5SB3kGk8LDdy3ZwiCduHIqYrkNXNnFr4
         nDTDnfc9NC90KAB1RFVC631t4fVIUNlD/BnH52gEUkyVqvads6SUTOGfOA1wK1tw+E8C
         aQbvr5FuUhzmxWzVFMEviw/sjoCPlk24UYpJa+Ux2ara2XH1DCEbqSH9phEwL24ZKh7u
         HBPPm9qeUd8gTlcIgcYSFopa+fpiODpxvpqeT8soIpEY49+9UmxTNdJXeD98L28vyUoI
         LDaBAYUmPsKwvFRZAfi4+gkSfFnuzWerLhuewjoOq8No/g/NeT86h6u9LS7VH7/CWjeR
         r3eQ==
X-Forwarded-Encrypted: i=1; AL+hErGHhA45QSCy5lMp0yatkipsrfY5xIBdlDO/ieC31DHLcP7wOOg9ZfGxGn2BVk0Ve2cc5lRw+V3uhsR/cg==@vger.kernel.org
X-Gm-Message-State: APuU4Z80+JTiIcpmBSjNWP7NN6ZbkhiiOybBryIVPpy75M8U7GbFzDvH
	qwLVJhVtGp56tUjbsa0dp1ap/YF2w+ffZbLapeYP63C5bieeBvwB28Fz
X-Gm-Gg: AYBFou3FBUhA2+PYOrpZ2YTfv9Okl8Uu42QpTyy636ZNV0WcXxfSyL9Xn1z8Tqs06Fc
	SyoA8oQf2SHyghGdsFBnC8Ds7oPLrg7P9VdGsxqDtbJH0W+4uU9JQ9BUhN3roPJuh3lMb8NldR2
	AEM3vvSfbX6nH31YyrQr8MYgIi7wAuXELkETxsMI9JYz6aJT1Eb3AStsNciNindGZBBY0jOiEuQ
	tknS9jg5jdsP0SBHTV3yjAuRqH4wETiFe0rPLlStZ/Dg2+lV4kjrkJu6bX32fs00SBvnmKGSK12
	vQCD3HWKjbSaHHKRYnOOuEhTfDjeU9rE3wlCmmgOkqO9uwom7btRReGj820p8mrwvjCG4fGv5hU
	gtqrV8FynRTfEPkf7zHqxMkH1pHhJi54KXC2sn/JXqxXppMaPoIx/Xfs9fhIlBQWzFKBR0rEFbr
	9AD0a49EmgfQjsVulB3XsD/yrKvgfBMEp86EEjq5iSknX7ybFbNt4OW3dlNTuhkDjBcbyRke39K
	hK3UHLpwt5vzNTJ54F69rqe6HlCW3sSKvlWAj6sv8fFFxaRhjW8aTt5giQyh8GAavZ11dSTGDYg
	y1SXrz4k37isLhAzFEEDGE/va2kGNfzqv6ijiZnNFtrFQGrQ9DW95LS5siyWsmaF4SerLqVwCZm
	x+0887mMW2MDQPYmhEQ==
X-Received: by 2002:a05:7022:ec17:b0:166:862b:9bcc with SMTP id a92af1059eb24-1b55689ad7amr3073096c88.18.1795164252855;
        Fri, 20 Nov 2026 00:44:12 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:43:53 -0800
Subject: [PATCH v3 02/18] HID: logitech-hidpp: preserve transport error
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-2-ba39242d4336@gmail.com>
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

__hidpp_send_report() returns -1 (-EPERM) whenever the underlying HID
transport write does not match the expected report length. This discards
genuine negative error codes returned by hid_hw_output_report() and
hid_hw_raw_request() (such as -ENODEV, -ESHUTDOWN, or -EPIPE), masking
device disconnection and transport failure from callers.

Preserve negative error codes from the transport call, and return -EIO
instead of -1 when a short write occurs.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index cd42783f85b6..f7e654d82805 100644
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
2.56.1.750.gf70dc682cf-goog

