Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FB3D669C;
	Fri, 17 Jul 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274145; cv=none; b=QKOMkMPYYPBnW09hzHUmRgp6Fz/hzCNxJEjEKUxxfDNJno2smRtK3yI+vsHPjC+/zpLCfGgxUMh8tH2ECPm99sNEGtQDGW3mGt9j7gE3BW4Zb9GwwImYsn2CqNLChTPa8zX02sHnFws54yqvcHeqvux9mCB+kp/STj1p8q+tVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274145; c=relaxed/simple;
	bh=SeGa6h3elsa2u/ae1KM0J4qwZhjss9PEPUa9CtRTt4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SbGk0K07dyFoyvAzcmPFZD0NjbmfE2cyxNPVCrNfmzqiJCCKh55az3DrhhzTfZqQwdko5sKhVDFh/z3XuDbhjFVcdDbEiw2RjcPqK7zLDfj8YXB506Y6uS6W9WnmN2VbrJgUry4/g79wEB/l+15isBFFOJiFAAdwFuhuNUMt2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j50c4n0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j50c4n0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698821F000E9;
	Fri, 17 Jul 2026 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784274132;
	bh=WpqKZ4yodzh1XCqXtDL11sldJN/E+dMTk/MCscuwknE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j50c4n0pcGF1aYUcW9fopK3RviiObjDRfgVyP6VvD9j8mGwzEi9LIrLR+hEj+waQp
	 +tLEgSAlYOlXI6H5+iT+NiKgvhxqDijx3Lkcpeoyfel2X9r8HVmCSdSckW8LNyWzd2
	 H6uaJPRaZpn80/6cykSPkKe3xA8+J2jsaxf0KrRw6hJSTD3xYclyQvQ6dX85YUZ3Xw
	 Y81hsSHdMiB6WsPYd90cZMlRjC9s8uBFyWWkRMczSo3pBKBvcU9ygHRW5sxb3aP5r0
	 MCf+4ZsMgTnb/aOLcLQcsAVZrcoopNleznyXY3ZldYsFFz72uzLDNQq33nBWNUqztz
	 KzT9lxoCYMVvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] input: misc: Add Qualcomm SPMI PMIC haptics
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260717-qcom-spmi-haptics-v4-3-b0fe0ed30849@oss.qualcomm.com>
References: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
 <20260717-qcom-spmi-haptics-v4-3-b0fe0ed30849@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:42:11 +0000
Message-Id: <20260717074212.698821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing stop logic in the haptics worker causes indefinite playbac=
k and PM reference leak when effect duration expires.
- [Medium] Explicit input_unregister_device() on a devm-managed device viol=
ates input subsystem rules.
- [Medium] Data race on `irq_enabled` causes permanently unbalanced IRQ dis=
able depth on bus errors.
- [Low] Use of undefined macro `kmalloc_obj` causes compilation failure.
--

--- Patch [3]: [PATCH v4 3/3] input: misc: Add Qualcomm SPMI PMIC haptics d=
river ---
commit e63f14da39f2a372d48e418f9fac8b20cd9d0698
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

input: misc: Add Qualcomm SPMI PMIC haptics driver

Adds an initial driver for the Qualcomm PMIH0108 PMIC haptics module.
Supports DIRECT_PLAY and FIFO modes via the input force-feedback framework.

> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/=
qcom-spmi-haptics.c
> new file mode 100644
> index 0000000000000..235f77e0229c5
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c

[ ... ]

> +static int haptics_enqueue_play_req(struct qcom_haptics *h, int effect_i=
d, bool play)
> +{
> +	struct haptics_play_req *req;
> +
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +
> +	/*
> +	 * Coalesce with an already queued request for
> +	 * the same effect instead of appending.
> +	 */
> +	list_for_each_entry(req, &h->play_queue, node) {
> +		if (req->effect_id =3D=3D effect_id) {
> +			req->play =3D play;
> +			return 0;
> +		}
> +	}
> +
> +	req =3D kmalloc_obj(*req, GFP_ATOMIC);
> +	if (!req)
> +		return -ENOMEM;

[Severity: Low]
Does this code compile successfully? I couldn't find kmalloc_obj() defined =
in
the standard kernel headers. Should this use kmalloc() or kzalloc() instead?

> +
> +	req->effect_id =3D effect_id;
> +	req->play =3D play;

[ ... ]

> +static irqreturn_t haptics_fifo_empty_irq(int irq, void *dev_id)
> +{

[ ... ]

> +	/* Refill: write the next chunk */
> +	to_write =3D min_t(u32, h->data_len - h->data_written,
> +			 h->fifo_len - FIFO_EMPTY_THRESH);
> +	ret =3D haptics_write_fifo_chunk(h, &h->fifo_data[h->data_written], to_=
write);
> +	if (ret) {
> +		dev_err(h->dev, "refill FIFO samples failed, ret=3D%d\n", ret);
> +		/*
> +		 * If data refilling is failed,stop the HW play and disable the
> +		 * IRQ to prevent the FIFO empty IRQ being fired continuously.
> +		 */
> +		cfg_write(h, HAP_CFG_SPMI_PLAY_REG, 0);
> +		disable_irq_nosync(h->fifo_empty_irq);
> +		h->irq_enabled =3D false;

[Severity: Medium]
Can a data race occur on h->irq_enabled here?=20

If userspace stops playback concurrently with a bus write failure in
haptics_fifo_empty_irq(), both paths could check and modify h->irq_enabled
without mutual exclusion.

For example, this path:

haptics_fifo_empty_irq()
    disable_irq_nosync(h->fifo_empty_irq);
    h->irq_enabled =3D false;

Could race with:

haptics_stop_locked()
    haptics_fifo_irq_enable(h, false);

This might result in disable_irq() being called twice while enable_irq() is
only called once, leaving the IRQ permanently disabled and breaking future
FIFO playback.

> +		return IRQ_HANDLED;
> +	}
> +
> +	h->data_written +=3D to_write;

[ ... ]

> +static void haptics_play_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h =3D container_of(to_delayed_work(work),
> +					      struct qcom_haptics, play_work);
> +	struct haptics_play_req *req =3D haptics_dequeue_play_req(h);
> +	bool rearmed =3D false;
> +	u32 length_us;
> +	int ret;
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	/* No valid request available */
> +	if (req =3D=3D NULL)
> +		return;

[Severity: High]
When a finite-length effect expires, schedule_delayed_work() wakes up this
worker, but haptics_dequeue_play_req() returns NULL since the queue is
empty.=20

Since we return early here when req is NULL, how does the driver stop the
active effect and release the runtime PM reference? This appears to leave
the device vibrating indefinitely.

> +
> +	if (req->play) {
> +		ret =3D haptics_start_locked(h, req->effect_id);

[ ... ]

> +static void qcom_haptics_remove(struct platform_device *pdev)
> +{
> +	struct qcom_haptics *h =3D platform_get_drvdata(pdev);
> +
> +	/*
> +	 * Unregister the input device explicitly at the beginning
> +	 * to avoid the input device being used after the resources
> +	 * are freed.
> +	 */
> +	input_unregister_device(h->input);

[Severity: Medium]
Is it safe to explicitly unregister this input device here?

The input device is allocated with devm_input_allocate_device() during
probe, which means the input core will automatically handle unregistration
when the provider device is unbound.

Manually calling input_unregister_device() on a devm-managed device can
lead to double-unregistration.

> +	disable_delayed_work_sync(&h->play_work);
> +	scoped_guard(mutex, &h->play_lock) {
> +		haptics_queue_flush(h);
> +		haptics_stop_locked(h, true);
> +	}
> +
> +	haptics_enable_module(h, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-qcom-spmi-=
haptics-v4-0-b0fe0ed30849@oss.qualcomm.com?part=3D3
