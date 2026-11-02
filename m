Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621592;
	b=AgNCG/PyjZB3LU3RmfOWoyqiQIofxMwE7scfd1QM6oEa6SIc13dy4tOBhs+WCZHGvVlM
	 tVY+xE+Bd0K1L2Fm6es4Jc45W/5UQ0zklLlNbivhSECEwLbmtVtWWm0e7sf1Lo67dWDra
	 D+aq3KV75YoPY6VuvQHwA9lPtxG6IGHXsOD+mqpX+m60+RPpzflvkmZNurM/PI10d/Ccm
	 uLAZDYu6GgNzt290uAjfXeYEGXaP6jky3jvHddzFCQ4eFNym6zqoBkR2bttIIeYiXOPj0
	 wIEuBjpAGHrukbmDIjQHQyv7hU6h+H6hpIizaUNIwbHCIs61ALbgWsNgB08tcIlqKDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w16SL+kWg6jfT8JKO9pwhGzPmHVD9dHRs+8Matajy4k=;
	b=RthqVdYLjvuWQuig9aal2330PhoiDMKnShwtm4W1senGcmQnlic+VpU7ONNYbWrUARXv
	 liGV4yeAJr3phcLhy3dTudbe4tAhaVF8ALeG9OFao/XAkEzw5EkU4bWL/niWhOXD2klAl
	 jb0wOPbtBbjnS30h22wLYvmNFEhp/BrmULpgwLLse5cwDg9Io2sXOEPbvJ2qqZhbukQr6
	 ZBq5ofqBBokqW/qhJRYk9G1RhXklNuHpOO1u7q/n3rA+Lm8030e6KBp4YtwiTuyzyje8p
	 B/bGrdppjvGnCLKCGMW1HMvxvmKheS+iKSIyAC3LYr1948fqWhtRuwSr60T9U2lcQoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwsmmSKR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B70606A326;
	Mon,  2 Nov 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwsmmSKR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF091F00A17;
	Mon,  2 Nov 2026 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621592;
	bh=w16SL+kWg6jfT8JKO9pwhGzPmHVD9dHRs+8Matajy4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwsmmSKRpzmwdCMQq7JxfyKwuyaDoJR2QRucJUTPr8q+z/nyGmZiU4Lmbl0pzlbp6
	 3O7z0dnonQqy9tPGWn8zv96a/urPHfQdmJULQe/M++1uszl1Y26gqpFxvSQb6wVEcS
	 owthYuASj05zUQrk9qV4tYAwMBPVi31OFx6iyh+jW4egKVpDu5pZdRm7cbDn2ALXl0
	 y4ibRnXG7aMCRdpTvuDCYbqF9Y0sfj6kdh2JW88j9WbaYbIBASOA52r44b5A4E9Ppy
	 JQ/vJtSGfJ5b8eQzNhDginSHN9l23/es6pzAe68a1++qWRCuXMDapnYvBOlVhO7Ilr
	 kZYlgfuLD3X3g==
Message-ID: <sashiko-outbox-193378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: bpf: reject struct_ops registration during
 device destruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, linux-input@vger.kernel.org
Cc: bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <179362071771.29269.9450789504034226345@stu.pku.edu.cn>
References: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
 <179362071771.29269.9450789504034226345@stu.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:13:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] HID: bpf: dangling ops->hdev pointer on error path in hid_bpf_=
reg()
- [High] HID: bpf: deadlock on prog_list_lock and srcu in hid_bpf_hw_reques=
t()
--

commit 318c71f825ad280448e4c11859ac62903f968c18
Author: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

HID: bpf: reject struct_ops registration during device destruction

This series serializes HID-BPF hardware requests and output reports against
device teardown using prog_list_lock and the destroyed flag, and rejects new
struct_ops registrations once device destruction has started.

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 6b467c74601cb..4fea42dd2f392 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -444,14 +444,20 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *b=
uf, size_t buf__sz,
>  	if (!dma_data)
>  		return -ENOMEM;
> =20
> -	ret =3D hid_ops->hid_hw_raw_request(ctx->hid,
> -					      dma_data[0],
> -					      dma_data,
> -					      size,
> -					      rtype,
> -					      reqtype,
> -					      (u64)(long)ctx,
> -					      true); /* prevent infinite recursions */
> +	mutex_lock(&ctx->hid->bpf.prog_list_lock);
> +	if (READ_ONCE(ctx->hid->bpf.destroyed)) {
> +		ret =3D -ENODEV;
> +	} else {
> +		ret =3D hid_ops->hid_hw_raw_request(ctx->hid,
> +						  dma_data[0],
> +						  dma_data,
> +						  size,
> +						  rtype,
> +						  reqtype,
> +						  (u64)(long)ctx,
> +						  true); /* prevent infinite recursions */
> +	}
> +	mutex_unlock(&ctx->hid->bpf.prog_list_lock);
> =20
>  	if (ret > (ssize_t)size)
>  		ret =3D size;
> @@ -492,7 +498,13 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __=
u8 *buf, size_t buf__sz)
>  	if (!dma_data)
>  		return -ENOMEM;
> =20
> -	ret =3D hid_ops->hid_hw_output_report(ctx->hid, dma_data, size, (u64)(l=
ong)ctx, true);
> +	mutex_lock(&ctx->hid->bpf.prog_list_lock);
> +	if (READ_ONCE(ctx->hid->bpf.destroyed))
> +		ret =3D -ENODEV;
> +	else
> +		ret =3D hid_ops->hid_hw_output_report(ctx->hid, dma_data, size,
> +						    (u64)(long)ctx, true);
> +	mutex_unlock(&ctx->hid->bpf.prog_list_lock);

[Severity: High]
Can taking prog_list_lock in hid_bpf_hw_request() and
hid_bpf_hw_output_report() deadlock against hdev->bpf.srcu or against itsel=
f?

In drivers/hid/bpf/hid_bpf_struct_ops.c, hid_bpf_reg() and hid_bpf_unreg()
acquire prog_list_lock and then wait in synchronize_srcu():

drivers/hid/bpf/hid_bpf_struct_ops.c:hid_bpf_reg() {
	mutex_lock(&hdev->bpf.prog_list_lock);
	...
	synchronize_srcu(&hdev->bpf.srcu);
}

Meanwhile, in drivers/hid/bpf/hid_bpf_dispatch.c,
dispatch_hid_bpf_raw_requests() and dispatch_hid_bpf_output_report() hold
srcu_read_lock(&hdev->bpf.srcu) while invoking sleepable struct_ops programs
(e->hid_hw_request and e->hid_hw_output_report):

drivers/hid/bpf/hid_bpf_dispatch.c:dispatch_hid_bpf_raw_requests() {
	idx =3D srcu_read_lock(&hdev->bpf.srcu);
	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
				 srcu_read_lock_held(&hdev->bpf.srcu)) {
		if (!e->hid_hw_request)
			continue;

		ret =3D e->hid_hw_request(&ctx_kern.ctx, reportnum, rtype, reqtype, sourc=
e);
		...
	}
	srcu_read_unlock(&hdev->bpf.srcu, idx);
}

Those sleepable callbacks are permitted to call the kfuncs
hid_bpf_hw_request() and hid_bpf_hw_output_report() (as done in
tools/testing/selftests/hid/progs/hid.c). With prog_list_lock taken inside
those kfuncs, a task running in dispatch_hid_bpf_raw_requests() or
dispatch_hid_bpf_output_report() will lock srcu -> prog_list_lock, while a
concurrent hid_bpf_reg() or hid_bpf_unreg() locks prog_list_lock -> srcu,
causing an ABBA deadlock.

Additionally, because prog_list_lock is held across
hid_ops->hid_hw_raw_request() and hid_ops->hid_hw_output_report(), which in=
voke
dispatch_hid_bpf_raw_requests() and dispatch_hid_bpf_output_report() on the
same task, if an attached sleepable struct_ops program allocates a fresh
context via hid_bpf_allocate_context() (where from_bpf is false) and calls
hid_bpf_hw_request() or hid_bpf_hw_output_report() on the same device, the =
task
will attempt to acquire prog_list_lock a second time and self-deadlock.

[ ... ]

> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index c90b68956cb3b..4c433f419c85e 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -201,6 +201,11 @@ static int hid_bpf_reg(void *kdata, struct bpf_link =
*link)
> =20
>  	mutex_lock(&hdev->bpf.prog_list_lock);
> =20
> +	if (READ_ONCE(hdev->bpf.destroyed)) {
> +		err =3D -ENODEV;
> +		goto out_unlock;
> +	}

[Severity: Critical]
Does jumping to out_unlock on error in hid_bpf_reg() leave a dangling point=
er
in ops->hdev after hid_put_device(hdev) is called?

In drivers/hid/bpf/hid_bpf_struct_ops.c, hid_bpf_reg() assigns ops->hdev =
=3D hdev
before acquiring prog_list_lock, and the error path under out_unlock drops =
the
hdev reference without clearing ops->hdev:

drivers/hid/bpf/hid_bpf_struct_ops.c:hid_bpf_reg() {
	hdev =3D hid_get_device(ops->hid_id);
	if (IS_ERR(hdev))
		return PTR_ERR(hdev);

	ops->hdev =3D hdev;

	mutex_lock(&hdev->bpf.prog_list_lock);

	if (READ_ONCE(hdev->bpf.destroyed)) {
		err =3D -ENODEV;
		goto out_unlock;
	}
	...
out_unlock:
	mutex_unlock(&hdev->bpf.prog_list_lock);

	if (err) {
		if (hdev->bpf.rdesc_ops =3D=3D ops)
			hdev->bpf.rdesc_ops =3D NULL;
		hid_put_device(hdev);
	}
}

When bpf_struct_ops_link_create() fails in st_ops->reg(), the struct_ops ma=
p's
kdata is not reset, so leaving ops->hdev non-NULL causes any subsequent att=
ach
attempt on the map to fail at if (ops->hdev) return -EINVAL.

More importantly, if the map is already attached via an active bpf_link whi=
le
hid_destroy_device(hdev) runs, hid_bpf_destroy_device() calls
__hid_bpf_ops_destroy_device(hdev) (which clears ops->hdev =3D NULL and dro=
ps the
active link's hdev reference) before hid_remove_device(hdev) removes the de=
vice
from hid_bus_type. If a second bpf_struct_ops_link_create() on the same map
races in this window, it passes if (ops->hdev), gets a temporary reference =
via
hid_get_device(), sets ops->hdev =3D hdev, hits the new hdev->bpf.destroyed
check, and drops the temporary reference via hid_put_device(hdev) while lea=
ving
ops->hdev pointing to hdev. Once hid_destroy_device() frees hdev, closing t=
he
first bpf_link calls hid_bpf_unreg(), which sees ops->hdev !=3D NULL and
dereferences the freed hdev.

Should ops->hdev be cleared in the if (err) block (or assigned only after t=
he
error checks succeed)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179362071770.29269.=
16022650793604369465@stu.pku.edu.cn?part=3D2
