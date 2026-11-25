Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597603;
	b=ZiHxVGJ2pF7SBsQU2nbp275UZ/QAtZTSdzQfS0U2JqIhWyTaW9V9vyviovCtknwfW/OP
	 /RB2zdpzefkACYiWuXY7K2ZWpvasfZ5oimiEKflcR4Tzo15mBCZ21U54xVwkinSjI5OFt
	 AzHzRV7ryft32CC3Ukie6FzQMHZnHDfyXAfKzkGhTlA3O5fCZ+29JXSbk1UG7gHrz/6kT
	 Nj2NPMRpDUANEVCfW2tk3PoFY5zfZgIIjCRFCEmr48mUnzp4tQKHHpez9fBhFirdemV5x
	 yQlC+saLGN7J02uAiU14tCcWq11TkJmMYaqPaf+V7Fi95QPBqmRT7ImzZWUjEycXWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KDTgAMo9MoGmI6cUP6xYgmRM4jfbNullnyIPniAfJY4=;
	b=tIgTB3ZjNcIqKREWSxPv20wvxPeW3x5hMY4XHSgs9bMJX3DPI7jrlXjy9KQ5V2CICGO5
	 fQaCykL4uhd6dfltY0Bz8khywEPmttiK5CwG/6NaToBbk6BYD4BDysLmEvZmu3iMLV++R
	 9jK1RGLlcRJdtku7O1StZZ/I9SaPcHLq9L+hBhWD1fMiiwoFCUnalmzm+2B8eHZotuOnU
	 PkAsmCcq5KkQWEPViXQ7sZBNbO3Uz/WcKno9QJjtH0OdaLMARkbdry2FAi//gjwchPrWA
	 y2cPxYYWMOlLJGELZ2mJqTrkhpRSszaOduedpbOPRFgDsYGHEpJSyKIYNjXad2OanOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqgwWaKj;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF3606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 09:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51EF3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqgwWaKj
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-385c497bf94so2219289eec.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597602; x=1796202402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDTgAMo9MoGmI6cUP6xYgmRM4jfbNullnyIPniAfJY4=;
        b=IqgwWaKj8WAcGY9LMkSxzjgT3RdVug0Bw7CwQWFNEAvIoE1ow8qz2M/fKLcCCUlW93
         83dck4cRSeXgltQZ2K62yyMkihRNJhnU2Ea76gS6NeeSW4Spi2PqV0im3L8TnrXnnAMU
         g9mxQJ/ALldirRMe4QBeNskIjyDa+7y24sURSdLETrsB1jcHS8SXuhQDNeQxj8Mx012P
         VnBZaozzNw2mrhktqllYWmhCuIPeE/AXUBRwwRffiOzlfON4Ltbm3+wAY1HMPbB06ljR
         Uf/emA/I6sIjVM6I1GNlQHvPu27X/WLfVufxTl8Iz/N11qwv3Ga6Zx+azX189uwz0l/j
         URCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597602; x=1796202402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDTgAMo9MoGmI6cUP6xYgmRM4jfbNullnyIPniAfJY4=;
        b=a25zI2ZkGetel4Y7v968xShLhKvqwlHC0fCBpelvqSUTbLAgo7Nst1dhGQ8/4ey9B/
         8M0zmamrvNxgYSEf3/ne6t07HHGwBJe1X/hxjpkNbdRgnM6/wRGGp+QycJmXIW6xbB4i
         IlfUaq/9MyfhuFKei77wOaDcobwNp4mGBsNeGUtD5T7krzJxKrxLX5I5JCsiqNQMcyAk
         58hDOW5MUWvaDMNadsbeefu3iRrAzdxXeGbTdgrBQsrKDSJzeTeZYbfLida/c+hg9nqN
         fSYQwbA3PIDyA0vbgODR4NtfHa3btV21TYkEs1oln100Utfx5KkgoW4UTpIwgFj0LVPw
         vPWw==
X-Forwarded-Encrypted: i=1; AL+hErHfacv0od3vBSbhk2yjXUUFJtjLB61Bg3nehBb2cbwXJj3nNnWTS78VnKJwdq9oEcq1viW1IZzfBg1ZGw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+seRwoN7L1Jt2jKltgl1e356v0N7oeJcswBhDdnGcRFz5TW/EW
	REYD2CKInO2FPMGKYEArQdzKNN6iNgX9ln+inlZTLoG0b9wDR8Ii+aVz
X-Gm-Gg: AZFdTZeZjuQv2SSRQF2SxqBFdJvKZAbTvZ6bp5OqqFvH8nKcApXr8YoLpgOVrrXPi3c
	jaEPq8aCzUsum60/mmaj19rdU2xjYutepYN8M+oTQpatBt/aPEykapch45Ef67KbBocjJ5WRjzq
	yz1jCu+CzaBJbebsPQ5Et/318lAuF1Pyffck8poAQayl1FrlClNAPbLvkTa/8TQBUAEHBDFxoNS
	rOIMhypheFIMn/sFClKWRyv1t26/HdeQfzM60f+8uKrmDEiPu6FxbcbwBIgDUJg/R/k1COqIB74
	R7URaYE49jbAM8kptI4HPqz4qJJVqXr49kJV/IeqIT6rLCKXJte6oRJb8WNQ1fz0rLBTeUkxYpQ
	q3972pLzd8pNv8RZSVOZEPHrrDNOHWaTI2x/EXm5D2pK1i85QPbhm5gjJC5ZXw3ge0UPQEZbegf
	k0FgNNOw7GzgEUIIZy+155A5dNkFaA6DprrNH8TYs8LATBMwDGKFDGLm/EY0cGNKVb15ZDOcDW5
	9Qc7CCMCLeUACo/wuAc0TXURIgjaSR3YMOxH3L2v1jF+FzWb16rJvGNZ3NQ/6V22xO5yhul1n8v
	0BsGLI8YosRYk1/iNpi0xnOJzBiAKAH83kyCAyv9CbKZy8c+A4BdaQ==
X-Received: by 2002:a05:7300:f0c2:b0:386:688:7f25 with SMTP id 5a478bee46e88-386068880f5mr17261988eec.18.1795597602408;
        Wed, 25 Nov 2026 01:06:42 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm58712596eec.24.2026.11.25.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:06:41 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] HID: intel-ish-hid: Allocate hid_devices for the largest device count
Date: Wed, 25 Nov 2026 17:06:33 +0800
Message-Id: <20261125090633.1385386-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
References: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
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

process_recv() allocates hid_devices only when it is NULL, with the
count of the first ENUM_DEVICES response. It then copies as many
entries as each response announces. A later response with a larger
count, for example after an ISH reset, can write past the array.

The count is one byte. Allocate the array once for U8_MAX entries. The
array is never reallocated, because hid_ishtp_cl_init() and the request
paths read it without a lock.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2:
- Allocate the array once for the largest count and do not reallocate
  it (Sashiko review).
- The subject changed with that.
- Shorten the commit message.
v1: https://lore.kernel.org/linux-input/20261123092816.2200718-3-maoyixie.tju@gmail.com/

I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index d1eccdc37e7a..0837af243904 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -128,7 +128,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			if (!client_data->hid_devices)
 				client_data->hid_devices = devm_kcalloc(
 						cl_data_to_dev(client_data),
-						client_data->hid_dev_count,
+						U8_MAX,
 						sizeof(struct device_info),
 						GFP_KERNEL);
 			if (!client_data->hid_devices) {
-- 
2.34.1

