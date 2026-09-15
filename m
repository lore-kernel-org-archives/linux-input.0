Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7884AE129;
	Tue, 15 Sep 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487245; cv=none; b=S8Vfx+h/zJtLmDQm9Cg/31cpeZPn5K9o5S1Rbg8dXT0UTyv3I092SI63ssCdOqnHlX2vXAme4KnBDJJOauJW6x2JMId7mLbP3JfNmd/5v3gmTpk1kIapewQA18jjijfKzbUMTW33E69AR/DhYuNbfB8tl13KpjbvtCxb8TJ2D/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487245; c=relaxed/simple;
	bh=0dYP8z90v/+3pLXtp/DmVmsrtJDmQxR8xm5XIMMTco4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmGt0lnarfk9n4Aw+D2ZudmTqeD5Z1on+fpQcnTfWpbY206VR6MH2nNVPPAqGAXIgJPhRoaIhTO3GIcAk0eC8klOu2adSf8jzNCB8dXV++s4CLQf/LryiPKH61ZNjQ3dYMf2sYXvdqF48GlKXcXRE45znuadFWO465z361TuGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM2vWMID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM2vWMID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA7E1F00898;
	Tue, 15 Sep 2026 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487239;
	bh=DoojKGc4o04NPyiuOz3QFmMOfxrqdrEBJZtCwqmeqic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cM2vWMIDif2Ez+W8h5h1+bnqf9+83/xld+RC6NoUswXDkcwvxdYveNYkZXM7wuPyD
	 YlImqqD016SeorGdLFs80bqzuiWGloxfU2SH7FTHgyGA5il/2OmCxp+Jxw5Da6UWjr
	 /BTBv+mHz37D1sT0TVrT3F1ZWBfAdXGHmFuoJLTj680yYfDB+1eKSdZjLS9MwgDGBS
	 U4bp06L4o7DhnJTCOT5OOuB5xbiacjGrT88qqMuJwiI9JHUoqmPh9itNeOG9BPPGVG
	 VVX7c4jLoqxT8Y/Ace0m06P10gec6JovTCn1vOxNgk38xe37VovhacM8kacyj0LR27
	 lJb3jNNMLYhNQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 15 Sep 2026 17:46:58 +0200
Subject: [PATCH 2/2] selftest/hid: add test for negative return codes for
 hid_bpf_hw_request
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-wip-bpf-signed_size-v1-2-6bc8f3d09f5b@kernel.org>
References: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
In-Reply-To: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487234; l=1584;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0dYP8z90v/+3pLXtp/DmVmsrtJDmQxR8xm5XIMMTco4=;
 b=ZC0ZcIFVr5RjtRpgD/cR7LerAXA0DadoPSYEVj+Wgn0c9uXvpruSd+3StKgKVNvGzQxveidC7
 +TctbRh4AbeCGeWIkvinKSK8p9Hly0YIMV83opCkOive3cpN+D4C+xq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If the transport driver returns an error, we should ensure we actually
get the error, not a success value.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 32d81ba15a25..8c41ebfb85e4 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -546,6 +546,37 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 	ASSERT_EQ(args.data[1], 2);
 }
 
+/*
+ * Call hid_hw_raw_request against the given uhid device,
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_user_raw_request_call_eio)
+{
+	struct hid_hw_request_syscall_args args = {
+		.retval = -1,
+		.type = HID_FEATURE_REPORT,
+		.request_type = HID_REQ_GET_PROTOCOL,
+		.size = MAX_BUF_SIZE,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+	int err, prog_fd;
+
+	LOAD_BPF;
+
+	args.hid = self->hid.hid_id;
+	args.data[0] = 1; /* report ID */
+
+	prog_fd = bpf_program__fd(self->skel->progs.hid_user_raw_request);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+	ASSERT_OK(err) TH_LOG("error while calling bpf_prog_test_run_opts");
+
+	ASSERT_EQ(args.retval, -EIO);
+}
+
 /*
  * Call hid_hw_raw_request against the given uhid device,
  * check that the program is called and prevents the

-- 
2.55.0

