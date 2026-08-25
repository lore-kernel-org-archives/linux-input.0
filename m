Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB983D566F;
	Tue, 25 Aug 2026 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647422; cv=none; b=BELgPEC/MINKhG8FOe2mqCvynxhBoMzH/RlRtakkDQCgMS5yQyqA/vwOePMaGANWJT0TEfsxlXa6KHJGwf2G0sctyWcVGkR/1s5uEPVUxvACxIlurqrR9PWUTOdpc8mXJX90qbeXuWeSKQK4zPkqQSL6gl8uD4wQmbmy0lxmcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647422; c=relaxed/simple;
	bh=1KGuUQbUI6rYf3zRi3ntw8YgtXmGrC0WbyQOLJXX+jM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GkXcIpURiHCMyssUXBxSxiLiCzLg4HgxcHbUmdYlEwCqDcsaGec2tBElKZwwcetQ1GomzHFiZEQ+zmbMs78Oe7cRNLPmvj+WdK2+rmKtSGCcPcGbZ0yU9IF4FmQEvQQit1Y1jeKotKbUw1zliUF+chOp9OosNLK+sUzCghgMIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feJo/pX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feJo/pX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763B81F000E9;
	Tue, 25 Aug 2026 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787647421;
	bh=JtUqLh2eEplZS6ItNuL/Dr58W/hI1arthYuGxrCKMr8=;
	h=From:Subject:Date:To:Cc;
	b=feJo/pX9DZidIdnOYn8o7LKuH5tCkP6MgLYJiQVa5S28CJeHh7UXEq+jnQLMVjKnH
	 DgxH3vOxYedzgXsG1iE76q0ZcZ2HBQo975kOj3C5Cinrv+D/VledDl/sEVIqSVfcgc
	 oulmBXJqmZ60tT10/1bMJmjNn96p+7mTSvjG6YoSvHu8ni+8Dz3C4QamkCOvcpP1XF
	 DZAJS4SZVF1xW7blduhQl74lV6VGSzoLLzTyQDCJn1R6HMwW0d/DyaH7yHCNI3s+9z
	 8s6UD7tx+wUUKXqxrIHGiK+SkSNV6L/XfrDKOCAGbAAapnFLi11Uje5DP4/5xKqB1D
	 a5RS35OaWDtXg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/3] HID: bpf: fix 7.3-rc0 bpf breakage
Date: Tue, 25 Aug 2026 10:43:15 +0200
Message-Id: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyND3fLMAt2kgjTd4sS0VF1jy2QDM8vkFAtjYxMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loA85torHAAAAA=
X-Change-ID: 20260821-wip-bpf-safe-39c069cd8334
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787647419; l=1333;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=1KGuUQbUI6rYf3zRi3ntw8YgtXmGrC0WbyQOLJXX+jM=;
 b=sJ1Z5zyO7sT+w+ZtL/1Oi63BSABRTQDco2zltcVtor3OL2HzFOSPKPF5BmiuRyPzoxQ4jFbma
 eHTTYGhAxSoAE7wF0wWsCJ1vkfiv0aDGa2EqLW38of9Zzlzh9wd/7zO
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

