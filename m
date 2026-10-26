Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010662;
	b=mGoD7SE3eQm/BwrIHgiUC//tmsech4TByXV7fXKOg0Be5pNbkXn0kIV3Rp+XNNl790Mx
	 x/NNWB35INTC5+jaF/3mkH4/8sRMsP5blsUjV6dvAyElBWlda1nyguP03Ed5tXDeBm2UL
	 Dw3Ajn1cbYC9IAWMqTfpEyR69olFeUDA8JWzwlZrVdW54sl17kt2IF3cq5lUoLP0j3otA
	 uhmDA2hcv05H39FPeg4hW6FbN1YRKOBOtZGE30EuA9MM7PDMvHlSorNhEmqJo9pydPKN6
	 AWUpfQcMTNCHg4it+vUbDi2bLSuMfzDNsn3Lwf4cAeMbqo0ADBUb22FnlSBAI90c7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2IdFrv2StJIxIpjZp24Fw+nYr7jnL1z/El5dcRDT0bQ=;
	b=a5EtrcrqhaOybntkyoCRzCfBLcyUE0D3huHGwOtKJqKEKMDOx7SCo0c46War6M3h5kti
	 gIMxQ4vNCDW2lmwhXEVph5foYd9qaj5bziDN8VPPDA+l3oX76TwYfPhSCImrcoRIglLxq
	 iEu0+7LAMAiiFAs7J0GhzhtX88OrF6V0MiP+eeDcmeRpzeysx0Dhs/w4D2IB/q3BNtJ1b
	 T7JHY22drd4pOsAL4mXGPjVESLFOMMoOkm+LufygWnsQdrok84uAKCwGVXhhOFz4FgbvP
	 xU9w5srtDPOFCn4iJIhVweIoDWCm4xO5wYolK+JYZHMfsGR7j2N3A91KXhrDlt1A05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDSTfIsa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F585606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDSTfIsa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B5C1F01825;
	Mon, 26 Oct 2026 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010661;
	bh=2IdFrv2StJIxIpjZp24Fw+nYr7jnL1z/El5dcRDT0bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDSTfIsaO1Bj1hJSuuSPFMHrJK8Ut8Rzbw6uWs0yJoy7xqymq0T+AGv9LMDG080Te
	 zLALnmUxsJephAp2KJgsREACfP7IQ/exKauZebY8NcL1DrDNJs5HlLnvk4L6levkId
	 zbtgufEYUv7UgQIJEUS8EyMiFlfbtrFmJIuo0LAQtOwlc8Gzj3/nHuRdtgVKucQu8d
	 RLHljWa87ZPaFBgn5cJl97+mpQP9HFCaFzKVfbcXWnbS7ckG+ux6eIZ/cVpk5+O0H0
	 LXBB8iwp1tTSIuWzxEiopS15gwyJjajA351zW0qbSDPm75vI1MS/QhnBgrOH5A1ZJI
	 jL9W2qkC7DPug==
Message-ID: <sashiko-outbox-184948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - f12: read only the object
 data on attention
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Mikushin" <dmitry@kernelgen.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261026093118.2312302-2-dmitry@kernelgen.org>
References: <20261026093118.2312302-1-dmitry@kernelgen.org>
 <20261026093118.2312302-2-dmitry@kernelgen.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:31:01 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Input: rmi4: unadjusted valid_bytes in rmi_f12_attention() reads p=
ast data1
--

commit c4b3a9b641a3a2e611195ada64fab67096a67d47
Author: Dmitry Mikushin <dmitry@kernelgen.org>

Input: synaptics-rmi4 - f12: read only the object data on attention

This commit optimizes F12 attention handling when attention data is not
supplied by the transport by computing the size of the leading registers
up to and including Data1 at probe time and reading only that prefix
instead of the full F12 data packet.

> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 841884d967a3d..ad210464b2f34 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -58,6 +58,8 @@ struct f12_data {
>  	const struct rmi_register_desc_item *data15;
>  	u16 data15_offset;
> =20
> +	u32 read_size;
> +
>  	unsigned long irq_mask[];
>  };
> =20
> @@ -269,8 +271,9 @@ static irqreturn_t rmi_f12_attention(int irq, void *c=
tx)
>  		drvdata->attn_data.data +=3D valid_bytes;
>  		drvdata->attn_data.size -=3D valid_bytes;
>  	} else {
> +		valid_bytes =3D f12->read_size;
>  		retval =3D rmi_read_block(rmi_dev, f12->data_addr,
> -					sensor->data_pkt, sensor->pkt_size);
> +					sensor->data_pkt, valid_bytes);
>  		if (retval < 0) {
>  			dev_err(&fn->dev, "Failed to read object data. Code: %d.\n",
>  				retval);
> @@ -529,6 +532,17 @@ static int rmi_f12_probe(struct rmi_function *fn)
>  		data_offset +=3D item->reg_size;
>  	}
> =20
> +	/*
> +	 * Only Data1 (object reports) is consumed when the data registers
> +	 * are read from the device, so do not read the remaining registers
> +	 * on every attention. On SMBus this transfer dominates the per-frame
> +	 * cost and therefore limits the report rate.
> +	 */
> +	f12->read_size =3D sensor->pkt_size;
> +	if (f12->data1)
> +		f12->read_size =3D min_t(u32, sensor->pkt_size,
> +				       f12->data1_offset + f12->data1->reg_size);

[Severity: High]
Can this read past the end of Data1 into uninitialized memory in
sensor->data_pkt[] or out-of-bounds past sensor->data_pkt[] when Data0 is
present in the F12 data register descriptor (so f12->data1_offset > 0)?

In rmi_f12_probe(), sensor->data_pkt is allocated with devm_kmalloc()
without zero-initialization:

drivers/input/rmi4/rmi_f12.c:rmi_f12_probe() {
	...
	sensor->data_pkt =3D devm_kmalloc(&fn->dev, sensor->pkt_size, GFP_KERNEL);
	...
}

In rmi_f12_attention(), rmi_read_block() now populates only the first
valid_bytes (f12->read_size =3D f12->data1_offset + f12->data1->reg_size)
bytes of sensor->data_pkt, leaving any trailing bytes of sensor->data_pkt
uninitialized, and then passes &sensor->data_pkt[f12->data1_offset] with
the unadjusted valid_bytes to rmi_f12_process_objects():

drivers/input/rmi4/rmi_f12.c:rmi_f12_attention() {
	...
	if (f12->data1)
		rmi_f12_process_objects(f12, &sensor->data_pkt[f12->data1_offset],
					valid_bytes);
	...
}

Inside rmi_f12_process_objects(), size is treated as the number of valid
bytes starting at data1 (&sensor->data_pkt[f12->data1_offset]):

drivers/input/rmi4/rmi_f12.c:rmi_f12_process_objects() {
	struct rmi_2d_sensor *sensor =3D &f12->sensor;
	u32 objects =3D min(f12->data1->num_subpackets, size / F12_DATA1_BYTES_PER=
_OBJ);
	...
}

Because rmi_parse_register_desc_item() parses item->reg_size and
item->num_subpackets independently, if f12->data1->reg_size is smaller
than f12->data1->num_subpackets * F12_DATA1_BYTES_PER_OBJ (or if
valid_bytes on the attn_data path is smaller than f12->data1_offset +
f12->data1->num_subpackets * F12_DATA1_BYTES_PER_OBJ),
rmi_f12_process_objects() can read up to f12->data1_offset bytes past
sensor->data_pkt[valid_bytes - 1], reporting uninitialized kernel heap
memory to userspace via input events or reading past the end of
sensor->data_pkt[].

Should rmi_f12_attention() check that valid_bytes > f12->data1_offset and
pass valid_bytes - f12->data1_offset to rmi_f12_process_objects()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026093118.2312=
302-1-dmitry@kernelgen.org?part=3D1
