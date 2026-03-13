Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201936F40D;
	Fri, 13 Mar 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387649; cv=none; b=dkBk/FqgIYvrblhbanv6ntv1QAdRtc9MBK9xo8oQulnVL6hfLuYNolbpUYMpLpLojZdwp9Pv8yz3MpJD1lzca1UO67Ef1wXITdbJdh3DI4nekvEx+U4bXFjn1+dbpvyWPo7x658UQfY9Q86d7ne6pX91GUutAkDMQu4nwJlWwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387649; c=relaxed/simple;
	bh=0sZQ+czOgztMPQpfgVSOWELt/G9sQl4X0UukyDA+KrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnUz+1N7DuEvyLBYvRzWdsyyHdI3slMoNeIvyTVNwEn8zVVqcuQBQ6HosWDKp+KUd+Gi3MF9jVuGHm7ucwt/WVNIhkeWrAmL1rsdnF4a9v3Mwj3pa1DWEWDSOWWf0cgRlBtq/sfP3kv+OCTul/O3p7+YwRqAvUAWLOIDrhUM+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMDEaqNq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMDEaqNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C05C19424;
	Fri, 13 Mar 2026 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387649;
	bh=0sZQ+czOgztMPQpfgVSOWELt/G9sQl4X0UukyDA+KrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mMDEaqNqcbeb7LsNYR1fljQ9hsHvrABePqn29O/qMQtQsagL07q9FOsvtr2nUxc8i
	 TqPmZ5UZiouwC4pKUwRzu1G2kWkvOUGtb9b5kAWjJvlOIcwpu29FZMQ7v2Pp1eysgB
	 cB/o8TZ2vL2lg7tv+eT+hB3I2o0UwlEDbvKbafvDFpgXjLSfhkljvLgmgGpLVrCPX2
	 3F3VhSEUIQ4CxPk+u9Q5t4F/vOCf7H7lSKBjYGgIiZiH8jVpLpF8CY63hLDzqKLW9L
	 +cKYgf2b9D0bgc3uFcMLYB1KSZqLVuTmEaK52LCJZ45n4hJPP39hHc8Rad+kR9aFRf
	 Ky9qHIRsPrMNw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 13 Mar 2026 08:40:25 +0100
Subject: [PATCH 2/4] HID: bpf: prevent buffer overflow in hid_hw_request
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wip-bpf-fixes-v1-2-74b860315060@kernel.org>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
In-Reply-To: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773387643; l=951;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0sZQ+czOgztMPQpfgVSOWELt/G9sQl4X0UukyDA+KrE=;
 b=hJIXco5EJPmc7XEmh3QD0+/IMn1m5GYxsQJIOSLAaLCIRcJf+EfCExqFwkxE8k00QryldA3s6
 h02fajwfwIIBYqWR3gHaFzk57Wbh2mpKwGmurlwc2Let9zunxUaV6to
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

right now the returned value is considered to be always valid. However,
when playing with HID-BPF, the return value can be arbitrary big,
because it's the return value of dispatch_hid_bpf_raw_requests(), which
calls the struct_ops and we have no guarantees that the value makes
sense.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index f3d15994ca1e..50c7b45c59e3 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -444,6 +444,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
+	if (ret > size)
+		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
 

-- 
2.52.0

