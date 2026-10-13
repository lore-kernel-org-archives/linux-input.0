Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0F4B488C
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888044; cv=none; b=RxwEi9TWLl6bWxgJMTtKPM37PB05U55hYSp0v8TnJtD3cWFxMkhdMqrdWxnlFYUJI/Uv48CVjBoygtE30X5iNRrroaeINW8n0nrIUq9Qw2ruRX5FDlGY2QRHLJs2C+fjzoHBfB35T+3oEDgsq09JaUSpKxAycTSDJN1WbB9fA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888044; c=relaxed/simple;
	bh=bl8DC5WOM940OcUZ0HKjeJ8zrpQwrjXA+YeiWLryKnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6UCM2pUc6gvupzfsOj733mxfE6Iet24ZvxkWWhJt/GtO5CVc2oqQvfK1l+Ztnf3LDvdjs4nROp2VuL5rNXkEHCEvUiVnctdmVY86ocfRZs4kELzVYzYExAi9SJp7nL4sEZhbTLJrXs8ZmTYdnLpiJ2g0hduz9OMwJwnCC/44Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg/Tc04S; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg/Tc04S"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48af27fe287so2410998f8f.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888040; x=1792492840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSpKFPrBiXLqTziF9p8uMEZyzm13zAd0Ie0+X+8d0Fg=;
        b=gg/Tc04SdNNIL/wdFNEUe2AhqzXwNROIwOCi7d2rU3bYpfwijMmrHAi0TnGov70e6C
         BcMBfJNNYj5jrXtDbkOastenHg1ZjoOGvU6Mz0zLHSW8IrqEiF2fUHpSTTBXLmqyHm01
         SXUSQoLFGo/MOSisBte+p0aCDnkUPuvDEWlWgSsWHdQRUYgoPbz2V+UC/era9fBwvHlc
         mO4InlDCtk+xHQTkFNVti927slWlr9UQyw/CnggC6DSzwwCNXJqwmjEEjh1ke11YUxrF
         157D+bmG4+dblxqjm+u+XOwSAPctEdu5ACeVmVlqGMI34BWSVYrEhdjXd5wvdRpCVTe7
         0rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888040; x=1792492840;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSpKFPrBiXLqTziF9p8uMEZyzm13zAd0Ie0+X+8d0Fg=;
        b=1/5dCukWDDOsugqDxlTDuf+xVvGPkIvSx42twlcFDB2nTFspjIjaivwNj2QNZLCkW9
         Dx2CS2uGFhsuE1I48jeONn5WTQfUdJ0VdXFrlkQTIj6KiOabdsSVHD6nVD1+pUnMoX7A
         LHWEWZlM2o7LkAzlOWSgNLE0RiXdmjA1eU69YcqS818HpzV93GJkmW3bzwwIs0so1dIj
         B1x3iATW/cR940cOVEbxUybTPBlH1b+n7oIa1aaq5vhS/BhFO5cpIgsdtZfCqJEXP1ub
         9BUienI7QQzYu6mEXbeSXSJ0w+dBgnJMIMHgloMkbg1/KMN72c79ene12IOmdnKhZRGu
         wVhA==
X-Gm-Message-State: AFq9FYI9gGdv/osUwM2wt2RkNN2K0JV29rIRFWjT3/566H21Eeg7SDXD
	TXsgvmL/QXUNhsAAUyZrVw3Byzvy3ED/i8lstqksYZSHI53VIe/fjb9e
X-Gm-Gg: AYBFou0SKUVDpagd6YiHMZ/5XslcD+Bj51UX7yY3ERD+0vnNg1CceJ4I4o2iHU/PnOf
	DsW/v9vXFH2QYwWhjUqTyghsH8NClFTOUG2PR8OJiSf5K/uhLwQ0gONsgTUD61TdCzobNMVArMs
	2z/YpMPl/uOOdgrJkTNOR08UnU/wJnAItgD6QRro9T8gTxsZtNTs4h3ohX9ccWtgfI1CUqW+9de
	mD3NgBQO9rbTykFhpvbQvVge5aVAfwFBKk7SCJpnPDs8k+P564bm2akRiKcrS8v2znN2Qqs1wMG
	oDZ8dVSIJEiNKbGBJyiH19Wghy1VAbEqQBIPzA2Ns/rXnppxS0qtgKfL9rdIHioGF4kRn/bIsAG
	qizbc9pKL2prdGN6NmIG0gLBkgmlWaaI2tOSidYTaKIj0cCtgFllkLTW2c3KcrRGQQseojZnJEM
	gE+mQ8wFr0ZK5NGK5pPBobv8rlvujHH5RXP01AY92WNkaUE7JJUP1ncJRABIgrYB++mHMx6gqN1
	/j/SOTtunEfRfIZtN81plLGjyUbEM+6u3DphYhip0nuuYOGuFT5Wt3I5Q==
X-Received: by 2002:a5d:6084:0:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48dbacdb462mr18938822f8f.45.1791888040290;
        Tue, 13 Oct 2026 03:40:40 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:e22b:cb88:4091:8aab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac37acsm4255088f8f.34.2026.10.13.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:39 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 5/7] HID: asus: Do not send feature reports larger than declared
Date: Tue, 13 Oct 2026 12:40:02 +0200
Message-ID: <20261013104033.36079-6-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104033.36079-1-p.pisati@gmail.com>
References: <20261013104033.36079-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The keyboard backlight and Fn-lock commands are sent as 64 byte
feature reports, the size of report 0x5a on the ROG keyboards. The
Zenbook Duo keyboards declare feature report 0x5a with 15 data bytes,
16 with the report ID, and do not answer writes larger than that: the
control transfer times out over USB and fails with -EIO over
Bluetooth, so the backlight cannot be set, while the 16 byte handshake
goes through.

Cap feature report writes at the length the device declares for the
report, when it declares it. hid_report_len() counts the report ID, so
the handshake and the other commands up to that size are sent as they
are.

Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
---
 drivers/hid/hid-asus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index b127f5c38f60..7b17553e94b6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -632,6 +632,18 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
+	struct hid_report *report;
+
+	/*
+	 * Do not send more than the declared size of the report, report ID
+	 * included: the Zenbook Duo keyboards declare 15 data bytes for
+	 * report 0x5a, 16 on the wire like the handshake, and do not answer
+	 * the 64 byte writes sized for the ROG keyboards.
+	 */
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[buf[0]];
+	if (report)
+		buf_size = min_t(size_t, buf_size, hid_report_len(report));
+
 	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
-- 
2.43.0

