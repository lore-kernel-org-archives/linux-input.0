Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620727;
	b=SuOLoz2/xszleT7TxGQupYLdz2BjSHt8Ed005mN7z6LHp60Hj4z17D/hB6g/w+lSEO0G
	 TnWO59QEkQT13aJY6FeECyRofRllmHWHCHtxbiZLI4dUPXzwD06rwvnVkJ2ywxtnnTEPv
	 rk8CiVCXTBTa7wSjfMafxEBWOPDZxySjs7HlxvCx7ee3AmfRve6J49Eleb3WslJNq4y2T
	 z2sr6nUtmdhxE3fwLgX+gRcZW47QUqhV0o3VInUjOcbqodVcK6C3/HHQEaKknRrLusmJK
	 RfY1LDlLBpnmk8LP9BpEZEnBcBl3WcJN8IOjkEPUkT6zBRJgJp+JXKm4x/dWXTORZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620727;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=/uJJ7yIf1ZulPlcjHC1h8QagLgkGqnFozm17to6Gfk8=;
	b=nGL4eVzP1kipIAQHuolLDbPsVu7miaThhoJ0XgXijlC8RW4ZvcZfxOKbcrBxoQ/82BhM
	 Cn3rTWykPHEAGykamkUIVlxImLGrkIHqSJ3RYFH+VUQj9zED1588ZN82QFdHvpCT69ByY
	 ICQ1Cei94IJdn0o3Trfj664GBnG1k8Tmj+axN2JWNoqdNPban9n8hgBulrv75oaS4b3zk
	 aAdnNMeCNSWDvxNXRi/EUd2BXhNXaTLRmyWT+7Cf6bdy9lZaVne3HqcOF3G0LU+qJ3Ign
	 MJjFQ0TqFFd74KrLjs2wgregIDY/fNyzmDEIKJ7hLILEpojHsmRBgc5X4Rx/9XOIUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=epC1oruA;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D2606A334;
	Mon,  2 Nov 2026 11:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB5D2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=epC1oruA
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b234c;
	Mon, 2 Nov 2026 19:58:42 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071771.29269.9450789504034226345@stu.pku.edu.cn>
Subject: [PATCH 2/2] HID: bpf: reject struct_ops registration during device
 destruction
In-Reply-To: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
References: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c20429303a2kunmab045f0fe84e0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUgaVkgZHhpKQh1PTxhMS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=epC1oruAgbc7809zi58uXEDYrQFMRITmEETxQfW4w5rS8Dp/bB1RQ/tC6RoArwY91HjHImOKkrQxjbAnJKY4l0HSjFlY7RFXoqxwWh6KxB5e6OzpKwdgrQkS0Hb9J04pZutQPu4rg8SMIrwGMOh2KCJQat2/7m7fXodMEMatX4c=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=/uJJ7yIf1ZulPlcjHC1h8QagLgkGqnFozm17to6Gfk8=;
	h=date:mime-version:subject:message-id:from;

hid_bpf_reg() can obtain a device reference before hid_destroy_device()
removes the device from the bus, then block on prog_list_lock while HID-BPF
destruction cleans the device's SRCU state.  The registration path does not
check the destroyed flag after taking the lock, so it can publish a new
struct_ops entry and call synchronize_srcu() on the cleaned SRCU object.

KASAN reports:

  BUG: KASAN: slab-use-after-free in check_init_srcu_struct
  Read of size 8
  check_init_srcu_struct
  synchronize_srcu
  hid_bpf_reg
  bpf_struct_ops_link_create

Check destroyed while holding prog_list_lock.  The preceding teardown
serialization change sets the flag while holding the same lock, so either a
registration completes before destruction starts or it fails with -ENODEV
without accessing SRCU.

The reproducer no longer triggers a KASAN report with this change.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Closes: https://lore.kernel.org/linux-input/179317460937.87455.17990170930834=
67190@stu.pku.edu.cn/
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_s=
truct_ops.c
index c90b68956cb3b..4c433f419c85e 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -201,6 +201,11 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *lin=
k)
=20
 	mutex_lock(&hdev->bpf.prog_list_lock);
=20
+	if (READ_ONCE(hdev->bpf.destroyed)) {
+		err =3D -ENODEV;
+		goto out_unlock;
+	}
+
 	count =3D list_count_nodes(&hdev->bpf.prog_list);
 	if (count >=3D HID_BPF_MAX_PROGS_PER_DEV) {
 		err =3D -E2BIG;
--=20
2.39.5 (Apple Git-154)
