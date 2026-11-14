Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636014;
	b=u7LjjEbUK6ON6//41bT4i3GknB5j42HUzrfqkc9BHg0EW9DlnH+4PlVTTEdWP72LM+mw
	 DOfosSHNQKXih8cEgIKV86FqO70DPGPgiZPLsOOo90XPelSkm3PbqZ88IYBNqZh0YJqOd
	 WxFzjy/5mm1w57t4/d4qxiTM5vDzWCmvyXOV6wioAVFWD0iZp+NfyHs2N80vE0uLTuACs
	 X8lBDTDcdm+7NbCv8ElVR73obXog5pxlChnlqyRH/s5Jx2J2bI5z8Fo2Lqpx4k4MOwjiM
	 CXrmVkHAnaBeovq+RAyTR9KqQ4LUPzUx5mif9HFM+lAaBz2/s2bC4bR66ayxiZtnapQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=V5vFPK32ZMQWprKRPGreWVAcROr/+4kRa727HzscJ4g=;
	b=LoCpKBILY0yrhwGgxoCyi2pU3Z2c1dKfr4uLuw3M+Fv5ZKsPqwSnIJjcNoHl6fLOzfqw
	 1+GzAaJhnaTBPYdrcyACb3BA9T5Ru5OaHn49oUSoZkJqbnpZuA+CUy6Tenmh0MUAelTxk
	 K4qRTqXgi0F4xbtVj5YacbKWil6manJXa2yNBI+ZeA0sifVK2OBD2h9Fm9lqtqdNqxMKr
	 Hmo3dg/2lAcOQiOLy6LRTiRxHjWmTmR5Hc1AblQh8LJ5bK8bSMlTCaLBS29TIY7ilr6rN
	 1A9FcJJZhT2a0/bqFPozQXJW0rVGYbpmtesS6gfEjZRYcDn8gllqJr71wOMlQOfu26A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WS9H+bPs;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670B60A380F
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5670B60A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WS9H+bPs
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37600b0db49so2429115eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636013; x=1795240813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5vFPK32ZMQWprKRPGreWVAcROr/+4kRa727HzscJ4g=;
        b=WS9H+bPsKsSlIpGtl/XQGa8+Sds7Bo9LhuF5FEL1Sjyl9UatMboccnQvKDFYAbn2Zi
         /nBRrgEQVjI9l9YzvCNnSNRV/YqBfaMo/+H78M/rPu95jRY+Fb6nU6h6wqUt7wfv693L
         eWUOsAgtkAECaUmvRppWHoMLwSuxA8EUe1Fhi7hDpBu+8W0PtgbAVRCBnXqtG3ejgssA
         RSkDflkgqFB7/sHHwjEU4liUs8VcTDKhfDig87c+Zwlzhk0AYXHVmUq6XnM1sMhJ1vCr
         id8cLv6rEqthPuTQ8sllV/+t5qB0qLWq6Fz30pJ9gChEao8RgRSqsKEjmQ1J9z88eSBW
         1PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636013; x=1795240813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5vFPK32ZMQWprKRPGreWVAcROr/+4kRa727HzscJ4g=;
        b=dtVe+NXs8DcfbgNaiyuMfqaI1BXaRR7N1UPoBRZJqYzD/VPaCzPgJZhsC035XZQlVE
         O7LAnbNKR1DnC0uOBpOKOMqCmBZgUQyFX94r5JmtU4HlrUZFKmN9DFnGYRo74UAnc0Gn
         wIalddiQ/nJPXzX20MBOX1+9SX2sucYsmXuIjHvmJNPkO3m49742o/pnZ69Co/jlrIr2
         vYeCTKMoIALGacaDeL5CAAzY8MhLH2vvQ2JHTC0sgwOJgGjHh2EewzhEV4a86xYYOn/H
         ap+YEqf/LkyyYAhs3q1R9cBT9DIY1kbUb8iGSM7bsBx3JvySy4dYdjuix2iHMapSH/n5
         9c/A==
X-Gm-Message-State: APuU4Z87bXRJ1esAbaQDmLEOjvVb59MTgUmFYfECwVUTCkehbCNwiRWh
	F2hdhr2qKPR0pHqgkcoQfClGaG0Ac8V6+EcYkVsoxrmGXGmFMYnL6uAH
X-Gm-Gg: AYBFou27ZCbMcKnZVPrNXSACMD25D4mZHUReY1tBlcwUnkeWo9+DO2eunNXu9MPhv7m
	aJKMgqiyeEopjzQPj7m7rp3msXWzmu/xhkR8y2sY8ByqN6BiX3kncSUBm6jt9wi+6pBLRAdU1cZ
	0oM7/erm0WU9Cc9uWZXhieaXbcl0q1ALrsvLwnJAspSNywnr8Rgril4dUvLOrBrXbDhr7ZocXLD
	3ppZ7HOjZVZqCVA2uDNERgFhL67bR48NqHmbOgwyZHy59Eh2qIaAevzHxDThS20+yLZuFY0UPUZ
	0yz6DIvr56YIzywpYWktzrlC/U2sDKUOrZVFWBHBHfUsf+h2O6FzHYZgUVIHZN1t5qAAORcNeNF
	uV3F8OYmlQR3hKDuJZN/23/NKUX96uaOBAR4DLGjgHtqqjNJfDm3zidlBhBUMySVQijq1dEEpFE
	XBrY37Wtn+uSosB/bNiDioUqCK9vawNYDsBLLkao2A46XaH3qdjmyqYEUOBvzMInaWiux6IV/Fi
	gu6ebU8ArEUK3PqJwo3xsH57qmMtLUI80RNmQInTTslvoJ8+A64Eho9AJZwI8VTfb31vP9Pw0aL
	6/v1GwStxDt/rcjooG+fDOeLID9BjRXS5uXnYiPUUCuGlvKhuObqFvGkAo8UCsJREIFxDkApE9Q
	39OvzM1up46k0nlCL
X-Received: by 2002:a05:701b:2616:b0:159:f192:5290 with SMTP id a92af1059eb24-1b4f5f37854mr5951635c88.13.1794636012896;
        Fri, 13 Nov 2026 22:00:12 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:58 -0800
Subject: [PATCH 08/12] HID: rmi: use put_unaligned_le16() to populate
 output reports
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
Message-Id: <20261113-hid-rmi-v1-8-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Open-coded byte shifts for 16-bit integers are verbose and left the
upper page address byte uninitialized when reusing the output buffer.

Use put_unaligned_le16() when packing 16-bit fields into output reports.

Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 0a5d32dbe881..ad2ab6c13550 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/rmi.h>
@@ -126,7 +127,7 @@ static int rmi_set_page(struct hid_device *hdev, u8 page)
 
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
 	data->writeReport[1] = 1;
-	data->writeReport[2] = 0xFF;
+	put_unaligned_le16(0x00ff, &data->writeReport[2]);
 	data->writeReport[4] = page;
 
 	retval = rmi_write_report(hdev, data->writeReport,
@@ -217,10 +218,8 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 	for (retries = 5; retries > 0; retries--) {
 		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
 		data->writeReport[1] = 0; /* old 1 byte read count */
-		data->writeReport[2] = addr & 0xFF;
-		data->writeReport[3] = (addr >> 8) & 0xFF;
-		data->writeReport[4] = len  & 0xFF;
-		data->writeReport[5] = (len >> 8) & 0xFF;
+		put_unaligned_le16(addr, &data->writeReport[2]);
+		put_unaligned_le16(len, &data->writeReport[4]);
 
 		set_bit(RMI_READ_REQUEST_PENDING, &data->flags);
 
@@ -293,8 +292,7 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
 	data->writeReport[1] = len;
-	data->writeReport[2] = addr & 0xFF;
-	data->writeReport[3] = (addr >> 8) & 0xFF;
+	put_unaligned_le16(addr, &data->writeReport[2]);
 	memcpy(&data->writeReport[4], buf, len);
 
 	ret = rmi_write_report(hdev, data->writeReport,

-- 
2.56.0.679.gc527c65306-goog

