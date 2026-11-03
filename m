Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673927;
	b=cX878DTHsUKrrXTE9GVwKBJNKS4/y33F6bRT5xnvWYVTXaxWrDOmfx+dsGzfL8MJUel9
	 2gvm6QNEteTuk8b6Oms/wXIwal2FbkC7I62mhKrHvwQ4cDWXXTIar/uJl/YHFN51J1sGP
	 1tjG2JHyWyMc6gOpKX0p77XEZRXNiYizxsMWRO7cNhZtwQXn8tT5NjeRju1gsgyMdjB+/
	 DHWvGCMGF7jsWB5oyRF2nzuni8IughSeFqwaVtlNLkAbHAUvPB2/7ilB+qyQ6mtwbqlu6
	 iy74Oa/m54C62Dz6v4M+K0L0WlmZpvlwJy/mZLGjgW3qye9lOt/WX1kHdrCokfUTsjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673927;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=j2KD9GvfPeXoDg285IZexB8Z8vN8Y20a8MOwOXjwlFc=;
	b=xKS6K5AB6Bh1OxrskOtqpQNr4KnyGb0hknYs0a577OhLJckLiDabpauTPFd1JRZjSDld
	 jTYp//H4zMRusT/dyxITiCAKjdTb2WhH7GHOzeAg75sPhuoatUV7UYDkS1SanuGyGlE5i
	 6JsneffStDbuI+Yu5M3xXFMqWmjO2Gn6DnW+0JccJPQ1JZ3ioZGotrOcct2dj0TztJHPx
	 1yerKJdhrpAxUuShGhCuauDdCFTldLApos4jIUQ6LSVxx8EQKuwa1zbVrxAT/hlPmnpcT
	 ptyOT6XeJFyK2Lrcwz6Q12nY34tHUog613EWZ6a5qZ+oJgNwBm+PkbBBWwWeVyBGaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=OwrRybO2;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC861606A327;
	Tue,  3 Nov 2026 02:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC861606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=OwrRybO2
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a3a;
	Tue, 3 Nov 2026 10:45:21 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.16512492575149308999@stu.pku.edu.cn>
Subject: [PATCH v2 2/2] HID: bpf: reject struct_ops registration during device
 destruction
In-Reply-To: <179367391951.8187.14164894863012056170@stu.pku.edu.cn>
References: <179367391951.8187.14164894863012056170@stu.pku.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19f4c04d503a2kunm153cdd6b10a857
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTxgfVh5DQh4YS08dS0odHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0lITkNDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=OwrRybO2Wuj46VFCa7BjnOIRVok+fuhiqXMbFkMrRpJfJeEQbNTlFum9N1FfyioxyppCZOYNFgl9KuOGs8RawkSExt6Kftn+ZhswJM1Dal0YZeqK0y6XnT2RvBllj6mAnSYtWAbGWB1DHtmKStYXlDCQcn2pxjkcZYj1ow9NzVY=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=j2KD9GvfPeXoDg285IZexB8Z8vN8Y20a8MOwOXjwlFc=;
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

Check destroyed while holding prog_list_lock.  Device destruction sets the
flag while holding the same lock, so a registration either completes before
destruction starts or fails with -ENODEV without accessing the SRCU state.

Also clear ops->hdev on every registration error before dropping the device
reference.  This keeps a failed struct_ops instance reusable and prevents a
dangling device pointer from reaching a later unregister operation.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Closes: https://lore.kernel.org/linux-input/179317460937.87455.1799017093083467190@stu.pku.edu.cn/
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index c90b68956cb3b..31e2cb146b92c 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -201,6 +201,11 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 
 	mutex_lock(&hdev->bpf.prog_list_lock);
 
+	if (READ_ONCE(hdev->bpf.destroyed)) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+
 	count = list_count_nodes(&hdev->bpf.prog_list);
 	if (count >= HID_BPF_MAX_PROGS_PER_DEV) {
 		err = -E2BIG;
@@ -229,11 +234,14 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 	synchronize_srcu(&hdev->bpf.srcu);
 
 out_unlock:
-	mutex_unlock(&hdev->bpf.prog_list_lock);
-
 	if (err) {
 		if (hdev->bpf.rdesc_ops == ops)
 			hdev->bpf.rdesc_ops = NULL;
+		ops->hdev = NULL;
+	}
+	mutex_unlock(&hdev->bpf.prog_list_lock);
+
+	if (err) {
 		hid_put_device(hdev);
 	} else if (ops->hid_rdesc_fixup) {
 		hid_bpf_reconnect(hdev);
-- 
2.39.5 (Apple Git-154)
