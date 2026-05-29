Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23322425B
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062177; cv=none; b=WLe0WeFcFeZRQryWaf39BPqSEBoiZjHjePqPDBLa3FmAF7y9rIF8OziY5/oFeU+Kc3+sQ/3TrSqgOzo+xE4No2cLvqqWOGFYPT1DOtxR/tDVz7MZq/qlVhny24SvrLiqDm0RQH9o/20rTBfAqboMaF0M3ZP6K9n4qKObLi7aaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062177; c=relaxed/simple;
	bh=w/XDoJD9UW2X/ZMFzoYwJZ7NELGaSy7SAIfzA4Zj1uQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=bs3r+EYVSM2XZVdqRwuSNq9nq1MBCGX17MYlMATxeGUAAYkFy+t8B4XoHp7aU1jvRM0f6JPNP2kc9VaxfhXxFmKK2YjY3rNJ1aH8rNqJcNeDcTjHY2a19BGjOtdwR0pWv4un1Cd0Mqz0ic4nOecilThkMkb5SeJoIap9hHHTep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqiaS2gU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqiaS2gU"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780062173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9NP0pxuD7iebhIQJui2i7alD2QVqysKVjU+6FBbyOhY=;
	b=fqiaS2gUMo750SRQLJ3LCnbHmuk8YvQJmFHpdOHYOgKjkyo7UIx4tnHH2ap4lSAg1/BCRn
	Yx3y9UiTqwNHH8iTEd0xVBhrF6cYxfEkOibUgABZKV7VKE114bbEOcbbotVp+PlAKo5r69
	/WteLMKuXe8Ie67PaeYnHBU0vlx6sIk=
Date: Fri, 29 May 2026 13:42:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
TLS-Required: No
Subject: [PATCH] HID: hid-goodix-spi: validate report size to prevent stack
 buffer overflow
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

From: Tianchu Chen <flynnnchen@tencent.com>

goodix_hid_set_raw_report() builds a protocol frame in a 128-byte stack
buffer (tmp_buf), writing an 11-12 byte header followed by the
caller-supplied report data.  The HID core caps report size at
HID_MAX_BUFFER_SIZE (16384) by default, while the driver does not set
hid_ll_driver.max_buffer_size and performs no bounds checking before
copying the payload:

    memcpy(tmp_buf + tx_len, buf, len);

A hidraw SET_REPORT ioctl with a report larger than ~116 bytes
overflows the stack buffer.

Add a size check after constructing the header, rejecting reports that
would exceed the buffer capacity.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/hid/hid-goodix-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 80c0288a3..288cb827e 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -520,6 +520,9 @@ static int goodix_hid_set_raw_report(struct hid_devic=
e *hid,
 	memcpy(tmp_buf + tx_len, args, args_len);
 	tx_len +=3D args_len;
=20
+=09if (tx_len + len > sizeof(tmp_buf))
+		return -EINVAL;
+
 	memcpy(tmp_buf + tx_len, buf, len);
 	tx_len +=3D len;
=20
--=20
2.51.0
