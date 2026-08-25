Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE793F3284;
	Tue, 25 Aug 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651727; cv=none; b=MZbi7kYQOgeg1RIwi5uFZzDylqbzFz+CxbORSnENdprHzG4jknELvuggIp7e/a8+4hnTiDyPK5R+z/Pyhk1t2QpbSARbgjOUB+UDl97oz4SsO7Uy0eWxjeC/jfA0+h5n8rTJIYxqWiBPV/qkYbKtEjItip5WtUV8ZzG/iRx2Xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651727; c=relaxed/simple;
	bh=RRI7heggkeD0xInS0KH2fg5GDv7rm0CcI5PN/y/1VPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WjiKudUFInz0ixNVqnge8IpGlEqpJjL6MjrvcFkGKlrzq6W+JRfX//HRRBF07N3DtszlIwF6G1P7TVSjgN3ruEOYcGSoJpo87lYpGFAaw7VNTBMdrf7UKCC2uoFjFfPQN2Cg568me40vxc5S7JIMmc9eaqrPXcbObVedNMHMnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtSWVezn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtSWVezn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6E71F000E9;
	Tue, 25 Aug 2026 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787651725;
	bh=YakmDYC+CNfeq8NrnrgCoAi7VDePKv/R2VGkWswlhMg=;
	h=From:Subject:Date:To:Cc;
	b=QtSWVeznXfmuy1OjKFIDBpn4yR1mjlcEv6GhZIo/SrlsOpe6DeTxzD06yNUtk42n4
	 jfCbyt0wXFeOb+6PPBXM3Pdq9HAGN6jHFU4ucbIg5WqV1VzgKodN+sRqLziHxY2qIg
	 7yj95p0CXGEvuEl+BWT/glfkvGJ9LNrUhhPiEAobDjvcLTbIB8uFU82VON0AkewCTJ
	 WGZ5aJakAw3GzF1M/eE6fRua56HGPrRRfpV9tWI7oyFcoJN3vH2kRrwBhm7GEraGtl
	 BbzhCUL5vEV1xcj+ym+HBZ/UTF/niiNf3B18FhsYHRSs9K1T/13pwjjHszKgHP6t6C
	 vi8obob7F5Dkg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 0/3] HID: bpf: fix 7.3-rc0 bpf breakage
Date: Tue, 25 Aug 2026 11:55:10 +0200
Message-Id: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6CMBBFf4XM2jF9CAFX/IdhUcoAowZIi1VD+
 HcpxoXLk5x77gKeHJOHc7KAo8Cex2EDdUjA9mboCLnZGJRQmciVxCdPWE8tetMS6sKKrLBNrvU
 JtsnkqOXXnrtUX/aP+kp2jo1o9Ozn0b33vyCj90un/+kgUaCpCxIkpbSpLW/kBrofR9dBta7rB
 1BTJtq7AAAA
X-Change-ID: 20260821-wip-bpf-safe-39c069cd8334
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787651723; l=1484;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=RRI7heggkeD0xInS0KH2fg5GDv7rm0CcI5PN/y/1VPA=;
 b=QKeo+qpVxVqlBQdxTsSPwUBNLETtQDpFx6e1qQ5zUjyS9Th5TmbnAeORR1YbKRPZyQiXXIPQz
 hy/rwaoTGdCByCiPu3ruGMw+8a6ekM+YxtpBh0QsOR0zxNA0W7HcdoS
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

With the introduction of commit ee9ad135b208 ("bpf: Reject a store
through a fault prone pointer"), a HID-BPF program which would try to
change the name, phys or uniq of a HID device would be rejected by the
verifier. Also, this commits and its siblings manage to detect the
buffer overflow that is currently dynamically detected in the test
suite. The verifier now rejects the bpf program we try to load, marking
the test as fail. This is correct behavior, and better admittedly so fix
this so the CI stays green.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- Fixed 2 issues found by shashiko 
- Link to v1: https://patch.msgid.link/20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org

---
Benjamin Tissoires (3):
      HID: bpf: mark struct hid_device as safe BPF pointer
      selftests/hid: Add a test to ensure we can write fields in hid_device
      selftests/hid: prepare test_rdesc_fixup_get_data_overflow for the new verifier

 drivers/hid/bpf/hid_bpf_struct_ops.c               |  6 +++
 tools/testing/selftests/hid/hid_bpf.c              | 51 ++++++++++++++++++----
 tools/testing/selftests/hid/progs/hid.c            | 26 +++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  3 ++
 4 files changed, 78 insertions(+), 8 deletions(-)
---
base-commit: a93f3bf4e1d60777b1659b812c9e818cfc53b449
change-id: 20260821-wip-bpf-safe-39c069cd8334

Best regards,
--  
Benjamin Tissoires <bentiss@kernel.org>

