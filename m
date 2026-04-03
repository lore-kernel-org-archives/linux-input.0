Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DB3CF673;
	Fri,  3 Apr 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232754; cv=none; b=cBwC3jBOvGrQ95DW3xnP/Jq70tKvFJLOpESh6cn+9LphVxkR00Znx5ZjFFcRiEP6GVoH9xFf3ewM/1M5qEVAoioVqVu9B8hQGDevpaF5wtSpfpEmI2mIjbJVXjJydCL96vrH56FK3/uUU2KldjpKQsXKWf+i2P4wnjSXXYuk01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232754; c=relaxed/simple;
	bh=KDwz/4L8x+PCtjlGWnrKbO/cQWSNwxPg/CgLKH5OKQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQKng//fgBqOyxT+qErn9q9UAPUaUo347UtFsIf9NkvSdkmnGmizVfs4iox4oJvGw+cRpmURJ1B/3siRNlEhenXdzn0VeD3/AxwMr9NNdACPQydAWKFpvaHpsQmOIHm3Y6WAXGE+o+F7UHNFDMIZMTMmJQty20M7bs7roE+N0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3IW/0Ls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3IW/0Ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA201C19421;
	Fri,  3 Apr 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232753;
	bh=KDwz/4L8x+PCtjlGWnrKbO/cQWSNwxPg/CgLKH5OKQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i3IW/0LsCROl8M1m2pPze6HcqkjQ9ovsJUIQ+NJjvBMJBfKLprzu9d4eztSeYmxbj
	 nn2AbH+P//toBohQECNaeiw9NgodEY6IQMvGaG7htbRKDV58cauB5olzS0h3dc8A6C
	 4RXtUAV++eK3XkIEJ1EPyjvpowrKWW07Lm/DvnGdEKSlKKPiEFVmHvPV/XpLFo5H6k
	 U95UIAC65Vp7ohmeKBrL3t641/wf0nGwC1f4Ad9W4Si09qPmj8dBwNZsMd//rOcU9D
	 y2T5hAG3gOIVHTCzrFyWjKLNQKdfgqGaVSzLWn+o90IC5KrpRYpHzVmkAH1bzoA4hl
	 p7TqdeuJ3Ug3A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 03 Apr 2026 18:12:19 +0200
Subject: [PATCH 1/8] HID: bpf: fix some signed vs unsigned compiler
 warnings
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-1-978cedb9a074@kernel.org>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=2735;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8NOYANGVsBPe2PvEMa1dbDbeNVoX4fiDjdeEyTSOcgE=;
 b=q5dqAFWFjs8JhBRIM9ii4CGs7PwtSyje0KI/+ZA/ZdCVABoXxDhL6jFTIt6V5HT3RAz9MnKHY
 4lAqD7Ek5PdBtfhAYOOTvSMaQAxCsLWpae9oYMy9eTQmlQ30qzzWvbt
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

From: Peter Hutterer <peter.hutterer@who-t.net>

On udev-hid-bpf, we are now getting warnings here, shut them off.

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/227
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c         | 3 ++-
 drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c | 2 +-
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c             | 2 +-
 drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c          | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c b/drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c
index ec360d71130f..c562c2d684fe 100644
--- a/drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c
+++ b/drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c
@@ -462,7 +462,8 @@ int BPF_PROG(k20_fix_events, struct hid_bpf_ctx *hctx)
 			__u32 buttons;
 			__u8 wheel;
 		} __attribute__((packed)) *pad_report;
-		int i, b;
+		int i;
+		size_t b;
 		__u8 modifiers = data[1];
 		__u32 buttons = 0;
 
diff --git a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
index 82f1950445dd..253b96458c58 100644
--- a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
+++ b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
@@ -34,7 +34,7 @@ int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 	if (data[3] != 0x06)
 		return 0;
 
-	for (int idx = 0; idx < ARRAY_SIZE(offsets); idx++) {
+	for (size_t idx = 0; idx < ARRAY_SIZE(offsets); idx++) {
 		u8 offset = offsets[idx];
 
 		/* if Input (Cnst,Var,Abs) , make it Input (Data,Var,Abs) */
diff --git a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
index 2da680bc4e11..ed60a660cc1a 100644
--- a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
+++ b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
@@ -148,7 +148,7 @@ int probe(struct hid_bpf_probe_args *ctx)
 {
 	struct hid_bpf_ctx *hid_ctx;
 	__u16 pid;
-	int i;
+	size_t i;
 
 	/* get a struct hid_device to access the actual pid of the device */
 	hid_ctx = hid_bpf_allocate_context(ctx->hid);
diff --git a/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c b/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c
index 46d5c459d0c9..ac07216f5b67 100644
--- a/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c
@@ -173,7 +173,7 @@ int BPF_PROG(hid_device_event_xppen_deco_mini_4, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 8 /* size */);
 	__u8 button_mask = 0;
-	int d, b;
+	size_t d, b;
 
 	if (!data)
 		return 0; /* EPERM check */

-- 
2.53.0

