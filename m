Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550423E6DD2;
	Tue, 25 Aug 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647424; cv=none; b=TuBm+lqR2pK+krl6R55MmhhsxnhZ9WgtR3h6orpCYkmCg0LACFX/BeeZLq/ysNC2HBd7AUe1Rc/9RrY7nmOQT8/Y/zGtzy/IMTsku/+0ZVJAtgQ0SYNUe4H2dFZS5y+kajFIIdbBMQtYydI5r7yAjYfEICHzVX68B/mBXsseXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647424; c=relaxed/simple;
	bh=OscypHFrJFm+ZYXSCBm6lKLesfyBY4e8glY4nGsqzEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlC40fL0qVgrtdLuqfi4E/YxSJXfm17bwIT4/UNspH3HEbHCAN1kAXB5Rb1NENbGWurEkc3BMA+rLkg8SLi0FWglPes+64AqjQzRiCqLoKdwkmoI1Y1Xt8q1cq647YB7HH7hGSfcjGXO77sDTTl5Z+mnmjKLIva0HKCtqR/pqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoH/YwWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoH/YwWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3531F00A3A;
	Tue, 25 Aug 2026 08:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787647422;
	bh=Q+1vqyZOB06Y8gMGMiT8CtnV3r2AYsSOBSqg94mj4xI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AoH/YwWIVKv2Gl6rpEqQdkpvWCqa0BKsMw9vEBwfjz9UgZqPH6/Qz+GFWoqefhUMc
	 LjGbSeOqoUrYA8tfK4u7NXPj8yTnpy8E31wA6N5wkvX8Zbbaxtctk9pNrogCN8pbcv
	 Y9VQHL514cC9Pl1svNkNDlHDm93kZgo+HrsTWe9mWfPSUQfARHfJDbooCL9fI/rvE4
	 DcF8QE8SWsZvC+wmK1qNrY1f6BtWgbqNGACL0BlJPQ8dT56vvJVDjtIVpHm7j2W6xe
	 U7AfLZJ2jzhVKHucRJR7SO+oeGnE8+ddHvR5eZHkNjEwgahFQooioAiitURaPNyFrp
	 cwmqQUCOy8jYQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 25 Aug 2026 10:43:16 +0200
Subject: [PATCH 1/3] HID: bpf: mark struct hid_device as safe BPF pointer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-wip-bpf-safe-v1-1-ab9e0e111c5c@kernel.org>
References: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
In-Reply-To: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787647419; l=1265;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=OscypHFrJFm+ZYXSCBm6lKLesfyBY4e8glY4nGsqzEo=;
 b=D+5pKvfPay7Oj/irQcyyovxl11XdAAiAIqLNHy9bi2plu5RFLyHFb9PxM7n5TjqmLdcM7p0tg
 ZpPm0cqibtCBXamF4Y3w4WnisRRrHQ7fDdd7DvaKykTJ13+54hFjNB5
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

