Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19524E016
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040140; cv=none; b=o1gsjjNxKgbiztvvUXuu8tB4Zl0hRZmitiw6h/7Zkkga65QqLFos6CEsFdSfw9aUK2L96wTuLafJF9n6x9LMVmHJGlFtpwQmE53GIg8/mRAmPnQnQUuJsWNw0+K3zCWSgeNM07N9r/2Ozt/crhQRyTA+wAw5IrCs78+8sVO2t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040140; c=relaxed/simple;
	bh=YU5DiSUTRuwKREznyBFfT8v9ZrtRb0PB4UzmElkscW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SenMpSTjOzFj7cUW14aX+EpGiiW22paRhlL1xUG6wobOcqG3O0/AeuE7gpBQIsvc5my5e6/rarYu/xnMgMcH2yd/eJ84eZ8mUcEE1fejQaORg0hYIgtHfGh9XOjmQKbwZhhk3Xx961XlfA9PzIEhaW9YtazxRnPy1O6POmSLMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaNzRF9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaNzRF9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE06E1F000FF;
	Thu, 10 Sep 2026 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040138;
	bh=gU7iUemVl8S0mhcpCmdX+dhUb6Zz/HnUTKPc4juqMMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EaNzRF9cnJxMiH+0bTE8gEwGWh8xtsrRtB/LeGkGpoQFtTIJIfkIjXTVwbyxgdpmb
	 YI9YoeR9tdgORT47jCbWT2nRepResdBuUVDpv70Cs/D9Vhh5OBZXjWOsTWWsahurK3
	 hNq94fxX+2K1CIx+h5bnVnebeR0NZArAanM7og/lcJfVGsQzVmu9hR820nrvhCnBmm
	 psdwI1FFIKmNSiI7WYqzVQ9xizAqwCO0WW18Y4YjO9fw0KfaXAatQcDk65p+B10Vc8
	 flIp4DtJLR4ce0XmKJuUGpLa4OGjzWuIywXZ87BsPhZU2FWyAp37eAlTdXI2B9F0G+
	 wtpFELYsBYwqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] HID: sensor-hub: synchronize multi-value read
 cancellation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yibo Tan" <lhfff@tju.edu.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910112338.4171983-1-lhfff@tju.edu.cn>
References: <20260910112338.4171983-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:35:38 +0000
Message-Id: <20260910113538.AE06E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fixes a missing lock race condition in `sensor_hub_i=
nput_attr_read_values` but fails to apply the same fix to `sensor_hub_input=
_attr_get_raw_value`, leaving an identical race condition that causes memor=
y leaks and completion queue corruption.
- [Critical] Unvalidated access to `report->field[i]->usage` in `sensor_hub=
_raw_event` causes an out-of-bounds read if a field defines zero usages.
- [Critical] Missing bounds check on `ptr` against the total received `size=
` in `sensor_hub_raw_event` allows an out-of-bounds read of kernel memory.
--

commit c2fc661d8850deb7960ddffa43fdc7a6bea63778
Author: Yibo Tan <lhfff@tju.edu.cn>

    HID: sensor-hub: synchronize multi-value read cancellation
   =20
    sensor_hub_input_attr_read_values() publishes a caller-owned buffer to =
the
    raw-event path. If its interruptible wait times out or is interrupted, =
it
    clears pending.status without taking data->lock and returns.

Link: https://lore.kernel.org/r/20260610083849.067A11F00893@smtp.kernel.org/

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc5..80f18aff6f1f8 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -335,7 +335,9 @@ int sensor_hub_input_attr_read_values(struct hid_sens=
or_hub_device *hsdev,
>  		else if (cycles < 0)
>  			ret =3D cycles;
> =20
> +		spin_lock_irqsave(&data->lock, flags);
>  		hsdev->pending.status =3D false;
> +		spin_unlock_irqrestore(&data->lock, flags);
>  	}
>  	mutex_unlock(hsdev->mutex_ptr);

[Severity: Critical]
This is a pre-existing issue, but doesn't the exact same race condition
fixed here also exist in sensor_hub_input_attr_get_raw_value() in
drivers/hid/hid-sensor-hub.c?

If the wait times out or is interrupted, the state is modified and memory
freed without holding data->lock:

drivers/hid/hid-sensor-hub.c:sensor_hub_input_attr_get_raw_value() {
[ ... ]
		kfree(hsdev->pending.raw_data);
		hsdev->pending.status =3D false;
[ ... ]
}

Concurrently, sensor_hub_raw_event() can observe status =3D=3D true while h=
olding
the lock, and perform an allocation:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
[ ... ]
				hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);
				if (hsdev->pending.raw_data)
[ ... ]
				complete(&hsdev->pending.ready);
[ ... ]
}

Can this cause a memory leak when the dynamically allocated buffer is
stranded, and waitqueue list corruption if the waiter has already exited
and reinitialized the completion queue for a new request?

[Severity: Critical]
This is a pre-existing issue, but could sensor_hub_raw_event() in
drivers/hid/hid-sensor-hub.c unconditionally access the usage array without
validating maxusage > 0?

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
[ ... ]
	for (i =3D 0; i < report->maxfield; ++i) {
		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
				i, report->field[i]->usage->collection_index,
				report->field[i]->usage->hid,
[ ... ]
				report->field[i]->usage[0].collection_index,
[ ... ]
}

If a malicious USB device provides a crafted report descriptor defining a
field with zero usages, would this out-of-bounds array access to usage[0]
cause a kernel panic?

[Severity: Critical]
This is a pre-existing issue, but is it possible for sensor_hub_raw_event()
in drivers/hid/hid-sensor-hub.c to copy data from ptr without ensuring it
remains within the bounds of the total received report size?

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
[ ... ]
					memcpy(hsdev->pending.raw_data + hsdev->pending.index,
					       ptr, copy_size);
[ ... ]
				hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);
[ ... ]
}

If a malicious device supplies a report descriptor defining large fields but
sends a truncated input report with a small size, could this read beyond the
end of the raw_data buffer and leak adjacent kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910112338.4171=
983-1-lhfff@tju.edu.cn?part=3D1
