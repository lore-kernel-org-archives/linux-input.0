Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5924E322F;
	Fri, 18 Sep 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730343; cv=none; b=t9gHlfxtLWRNmDCntfumNDVlmEFm+h0IwsOguDmtMXhZ6jRs+nJkznqY2pe8ejxV1vNv/2PBw75LQCWawr+s1QxV4Hlx4mJxms5/HdEVIfm3NgFjxG8JRK1tYqAX6cH3c/VXjcUtpU/OJVdss+6Q5RtKBrGRsiwXgtePbWW3zrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730343; c=relaxed/simple;
	bh=7gbWzQXgCMJs5YwFlU1fSUDtVnl8+K7Iff3lYowshww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZgUIzArzshqzXtnPOJEbzr1E2Yn3wR++Qbs7W0zOc78yPUv3lCTKME9d8gHzJ8GxHxVp6Hlsxd9j4lsRV+8NTGomYLIEb5BzIoxCdEngGA633vaqIFAjxODnD0S/ZbqEP5fKs35Ds0QfzT09UYRzMGDzeKiZntur2BVZpegKvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr1sDXlA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr1sDXlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578581F000FF;
	Fri, 18 Sep 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789730341;
	bh=kGay+fdFL7tSL3oJruEjgG6EB6hAd6LczuwH+icBrZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kr1sDXlAdautLbwIN4YaeLOp64EMInJZpXv7nWwy0k9ZFYeNI7ZMbkExy+xcouiI3
	 4sE//l4bynwvH/Spj0WZPLJwuPddtW8B/bkwI4MgnUX50LDqyL0zFoiz+BbiAeQfLk
	 Zvg6CP5sgJjbiosi0TWd6k7tsbgcLnCwkpvQq31IeJaVY3jTskbkAJgw36nIUpz5EE
	 b+kDHZE+WtQ1DqK8CThT0ZmM1p6ByrFOSzCgpt4cwb+QvZKxPJIY3+wgcF4FjvcTBh
	 tOO4YHNJ/rftNBVaQONqoOoFP6C+QY53EDMHXywuUCUtRE1ZMU0XeqXINU90cOwDUW
	 9aJL1wkW/q6cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] HID: apple: Add DockChannel HID transport
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918-apple-mtp-keyboard-final-v2-8-a5c685e50b60@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
 <20260918-apple-mtp-keyboard-final-v2-8-a5c685e50b60@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 11:19:00 +0000
Message-Id: <20260918111901.578581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] hid: out-of-bounds read due to unsafe hid_input_report()
- [High] soc: apple: leaked running ASC coprocessor on probe failure
- [High] hid: out-of-bounds read in userspace via oversized raw_request ret=
urn
- [High] hid: UAF due to dynamic HID device registration on probe failure
- [High] hid: data race and potential uninitialized memory access in interf=
ace array
- [Medium] hid: memory leak of report descriptor on multiple INIT events
- [Medium] hid: incorrect return value in raw_request for SET_REPORT
- [Low] hid: missing null termination for serial string updates
- [Low] hid: checksum stored in host endianness breaking big-endian systems
--

commit d188bf6bf7d855a9c26413ca6bc664695872df14
Author: Michael Reeves <michael.reeves077@gmail.com>

    HID: apple: Add DockChannel HID transport driver

This commit adds a HID transport layer over the Apple DockChannel mailbox
interface. It enables support for the internal keyboard and trackpad on
Apple M2 and later MacBook models by exchanging HID packets with the
RTKit coprocessor.

> diff --git a/drivers/hid/dockchannel/apple-hid.c b/drivers/hid/dockchanne=
l/apple-hid.c
> --- /dev/null
> +++ b/drivers/hid/dockchannel/apple-hid.c
[ ... ]
> +static struct dchid_iface *
> +dchid_get_interface(struct dchid_dev *dchid, int index, const char *name)
> +{
[ ... ]
> +	iface->fwnode =3D fwnode;
> +	ret =3D devm_add_action_or_reset(dchid->dev, dchid_fwnode_release,
> +				       iface->fwnode);
> +	if (ret)
> +		goto err_unlock;
> +
> +	dchid->ifaces[index] =3D iface;
> +	mutex_unlock(&dchid->ifaces_lock);
> +	return iface;

[Severity: High]
Does this code have a data race?

In dchid_get_interface(), dchid->ifaces[index] is published locklessly with
respect to the interrupt handler using a simple assignment. Since there is =
no
write memory barrier here, and no read memory barrier in dchid_process_pack=
et()
where the pointer is loaded, could weakly-ordered architectures observe a
non-NULL pointer but read stale or uninitialized values for the struct's
contents (such as work->iface->wq)?

> +
> +err_put_fwnode:
> +	fwnode_handle_put(fwnode);
> +err_unlock:
> +	mutex_unlock(&dchid->ifaces_lock);
> +	return NULL;
> +}
> +
> +static int dchid_send(struct dchid_iface *iface, u32 flags, const void *=
msg,
> +		      size_t size)
> +{
[ ... ]
> +	memcpy(buf + sizeof(*hdr) + sizeof(*sub), msg, size);
> +
> +	*checksum_ptr =3D 0xffffffff - dchid_checksum(buf, total_len - DCHID_CH=
ECKSUM_LEN);

[Severity: Low]
Does this write the checksum in host endianness?

The assignment through a u32* pointer writes the computed checksum in host
endianness. Could this break compatibility and cause the hardware to reject
packets on big-endian systems?

> +
> +	dc_msg.data =3D buf;
> +	dc_msg.len =3D total_len;
> +	ret =3D mbox_send_message(dchid->dc_mbox, &dc_msg);
> +	kfree(buf);
> +
> +	return ret < 0 ? ret : 0;
> +}
[ ... ]
> +static int dchid_set_report(struct dchid_iface *iface, void *buf, size_t=
 len)
> +{
> +	return dchid_cmd(iface, HID_OUTPUT_REPORT, REQ_SET_REPORT, buf, len,
> +			 NULL, 0);
> +}

[Severity: Medium]
Does this return an incorrect value for SET_REPORT?

dchid_set_report() returns the value from dchid_cmd(), which is the size
of the acknowledgment packet payload received from the device. However, the
HID raw_request callback contract requires returning the number of bytes
successfully written to the device (i.e., len). Returning the ACK size
could break callers that verify the full payload was transferred.

> +
> +static int dchid_raw_request(struct hid_device *hdev, unsigned char repo=
rtnum,
> +			     __u8 *buf, size_t len, unsigned char rtype,
> +			     int reqtype)
> +{
> +	struct dchid_iface *iface =3D hdev->driver_data;
> +
> +	switch (reqtype) {
> +	case HID_REQ_GET_REPORT:
> +		if (len < 1)
> +			return -EINVAL;
> +
> +		buf[0] =3D reportnum;
> +		return dchid_cmd(iface, rtype, REQ_GET_REPORT, &reportnum, 1,
> +				 buf + 1, len - 1);

[Severity: High]
Does this return an oversized length to userspace, causing an out-of-bounds=
 read?

dchid_cmd() returns the actual size of the device's response payload. If the
device's response is larger than the requested buffer size, raw_request()
will return a length greater than the buffer allocation. Could this cause
callers to copy uninitialized adjacent kernel heap memory to userspace?

> +	case HID_REQ_SET_REPORT:
> +		return dchid_set_report(iface, buf, len);
> +	default:
> +		return -EIO;
> +	}
> +}
[ ... ]
> +static void dchid_create_interface_work(struct work_struct *ws)
> +{
[ ... ]
> +	hid->dev.parent =3D iface->dchid->dev;
> +	hid->driver_data =3D iface;
> +	iface->hid =3D hid;
> +
> +	ret =3D hid_add_device(hid);

[Severity: High]
Can this result in a use-after-free on probe failure?

If apple_rtkit_wake() fails in dchid_probe(), it initiates devres cleanup. =
As
part of this cleanup, the workqueue is flushed. If coprocessor events trigg=
ered
this work, dchid_create_interface_work() will run and successfully register
the HID device here, because dchid->stopping is not set during probe failur=
e.
When devres subsequently frees the driver's memory, the active HID device
will be left pointing to freed memory.

> +	if (ret < 0) {
> +		iface->hid =3D NULL;
> +		hid_destroy_device(hid);
> +		dev_warn(iface->dchid->dev, "failed to register HID device %s\n",
> +			 iface->name);
> +	}
> +
> +done:
> +	iface->creating =3D false;
> +}
[ ... ]
> +static void dchid_handle_descriptor(struct dchid_iface *iface, void *hid=
_desc,
> +				    size_t desc_len)
> +{
> +	u8 *rdesc;
> +	int i;
> +
> +	if (iface->hid)
> +		return;
> +
> +	rdesc =3D devm_kmemdup(iface->dchid->dev, hid_desc, desc_len,
> +			     GFP_KERNEL);

[Severity: Medium]
Does this leak memory if multiple INIT events are received?

There is no check to see if iface->hid_desc has already been allocated.
If a malfunctioning or malicious firmware sends multiple INIT_HID_DESCRIPTOR
events before HID device registration, previous allocations will be
overwritten and leaked until the device is unbound.

> +	if (!rdesc)
> +		return;
[ ... ]
> +static void dchid_handle_ready(struct dchid_dev *dchid, void *data, size=
_t length)
> +{
[ ... ]
> +	/* When STM is ready, grab global device info */
> +	if (!strcmp(iface->name, "stm")) {
> +		ret =3D dchid_get_report_cmd(iface, STM_REPORT_ID, &dchid->device_id,
> +					   sizeof(dchid->device_id));
> +		if (ret < (int)sizeof(dchid->device_id)) {
> +			dev_warn(iface->dchid->dev, "failed to get device ID from STM\n");
> +			/* Fake it and keep going. Things might still work. */
> +			memset(&dchid->device_id, 0, sizeof(dchid->device_id));
> +		}
> +
> +		ret =3D dchid_get_report_cmd(iface, STM_REPORT_SERIAL, dchid->serial,
> +					   sizeof(dchid->serial) - 1);
> +		if (ret < 0) {
> +			dev_warn(iface->dchid->dev, "failed to get serial from STM\n");
> +			dchid->serial[0] =3D 0;
> +		}

[Severity: Low]
Should this be null-terminated on the success path?

When reading the serial string into dchid->serial, the driver does not appe=
nd
a null terminator at the returned length. Since the buffer is initially all=
ocated
with zeroed memory, the first read is safe, but if the coprocessor restarts
and resends an EVENT_READY with a shorter serial string, the buffer will
retain trailing characters from the older string.

> +
> +		dchid->id_ready =3D true;
> +		for (i =3D 0; i < MAX_INTERFACES; i++) {
> +			if (!dchid->ifaces[i] || !dchid->ifaces[i]->deferred)
> +				continue;
> +			dchid_create_interface(dchid->ifaces[i]);
> +		}
> +	}
> +}
[ ... ]
> +static void dchid_handle_report(struct dchid_iface *iface, void *data, s=
ize_t length)
> +{
> +	if (!iface->hid || !iface->open)
> +		return;
> +
> +	hid_input_report(iface->hid, HID_INPUT_REPORT, data, length, 1);

[Severity: High]
Does this cause an out-of-bounds read if the report is smaller than expecte=
d?

According to the HID subsystem guidelines, transport drivers must use
hid_safe_input_report() because hid_input_report() assumes the buffer size
matches the descriptor's expected size. If the coprocessor provides a report
that is smaller than expected, hid_input_report() will blindly read past the
end of the dynamically allocated buffer.

> +}
[ ... ]
> +static void dchid_handle_ack(struct dchid_iface *iface, struct dchid_hdr=
 *hdr,
> +			     void *data)
> +{
> +	struct dchid_subhdr *shdr =3D data;
> +	u8 *payload =3D data + sizeof(*shdr);
> +	u16 hdr_len =3D le16_to_cpu(hdr->length);
> +	u16 sub_len =3D le16_to_cpu(shdr->length);
> +	unsigned long flags;
> +	bool complete_cmd =3D false;
> +
> +	if (hdr_len < sizeof(*shdr) || sub_len > hdr_len - sizeof(*shdr) ||
> +	    sub_len < 1)
> +		return;
> +
> +	spin_lock_irqsave(&iface->out_lock, flags);
> +
> +	if (shdr->flags =3D=3D iface->out_flags && iface->tx_seq =3D=3D hdr->se=
q &&
> +	    iface->out_report =3D=3D payload[0]) {
> +		if (iface->resp_buf && iface->resp_size)
> +			memcpy(iface->resp_buf, payload + 1,
> +			       min_t(size_t, sub_len - 1, iface->resp_size));
> +
> +		iface->resp_size =3D sub_len;

[Severity: High]
Does this update contribute to the oversized length returned by raw_request?

This updates the tracked response size to the received length (sub_len),
which is then returned by dchid_cmd() to dchid_raw_request(). This can exce=
ed
the caller's originally requested buffer size, which dchid_raw_request()
then returns to userspace.

> +		iface->out_report =3D -1;
> +		iface->retcode =3D le32_to_cpu(shdr->retcode);
> +		complete_cmd =3D true;
> +	}
> +
> +	spin_unlock_irqrestore(&iface->out_lock, flags);
> +
> +	if (complete_cmd)
> +		complete(&iface->out_complete);
> +}
[ ... ]
> +static void dchid_process_packet(struct dchid_dev *dchid, struct dchid_h=
dr *hdr,
> +				 u8 *payload, size_t payload_len, u8 *packet,
> +				 size_t packet_len)
> +{
> +	struct dchid_work *work;
> +	unsigned long flags;
> +
> +	if (dchid_checksum(packet, packet_len) !=3D DCHID_CHECKSUM_SEED) {
> +		dev_err_ratelimited(dchid->dev, "checksum error\n");
> +		return;
> +	}
> +
> +	if (payload_len < sizeof(struct dchid_subhdr))
> +		return;
> +
> +	if (hdr->iface >=3D MAX_INTERFACES || !dchid->ifaces[hdr->iface])
> +		return;
> +
> +	if (hdr->channel =3D=3D DCHID_CHANNEL_CMD) {
> +		dchid_handle_ack(dchid->ifaces[hdr->iface], hdr, payload);
> +		return;
> +	}
> +
> +	if (hdr->channel !=3D DCHID_CHANNEL_REPORT)
> +		return;
> +
> +	work =3D kzalloc(sizeof(*work) + payload_len, GFP_ATOMIC);
> +	if (!work)
> +		return;
> +
> +	work->hdr =3D *hdr;
> +	work->iface =3D dchid->ifaces[hdr->iface];

[Severity: High]
Is this missing a read memory barrier?

This pointer is loaded and dereferenced locklessly. As mentioned earlier,
without a read memory barrier, this could observe uninitialized memory if
it races with interface creation in dchid_get_interface().

> +	memcpy(work->data, payload, payload_len);
> +	INIT_WORK(&work->work, dchid_packet_work);
> +
> +	spin_lock_irqsave(&dchid->rx_lock, flags);
> +	if (dchid->stopping)
> +		kfree(work);
> +	else
> +		queue_work(work->iface->wq, &work->work);
> +	spin_unlock_irqrestore(&dchid->rx_lock, flags);
> +}
[ ... ]
> +static int dchid_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	writel_relaxed(APPLE_ASC_CPU_CONTROL_RUN,
> +		       dchid->asc_base + APPLE_ASC_CPU_CONTROL);
> +
> +	ret =3D apple_rtkit_wake(dchid->rtk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to wake coprocessor\n");

[Severity: High]
Does this leak the running ASC coprocessor on failure?

The driver starts the ASC CPU by writing APPLE_ASC_CPU_CONTROL_RUN to its
control register. If apple_rtkit_wake() fails, the driver returns an error
without clearing the control register. Devres will unmap the memory and
free resources, but the CPU remains physically running and may continue to
access unmapped or freed memory.

> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-apple-mtp-=
keyboard-final-v2-0-a5c685e50b60@gmail.com?part=3D8
