Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8E4FD78E;
	Fri, 18 Sep 2026 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738890; cv=none; b=ZskSem7Ct5hLTZ5ENRyiwSKzByJu6noIzEtHCrLsEs5Fl2NtdDSeg1RqwXyUH9GKaRr4C3LTSMhCFUEEEoXgx/DOUgrxygxX9uvyA3l0n+HD5pvaP6YTnRDcM76k4E4yQB0AlzqiuEztHexO/9enjhJfyH/xiPUb2cAa1BajGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738890; c=relaxed/simple;
	bh=dloLV4HYCCPaOV+L/OTMKNKQnETvSaPTpEonVO7Olnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SnNBfqbBftxJUgyYBPFskNgaxj/iGplHJ57dlVEmFgCyDnY8crqMPgnOATiiBlFR77cdXmu6S+XqbfGkHpPHfRguTpv355qydrvyKcaMCiwb60mwhT19GgbWBZTznS3qkBMDv89hEkG0yCVoJhyxTmBrZNKZ9Mnbf1yjojntb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxO1VRkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxO1VRkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9621F000FF;
	Fri, 18 Sep 2026 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789738888;
	bh=HtWjXaiApjcacubTg0mWVUajzAgJSFSfnPWkggT6wDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxO1VRkvsSYBHPuCPRCIASF00lkJiX9gtCAXvU4wH/vhMHu9ucriuiwwwDUjf3t8o
	 10Pntdq8lXpQK+oSPi3t53btk5lKfnuJjXjpOssUUXdUQhl7qXV7ETmw3NDHndPDRY
	 BtkQCZTirULN1txga/ThB9O3KvdCQr30Lq2bdQeZTjqGCwFwJFg1uiz2Fe+b902H9a
	 /JY6zY2mEwF7brPj261Za5STuBggZfSaCN8UDwXkKul7MhoghUm0wunhn5easM5+kX
	 q0iVKenpGC8oeMuqDss47hECZUMKwyYuKoGopa9aUxQCmqYRv/bf3gXr7Zwxoh1hgL
	 feJRmwu/4bhLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] HID: apple: Add DockChannel HID transport
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260918-apple-mtp-keyboard-final-v3-8-e356464e454b@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
 <20260918-apple-mtp-keyboard-final-v3-8-e356464e454b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:41:28 +0000
Message-Id: <20260918134128.5C9621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] hid: use-after-free in dchid_cmd() if unbound with pending commands
- [Medium] hid: out-of-bounds read due to using hid_input_report() instead =
of hid_safe_input_report()
- [Medium] hid: concurrent command submissions trigger WARN_ON and fail wit=
h -EBUSY
- [Medium] hid: race condition between internal STM requests and userspace =
in dchid_handle_ready()
--

commit 9430d372e505704cf501df7e6ffaa4952a5855aa
Author: Michael Reeves <michael.reeves077@gmail.com>

HID: apple: Add DockChannel HID transport driver

This commit adds a new HID transport driver for Apple DockChannel. It boots
the MTP RTKit coprocessor, exchanges HID packets through the DockChannel
mailbox, and registers child HID interfaces from devicetree.

> diff --git a/drivers/hid/dockchannel/apple-hid.c b/drivers/hid/dockchanne=
l/apple-hid.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/dockchannel/apple-hid.c
[ ... ]
> +static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
> +		     void *data, size_t size, void *resp_buf, size_t resp_size)
> +{
> +	unsigned long flags;
> +	int ret;
> +	int report_id;
> +	bool timed_out =3D false;
> +	u32 out_flags;
> +
> +	if (size < 1)
> +		return -EINVAL;
> +
> +	report_id =3D *(u8 *)data;
> +	out_flags =3D FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req=
);
> +
> +	spin_lock_irqsave(&iface->out_lock, flags);
> +
> +	/* Only one command can be in flight per interface */
> +	if (WARN_ON(iface->out_report !=3D -1)) {
> +		spin_unlock_irqrestore(&iface->out_lock, flags);
> +		return -EBUSY;
> +	}

[Severity: Medium]
Can this warning be triggered by unprivileged userspace or during normal
initialization?

The dchid_cmd() function rejects concurrent commands with a kernel warning
and returns an error. Since the HID core does not serialize raw_request
ioctls, concurrent ioctls on the hidraw node can trigger this.

Additionally, dchid_open() invokes dchid_start_interface() which calls
dchid_comm_cmd() on the shared "comm" interface. If multiple child devices
are opened concurrently, they might race on the shared interface and hit
this warning. Could the driver wait for the interface to become free or
queue the commands instead of returning an error?

> +
> +	iface->out_report =3D report_id;
> +	iface->out_flags =3D out_flags;
> +	iface->retcode =3D 0;
> +	iface->resp_buf =3D resp_buf;
> +	iface->resp_size =3D resp_size;
> +	reinit_completion(&iface->out_complete);
> +
> +	spin_unlock_irqrestore(&iface->out_lock, flags);
> +
> +	ret =3D dchid_send(iface, out_flags, data, size);
> +	if (ret < 0) {
> +		spin_lock_irqsave(&iface->out_lock, flags);
> +		iface->out_report =3D -1;
> +		iface->resp_buf =3D NULL;
> +		iface->resp_size =3D 0;
> +		spin_unlock_irqrestore(&iface->out_lock, flags);
> +		return ret;
> +	}
> +
> +	if (!wait_for_completion_timeout(&iface->out_complete,
> +					 msecs_to_jiffies(COMMAND_TIMEOUT_MS))) {
> +		dev_err(iface->dchid->dev, "command 0x%x to iface %d (%s) timed out\n",
> +			report_id, iface->index, iface->name);
> +		timed_out =3D true;
> +	}
> +
> +	spin_lock_irqsave(&iface->out_lock, flags);

[Severity: High]
Is there a use-after-free risk here if the driver is unbound while commands
are pending?

A thread blocking in wait_for_completion_timeout() could wake up after
dchid_remove() returns. The dchid_shutdown() function stops the hardware
and destroys the HID devices, but does not abort or wait for pending
commands. After the remove callback returns, devres frees the iface
structure. When the blocked thread times out, it would access freed memory
at spin_lock_irqsave(&iface->out_lock, flags).

[ ... ]
> +static void dchid_handle_ready(struct dchid_dev *dchid, void *data, size=
_t length)
> +{
[ ... ]
> +	iface =3D dchid->ifaces[index];
> +	if (!iface)
> +		return;
> +
> +	dev_dbg(dchid->dev, "interface %s is now ready\n", iface->name);
> +	complete_all(&iface->ready);
> +
> +	/* When STM is ready, grab global device info */
> +	if (!strcmp(iface->name, "stm")) {
> +		ret =3D dchid_get_report_cmd(iface, STM_REPORT_ID, &dchid->device_id,

[Severity: Medium]
Does signaling the completion before internal requests are sent create a
race condition with userspace?

By calling complete_all(&iface->ready) before fetching the STM report ID,
any thread waiting in dchid_open() is woken up. A userspace process could
then immediately issue a synchronous HID request, entering dchid_cmd()
concurrently while dchid_handle_ready() is issuing its own internal STM
request via dchid_get_report_cmd(). This would trigger the lock check
warning in dchid_cmd() and fail with an error.

Should the completion be signaled only after internal requests are
finished?

[ ... ]
> +static void dchid_handle_report(struct dchid_iface *iface, void *data, s=
ize_t length)
> +{
> +	if (!iface->hid || !iface->open)
> +		return;
> +
> +	hid_input_report(iface->hid, HID_INPUT_REPORT, data, length, 1);

[Severity: Medium]
Does this allow an out-of-bounds read in the HID core?

The raw data is passed to hid_input_report() without specifying its
allocated bounds. If the device sends a maliciously truncated packet but
declares a large report size in its descriptor, the core could read past
the allocated bounds of the buffer.

Should this use hid_safe_input_report() to enforce explicit boundary checks
based on the allocated buffer size?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-apple-mtp-=
keyboard-final-v3-0-e356464e454b@gmail.com?part=3D8
