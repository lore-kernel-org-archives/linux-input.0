Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCA3AFB1C
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523761; cv=none; b=XDVTFgqL2N6HUtN/FMQTSKjdTeFGwj4nHRONgzdBYiGqH0q0ukbVXHKwBg7gOqPVy6N11vvIhd3jG1WBtclJVSHIwPE1NP02G5gd4HXTU9gm56bwlORPhB7nPbTOLF3Pdq5aX/xWNmL3Mb5poUHvv6ji8WnfYBDUwY7t5PXiFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523761; c=relaxed/simple;
	bh=dEDOqD2DABVv4x8N/kMIUqmNthooa3mEZTHIb839IWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KNRmbJkt/XO22KIBVkNxuxRqnksHpleOjJHlv+i/vvABXPjX5DMC8Ed4jGJlBA7b4S7PODl/8yaQhIHSLR5tnaYyR0h/V9oFtnKgiJk0TxW5xQO3MmDiofuMkkN0ayheuwk6aL/xru4yEwsKNu1VHdBgh3nNqBjVl09q0DC8lQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khqq+1h7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khqq+1h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD93A1F00AC4;
	Fri, 31 Jul 2026 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523759;
	bh=4Bgf7D5R9xb4Q8VOIwwgq7o9v4S1AhL6Qvp0oHrJTIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Khqq+1h7oRpXPW4IWPU7WZ9S5r5PP4qeKzi1sk8QvTHjJlY5/i8ouOpPlDftiC9BC
	 TKxHSn4vuiB/B+DIIQ4RUPc8AlWzn5yux0z4I5I12N4uz171ceaXn5sBn+cnrMLFWF
	 DVvFgc9DPqMst2aQcZP3bP/VJX3LqDClvITsnW8+dQ+E05RdG+wIuLw8r4IGHxjCp5
	 PfZyvAGfk920RsvnRGQQdrou3hKCi62Z+bOCC/WPJQ0+6WasmJhrxL72eoTLGbrfLK
	 8lHtY9/FEMhIJ79O+e1Rp21L4SBRCgASmkzFgfoMUv6yH74ZJD3fK8MH4zqOfxZOkv
	 S25B5E8Pu2OtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] Input: rmi4 - Move sensor initialization into
 own function for F12
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260731-synaptics-rmi4-fnsplit-v1-1-8175cec2ded1@ixit.cz>
References: <20260731-synaptics-rmi4-fnsplit-v1-1-8175cec2ded1@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:49:19 +0000
Message-Id: <20260731184919.AD93A1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap Out-of-Bounds Read in F12 attention handler
- [High] Division by Zero kernel panic triggered by malicious device
- [High] Uninitialized Kernel Stack Memory Leak
--

--- Patch [1]: [PATCH RESEND] Input: rmi4 - Move sensor initialization into=
 own function for F12 ---
commit ca79b6f1c1761554daeb36e4304a62bdc7fa5f10
Author: David Heidelberg <david@ixit.cz>

Input: rmi4 - Move sensor initialization into own function for F12

This commit refactors the F12 probe logic by extracting the sensor
initialization sequence into a separate helper function,
rmi_f12_sensor_init(). This reduces the size of rmi_f12_probe() and makes
the code more structured.

> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 88c28089de993..333477bf0663e 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
[ ... ]
> @@ -426,29 +457,10 @@ static int rmi_f12_probe(struct rmi_function *fn)
>  		return ret;
> =20
>  	sensor =3D &f12->sensor;
> -	sensor->fn =3D fn;
> -	f12->data_addr =3D fn->fd.data_base_addr;
> -	pkt_size =3D rmi_register_desc_calc_size(&f12->data_reg_desc);
> -	if (pkt_size > SZ_1M) {
> -		dev_err(&fn->dev, "Invalid data packet size: %zu\n", pkt_size);
> -		return -EINVAL;
> -	}
> -	sensor->pkt_size =3D pkt_size;
> -
> -	sensor->axis_align =3D f12->sensor_pdata.axis_align;
> =20
> -	sensor->x_mm =3D f12->sensor_pdata.x_mm;
> -	sensor->y_mm =3D f12->sensor_pdata.y_mm;
> -	sensor->dribble =3D f12->sensor_pdata.dribble;
> -
> -	if (sensor->sensor_type =3D=3D rmi_sensor_default)
> -		sensor->sensor_type =3D f12->sensor_pdata.sensor_type;
> -
> -	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %u\n", __func__,
> -		sensor->pkt_size);
> -	sensor->data_pkt =3D devm_kmalloc(&fn->dev, sensor->pkt_size, GFP_KERNE=
L);
> -	if (!sensor->data_pkt)
> -		return -ENOMEM;
> +	ret =3D rmi_f12_sensor_init(fn, f12);
> +	if (ret)
> +		return ret;
> =20
>  	dev_set_drvdata(&fn->dev, f12);
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds heap
read when f12 processes objects.

In rmi_f12_attention(), we advance the pointer by data1_offset but pass the
full valid_bytes without adjusting it:

drivers/input/rmi4/rmi_f12.c:rmi_f12_attention() {
    ...
    if (f12->data1)
        rmi_f12_process_objects(f12,
                                &sensor->data_pkt[f12->data1_offset],
                                valid_bytes);
    ...
}

Then in rmi_f12_process_objects(), we read object coordinates:

drivers/input/rmi4/rmi_f12.c:rmi_f12_process_objects() {
    ...
    obj->x =3D get_unaligned_le16(&data1[1]);
    ...
}

Could a malicious device over I2C/SPI specify a non-zero Data0 register size
(offsetting Data1) and a large number of fingers, causing the loop to read
data1_offset bytes past the end of the sensor->data_pkt heap allocation?

[Severity: High]
This isn't a bug introduced by this patch, but could a malicious hardware
device trigger a kernel panic via division by zero?

In rmi_f12_read_sensor_tuning(), if the device returns 0 for the DPM
resolution:

drivers/input/rmi4/rmi_f12.c:rmi_f12_read_sensor_tuning() {
    ...
    sensor->x_mm =3D sensor->max_x / dpm_resolution;
    sensor->y_mm =3D sensor->max_y / dpm_resolution;
    ...
}

Does the driver need to check if dpm_resolution is zero before performing t=
his
division?

[Severity: High]
This is a pre-existing issue, but could this code leak uninitialized kernel
stack memory to userspace?

In rmi_f12_read_sensor_tuning(), we read item->reg_size bytes into the buf
stack array:

drivers/input/rmi4/rmi_f12.c:rmi_f12_read_sensor_tuning() {
    ...
    ret =3D rmi_read_block(rmi_dev, fn->fd.control_base_addr + offset,
                         buf, item->reg_size);
    ...
    if (rmi_register_desc_has_subpacket(item, 0)) {
        sensor->max_x =3D get_unaligned_le16(&buf[offset]);
        sensor->max_y =3D get_unaligned_le16(&buf[offset + 2]);
        offset +=3D 4;
    }
    ...
}

If a malicious device specifies a small reg_size (e.g., 1 byte) but indicat=
es
via the subpacket_map that subpacket 0 exists, could the unconditional reads
for max_x and max_y read past the initialized portion of buf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synaptics-=
rmi4-fnsplit-v1-1-8175cec2ded1@ixit.cz?part=3D1
