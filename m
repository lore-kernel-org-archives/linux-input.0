Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F563876D5
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877351; cv=none; b=iJtgC9jE1CtKNkNuD0+P5rg9P/0fQrWAijL8WuVzFg0Q4ULDCrlaZ2U2X33IXIPjMG5NgaqVNltVSD1KWyBpBX0D1Y5rL/U5/QHPZzSFOPVQZryeBoJHV+QcqRse11J2zNVVLHlT86+mf8mrvr5nD+3tz3a/33921mRovrTPxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877351; c=relaxed/simple;
	bh=Dyg46i6NCc1WhVwi8ovx5dhpXtlJuvYJqgKq6QPv0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnY+13NIFhv9KjPyTfhbZqYamGufTw1XRD1IUNjmAGLz4uxN2937RlWjtPjxauoYL3yZ/4tz7rwYx6iHzDG+ha9Cs1qAMMm5OlAhr1IePasOsuE14H7ZIdTSWrxSw9/P4b0gem4Wi415/PeQcz/GkeMpvXP7KZ2B7pvGjEn96CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqbNdRQ+; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqbNdRQ+"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6028fe7eaa6so2982237137.2
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877348; x=1775482148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=jqbNdRQ+brfx8X8DvI6PE3vMIUb5l0vjDG5eGm7z9VB31K9+0dw2kOvqkXMxxciWUu
         5xCKJLkYBtkQLKCV1ZWkpnafj7krIZurd89+ZrMjLNHyyo3QBbr4ytXnS3tCvbgmkk4E
         PXaPIcD5et4kHOwLBkhZvXBeS3a460PeiwFbrNKrg8+pEr2g6qB8lASVBsasl8A1kiTT
         SYagBPM28fAzgTOD9nQgaJ2IhXMoREOVMWRy3dPnMQvMXfSx/2izOSZCscxqZ9ej3XUJ
         VuEzcwWb97tVdAHU9VQvNrzP87eim3ORmSfPaYNtN3ZEmWjLmKIVcpOQAy8dgBhpsWq1
         8eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877348; x=1775482148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=DpfkYQJ1RLHGI6w7W0D41p2kIsaEWDo/ccU1vPiUT4bqop7zwC0z+3O4h8XWOv1V3q
         J4hlvtsfsrfhD9g/KBA8T3aYP4r3f60OTX8/TRX+XmRJpW/ZG8H5UexDeWmloK3jmBbE
         oE/rr8+AzXdU2tHfk9W7TByfp2Enns9XTLCGICpoZH/GLg0v3dbc0Or/fyGEY0pSSudI
         WSNstUb/03ZUvslTJiec0QZhvyVg3OcAwgOJeeLhS2zXDn9NaviRfy9Au76OZBym8k+O
         ul2SyyREXdQo4QllQkK8tVMj771P9Lcj647Tqm5yPg2SMpAtC11AxN7ZyeLcgecMQq+a
         wcOQ==
X-Gm-Message-State: AOJu0Yy2qsnzmgmuuD+tpHrnL4bjLWHalrQalsQyOQ2AAJOev6fYVnM3
	wsl5D47G0wMS33v1MvxsTrmiQhY3Zv7X0UL9ieXsPX3eSjUnjx7gK5gh
X-Gm-Gg: ATEYQzyoalV9Y5SYwz6exT3cqxTCu5riBUZpJIXKqUs72NtGjTaB18GFfpUmszta1GC
	oTwtXZ4bX4V36N0o5KxenCtx1QwW2MKedVvDwd6rPxN+cNXcRy1Q68jK9F3WX2w6rmpA3Zq0U4R
	9ytAZ33b424S3jmyLkVGE/QhjszD70V5g1LxqPB/jhwP4A5srfyop/v628ALarQFBckeRg/kdCb
	vWzuqdRo+vfFcPb7YUIXoBDjj9Owfcjg+q1y9m+Y8rzgLimBuvt4VmDpw/tTKiue4z6Kuo5KD7F
	TQe7YOLGkgSSdN4pIPRoLeMyXjlCRYS0eSkCo9JNbrBFZNChVu9dz24r73pWPOoM6qOrwI7XkI5
	0uyHtaSQsZ/7vUDOcUo+XtM9/mdxITc3enaelwRCy9FxVddGRDq/QkH9gioFSVp0Hr0jFl3l70S
	KkU7ssApbJDINnYYig+VOJfD/viWs=
X-Received: by 2002:a05:6102:2009:b0:605:1f22:10f1 with SMTP id ada2fe7eead31-6051f22122cmr1995118137.13.1774877347810;
        Mon, 30 Mar 2026 06:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76a0:1048::11:1d6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9539e2604e4sm6998229241.1.2026.03.30.06.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:29:07 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
Date: Mon, 30 Mar 2026 07:28:44 -0600
Message-ID: <20260330132844.827338-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads.

Additionally, even with a full-sized report, a corrupted
xfer->length field can cause memcpy to read beyond the report
buffer. The existing check only validates against the destination
buffer size, not the source data available in the report.

Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
and verify that xfer->length does not exceed the actual data
available in the report. Log warnings to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..68008a423 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	if (size < FT260_REPORT_MAX_LENGTH) {
+		hid_warn(hdev, "short report: %d\n", size);
+		return 0;
+	}
+
+	if (xfer->length > size - offsetof(struct ft260_i2c_input_report, data)) {
+		hid_warn(hdev, "payload %d exceeds report size %d\n",
+			 xfer->length, size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0

