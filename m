Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852C1A682A
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664981; cv=none; b=ShkyB5vDfAbwftCuR1m8idUqMAAIiTTYk4ZoB6Vf1LfrCTj0ff7w9lxS7/WRlz17x9W3KBuDgqfAReEmCwV5ZqNYDIxbHD/CZartnYkaNz0g+7kc/un8nOEEHmfMrUYAYvz4tNHHkMhHzSRmwglk3BnkapsCPcUi3HhVVUHSKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664981; c=relaxed/simple;
	bh=6UfHfhuy5BJ+MQtBTSM6GsR3fbPS3n5OLgx8Xd0gDFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZcKAX+uZOE50R+VQG3pvzL62IuQagnxzrIaYGq/i7zvudIcnpVLkWlHTegv+oHrbIQ4QXVUqtbrc4u+OUoLozQJAmIbJGyjoMe4QjsIc52sFFNK77IxgLR16fPmS7Z+FJfgrEFRlf3I3D6Ypfc0m4fjmE2EjgPqpXnTuz8gvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D481F000E9;
	Sun, 28 Jun 2026 16:42:59 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2200: reject short read-all responses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628163035.12212-1-alhouseenyousef@gmail.com>
References: <20260628163035.12212-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:42:59 +0000
Message-Id: <20260628164259.F0D481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronization in `mcp_cmd_read_all` and lockless shared =
state access in `mcp2200_raw_event` lead to race conditions, timeouts, and =
data corruption.
- [High] `mcp_get` silently ignores negative error codes returned by `mcp_g=
et_multiple`, converting hardware or communication errors into a valid 'low=
' state.
- [High] The driver fails to synchronize its internal state cache (`mcp->gp=
io_dir` and `mcp->gpio_val`) with the actual hardware configuration during =
probe.
- [High] Device unbind race condition leading to Use-After-Free due to impr=
oper devm_ teardown order.
- [High] The `hid_report` buffer is embedded directly within `struct mcp220=
0` and passed to DMA mapping functions, violating DMA cache-line alignment =
requirements.
--

commit 3df6b9c6c4d5763dc3316160e66ba44dfef6c606
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: mcp2200: reject short read-all responses

This commit adds a size check for READ_ALL responses in the MCP2200
driver. If the response size is smaller than the expected struct size,
it sets the status to -EMSGSIZE and aborts processing to prevent
out-of-bounds reads.

> diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
> index dafdd5b4a0797..d49f3aa44448e 100644
> --- a/drivers/hid/hid-mcp2200.c
> +++ b/drivers/hid/hid-mcp2200.c
> @@ -302,6 +302,10 @@ static int mcp2200_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>  	switch (data[0]) {
>  	case READ_ALL:
>  		all_resp =3D (struct mcp_read_all_resp *) data;
> +		if (size < sizeof(*all_resp)) {
> +			mcp->status =3D -EMSGSIZE;

[Severity: High]
This is a pre-existing issue, but won't this new -EMSGSIZE error be silently
swallowed by mcp_get()?

Looking at mcp_get(), it calls mcp_get_multiple() which propagates this
negative error code. However, mcp_get() discards the return value:

drivers/hid/hid-mcp2200.c:mcp_get() {
    ...
    mcp_get_multiple(gc, &mask, &bits);
    return bits > 0;
}

Since bits remains uninitialized or zeroed upon error, this converts the
-EMSGSIZE error (or any other communication failure) into a valid logical
low state.

Does this need to be handled so downstream drivers don't receive false
logical states when the device errors out?

> +			break;
> +		}
>  		mcp->status =3D 0;
>  		mcp->gpio_inval =3D all_resp->io_port_val_bmap;

[Severity: High]
This is a pre-existing issue, but does mcp2200_raw_event() update shared
device state locklessly?

mcp_cmd_read_all() orchestrates a transaction but drops mcp->lock before
waiting for a completion, and calls reinit_completion() unprotected:

drivers/hid/hid-mcp2200.c:mcp_cmd_read_all() {
    ...
    reinit_completion(&mcp->wait_in_report);
   =20
    mutex_lock(&mcp->lock);
    ...
    mutex_unlock(&mcp->lock);
   =20
    ...
    t =3D wait_for_completion_timeout(&mcp->wait_in_report, ...);
}

If multiple threads concurrently invoke mcp_cmd_read_all(), or unrelated
hardware reports arrive while waiting, their wait queues and completion
states can collide.

Furthermore, mcp2200_raw_event() updates mcp->status and mcp->gpio_inval
locklessly in interrupt context, and unconditionally completes the wait que=
ue
for any unexpected report.

Should a single lock serialize the entire command-response wait cycle?

[Severity: High]
This is also a pre-existing issue, but why is the io_bmap hardware direction
state provided in READ_ALL responses completely ignored here instead of bei=
ng
saved to mcp->gpio_dir?

In mcp2200_probe(), mcp->gpio_dir defaults to 0 (all outputs) without
querying the initial state. Because io_bmap is ignored here, when
mcp_set_direction() is later called to modify a specific pin, it masks
against the uninitialized local cache:

drivers/hid/hid-mcp2200.c:mcp_set_direction() {
    ...
    conf->io_bmap =3D (mcp->gpio_dir & ~(1 << gpio_nr))
        | (io_direction << gpio_nr);
}

Doesn't this clobber the direction of all other pins, potentially causing
electrical short-circuits by driving input pins as outputs?

>  		mcp->baud_h =3D all_resp->baud_h;

[ ... ]

Additionally, there are a couple of other pre-existing issues in this driver
that might be worth addressing:

[Severity: High]
This is a pre-existing issue, but is there a device unbind race condition
leading to a use-after-free due to the devm_ teardown order?

mcp2200_probe() uses devm_gpiochip_add_data() to register the gpiochip:

drivers/hid/hid-mcp2200.c:mcp2200_probe() {
    ...
    ret =3D devm_gpiochip_add_data(&hdev->dev, &mcp->gc, mcp);
    ...
}

However, mcp2200_remove() calls hid_hw_stop(hdev) synchronously, freeing
underlying URBs:

drivers/hid/hid-mcp2200.c:mcp2200_remove() {
    ...
    hid_hw_stop(hdev);
}

Because devm_ cleanup callbacks run after mcp2200_remove() completes, the
gpiochip remains fully active.

If userspace invokes a GPIO operation during this window, mcp_cmd_read_all()
will call hid_hw_output_report(), triggering a use-after-free on the freed
urbout.=20

Should the driver use manual teardown in remove() instead of devm_?

[Severity: High]
This is a pre-existing issue, but does the hid_report buffer violate DMA
cache-line alignment requirements?

The hid_report buffer is embedded directly within struct mcp2200:

drivers/hid/hid-mcp2200.c:
struct mcp2200 {
    ...
    struct gpio_chip gc;
    u8 hid_report[16];
};

This buffer is placed at the end of the struct without a
____cacheline_aligned attribute.

When hid_hw_output_report() is called, the USB HID layer receives this
buffer and maps it for DMA. On non-coherent architectures, mapping a buffer
that shares cache lines with other actively modified struct members (like gc
or status) can cause cache invalidation or flush operations to overwrite
concurrent CPU writes.=20

Could this buffer be allocated independently or aligned to the cacheline si=
ze?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628163035.1221=
2-1-alhouseenyousef@gmail.com?part=3D1
