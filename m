Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5D35AC16;
	Fri, 24 Apr 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026185; cv=none; b=ig5KNE5ouPr/1wHDpsPGInmaEyOLNhDN6VhmOFPV8s54OLeDLJQFzEQclGcWHPF3HM3+qM1aSEYEPjxuZlokNoQ6JvyhwWde38xEOiRwm06FIf3w6mAf9jOTcSoZAhv2/ChoLRaGfOqknWlwJwPkISCHeRm5atD2CbAfwWuJuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026185; c=relaxed/simple;
	bh=/smHRgVH2uUcf0Bx7y3tGTkCASaVbYrlYycSncycJDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HbwXSg06ivDoBXb5yHWFsIW8c9TCdv9l9VDEu/J5Ih70VwrdpEdsS9IESw/UYTllNr5Do1qJZkw0t2gmNuA0PSp9f5oskrgjeKZjxqLB1BP1DFbASn4E6vC4CMp1CCPhOt5+sGxTgE53M/BHNbHHR62Z6LuDjApyUnp0DipJuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bKxbAZLs; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bKxbAZLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=qHrxNLSOcJ6r263jUyXsEigXpI69D7O6xkhPLCHj+K0=;
	b=bKxbAZLsYFNt4fwi8XXXew0GkdnO5C3jtJa8iSo8pZXiKPGzrQRg1YAnm40g3j
	GXTCtsVy0dNP4WkfjvnFFivZliCpRwSI4G8HOWPi4Imp11x1r0rVlDWZKvbd3QDQ
	z/gGYgwvt55jrtED3UXn4dqhoCQu4WhnFu4rQE3YqKn+0=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3x7dwROtpjpPtAA--.18658S2;
	Fri, 24 Apr 2026 18:22:41 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
Date: Fri, 24 Apr 2026 18:22:35 +0800
Subject: [PATCH] HID: bpf: Sync KF_SLEEPABLE flags in
 hid_bpf_syscall_kfuncs set
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAGpE62kC/yXMwQ5AMBCE4VeRPWvCRiq8ijhUDdahpEUk4t0Vx
 2+S+S8K8IJAdXKRxyFBFheRpwnZybgRSvpo4ox1VnChum1QPQZxUJpZV6UxsMgpHlYf9/OLNe3
 vsHcz7PYW6L4fI/PV424AAAA=
X-Change-ID: 20260424-btf-define-622697aaece1
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Zhao Mengmeng <zhaomengmeng@kylinos.cn>
X-Mailer: b4 0.15.2
X-CM-TRANSID:_____wD3x7dwROtpjpPtAA--.18658S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw43CryDAw48tw1rtry5Jwb_yoW8CFW3pa
	n7trWUCF18tw4rJa17CF45KFy5u340vw43ury7Cay5uan0vF98Xw1IgFy8Zasxtry8Gr4U
	Xr10ywsrZr12k37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrKsbUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlhGC+WnrRHFYqQAA36

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Pahole intersects flags across BTF_ID_FLAGS() occurrences, so omitting
KF_SLEEPABLE may drops the flags globally. sync this flags in
hid_bpf_syscall_kfuncs set to enforce consistency and safety.

Link: https://lore.kernel.org/sched-ext/177693500312.275653.17323765149266875001.b4-reply@b4/
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 50c7b45c59e3..62db80ead86e 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -585,11 +585,11 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
 
 /* for syscall HID-BPF */
 BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
-BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
-BTF_ID_FLAGS(func, hid_bpf_hw_request)
-BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
-BTF_ID_FLAGS(func, hid_bpf_input_report)
+BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
 BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {

---
base-commit: a67bb21a5fc478443d6db490c7049e9aeeb92bd4
change-id: 20260424-btf-define-622697aaece1

Best regards,
--  
Zhao Mengmeng <zhaomengmeng@kylinos.cn>

