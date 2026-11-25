Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597601;
	b=wcQxWClJAibcLzR5dLKEHPP+x15wWM16EOTmzvWKNfxzO3VPf9uFQyxuVC90JMoHJ2PP
	 4RLFErWfvBraF9UK4XgDQx87WyiDrazn0nBVc1h6qeIn66442J87TTdFEEFhceD4QzeMP
	 Nvs3EN8tBeqzWdLIIm9hOgI/oMW+u2jrsVGYdVN6Wm5U7Iun+8jSw9XSCpTfEoQqIBR1c
	 Ies9Sq6t846KJYoCzzMb47EkqryNwqxtZ59je/jAHLozVYX8oVWNMaZlSy41zwAlu3Lyr
	 Ww8JQ6PxwnaqG4RLN0TFPYZSXWHMtb1nzu2WeQ4dEQj9TwP5shDt4qc7rWS95gBNQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KrrZR7Yas+60sGGjOVcPMTCAlDBX4qIpvNx54Ov+Vv8=;
	b=FkxKGwGe7jQ8AjXRJJZe5tC+oEKP1XIpDeBPtY6mHAfW5DliRTtAGP6h6x6ZQgLj92ep
	 Yzi6uo+P/zFuST3mzL4GdfWfBNqjnHr22lCfm8dlEBsguSVbxjCm64jupBvsFOMncXQEk
	 9b5/n6jZs+e94JrECCg0B2NIdAew/ciJUpbFGvIYowmgO12L6aj5/zyIfhAhTbHmeqo/H
	 qVyW1W3ntgmTq9XUIbgqtIHimColx4FPncMhwsw6fLrQQXLnbVW/KsusjhVkc65fqGWhl
	 qKddc4QtgOJWDAzvoyTT+aomEnrt1ZbUaSSJlPvePvWLq06gdJtmy18X+ivWB8qzy+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0tnP6cY;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CB606A31E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 09:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0tnP6cY
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3866a784546so7359597eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 01:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597600; x=1796202400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrrZR7Yas+60sGGjOVcPMTCAlDBX4qIpvNx54Ov+Vv8=;
        b=Q0tnP6cYbZz3pfpyHrAMp7BKcf/DiF8GFu/4jtniXlCszClpJsdGVWuiydsiDhraH/
         w4AoBpfWh5O//j2k25pAZ3G8S7ON5fAzyVfMtyRHo+d7JgN/Q7v3OrzWG6rssfJSnbm9
         HtdGbDqY8ofqhduUFK7VOdJF69Sh13rn7LYZfsw/9C3R2J2A1T27qwmhWftDQl0gGZaV
         bQWNewrjAswXAV32lteV/1FjJU7BkEuWQgRogx6BkluL+V/c6bz/TIHb8re/FTFjy1K0
         muzEpFKul2ZLWH3CYXV9gEl/oZPezDicIZzcZ+WLJw8oCtlOf+BN5FfQI/vTbTGCJdLq
         AtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597600; x=1796202400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KrrZR7Yas+60sGGjOVcPMTCAlDBX4qIpvNx54Ov+Vv8=;
        b=LtbqivexN5j736luKcE/U0JXVZPaufbJi86RuEfUquNg98kAb43vK5ramSi6PNJQ4B
         ldISqjbNa9Fuak/4isFvuMosQ597rxt3AsDEGpGvri8lk/4kQrXSDSCQkbgXHWDXCfQV
         EQORE5y0E5v37dTtbqB1b2ZtmnUgz1cXL2ndrsNS2PwVbZ0A7Tv4M/uV78uWTHZ3lJgd
         x7Bz0CjiFdFfWSIZ6OyUVSRaQlfP6j3DuHFUBgWpH9GjTamQ8/05IRHuA1P1Sj8LUX1q
         ObC/FN/qowWaSyTVytDVzVWN2KbQxYgstqUFlOD2Js27Pd3OsLX/v9llIGMVTV23YXpM
         x5hw==
X-Forwarded-Encrypted: i=1; AL+hErHkqIVhLv7SMoaRlppk2pH0erTJLThIfknPCJVObNBBVDfwzCtUtUowMGLG8JbweTySJCPDzbCwOuBdqA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9B3YjnwLEUJsFXO9CxGrEL8T5H4Cy99zg+YWYEZgsaCU7zOgSM
	k4o2Dy1+sYGYi3ePmwgAKb7UqewFyP28JNDst3daJXewIskSNj2JEBz0
X-Gm-Gg: AZFdTZc1idIIXCDwJiQcnlzCZRWPVnxcaopYOikvaZ3MpaIHF3RkP+w82ZWcDGeSwnE
	dY4vUG/x0ly9VfkYWBy3TAzIBNxfrZVxnVmJUyqmluxND5poCFxiWzYXqMZeNIqS0V2JqoehAPx
	+z+4Fi0wzO1njfXjosJF0DALikyrODKzHZxviEFYvhtKWErzNSs0jxx7VI/EZwXtlU4hyRvWSWx
	24+CmGvBCBolrRQ01txmhbjga5F9aEhqDZE/dAK5q3orsT3vQSffJUsKdNpBFYb6xgPQ96NjS9d
	EjP8539l/JOT131cXus4KYWi1Ovl57yGqZWlGvGg1aYrBtgRddILUfRODtt/krXBxzSZlOx7pG+
	HkdHfyo3sIB7LzHMoNAv4KRTVD7a6yUsfgQLdUWUU7e1h8GhtUXfdoDwwZ1a7jIfH6XwXwjo0DZ
	r34gpHrYVJ+YID3GYuxJGrPQCMsoxNH1BENIOqklXMRE/vcMwsQWoExnBte7cUEbwsY9ezQkHhW
	SW8fXk+U0qloA0HoePt3ZR0BEoWZWSCqIMu6n2qweWUO68rOQp05aymtcq0Or6C5oBzSc7L6SH3
	FUbM7HVx+3IlkUMw59xLSHjWfZvUROMUNmw/BILL0JV8xM8mqgvq7Q==
X-Received: by 2002:a05:7300:ce0f:b0:386:b827:de97 with SMTP id 5a478bee46e88-386b827e2ffmr7302480eec.34.1795597600287;
        Wed, 25 Nov 2026 01:06:40 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm58712596eec.24.2026.11.25.01.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:06:39 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] HID: intel-ish-hid: Reallocate the descriptor buffers for a longer response
Date: Wed, 25 Nov 2026 17:06:32 +0800
Message-Id: <20261125090633.1385386-2-maoyixie.tju@gmail.com>
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

process_recv() allocates hid_descr[i] and report_descr[i] only when they
are NULL. It then copies each response into them with the length of
that response. After an ISH reset, a longer descriptor for the same
index can overflow the buffer allocated for the first response. A
second, longer response to one request does the same.

Size the buffer to the received length with devm_krealloc() before the
copy. Ignore a response whose done flag is already set.
ishtp_hid_parse() may be reading the report descriptor at that point.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2:
- Ignore a response whose done flag is already set (Sashiko review).
- Shorten the commit message.
v1: https://lore.kernel.org/linux-input/20261123092816.2200718-2-maoyixie.tju@gmail.com/

I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 25 ++++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index ec5e8afe77bd..d1eccdc37e7a 100644
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
@@ -172,11 +173,13 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->hid_descr[curr_hid_dev])
-				client_data->hid_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->hid_descr[curr_hid_dev]) {
+			if (client_data->hid_descr_done)
+				break;
+			descr = devm_krealloc(cl_data_to_dev(client_data),
+					      client_data->hid_descr[curr_hid_dev],
+					      payload_len, GFP_KERNEL);
+			if (descr) {
+				client_data->hid_descr[curr_hid_dev] = descr;
 				memcpy(client_data->hid_descr[curr_hid_dev],
 				       payload, payload_len);
 				client_data->hid_descr_size[curr_hid_dev] =
@@ -197,11 +200,13 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->report_descr[curr_hid_dev])
-				client_data->report_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->report_descr[curr_hid_dev])  {
+			if (client_data->report_descr_done)
+				break;
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

