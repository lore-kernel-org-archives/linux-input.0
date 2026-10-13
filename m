Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F56455607
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862947; cv=none; b=psNAD6j5iDT5ERMmZOdhIE0rhYYZ1R0CFJECMLiWKV7fiZF4Y6QN8TxhsVF1ypVc3PY8Xp37iNeG78wnstP7HraHiKBul6a72XtU+ej5G7VZ3OuG0JaDZLQnuh0kKvOfYv2/uTwosZFL2L435G21BUFdbqhckINP48udSZxxYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862947; c=relaxed/simple;
	bh=zYVFmzV22LMbZtP5WUybVQDb2eMNRFSPbUqPdU1ys/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3leCOsVE8qqOmMb2t7MhqzSQhbMHW1iLSluFu+I+V4Sc/edVDbnsX4F4wf6F64d+Q5OhiXQL+VydzwwRafN8De4KrwiwA6SKodUovsJOH1GX99/MDwUTybqZrUQpP1z3C6LIZXp5DRhJsqLv3WEbTDyzPgVSu3pCsydS/jmM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll+odRSO; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll+odRSO"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4386955eec.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862945; x=1792467745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJc32pXZBasQUG9wrdA1x6ufeI2G8vaiz5UsHPslqsI=;
        b=Ll+odRSO/gR+LS40vSkaU336RcFVVQS7MFMASGZKplnEHagrswOtzARDgpX7dbDSmB
         AZU21QKYD8aHZZzBpwM9NZrgWW7EMNrgwTubV5aDhZ9we3VDr8mGpyc7aerKE58iJ4l5
         WwcFESIOmJXxcdbf1wrvEp/f9m+f3ve24xWS/HdkhxUHzYEH9WtwKxMaNYsOFnDxijTi
         TIFaljsS+mJVWjjFbQLdrr1BQ1td2CXrBnKx8Jy9jZ6l0a+VdtyTdmzPEgvlDiKhjpjG
         0IpPlafzi6JKcHoh7cKgBTQymUhldj0WMe5z/aAxiRpPWXC7OR9Pa46HcT7xYUhImO9c
         8fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862945; x=1792467745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJc32pXZBasQUG9wrdA1x6ufeI2G8vaiz5UsHPslqsI=;
        b=N7yvfB5HHRnZO9dlt3tj+W4ksf8vUUZAN9iBjJXXWapwy7YydrTtPGm1oHQR1jtlQz
         AfN6+E3V7/2+eBytsYgk+dcsOKDvhcTSaj2KoVM05PWXG9sG/jfhazcncuwYJkLg4ZIR
         DsLa80KgAyMgU13fZRln5xuX0z/VIM9Rc+WgX5Seb/d0I+eoVc5DbYNfvFlVbZcCj6iC
         tL2GlqYt8QuSziaKxpWkCX0MLc1akjVY89KvED655j7OqoFdKUD9S0dQVETR2yxNfKF/
         DjpbYusaw5Eln3nNyAeimY68XcTxsK3cxNKJpiua+jJx7Aow/4lM5MELA+5MHwZ1CIvl
         oIYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1d2S6NRIKYQkIufdBODxjRW8uybNjEH74e0GzozmMwA4bwztPytYhbzf/FpSgBpj6EiI+yTn4sFjxsg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0hgfaxD8X1djkZa9uGb9WpNMhQNhCRwcLq5vg2PlVr96TEpNG
	Ekzhb9Ufkfs6nTgbHyTlY+vNw4QnJdY/N/9WKJ4WUkUWEG8fvydiz8aa
X-Gm-Gg: AYBFou3+tjFDKeSqRZcG4O0ooGO82fpNfzJ+5Jc2Y6rBP6qMHrPrh0ez6Q+f5lidMUp
	GwUW2kP1iYT+irmDDbXfDbToEWP1OOvNJzMNr/u4agH1N//Y1JQ3J2QYmjjDIh9pGemdO+FPOo+
	cv9tgNzCI+6c3TP2Peq8j+ey4AaV0Gru88RY+2XHR1ZHxJMdVPIlYQwEVBpN04+VZ4Sd5X+jDC3
	UjlY4BF8WNLt28LH7xCyf9ztx30FtndRBzy+O8gVi/yW8xNlmxROGQg0oEu3mome0yvLFM7VO1M
	NzDvZEd8iSVtKxjHmWeysjrIOMAad+zfUPE2Gxokzetrs0qIp2zRWu4uQF3n3otca1w2pk2zvmE
	mk6wutimj3PcOM3fmlt2TeCo1y+Avut8aTXe+cg8TiPyireuyWDxHftd4zFy0NCfpglsJLn5z2Q
	GSOWL5OLWOMBK9XgMZFXR5t47OA/k1vRUGnZrJ4WettGjSy2dGEex13T+PPUDTte4C8rqMfhuPv
	T97A/cvu27sTEcXhYdnkc+0SCd+VsIb0CVrvaGOFkqsBnNUzONoicxHTHiPdG8=
X-Received: by 2002:a05:7301:5f0b:b0:351:4648:3611 with SMTP id 5a478bee46e88-3537e1118bcmr14540646eec.26.1791862945215;
        Mon, 12 Oct 2026 20:42:25 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:24 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:17 -0700
Subject: [PATCH 1/9] Bluetooth: HIDP: Fix GET_REPORT and SET_REPORT for
 unnumbered reports
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

Internally, the kernel HID subsystem expects that report buffers for
both numbered and unnumbered raw report requests begin with a report ID
byte, using report ID 0 for unnumbered reports.

Adjust Bluetooth HIDP transport callbacks to adhere to this convention.
When fetching an unnumbered report, request the report without a report
ID over the control channel, prepend the report ID 0 byte to the
received data, and account for it in the returned length. Similarly,
when setting an unnumbered report, strip the leading dummy report ID
before sending the transfer while including it in the reported transfer
count.

Fixes: 0a7f364e8122 ("HID: Add the transport-driver functions to the HIDP driver.")
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 net/bluetooth/hidp/core.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index f5bdf9f1ca63..004a8eed51fb 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -248,7 +248,6 @@ static int hidp_get_raw_report(struct hid_device *hid,
 	struct hidp_session *session = hid->driver_data;
 	struct sk_buff *skb;
 	size_t len;
-	int numbered_reports = hid->report_enum[report_type].numbered;
 	int ret;
 
 	if (atomic_read(&session->terminate))
@@ -273,10 +272,11 @@ static int hidp_get_raw_report(struct hid_device *hid,
 
 	/* Set up our wait, and send the report request to the device. */
 	session->waiting_report_type = report_type & HIDP_DATA_RTYPE_MASK;
-	session->waiting_report_number = numbered_reports ? report_number : -1;
+	session->waiting_report_number = report_number ? report_number : -1;
 	set_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
+
 	data[0] = report_number;
-	ret = hidp_send_ctrl_message(session, report_type, data, 1);
+	ret = hidp_send_ctrl_message(session, report_type, data, !!report_number);
 	if (ret < 0)
 		goto err;
 
@@ -302,11 +302,25 @@ static int hidp_get_raw_report(struct hid_device *hid,
 		}
 	}
 
+	/*
+	 * In case of unnumbered reports the response from the device will
+	 * not have the report ID that the upper layers expect, so we need
+	 * to stash it in the buffer ourselves and adjust the data size.
+	 */
+	if (!report_number) {
+		data[0] = 0;
+		data++;
+		count--;
+	}
+
 	skb = session->report_return;
 	if (skb) {
-		len = skb->len < count ? skb->len : count;
+		len = min_t(size_t, skb->len, count);
 		memcpy(data, skb->data, len);
 
+		if (!report_number && len)
+			len++;
+
 		kfree_skb(skb);
 		session->report_return = NULL;
 	} else {
@@ -350,9 +364,12 @@ static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
 		return -ERESTARTSYS;
 
 	/* Set up our wait, and send the report request to the device. */
-	data[0] = reportnum;
+	if (reportnum)
+		data[0] = reportnum;
+
 	set_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
-	ret = hidp_send_ctrl_message(session, report_type, data, count);
+	ret = hidp_send_ctrl_message(session, report_type,
+				     data + !reportnum, count - !reportnum);
 	if (ret < 0)
 		goto err;
 

-- 
2.56.0.385.gd3acb90ef8-goog

