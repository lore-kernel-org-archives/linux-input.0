Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC303C1411
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787400617; cv=none; b=UHVHF8rrQaofz1YklHhtiQRR0MNS2YvxWz1PxqemruWZdGFMpCKGOpURnnQQs7U7MCL9vOc79+SuM7VHxMEAwCQh+hTNjRzYgi/3tH916jaCKyELK/S/yGRuE0ue25ys3JUKG75O68QWdMtl2ju7/ljF8XDh3siiw/Ar0wVucVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787400617; c=relaxed/simple;
	bh=Vr5HGOvmvPpkjWgDtThY64AqnPg00tx71QkxFIVq8XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOuD+T/g/MLgipAzzdi/gWdKQWAfr3HQdQiOKcQWRSXNyb1aY7QKNH/yNHAzEJzEK19a1Bwur5aBo41bkzjlvQGeOoewjdt/wh/3CAHO/wHeJPk8AbkEcTcpzdqhafLQVCV1khN0vPVBAT/XxDTYOIEbz+ytsb8WCT62P56dntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sabii66r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sabii66r"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84867f07d63so1953049b3a.2
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787400615; x=1788005415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwQOW24aYq8g+uW7VI9Ls6LuehzpGekB5XJ+3F7qiHM=;
        b=sabii66r+sbIe/u2lt4lIAKlZm4j/Ny9GfsYlmqRnyamL1CFnZupXqGmc3iDKVmBCW
         Dpzu8TCbhMAfF5omYPxEwnb1cIInTEq9EhL9Y/8HV6D6kx9+TGo+e/HJll5I/AU9XDzQ
         Yn3A1rxdlMOkklvsjuCJCoQlfbNHDX/8HZY9bu/ZBlj7SnNTWmtXsLU8bOnjgE1fqpn2
         4zN7NpH4WfXkvpKhZYS+r8dTI3b5IIdAGTKp6i0Fy9sAnRthtlnHEFHheWNQwLLP44RL
         hvmAfQZplAncygZYYdzZSP8EbYlyd2kgyxd4+5XeBcp0Sm0V6ZHfpCnwgL+5Sn3PVov8
         fCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787400615; x=1788005415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwQOW24aYq8g+uW7VI9Ls6LuehzpGekB5XJ+3F7qiHM=;
        b=Du77DtT6ttx5ENMNost1q4xUL+PKcyIEJuC7TGpHy+VzGt25tSfU9efbNNbc37ScD9
         owW5AVEvLQ9E5awTtowVYKaSrUMqBc6fzNZpgvWYn2WkZ5NaiEOYy6UlV5LkdaT003z/
         6ay7DIfDQnAT3Z3wfRr2WfpPZP/vuwscV4GKr+f33bEA9D4kT7QxBsosA8vmf8chZM1w
         lF0bdvDRJIs4XUSvJ0whfBy5kHjibgnkALNbIo7tsvAcCuPSw58HYIUvQ/mBGncS8Zq8
         rDNDFei6EUKIyeDSyQZtBw3YAWFYpRdBIZWnbf7UN5IJvSe4b/MdKCUitUSruJk1JFpT
         5bnw==
X-Gm-Message-State: AFuF++ly/PMGVXY8Ykc+9Q42tlwJJOkOvtARB7FYqUD1JEPR22ClU85l
	3nd7PFbb2a9dCsu5mVAzSR5pGxx+u9CuXnGrHK8ICsbhs8/Ap+XNksKI
X-Gm-Gg: AR+sD12/4bIUy1alRGBTjZvWvuWDdPXupbLg3/S38G9yx3hMWI4y4g14NaSegPx61wt
	Y/KWffBTLW//lprLb5gWvSyUxIXZGyjM7/BDe1LzJyiN2T6qm2BJNNCqe+NjHTuCu8tTUiUxbFe
	UarAP0D+zYFwXsRp4KFXAqot5roHoa6vQaoM5KJ6Z5rSrh1Yi4EvYPPHmIFVvLNCvzgGs0X54xX
	fgNwIV8R5ckCkP1AU7GS1AUhYw5R6CKJw7ndjSzYCHPjk7fASeUfTuNyiwpCW72GufF2p27cJJi
	0wLynXZXpjVkI2hCbW+KkR4xFMzmXnvUxwcG8BfrnXKEnLrs7sTdq2C+z+tTanKwLEndM0+UClP
	a97747BuLr3IvSZhZh9VyP05wkI+HrQcIAhjhU/vUVL/bc5IywImN7ZDZ7vXog/jKFQeN3GiHRi
	hbL5I2LrPYYkFUqLqUo6Gg0hhjqir6xkZZEzgZ2rFoKbEmrR7OBCf0sgPuPu1UrTyH+0s51rFFt
	RAB8g4BnlTs9hVbzXtrLqeSX1TxhuTf5JJC/eD5bmY/8L2RY60QOIiHoZX1DvrHvSbsZ9lnV85u
	qRdltgfteqbWBQvftmnKeE2b
X-Received: by 2002:a05:6a00:194b:b0:851:8012:c38b with SMTP id d2e1a72fcca58-8520ba23894mr7689217b3a.10.1787400615010;
        Sat, 22 Aug 2026 05:10:15 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b243sm522696b3a.31.2026.08.22.05.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 05:10:14 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: rmi: fix OOB access with undersized RMI reports
Date: Sat, 22 Aug 2026 20:10:07 +0800
Message-ID: <20260822121007.153988-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hid-rmi driver sizes its writeReport/readReport buffer purely from
the report descriptor supplied by the device, with no minimum bound:

	data->input_report_size  = hid_report_len(input_report);
	data->output_report_size = hid_report_len(output_report);
	alloc_size = data->output_report_size + data->input_report_size;
	data->writeReport = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);

but then writes fixed offsets into that buffer without validating the
sizes.  A device declaring a 1-byte output report (0x09) and a 1-byte
input report (0x0c) makes hid_report_len() return 2 for each, so
alloc_size is 4, and rmi_set_page() -- reached unconditionally at probe
time through rmi_input_configured() -- writes writeReport[4], one byte
past the allocation.  rmi_hid_read_block() writes writeReport[0..5] in
the same way, and rmi_hid_write_block() copies an unbounded len to
&writeReport[4].

The read path has the mirror image of the problem: the copy length
comes from readReport[1], which is filled in from the device's response
and can be up to 255, and the copy starts at &readReport[2] without any
regard for input_report_size, so it runs past the allocation and into
adjacent slab objects.  Those bytes become the register values the RMI
core acts on; they are printed to the kernel log as the product id by
rmi_f01_probe(), and they are sent back to the device as the interrupt
mask by rmi_driver_set_irq_bits(), so an undersized report descriptor
leaks heap contents both to userspace and to the device itself.

Reject reports that are too small at probe time, where the driver needs
6 output bytes for the write reports it builds and 3 input bytes for the
read handshake, and clamp the write and the read copy to the report
sizes the device declared.  A write longer than the output report was
already overrunning the buffer, so rejecting it cannot regress a device
that used to work.

Verified on v6.12.104, whose hid-rmi.c is identical to mainline here,
with a UHID reproducer and with an emulated USB device (raw-gadget): a
breakpoint on rmi_set_page() shows the store to writeReport[4] executing
with alloc_size == 4, and after the change probe stops with "rmi reports
too small (out=2 in=2)".  With a larger descriptor the read path returns
kernel heap bytes, observed both in the product id printed by
rmi_f01_probe() and in the interrupt mask written back to the emulated
device.

Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
The reproducer is available on request.

Compile-tested on bd5f485f3f02, x86_64 defconfig + CONFIG_HID_RMI=y.

 drivers/hid/hid-rmi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17fdba46..a0780087d413 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -235,7 +235,8 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 				break;
 			}
 
-			read_input_count = data->readReport[1];
+			read_input_count = min_t(int, data->readReport[1],
+						 data->input_report_size - 2);
 			memcpy(buf + bytes_read, &data->readReport[2],
 				min(read_input_count, bytes_needed));
 
@@ -271,6 +272,11 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 			goto exit;
 	}
 
+	if (len > data->output_report_size - 4) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
 	data->writeReport[1] = len;
 	data->writeReport[2] = addr & 0xFF;
@@ -696,6 +702,17 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	data->output_report_size = hid_report_len(output_report);
 
+	/*
+	 * The write reports built by this driver occupy 6 bytes and the read
+	 * handshake looks at the first 3 bytes of an input report, so refuse
+	 * to drive a device whose reports cannot hold them.
+	 */
+	if (data->output_report_size < 6 || data->input_report_size < 3) {
+		hid_err(hdev, "rmi reports too small (out=%u in=%u)\n",
+			data->output_report_size, data->input_report_size);
+		goto start;
+	}
+
 	data->device_flags |= RMI_DEVICE;
 	alloc_size = data->output_report_size + data->input_report_size;
 

base-commit: bd5f485f3f026225b86573e559af0b7254ef4184
-- 
2.43.0

