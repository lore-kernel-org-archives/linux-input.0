Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34383F20E3
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575269; cv=none; b=Q7RX/VHwpUbRlvKSacX1k9zGu6HyUFB6MR171ix8SaPMyWKkl7+FJsSOi/LBRujzCRjVE9q2+0J/vGOlLPGtQYTIz8MNaGMQyQJOiX/qc5fOpphxRq6uvnL6rMc4fiCKBvh/DKTG+4DrmuZ3xhkDfU8sf8Yc7MX7qYimABmOOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575269; c=relaxed/simple;
	bh=ocb/RSEu3n02X3m/nyelbhk9/Unrt21buq3kWXXNYjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWEihCQZfBucJ5aSW0UtpZlfJw+24OvQndIZUAyOA1cuX2nENUuHUQ7HJEv1H4qRRALG1+yEN/mg9hrI9xUTb5qimQMG78wWSclD8T3bxUWSuaSuQMS+uqCrQdvbbU7EyGbICPnmaKwLMniqk+dWdh4ieNZPERZREzQk/HxSF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEYYwQwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEYYwQwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10B71F000E9;
	Mon, 24 Aug 2026 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575268;
	bh=Ugg6mrs0BiakSQr0OR1p4lS1zZl+89bP/R4UAsctQ3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OEYYwQwdQFBdzbi4xsy1cPfaQ+cZWNWX/8Kpb1Up+ru/JgLPCjVOjnUpgl5jaQbRn
	 ZrJ53edZhBmgFBvEUv9v6VAEBqMtRdSXg/p4yZnLCJJEBoaj/aAVhLprOaPDaj1RIE
	 LdimksejRS88M3TPt3nT7WEzLMxty6URkOb6sX55cuQ9ivPC6pu4Y/4NjT4ol7fCJE
	 /vKuaYTnNnG0idVj2KDE0S5xWwq9i52R28DQlkuDGAMDcY6SdR0ULeVFpXkP3wZBu+
	 A48zvcVc9Psikzh4qbmMyP2Fh4KNdq2Red3tq4ffGYECZHcWuLIFVKqPS3mYCTcszr
	 ajzUjDC/6MlmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - remove the F34 sysfs group when
 probe fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824122751.76415-1-98lawweijie@gmail.com>
References: <20260824122751.76415-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:41:07 +0000
Message-Id: <20260824124107.F10B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The non-devm managed IRQ domain allocated in rmi_probe_interrupts(=
) is permanently leaked on probe error paths and repeatedly during firmware=
 updates, leading to a Use-After-Free.
- [High] Missing mutual exclusion in the sysfs interface allows concurrent =
firmware updates to trigger kernel panics via list corruption and double-fr=
ees.
- [High] Modifying input->name with a devm-allocated string for a transport=
-provided input device causes a Use-After-Free.
- [Medium] TOCTOU race between rmi_set_attn_data and rmi_disable_irq leads =
to a memory leak in attn_fifo.
--

--- Patch [1]: [PATCH] Input: synaptics-rmi4 - remove the F34 sysfs group w=
hen probe fails ---
commit 8215764a60df6f91a5ee0d3e6244015a81ede7e2
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails

This patch adds an error path to drop the F34 sysfs group if probe fails
after it is created, preventing a null pointer dereference on the
attribute's show handler. It also fixes a leak by ensuring
rmi_free_function_list() is called when rmi_f34_create_sysfs() fails.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -1255,7 +1255,7 @@ static int rmi_driver_probe(struct device *dev)
> =20
>  	retval =3D rmi_f34_create_sysfs(rmi_dev);
>  	if (retval)
> -		goto err;
> +		goto err_destroy_functions;
> =20
>  	if (data->input) {
>  		rmi_driver_set_input_name(rmi_dev, data->input);

[Severity: High]
This is a pre-existing issue, but does assigning a devm-allocated string to
the transport-provided input device cause a use-after-free?

When the transport layer provides an existing input device:

rmi_driver_probe() {
        if (rmi_dev->xport->input) {
                data->input =3D rmi_dev->xport->input;
        }
        ...
}

The device outlives rmi_dev. However, rmi_driver_set_input_name() assigns a
devm-allocated string to input->name:

rmi_driver_set_input_name() {
        name =3D devm_kasprintf(&rmi_dev->dev, ...);
        input->name =3D name;
}

If probe fails or the driver unbinds, the devm string is freed while the
input device is still alive, leaving a dangling pointer for userspace reade=
rs.

[ ... ]

>  err_disable_irq:
>  	rmi_disable_irq(rmi_dev, false);

[Severity: Medium]
This isn't a bug introduced by this patch, but is there a race condition
between rmi_disable_irq() and rmi_set_attn_data() that could leak memory?

In rmi_set_attn_data(), there is a lockless check of drvdata->enabled:

rmi_set_attn_data() {
        if (!drvdata->enabled)
                return;
        fifo_data =3D kmemdup(data, size, GFP_ATOMIC);
        ...
}

Meanwhile, rmi_disable_irq() sets enabled to false and drains the FIFO
under a mutex:

rmi_disable_irq() {
        while (!kfifo_is_empty(&data->attn_fifo)) {
                count =3D kfifo_get(&data->attn_fifo, &attn_data);
                if (count)
                        kfree(attn_data.data);
        }
}

Could a concurrent enqueue from a hardware interrupt occur right after the
drain, permanently leaking the dynamically allocated attn_data elements?

> +err_remove_sysfs:
> +	rmi_f34_remove_sysfs(rmi_dev);
>  err_destroy_functions:
>  	rmi_free_function_list(rmi_dev);

[Severity: High]
This is a pre-existing issue, but does calling rmi_free_function_list()
lack necessary serialization during firmware updates?

The sysfs store handler rmi_driver_update_fw_store() calls
rmi_firmware_update() directly without acquiring any driver-level lock.
When that update calls rmi_free_function_list(), it tears down the function
list locklessly:

rmi_free_function_list() {
        list_for_each_entry_safe_reverse(fn, tmp,
                                         &data->function_list, node) {
                list_del(&fn->node);
                rmi_unregister_function(fn);
        }
}

Could concurrent writes to the update_fw sysfs attribute trigger list
corruption or double-frees since sysfs store callbacks do not serialize
concurrent execution?

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
the IRQ domain allocated earlier?

In rmi_probe_interrupts(), the IRQ domain is created without devres managem=
ent:

rmi_probe_interrupts() {
        data->irqdomain =3D irq_domain_create_linear(fwnode, irq_count,
                                                   &irq_domain_simple_ops, =
data);
}

However, these error paths do not call irq_domain_remove(). Also, since
rmi_firmware_update() re-probes interrupts, does it allocate a new IRQ doma=
in
without freeing the previous one, potentially leading to a use-after-free
when the devm-allocated data pointer is freed?

>  err:
>  	return retval;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122751.7641=
5-1-98lawweijie@gmail.com?part=3D1
