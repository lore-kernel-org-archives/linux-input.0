Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621751;
	b=oNo8DlOrpUguPTYW26RyMpb+0aHu2hb0N2NbqhiKXE9hvVB+jE368GlJt4/3rgjqkTBT
	 CY7NHKqZValEEZS/Bdc/PdmrrUpuax0BqR9gR6PTmTzUJ16wr9RcCLnjwczg2B8gHnBjU
	 4qrnzFeVld5x26JQfNIPQ9+LQxYHqAE2EMFPP/WAB+0T+MN4BX9DxDC0WfG0fPjcryl/w
	 X649GR6/3bgzcJ6vW9QdUkyOGaIMlT1dDUw499QhIZyaNcaM0RBj2A15tVYiVPjJPPFel
	 Uao01E7FuxvKa6oMY1+vzihoZ3UypUaNAILwnNiB0Akx9nAUghdR7DZXIlqqMGBz86w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pFChq7RWoPOYXNpRIbOmM3CPFuf/lb1BveblQyxDSPI=;
	b=TRQBB8bezClcSzyF4CK0mQe43k8yjeK0uZcPY4q3adCvtzxWqWBI0uD41roqoc5RZljo
	 UHfKa8wVvRlWlcp5ThrKaCAoZ/JxF4MX0aqHZC4inWVzEIDVJOSvUFyWD0WF4WI08+cTb
	 W0zBr0ydVmkr4Ci6iBMw9KXPRqSPcYcjTWiRtAOQqhBQjMVCiwRTudo2MafHK2NvkcYyv
	 Mg7JqaJ9j+3vyzGR+sAbsPuxj1CXwmnY3gmJluGfBwizSTI1l/xW2XjAUYITKyTvE0wNT
	 tz6XSHvWxIkT26j6u7s0pITtfoad2AXAkvplPDyh4xnGApeNiTfdNtdDLD4mb3XxpTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbPQIdpe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEA60A381D;
	Mon,  2 Nov 2026 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbPQIdpe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C0C1F0157D;
	Mon,  2 Nov 2026 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621750;
	bh=pFChq7RWoPOYXNpRIbOmM3CPFuf/lb1BveblQyxDSPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbPQIdpe/7N/9bSUxnF6NcBoPX8UUoIjM/Jbfx6xbwvEcSbIN+ym6eRvPHioWxZ2X
	 MdLfBtr+f3plu2NVXss1QzKlJ6bRdwQ3NQSEVCOVslMtAloz08paUNwBCac6JjlZUC
	 t/23JLiBVUZfYAGk/mP42uSOLRUFofLGjRtOwjlEUs5/WSFIvz5bx/CnwRXrsIunHp
	 Trayr0c6g+4Fy8UCRGZvJgbG+kwtV29f9u6A2lmaWn3BeSUcyZO3Hp38MlQPRV++3F
	 9Xe1CmmHQzKsMoKJ8BacbhCjvzK4t8z/VR3TuGy6GImdKAZJU8OJcSQrP2VddtZt4D
	 F8vSeFx17hKiA==
Message-ID: <sashiko-outbox-193383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: bpf: serialize hardware operations with device
 destruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, linux-input@vger.kernel.org
Cc: bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <179362071770.29269.481376767482231629@stu.pku.edu.cn>
References: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
 <179362071770.29269.481376767482231629@stu.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:15:50 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] HID: bpf: report UAF in __hid_bpf_hw_check_params() during dev=
ice teardown
- [High] HID: bpf: ABBA deadlock between prog_list_lock and srcu in hw requ=
est kfuncs
- [High] HID: bpf: recursive prog_list_lock deadlock in hid_bpf_hw_request()
- [High] HID: bpf: lock inversion between prog_list_lock and driver_input_l=
ock
--

commit 49a737ce63da80cb915d4530a8a28ce52af759cc
Author: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

HID: bpf: serialize hardware operations with device destruction

This commit serializes HID-BPF hardware requests and output reports with
device destruction by holding prog_list_lock and checking the destroyed
flag across low-level driver calls in hid_bpf_hw_request() and
hid_bpf_hw_output_report().

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

[Severity: High]
Can acquiring ctx->hid->bpf.prog_list_lock here in hid_bpf_hw_request()
(and below in hid_bpf_hw_output_report()) in
drivers/hid/bpf/hid_bpf_dispatch.c cause an ABBA deadlock with
hdev->bpf.srcu?

In drivers/hid/bpf/hid_bpf_struct_ops.c, both hid_bpf_reg() and
hid_bpf_unreg() hold prog_list_lock while waiting on synchronize_srcu():

drivers/hid/bpf/hid_bpf_struct_ops.c:hid_bpf_unreg() {
	...
	mutex_lock(&hdev->bpf.prog_list_lock);
	...
	list_del_rcu(&ops->list);
	synchronize_srcu(&hdev->bpf.srcu);
	...
	mutex_unlock(&hdev->bpf.prog_list_lock);
}

When hid_bpf_hw_request() or hid_bpf_hw_output_report() is invoked from a
syscall BPF program, it also takes prog_list_lock and then calls
__hid_hw_raw_request() or __hid_hw_output_report(), which enters
dispatch_hid_bpf_raw_requests() or dispatch_hid_bpf_output_report() and
takes srcu_read_lock(&hdev->bpf.srcu). Both paths establish the lock order
prog_list_lock -> hdev->bpf.srcu.

However, hid_bpf_hw_request() and hid_bpf_hw_output_report() are also
registered in hid_bpf_kfunc_ids for BPF_PROG_TYPE_STRUCT_OPS, so sleepable
struct_ops callbacks (e->hid_hw_request and e->hid_hw_output_report) can
call them directly. When a non-BPF caller such as hidraw invokes
__hid_hw_raw_request(..., from_bpf=3Dfalse) or
__hid_hw_output_report(..., from_bpf=3Dfalse),
dispatch_hid_bpf_raw_requests() or dispatch_hid_bpf_output_report() holds
srcu_read_lock(&hdev->bpf.srcu) across the callback:

drivers/hid/bpf/hid_bpf_dispatch.c:dispatch_hid_bpf_raw_requests() {
	...
	idx =3D srcu_read_lock(&hdev->bpf.srcu);
	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
				 srcu_read_lock_held(&hdev->bpf.srcu)) {
		if (!e->hid_hw_request)
			continue;

		ret =3D e->hid_hw_request(&ctx_kern.ctx, reportnum, rtype, reqtype, sourc=
e);
		if (ret)
			goto out;
	}
	ret =3D 0;

out:
	srcu_read_unlock(&hdev->bpf.srcu, idx);
	return ret;
}

When that struct_ops callback calls hid_bpf_hw_request() or
hid_bpf_hw_output_report(), it acquires prog_list_lock while holding
srcu_read_lock(&hdev->bpf.srcu), inverting the lock order to
hdev->bpf.srcu -> prog_list_lock and deadlocking if another thread is in
hid_bpf_reg() or hid_bpf_unreg().

[Severity: High]
Could holding ctx->hid->bpf.prog_list_lock across
hid_ops->hid_hw_raw_request() in hid_bpf_hw_request() (and across
hid_ops->hid_hw_output_report() in hid_bpf_hw_output_report()) also lead
to a recursive mutex self-deadlock on the same task?

When hid_ops->hid_hw_raw_request(..., true) or
hid_ops->hid_hw_output_report(..., true) runs with prog_list_lock held,
__hid_hw_raw_request() and __hid_hw_output_report() still invoke
dispatch_hid_bpf_raw_requests() and dispatch_hid_bpf_output_report(),
which call any attached sleepable struct_ops e->hid_hw_request or
e->hid_hw_output_report programs on that hid_device.

The recursion check at the start of hid_bpf_hw_request() and
hid_bpf_hw_output_report() only inspects ctx_kern->from_bpf on the passed
context:

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_hw_request() {
	ctx_kern =3D container_of(ctx, struct hid_bpf_ctx_kern, ctx);

	if (ctx_kern->from_bpf)
		return -EDEADLOCK;
	...
}

Because hid_bpf_allocate_context() is exposed in hid_bpf_kfunc_ids to
sleepable struct_ops programs and returns a fresh context with
from_bpf =3D=3D false, wouldn't a struct_ops program that calls
hid_bpf_allocate_context(hctx->hid->id) and passes the new context to
hid_bpf_hw_request() or hid_bpf_hw_output_report() bypass the
ctx_kern->from_bpf check and try to lock ctx->hid->bpf.prog_list_lock a
second time?

[Severity: High]
Does holding ctx->hid->bpf.prog_list_lock across
hid_ops->hid_hw_raw_request() and hid_ops->hid_hw_output_report() in
drivers/hid/bpf/hid_bpf_dispatch.c introduce a lock inversion with
hdev->driver_input_lock?

In drivers/hid/hid-core.c, hid_device_probe() and hid_device_remove()
acquire hdev->driver_input_lock before calling __hid_device_probe() (which
runs call_hid_bpf_rdesc_fixup() and hdrv->probe()) and hdrv->remove(). If
a sleepable struct_ops callback (such as hid_rdesc_fixup, hid_hw_request,
or hid_hw_output_report) invoked under driver_input_lock calls
hid_bpf_hw_request() or hid_bpf_hw_output_report(), it acquires
prog_list_lock while holding driver_input_lock
(driver_input_lock -> prog_list_lock).

Conversely, while hid_bpf_hw_request() or hid_bpf_hw_output_report() holds
prog_list_lock across hid_ops->hid_hw_raw_request() or
hid_ops->hid_hw_output_report(), an attached sleepable struct_ops callback
e->hid_hw_request or e->hid_hw_output_report can call
hid_bpf_input_report(), which is exposed in hid_bpf_kfunc_ids and acquires
driver_input_lock before checking ctx_kern->from_bpf:

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_input_report() {
	...
	ret =3D down_interruptible(&ctx->hid->driver_input_lock);
	if (ret)
		return ret;
	...
}

Wouldn't that establish the reverse ordering
prog_list_lock -> driver_input_lock?

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
> =20
>  	kfree(dma_data);
>  	return ret;
> @@ -641,8 +653,10 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
>  	if (!hdev)
>  		return;
> =20
> -	/* mark the device as destroyed in bpf so we don't reattach it */
> -	hdev->bpf.destroyed =3D true;
> +	/* Block new BPF hardware operations before transport teardown. */
> +	mutex_lock(&hdev->bpf.prog_list_lock);
> +	WRITE_ONCE(hdev->bpf.destroyed, true);
> +	mutex_unlock(&hdev->bpf.prog_list_lock);

[Severity: Critical]
Is checking ctx->hid->bpf.destroyed after __hid_bpf_hw_check_params() in
hid_bpf_hw_request() and hid_bpf_hw_output_report() sufficient to prevent
a use-after-free on struct hid_report during device teardown?

In drivers/hid/bpf/hid_bpf_dispatch.c, both hid_bpf_hw_request() and
hid_bpf_hw_output_report() call __hid_bpf_hw_check_params() before
acquiring ctx->hid->bpf.prog_list_lock and before checking
ctx->hid->bpf.destroyed:

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_hw_request() {
	...
	/* check arguments */
	ret =3D __hid_bpf_hw_check_params(ctx, buf, &size, rtype, true);
	if (ret)
		return ret;
	...
	mutex_lock(&ctx->hid->bpf.prog_list_lock);
	if (READ_ONCE(ctx->hid->bpf.destroyed)) {
	...
}

__hid_bpf_hw_check_params() looks up and dereferences struct hid_report
from ctx->hid->report_enum:

drivers/hid/bpf/hid_bpf_dispatch.c:__hid_bpf_hw_check_params() {
	...
	report_enum =3D ctx->hid->report_enum + rtype;
	report =3D hid_ops->hid_get_report(report_enum, buf);
	if (!report)
		return -EINVAL;

	report_len =3D hid_report_len(report);
	...
}

During hid_destroy_device() in drivers/hid/hid-core.c,
hid_bpf_destroy_device() sets hdev->bpf.destroyed =3D true and unlocks
prog_list_lock, and then hid_remove_device() -> device_del() ->
hid_device_remove() -> hid_close_report() frees each report in
report_enum->report_id_hash[] before zeroing report_enum:

drivers/hid/hid-core.c:hid_close_report() {
	...
	for (i =3D 0; i < HID_REPORT_TYPES; i++) {
		struct hid_report_enum *report_enum =3D device->report_enum + i;

		for (j =3D 0; j < HID_MAX_IDS; j++) {
			struct hid_report *report =3D report_enum->report_id_hash[j];
			if (report)
				hid_free_report(report);
		}
		memset(report_enum, 0, sizeof(*report_enum));
	}
}

Because a syscall BPF context allocated by hid_bpf_allocate_context()
only pins struct hid_device via get_device(&hdev->dev), can a concurrent
call to hid_bpf_hw_request() or hid_bpf_hw_output_report() race with
hid_close_report() inside __hid_bpf_hw_check_params() and dereference a
freed struct hid_report before reaching the prog_list_lock and destroyed
check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179362071770.29269.=
16022650793604369465@stu.pku.edu.cn?part=3D1
