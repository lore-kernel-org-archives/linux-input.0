Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426103;
	b=hQ/cY38T+YsvN/ToA80+cb/qvGUDPMwrcC1goTeJ25wmQ6GMuQ3NpBO7Znyu5wUZAaQ4
	 AfEpi+JSwBIRABTVENA/X3dQuiHv9j86D7ICrIL97GMjwqnsrj7M3JSECLESD5U5LWKk6
	 1pDeeVN+ehKqMFkzim4XQI7EG4nwL9HXodo0wAUBKJvw8i6eVmET5B4VI4BiLzkxDRuL3
	 HkjUfMtO/Q+mkNRKkBCtcKwvayO+wxaAP+4U7kSFGGLJS/8u9FKvLxHdWh89kdg+2dOxU
	 VoHAr0vpoLbsc4GpFTeG71ooug+CTXVCBZvcoIBYHmhCNluOvI5pgbcBD4mD8O8SlQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TyUSV4JaDgNRSYtJRC+X1tW6E6kq/VPnfDSZqIp7Hng=;
	b=TLXJ2+lKqlqSCHvXmg1G3y2xI4fwf02mjRNR29KQIUc+OoAeRWysKXgj5nIFDcvvqBst
	 J8M03eMA1vkbK/gYrG3bUz47k2Hr8fKvkICmCRUUpqyVoCumpO9F2Wqt3/v1ZRbMYL5Jg
	 Es0/ptGqx7Yy987OfvcSbKYtXdtMi9wkajXO/Smd86ZxS5ALSXgFglTojL6zsyJbxuxny
	 vH/Vj0CSMOeRRo2vVxLS+CQ9zQj72uETXvxw/RbPf67Vdg+il384bZMBLYR5EQoOfr709
	 vpzPrju75RUY5GY+y7tLmLOoGTGfW2NSGia8G7L0fFVGtjq70poCCt2UwZC5DT0Jicw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh1JqURN;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E8606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 09:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh1JqURN
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3ada81853so3414954c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426102; x=1796030902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyUSV4JaDgNRSYtJRC+X1tW6E6kq/VPnfDSZqIp7Hng=;
        b=Vh1JqURN+B2yAQdew/k7C1Hh8rWgATD86Pyevt/0HEmVzKY177Qfi6Up08k/oFggI5
         VU8NCr5rwNKmTS/VkmR6sP2CM3aAIy069Wsom26cvUdnd5RcA8mNwUXXASlBvLwHEeTs
         hh739zuSEFQcSZq0Q7dM8b2Ak7i4X0PEHALeqosfzVW3uXuT4yCWtAi/H0Mcy49I6h5n
         xkK35GEsQPH8BEZnvJVJrg4U79hdbagSoenOnDoeWKEIKx7A8YRE0vhUDEO3ZvqVr/dQ
         XOXcXkzLyYsuBZXpM6unWH3kJpikapjjNuIVuQw8q1+UfXpwOpLSSccMyopDxM/2G/vs
         5wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426102; x=1796030902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TyUSV4JaDgNRSYtJRC+X1tW6E6kq/VPnfDSZqIp7Hng=;
        b=PfWUmvxmaf7pP1W7Dxthzn0FjJnfqgo/0wI4FTDFasuvCu8+l3gYoD9yysJWnTXKPu
         zZfPU6iJJzoI0lhuL7/YI+pi6htnkq++F0ZFxllrskP0kQWjxpARbLy6cv1itSbC3t2x
         9xABMRfgm8LFj7kIYlV5Ay8qrFRKscgZ066Pv/F8a05rh9GNa+8ytDYcWqLoD7jY+a98
         GCh+7g9wiH/k4mLunajnlruKmRDt1TFDFqlk8kIUfZQgB3ANghXC0VzPv9xLYM1DmVvG
         ZMcXF1Sd5uoZopK3XyHyrrbxFUvuxYmr18WYzgITS6tCI1OrhBzPDg93+j7cPpJ/i058
         AC3w==
X-Forwarded-Encrypted: i=1; AL+hErG6FEEDjn9d0msyYIvdEYHf5gJetXElZWTM2SQMiAy0roIXXdAgy8eCgMWpGpWQPjcsPIJvWGeXEh8rCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+0beSQwp2I84kgcvqr8KTDnD8xRsGvhrznijbuMnJutzWwDdCe
	NJM+j6rYq47Kg0r3BEwk+yihEIwySH3tzGlY4tkBQE3zCk7PhPrB53PM
X-Gm-Gg: AZFdTZcCYMPz1dmmQP3LvksaErADtoZkXrh6D/vZ8fy/zZWuaaghuwW8/UU6XEigVxh
	s6ektTJrIANXVO0qn7xQZTVvh/Jhk05KtlJTubzyDJaB7z07Ayta/SfYRuI72NM9QGP3EPjSMLZ
	GwQ/4ZvU8rMsGmGSZqiqE/bGzbuD0qZyMZxJ/YlzUi3FAFldszmsHZ5rkkcfZ+dtLV7gJ3zCAdl
	BiVs6MYeiDcr7Tn3ofo8PlXeTxwLdzLLI/beCHlK2eVhBdxzxEjjZj7LvSSdv7uP0P7DSL4GVpd
	1uoTwCYCkrGjXtFm6UIPAtfV66Lf7XhmZWy3D62Ud5mJdVdUFFhRTSMoXtsfuUBREoDHjxPAr7V
	jkPlqB6UT5GJAcXoWWAe7kT9MzdpRBbjAlyjUeLnQ5g0SAg4SrLRJ16LrZIwL6J9dnWaULH9KjN
	en7DHgsjI+P+IZoYtwu2cBBNl9Zmu823rteHqY6/HpnDWjExeBUbueMcbIxK7Kha7k93CzNyqtg
	sXU+Zwbv5SXwW1MQrHsDsdSRCrY+nlZeiFnuP9SzNPIHrixE/mF22qhWPPcAaC4Vzm9GrZyPsoC
	9GKDEQoZRfOXDQV0KZ88Hleba69fg/gCPV+sFZ/icN7Yv/XJV+GQWEDsbZN5cPx4p0OQIa2wyNE
	=
X-Received: by 2002:a05:7022:5e09:b0:1a0:b8f5:872d with SMTP id a92af1059eb24-1b5567c13a5mr10587992c88.4.1795426101890;
        Mon, 23 Nov 2026 01:28:21 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm19861941c88.11.2026.11.23.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:28:21 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: intel-ish-hid: Reallocate the descriptor buffers for a longer response
Date: Mon, 23 Nov 2026 17:28:15 +0800
Message-Id: <20261123092816.2200718-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
References: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
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

process_recv() allocates hid_descr[i] and report_descr[i] only when they
are NULL. It then copies each response into them with the length of
that response. After an ISH reset, a longer descriptor for the same
index can overflow the buffer allocated for the first response. A
second, longer response to one request does the same. After an empty
first response, the next copy writes at ZERO_SIZE_PTR.

Size the buffer to the received length with devm_krealloc() before the
copy.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer, which reports
none of these writes with this patch. Not tested on hardware, only
compile-tested with W=1 on hid.git for-7.4/upstream-fixes.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 21 ++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index ec5e8afe77bd..24f4032d6dfe 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -68,6 +68,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 {
 	struct hostif_msg *recv_msg;
 	unsigned char *payload;
+	unsigned char *descr;
 	struct device_info *dev_info;
 	int i, j;
 	size_t	payload_len, total_len, cur_pos, raw_len, msg_len;
@@ -172,11 +173,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->hid_descr[curr_hid_dev])
-				client_data->hid_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->hid_descr[curr_hid_dev]) {
+			descr = devm_krealloc(cl_data_to_dev(client_data),
+					      client_data->hid_descr[curr_hid_dev],
+					      payload_len, GFP_KERNEL);
+			if (descr) {
+				client_data->hid_descr[curr_hid_dev] = descr;
 				memcpy(client_data->hid_descr[curr_hid_dev],
 				       payload, payload_len);
 				client_data->hid_descr_size[curr_hid_dev] =
@@ -197,11 +198,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->report_descr[curr_hid_dev])
-				client_data->report_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->report_descr[curr_hid_dev])  {
+			descr = devm_krealloc(cl_data_to_dev(client_data),
+					      client_data->report_descr[curr_hid_dev],
+					      payload_len, GFP_KERNEL);
+			if (descr) {
+				client_data->report_descr[curr_hid_dev] = descr;
 				memcpy(client_data->report_descr[curr_hid_dev],
 				       payload,
 				       payload_len);
-- 
2.34.1

