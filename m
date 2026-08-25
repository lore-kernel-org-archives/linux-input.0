Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64483F86EE;
	Tue, 25 Aug 2026 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651730; cv=none; b=eXuTXskYvAfa0m4pVrAtYCp4n9BnHCNdVQoMsaXLcmZJYGJAlp8Ix8PpU93L/uL995KmxXg7ZNKkA3cf4m4MpwIE+yrrhhoCCjPixwX8axoYn+qgwpEk0+NEbntiLVdoJmeNntVT8TMsh9o+jwFOFfJrPognfm6qMP/QUT8PbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651730; c=relaxed/simple;
	bh=OscypHFrJFm+ZYXSCBm6lKLesfyBY4e8glY4nGsqzEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uax2uAI7hQvpSjUx8hNnbqhJBDEnbQhzgAspw3t2jOakBYKmQfZz5LDcYjdH/TJaUTlYF8Z5wZAdqfceprp8di8z9TZbJr6MptvMyaCA8DRbFnPtPxuAInFuBMdElbbNOkDAkqo/WQhKZ/J8p37iS0oIV/un0AJqL8bIomU2A6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e25e954N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e25e954N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65AA1F00A3A;
	Tue, 25 Aug 2026 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787651727;
	bh=Q+1vqyZOB06Y8gMGMiT8CtnV3r2AYsSOBSqg94mj4xI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e25e954NVzdeFu84oqogrSygmrsESPwCq8loM/wntYOOlQFb2Bn3/naRUHYygslxP
	 3BdqqFH+NUQ3lkMdLoGH2ke8uw89PSCIYN1nHUq83R9ewlwfaiC243V66H8JRsCCqE
	 zjDLX2oycn3G65D9NlO2Yr85NnPr4T86KoPw/b7uBckZyctQngYhbfo3bQIYBWaTlV
	 4U2P6B1e12hntNInWjpwkcEl0INiJDOscaLsUKvbtEQRz/wchUsEamoLFF0Z2OC7A6
	 U5ULFQqhgevCXRqU30uDlyE1EK7N9honYkr+BwKP67p8IyLQ0gmXwwVSH4F2jYGSxc
	 WnRtkeyYJOBZA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 25 Aug 2026 11:55:11 +0200
Subject: [PATCH v2 1/3] HID: bpf: mark struct hid_device as safe BPF
 pointer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-wip-bpf-safe-v2-1-d044355c09d8@kernel.org>
References: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
In-Reply-To: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787651723; l=1265;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=OscypHFrJFm+ZYXSCBm6lKLesfyBY4e8glY4nGsqzEo=;
 b=r7XzpBdOuF8J7iCUpGjVdJFQl87GL3hAev2bXaFNJrefEr5O3/y573A3spyRV9YO56ROdLRvd
 8dNEyOePJDjDH0H8uNBR2S/ZLubiYbCynoR6UbAiru/rxs9At78cOwV
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Commit ee9ad135b208 ("bpf: Reject a store through a fault prone
pointer") in the BPF tree makes the verifier reject any writes to
hid_device->{name,uniq,phys}. A simple solution is to mark the struct
hid_device as safe from a BPF point of view.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..56c53aca4511 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -62,6 +62,10 @@ struct hid_bpf_offset_write_range {
 	u32 end;
 };
 
+struct hid_bpf_ctx__safe_trusted {
+	struct hid_device *hid;
+};
+
 static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct bpf_reg_state *reg,
 					   int off, int size)
@@ -86,6 +90,8 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 	const char *cur = NULL;
 	int i;
 
+	BTF_TYPE_EMIT(struct hid_bpf_ctx__safe_trusted);
+
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 
 	for (i = 0; i < ARRAY_SIZE(write_ranges); i++) {

-- 
2.55.0

