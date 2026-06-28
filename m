Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D82D9EE7
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665215; cv=none; b=XniTvoBSb2hwwJUgNTe1nR+EtjS2NrWr3Ql1toKXeEbyhybqakG4BXuQftX1LzSru+WtE0z0JKX1uwLTkGcT4H/32dYXmXeYFvkgzPriW6x+Eng8M4XNfm0C/l0KBPrah0eO1GNcHa4cXxUMsxGBlwJQK/5uFyK7eZIY98I8lmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665215; c=relaxed/simple;
	bh=apbt+R0cL2oOzCTPz8RaRvTNoPfeUQburZk0MbR6l7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m47k/ase0P5aUYYDBLChw27vfT3Oo0BOmDUBBA6+P83PWwnyOPzKGrwqQjs39dzur+63zFXNzDlrDmCZdiwfK18PjwtKxyO86VsEEM/HGQGkx0MwYr+LNwUr4yLOdz0Wce8Vd3Y6QTGlXTebLIRTZTUklreOXvI44hRtbSysiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJh5RiWQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJh5RiWQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493ad116e05so1430985e9.3
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665211; x=1783270011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CowELyIfZDZEDORa9YyeNmFD8Qz09NjqxqPj3RI745s=;
        b=FJh5RiWQWAOaavAWRQRvrG8kEzRwVoPrUjogr4j1KkwYdy94fRxa8vrh+bRHcqz018
         tTlGks8EmTceFEWcy/UTp5Wg1rnoLNp1X/MmJQMqtEiMJYIXyA2q0aM1rysjcTgUBFti
         XS44nHj+pfs8/Q2cLvNroIAMnk7vNCRg/JL/vmE6ivIG/yyofc0AkX5wlP/oFXaX0pOv
         uocT8JtIrvyuV4oyqDgDaoiA7rc5iAUniCLtQaO0Elej6ZGUgXYU43PdiAGGnBAdJcm3
         cJOdyyuhSzaFDMLn5dU3aLAq/XUc7zh4YsGPyFazo33wo7oZCum4n+kt4IIIon7GzegT
         yL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665211; x=1783270011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CowELyIfZDZEDORa9YyeNmFD8Qz09NjqxqPj3RI745s=;
        b=ELqBmgp9IPXbA+wFDwTx43/la93dD/k8VDVsN2WmkL9add55fYIXuVH/SbH+v/ACdl
         VgoiiT25/YhxumiByJj8lNXds5T0JxI7kC3e+SsM8ufBwP81s9ChxPS5exqPCW8oFNZg
         4FCtniBI/UEOVitwRha51ZsXEIiRpTePqCqefsaXFqAzIbsCqdkPNxat36AaYcJOWJNW
         4YPFSwqitHZMX51AZD6wR5IOuaxOLLeyZOFGvU0ATnuSXUfy7eWLHtgaPrAsUBkDA+TK
         zS9CWy+1LnM+eqADJd9KLWm/Oel7LVZtLkc8G0rHYbwflnlq/X+oDAMdtKSTEe6wUqMt
         0EWg==
X-Gm-Message-State: AOJu0YyQzJ4e3gdqtXdJqknE9eNA+XAIqBP1rmd2VHIe/4uTYGHa7xbH
	G8njGUibfW3h+ZIt9SELFol32X/9O9/eq6IgG0MEo6vzgbDL442xeIhq
X-Gm-Gg: AfdE7cmX+3H9hdfv83o1kWO2YjE5uBWbyUZjQp/a+RxQT56qqTc70jorTDWnApZSLvo
	yLgn5ekABy7jptTYiWPqy08VDCcqzYIxllrUn3rvjPTLzXBki8JwakniCr4cEpZS20sL66PM+8O
	MCzEq1d7CXfPddhvYJuySjpJVzLgljjl2ZPD9l2vGs9E5Ahh85XpfrXwwocw/SsuClr1dBUz4cu
	OtssCQL+vbBGR2DOCcfIGd1rf8iOJJdRU3A3cKSWyiGZMq0d4D+1qpOhdXOzVp6Ry+jD+Vs85rf
	qvsJXVTaRh6xggKHWRbpnf76pPDk3HjmnPS1pgJ0Oe/SDMyA44qdLseG1+PQSbsBaLJ9JXOto0n
	z2PuoPMNOpHWrj9PkYpwgAHU6zHWpkbH/W3euqus02qi+wstIXlRuYe/o6aM+Z48eWdqvLJqsD/
	CaYs1KK9dkE1fgSUTDSDy1NyXaeg==
X-Received: by 2002:a05:600c:3b24:b0:490:bd66:db49 with SMTP id 5b1f17b1804b1-49266850100mr222559125e9.12.1782665210944;
        Sun, 28 Jun 2026 09:46:50 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:49 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 2/6] HID: roccat-isku: reject short button reports
Date: Sun, 28 Jun 2026 18:46:07 +0200
Message-ID: <20260628164611.17467-2-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Isku raw-event path casts button reports to a five-byte structure
and reads the event payload without validating the received size. A
malformed USB device can therefore trigger out-of-bounds reads from a
short report.

Require the complete button report before updating or forwarding it.

Fixes: d41c2a7011df ("HID: roccat: Add support for Isku keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-isku.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 93a49c93ae8c..c65f414b13cd 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -411,6 +411,10 @@ static int isku_raw_event(struct hid_device *hdev,
 	if (isku == NULL)
 		return 0;
 
+	if (data[0] == ISKU_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct isku_report_button))
+		return 0;
+
 	isku_keep_values_up_to_date(isku, data);
 
 	if (isku->roccat_claimed)
-- 
2.54.0

