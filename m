Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314644DE712
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359508; cv=none; b=aee7IFY04ia2/u3PTLX9zKWIq4gaf1jr9RWtIcdsCzq3D+km5FTq2lgXUCKlfJQToJUytMU/wOSqsrrQjfOrUT9cR/2pAR0JFDWpSYRG2Ld3gpxP+DDOucyfqqBq/J3zm3dDrUOUkwYFbZ72FZiDXp7l7P2GeTxe9s7+tugLMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359508; c=relaxed/simple;
	bh=mDZyU+7/YB0JlQIRAEywPgCEGsycCredHJmQMQnsn4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evcdC3OsY44T4uMAQB0ZMtM2iVIg+rPsjecKFRv5xZ3oz9V2p8CUiWgQYt87nV9ufqTuQMfFGjIjTx1Q2Fwdpv7Jk2XK87RCra9chPcvSvkrwHtUa+JjCeJB6yVWJTzgPahB13sR+0xD5uNXM8sbATOFh9jvGyV59jnaZZMRonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZa20WuQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZa20WuQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so6478805e9.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359505; x=1792964305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgux2BSkdpCe0yAd96caJdE5ThN2ey9owMjfge1g0T0=;
        b=XZa20WuQ/e7QgTDshBkEU5sIqgGI6rziLlaCIrwiZFF5GfCLceDyuya3mMzzvRUB0D
         7PpnNnuIiH8KULsj3qkpfJqL74yDVeqlS7+FdcHElPe8S3Cy8RBo6QlJbqG3k7eAG/Qj
         +e7+BoGen8jQk/tuBsQzu+BXQh/LeGyBXU9e0LwmRxpobXpZhTqP8uBAukkxVPRM1Vdn
         zTqE5vh5vm35cJSAUc8GqIr147hCUUfatj7KABnOPgiPeM9dooSTYAATGeXU/4vkLhQz
         kxMhfczIPNEg/qfG8RMsh5e26M7S+qWqg3rTCsO48JrWpqLh+Qka5qfv9ABI4Ls3vJ3T
         S/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359505; x=1792964305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgux2BSkdpCe0yAd96caJdE5ThN2ey9owMjfge1g0T0=;
        b=onkTaYC+kga/r4YzHPm9WbAO2x0V5jLco+ELz47U/c6e70xGhIi+8JJ773mh4I5Txu
         wY1X9uo3C2O28b0UCUhhv6sKSiCw0iTk4JwCKNNp5LcK/MgVFKwWoJNakxlGPSxmup8h
         WexQuuy87apQnxQorUaTvU82qgz6zdcN7l42L3z55r32t1FPwMwaLlV9zeObYt2dNEo8
         pgRymgICoYEBN2DykJl3AN/d0lYGIXrdol9ZN5nG3Tp9IoEoPr7EiKA2BDMp64KfCCno
         JkcLeoVIxoLADC9rjBM5SfmzDOgdKkJ50bjeje9PG8usyRyHrQx9XefB31vk99SKoavn
         0dYw==
X-Gm-Message-State: AFq9FYKPx6LZj3idFjHtr1BTxYN8Md+jqAX1v8MDxsejyfXz9PipkAGZ
	Sp8tWNoka4r1iNa+cGqIhPKSApHRL6YleoTm7pWuERdGm0mY7RqHWcE=
X-Gm-Gg: AYBFou0lOmn4AbdkwNvkCcThLGLgvWSMQmpinvQAH+0kJwKtsX0pzZgqSgSnu1m1dTy
	fIpP1NDGO/g/AMd+PRL00xoa8Ks7V1Qrl0JzxlXptgIVfYQQN0J/X6DHDiB5TiQv2J8w+Rzx41E
	Xt0oj5G8kx0L0n3qHgsxRssry3AwfOSAAIp3KpTYwh9h19ptqxl4kapX8gRdcBmO0dHEAvGXvXC
	nDh/RTtQpaOS6Vqn/C2UTWih66ElYVCKG/HZN81wsefKpRaXPQM5GYDnSSdA5U1wS74D2WNfnuX
	6xBGht2KZDSXR4EDTFsOoetqJBKuiCdv8k921rbh6uHwZm9oPdBlw4kWTV6mC6/KbQnQgDb7KWY
	nLQ+Q8rzaVDAQJtg3D3US1vSxOU0O4j4gDQWV5wElrhLrfikYomsr5ENTyFYb4umUmIBajRigS8
	r7jzUfjMEJuI/TTYigaGZJVN68sQaqT51wC9+1Acc=
X-Received: by 2002:a5d:5e06:0:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-48e17d11718mr218201f8f.40.1792359505274;
        Sun, 18 Oct 2026 14:38:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/8] HID: cp2112: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:52 +0000
Message-ID: <20261018213754.1951187-8-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018213754.1951187-1-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cp2112_raw_event() processes incoming HID reports without validating
the report size against the data it accesses. Since hid-core calls the
driver's raw_event callback before it validates the report size in
hid_report_raw_event(), the driver must perform its own bounds checking.

For CP2112_TRANSFER_STATUS_RESPONSE, the code casts data to struct
cp2112_xfer_status_report (7 bytes) and accesses fields at offsets 1-6.

For CP2112_DATA_READ_RESPONSE, the code reads data[1], data[2], and
then copies data[2] bytes (capped to 61) starting from data[3]. If the
report is shorter than 3 + read_length bytes, the memcpy reads beyond
the buffer boundary.

Add size validation for both report types:
 - Transfer status: require sizeof(struct cp2112_xfer_status_report)
 - Data read: require at least 3 bytes for the header, then cap the
   copy length to what is actually available in the buffer

Fixes: e932d817866770d4 ("HID: add hid-cp2112 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-cp2112.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571b..2508c8ea8b693 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1430,6 +1430,10 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(struct cp2112_xfer_status_report)) {
+			hid_err(hdev, "short transfer status report\n");
+			return 0;
+		}
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1463,11 +1467,17 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 3) {
+			hid_err(hdev, "short data read response\n");
+			return 0;
+		}
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
 		if (dev->read_length > sizeof(dev->read_data))
 			dev->read_length = sizeof(dev->read_data);
+		if (dev->read_length > size - 3)
+			dev->read_length = size - 3;
 
 		memcpy(dev->read_data, &data[3], dev->read_length);
 		atomic_set(&dev->read_avail, 1);
-- 
2.47.3

