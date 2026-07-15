Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B9386425
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126605; cv=none; b=nxAt+PlOUUjQAJzluit1QnNkbQrXMmz/t8aTlq8vyJ9iRpZI0j9MJD58FWhOWNv81kqgxlHIW39sYFae7OE8WePJWno3bdmj5isShrfXoJAqIorBazsbOPnuhX8wgnb289nQL7/4F5TOulRhlGU6DetOGjs3Nn97IQ/eJHQki78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126605; c=relaxed/simple;
	bh=UvGGIk/UGr4pN7/Kv2iQ2hZy6SI9WF7VLpq1PBO05H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lRr8P4NxyFJkeTiId3+ohZylM+jG/tNOImxfHg+iH+Pq4wK0Pa67EyuA8jydri0jIY/YMk03AtNNWjU3Vw1LXFtQOKqmqfEujtAo1yZZsfKeF+2i4cx4/R/LTZxHCD++FlFmmhYmRvuJjzeyZvf10+goANwqGXRDGzSXA2Eq0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO+1CODi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO+1CODi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579151F000E9;
	Wed, 15 Jul 2026 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784126604;
	bh=QEeLooKSi3ulZvoqhj/J40JlA/Qx+MKutPJzMRc8BB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RO+1CODi6OA7sB+U25K4KJPTFjZxsC37sQ7vI/EUUjI3JhFXXJCJQa9VZMGkxlnwi
	 ie+XPGtnxWpxEWI0yu8uudneScoBhpCImxZIeSJ43bsvwQpXHwUTmkNXHAEtlc/2eX
	 BzrEWIuyn1GBAZ5JbERQNWUH49kMdhsjo60vPD+zkMk11ZAY8nApnzRgFLsMFi/1Vg
	 FS8pWqVI/2KBDB/fbRuz99+11WeBNKuY8LClg9BeItmXxNgcsD936ghWCqpRXTDwdV
	 WMtwYqc2ELFEIFK5kHkawqgle650pECmw6oJDj5ZCiUPCmFT6TirR1feAi1cW4IYPT
	 7zbGYCWxETysw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] virtio-mem: validate device-reported block size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715142337.22811-2-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-2-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:43:23 +0000
Message-Id: <20260715144324.579151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing minimum threshold check for `device_block_size` leads to s=
ilent truncation of `nb_vm_blocks` to 16 bits, causing guest memory corrupt=
ion.
--

--- Patch [1]: [PATCH 1/4] virtio-mem: validate device-reported block size =
---
commit 1886b5144897e316d9afb5456f7874735bcb4c19
Author: Hari Mishal <harimishal1@gmail.com>

virtio-mem: validate device-reported block size

This commit adds validation to ensure the device-reported block size is
non-zero and a power of two, preventing division by zero and miscalculated
alignments.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 11c4415015829..43d12ec7c3230 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2847,6 +2847,13 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  			&vm->plugged_size);
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
>  			&vm->device_block_size);
> +	if (!vm->device_block_size ||
> +	    !is_power_of_2(vm->device_block_size)) {
> +		dev_err(&vm->vdev->dev,
> +			"invalid device block size: 0x%llx\n",
> +			(unsigned long long)vm->device_block_size);
> +		return -EINVAL;
> +	}

[Severity: High]
This is a pre-existing issue, but does this validation also need to enforce
a minimum threshold for device_block_size?

If a small power-of-two value like 16 or 32 is provided by the device, the
calculated block count can easily exceed 65535.

For example, a minimum sub-block size of 2MB divided by 16 yields 131,072
blocks. When this is passed to virtio_mem_send_plug_request(), the value is
silently truncated to 16 bits:

drivers/virtio/virtio_mem.c:virtio_mem_send_plug_request() {
    ...
    .u.plug.nb_blocks =3D cpu_to_virtio16(vm->vdev, nb_vm_blocks),
    ...
}

This truncation also happens in virtio_mem_send_unplug_request() and
virtio_mem_send_state_request() via the .u.unplug.nb_blocks and
.u.state.nb_blocks assignments.

Could this lead to the host processing a truncated request (e.g., plugging 0
blocks) while the guest kernel proceeds to add the full memory region,
causing a crash when the unbacked memory is accessed?

>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
>  			&node_id);
>  	vm->nid =3D virtio_mem_translate_node_id(vm, node_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715142337.2281=
1-1-harimishal1@gmail.com?part=3D1
