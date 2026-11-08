Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124092;
	b=jI98dWOBuWKlD/EFL6gr7qX4XO1icdzSeKhlNseqYoJq4hFtmt/jHUcDpe+HvpZEyzTf
	 F++1F+VYYAdMJXosUn57XfHNaoqaWq1jCXusUuTpTL8knkZZEtilqQEqS4DqYdCFdkyIv
	 v82qWIq2KPdYkcoOTvsCQgHy3UV2fv2lFQlHPMnMjAusiscXwA6lJBNjbZvyPP3Qt9yaV
	 ryjyQxlkpySPGOEwL+Fgo/SvfLAV/YjUIySTPt+hZLOOMlFKqHo4P+YoQ4KW6ADa+m6/7
	 EaECfMUtcn/5tI/gqknaujgljRCaD9Lz62aDdIuf+47GPIJOuFZDUtef6skpYAT8uwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3j65SYmSc/Yx9+A1aijBAHS3lcPaJsPueO2COBy9Q68=;
	b=W/dlWzYJ3CyHKGy2KExC58u1EcvtJdeTGbZQ279gc18DNmuL0aQD/Tz6/om0ETcd+EWB
	 vxeIXWrPMwpSinU7dajCCy/WK3CIlJhiVeA3ZoSlyvwMmJ2ozi9ujVq4jGoRDrNwxty2K
	 3dJf4qrCoPJqt8wLJN86HL0v8Ihe7yoFEyDfTSY1H7kB7Fu0LYtQidh/NtA9Q0ag4Al1d
	 TuMQ18bM8Gk9vwGSfohhO9vkXGBmuWIvSPE66HRKEXhd6j/e/JI6fN70CYtIlYuKw3XMu
	 pEGjm9DA0fd/+SR3FUEqcu4sW5Ty4kQuPYNUL59lxVvHKjHa6y8bAdoBsvgED1i0gRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwpUZhNk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD628606A332;
	Sun,  8 Nov 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwpUZhNk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F91F008A2;
	Sun,  8 Nov 2026 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794124091;
	bh=3j65SYmSc/Yx9+A1aijBAHS3lcPaJsPueO2COBy9Q68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jwpUZhNkqGY05SnSmj5PW3eX1HxZUDOWq9WPWIsMXfUGQ3+0Qm7UTklYFxKw9Toys
	 FRT1wQpX67nMlhnklj9gJ/P7ofkaikuCdB02yYJyU4Wd0n9HX3m5M9Ku/Q28OUdzY9
	 u4M1636hK4PF69ivnysrQaXVp2/ckhxBGzy5SFBqdMg7h6nlTeMHjL3DmeVPf6/beK
	 0c/ZkDZOFCdbSjDtjJMoHm6enoFp8bgtWTPQMnHwbOXED7/CwYkTwQcrQITo/W/X1t
	 aqJ1Ym8K3188PkDTsaSeOHEA6jfC0mIDIGPJzLm4xVQ1hWt3PIYKPD1as8DB2i5M8s
	 eKT0M+ihtsp1g==
Message-ID: <sashiko-outbox-203640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] HID: apple: Add DockChannel HID transport driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-6-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-6-e2c97b82669a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:48:10 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] HID: dockchannel: fix STM device_id race in
  dchid_create_interface_work()
- [High] HID: dockchannel: bound TX size and timeout in dchid_send() and
  dchid_probe()
- [Medium] HID: dockchannel: validate report descriptor and iface in
  dchid_handle_init()
--

commit 098cc69f724a6a1dd739b50990fad1fd9d489e3d
Author: Michael Reeves <michael.reeves077@gmail.com>

HID: apple: Add DockChannel HID transport driver

This commit adds a HID transport driver for Apple MTP keyboards and
trackpads connected over the DockChannel mailbox and RTKit.

> diff --git a/drivers/hid/dockchannel/apple-hid.c b/drivers/hid/dockchanne=
l/apple-hid.c
> new file mode 100644
> index 0000000000000..3974b877236b5
> --- /dev/null
> +++ b/drivers/hid/dockchannel/apple-hid.c
[ ... ]
> +static int dchid_send(struct dchid_iface *iface, u32 flags, const void *=
msg,
> +		      size_t size)
> +{
> +	struct dchid_dev *dchid =3D iface->dchid;
> +	size_t payload_padded =3D round_up(size, sizeof(u32));
> +	size_t total_len =3D sizeof(struct dchid_hdr) + sizeof(struct dchid_sub=
hdr) +
> +			   payload_padded + DCHID_CHECKSUM_LEN;
> +	struct apple_dockchannel_msg dc_msg;
> +	struct dchid_hdr *hdr;
> +	struct dchid_subhdr *sub;
> +	__le32 *checksum_ptr;
> +	u8 *buf;
> +	int ret;
> +
> +	if (total_len > DCHID_RX_BUF_SIZE)
> +		return -EINVAL;
> +
> +	buf =3D kzalloc(total_len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	hdr =3D (struct dchid_hdr *)buf;
> +	sub =3D (struct dchid_subhdr *)(buf + sizeof(*hdr));
> +	checksum_ptr =3D (__le32 *)(buf + total_len - DCHID_CHECKSUM_LEN);
> +
> +	hdr->hdr_len =3D sizeof(*hdr);
> +	hdr->channel =3D DCHID_CHANNEL_CMD;
> +	hdr->length =3D cpu_to_le16(payload_padded + sizeof(*sub));
> +	hdr->seq =3D iface->tx_seq;
> +	hdr->iface =3D iface->index;
> +
> +	sub->flags =3D (u8)flags;
> +	sub->length =3D cpu_to_le16(size);
> +
> +	memcpy(buf + sizeof(*hdr) + sizeof(*sub), msg, size);
> +
> +	*checksum_ptr =3D cpu_to_le32(DCHID_CHECKSUM_SEED -
> +				   dchid_checksum(buf, total_len - DCHID_CHECKSUM_LEN));
> +
> +	dc_msg.data =3D buf;
> +	dc_msg.len =3D total_len;
> +	ret =3D mbox_send_message(dchid->dc_mbox, &dc_msg);
> +	kfree(buf);
> +
> +	return ret < 0 ? ret : 0;
> +}

[Severity: High]
Can a SET_REPORT larger than 2048 bytes wedge dchid->dc_mbox for an hour
and leave a dangling stack pointer queued in the mailbox channel?

dchid_send() checks total_len against DCHID_RX_BUF_SIZE (65547), while
dchid_ll leaves max_buffer_size unset (allowing raw output reports up to
HID_MAX_BUFFER_SIZE, 16384 bytes).  However, apple_dockchannel_send_data()
rejects any message larger than APPLE_DOCKCHANNEL_FIFO_SIZE (2048 bytes)
with -EMSGSIZE.

When msg_submit() fails in mbox_send_message(), the stack pointer &dc_msg
has already been added to chan->msg_data[] without setting
chan->active_req.  Because dchid_probe() sets dc_mbox_client.tx_block =3D
true while leaving tx_tout as 0, mbox_send_message() defaults to a
3600000 ms (1 hour) wait on chan->tx_complete while holding
dchid->cmd_lock.  Once that wait times out, dchid_send() frees buf and
returns while &dc_msg remains in chan->msg_data[], causing a stack and
heap use-after-free on later mailbox submissions.

Bounding total_len to APPLE_DOCKCHANNEL_FIFO_SIZE and setting a reasonable
dc_mbox_client.tx_tout in dchid_probe() would avoid this.

[ ... ]
> +static void dchid_create_interface_work(struct work_struct *ws)
> +{
> +	struct dchid_iface *iface =3D container_of(ws, struct dchid_iface, crea=
te_work);
> +	struct dchid_dev *dchid =3D iface->dchid;
> +	struct hid_device *hid;
> +	char cap_name[16];
> +	int ret;
> +
> +	if (READ_ONCE(dchid->stopping))
> +		goto done;
> +
> +	if (iface->hid) {
> +		dev_warn(dchid->dev, "interface %s already created\n", iface->name);
> +		goto done;
> +	}
> +
> +	ret =3D dchid_enable_interface(iface);
> +	if (ret < 0) {
> +		dev_warn(dchid->dev, "failed to enable %s: %d\n", iface->name, ret);
> +		goto done;
> +	}
> +
> +	iface->deferred =3D false;
> +
> +	hid =3D hid_allocate_device();
> +	if (IS_ERR(hid))
> +		goto done;
> +
> +	strscpy(cap_name, iface->name, sizeof(cap_name));
> +	if (cap_name[0])
> +		cap_name[0] =3D toupper(cap_name[0]);
> +	snprintf(hid->name, sizeof(hid->name), "Apple DockChannel %s", cap_name=
);
> +
> +	snprintf(hid->phys, sizeof(hid->phys), "%s.%d", dev_name(dchid->dev),
> +		 iface->index);
> +	strscpy(hid->uniq, dchid->serial, sizeof(hid->uniq));
> +
> +	hid->ll_driver =3D &dchid_ll;
> +	hid->bus =3D BUS_HOST;
> +	hid->vendor =3D le16_to_cpu(dchid->device_id.vendor_id);
> +	hid->product =3D le16_to_cpu(dchid->device_id.product_id);
> +	hid->version =3D le16_to_cpu(dchid->device_id.version_number);
[ ... ]
> +	ret =3D hid_add_device(hid);

[Severity: High]
On machines with apple,has-stm, doesn't dchid_create_interface_work()
register the stm HID device before or concurrently while
dchid_handle_ready() fetches dchid->device_id and dchid->serial?

dchid_handle_init() queues create_work for stm before dchid->id_ready is
set.  When CMD_ENABLE_INTERFACE completes, dchid_create_interface_work()
does not wait for EVENT_READY on stm, so it races with dchid_handle_ready()
running on dchid->comm->wq:

kworker (dchid->new_iface_wq)     kworker (dchid->comm->wq)
dchid_create_interface_work()
  dchid_enable_interface(stm)
                                  dchid_handle_ready()
                                    dchid_get_report_cmd(...,
                                      &dchid->device_id, ...)
                                    dchid_get_report_cmd(...,
                                      dchid->serial, ...)
  strscpy(hid->uniq,
          dchid->serial, ...)  <-- data race / uninitialized
  hid->vendor =3D ...            <-- data race / zero IDs
  hid_add_device(hid)
    ...
      dchid_open()
        !completion_done(&stm->ready)
        dchid_start_interface(stm)
          dchid_reset_interface() <-- resets stm mid-init
                                    dchid->serial[ret] =3D 0;
                                    dchid->id_ready =3D true;
                                    complete_all(&stm->ready);

As a result, the stm HID device is registered with zero or torn device IDs
and an uninitialized or unterminated serial string, and opening it before
dchid_handle_ready() reaches complete_all(&iface->ready) sends
CMD_RESET_INTERFACE while STM reports are being queried (or triggers a
second EVENT_READY that overwrites dchid->device_id and dchid->serial
while deferred interfaces are reading them).

[ ... ]
> +static void dchid_handle_descriptor(struct dchid_iface *iface, void *hid=
_desc,
> +				    size_t desc_len)
> +{
> +	u8 *rdesc;
> +	int i;
> +
> +	/* Keep the descriptor stable while creation and HID parsing run. */
> +	if (iface->hid_desc)
> +		return;
> +
> +	rdesc =3D devm_kmemdup(iface->dchid->dev, hid_desc, desc_len,
> +			     GFP_KERNEL);
> +	if (!rdesc)
> +		return;
[ ... ]
> +	iface->hid_desc =3D rdesc;
> +	iface->hid_desc_len =3D desc_len;
> +}
[ ... ]
> +static void dchid_handle_init(struct dchid_dev *dchid, void *data, size_=
t length)
> +{
> +	struct dchid_init_hdr *hdr =3D data;
> +	struct dchid_init_block_hdr *blk;
> +	struct dchid_iface *iface;
> +	u8 *p =3D data;
> +
> +	if (length < sizeof(*hdr))
> +		return;
> +
> +	if (!memchr(hdr->name, 0, sizeof(hdr->name)))
> +		return;
> +
> +	iface =3D dchid_get_interface(dchid, hdr->iface, hdr->name);
> +	if (!iface)
> +		return;
[ ... ]
> +	if (hdr->more_packets)
> +		return;
> +
> +	/* Wait for the shared device IDs only on machines with an STM. */
> +	if (dchid->id_ready || !strcmp(iface->name, "stm"))
> +		dchid_create_interface(iface);
> +	else
> +		iface->deferred =3D true;
> +}

[Severity: Medium]
What happens if devm_kmemdup() fails in dchid_handle_descriptor(), or if
an EVENT_INIT packet has no non-empty INIT_HID_DESCRIPTOR block?

dchid_handle_descriptor() returns without recording an error, and
dchid_handle_init() still queues dchid_create_interface(iface).
dchid_parse() then passes a NULL or zero-length iface->hid_desc to
hid_parse_report(), where kmemdup(NULL, 0, GFP_KERNEL) returns
ZERO_SIZE_PTR and registers a broken HID device with a zero-length report
descriptor.

Also, dchid_get_interface() accepts the name "comm" and returns any
existing dchid->ifaces[index] without checking that hdr->iface !=3D
IFACE_COMM or that the existing interface name matches hdr->name, which
would allow an EVENT_INIT for index 0 to queue HID device creation on
dchid->comm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-apple-m=
tp-keyboard-v5-0-e2c97b82669a@gmail.com?part=3D6
