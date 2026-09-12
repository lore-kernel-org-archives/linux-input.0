Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D8282F13
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789190192; cv=none; b=aq5KID964qX91gsj6W4BKxdXKXMePYzYoncXsj+yjq3E4hiWlCqN7px3IraSfayknkSTBa/xPFmepuf8fHwvjTwi4zHHG6BUiuE50xVm/4igRzMTmT1354grbUiDXwcfP9jC+FEgcrp+KjunHUVNIfXeWokBz8le+JaWbo7kG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789190192; c=relaxed/simple;
	bh=wQnym/dwpaic1auob+gWrv6Z2LNgjkQcfmhkH9LTCmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUQMpVgT5Sya3C4aiVgoKc9OU0Zhaie8NzFhpIVXDKfNVDpsxax13gropDvKER174SzpD0K68L+5eMpb5D73qTASi+Ftyz22Q8EDHrKy/j4UM7dQynWIu+s1wfxqrhKkBChwaeJhn14/uIvo5NLeN/Dv4rRhWSjUgW3cYPo19Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY32TlEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY32TlEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6029A1F000FF;
	Sat, 12 Sep 2026 05:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789190190;
	bh=sSUVlSp1yCji6ujMt40Kfbe12cPctlmCHwdKOnEHtYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gY32TlEjupex9/7u6xsdJ/264OlApUppxcsle2ta48qDpr1RUFQmwm1qT7JNrhhiu
	 7gqG9tRj5nIwsENtyPTUWcnoJ553xp+KL/0ITYnF7prTBRYxHLT+2R1eKKy4g7iM0+
	 bXFN3Z2tKP1NRs+f7CtZiSVFnIJJzDGL/nX//LFiBwgf6F2snUevo/He7fFWfXpThy
	 iG4hJDNy5jYste02sKYc84r9xvHelki1X30r44jgTPgxv3TxWQ5/4cwLSwDR+wnBSH
	 b+ys1++50plzIWnsXNNeq0FYEPAOlYbR9ydNSgyY6Pf6sjEqOuNO6DHsDxE+Fc4Myr
	 V2YEEZBkuyL0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: sensor-hub: Fail unfinished multi-value reads
 on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yibo Tan" <lhfff@tju.edu.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912050257.837340-1-lhfff@tju.edu.cn>
References: <aqPNDZgMS9K6NT7d@ashevche-desk.local>
 <20260912050257.837340-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 05:16:29 +0000
Message-Id: <20260912051630.6029A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing spinlock synchronization when aborting synchronous rea=
ds on timeout or signal allows a concurrent HID report to overwrite a poppe=
d stack frame or leak heap memory.
--

commit d72580296b294439ca880b1a4de796414e3195a6
Author: Yibo Tan <lhfff@tju.edu.cn>

    HID: sensor-hub: Fail unfinished multi-value reads on removal
   =20
    sensor_hub_remove() completes pending reads after stopping the HID devi=
ce,
    but does not record why they completed.  A successful completion wait
    therefore returns zero even if no complete input report was received.

Link: https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tre=
e/main/cases/hid-sensor-quaternion-root-b-kaslr [1]

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc5..687f8defa2f0d 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct hid_sens=
or_hub_device *hsdev,
>  			ret =3D -ETIMEDOUT;
>  		else if (cycles < 0)
>  			ret =3D cycles;
> +		else if (hsdev->pending.raw_size < 0)
> +			ret =3D hsdev->pending.raw_size;
> =20
>  		hsdev->pending.status =3D false;

[Severity: Critical]
This is a pre-existing issue, but missing spinlock synchronization when abo=
rting
synchronous reads on timeout or signal allows a concurrent HID report to
overwrite a popped stack frame.

Can a local unprivileged user trigger a stack buffer overflow here by readi=
ng
a multi-value IIO attribute, sleeping in
wait_for_completion_interruptible_timeout(), and then sending a signal to
their own process?

If the wait is aborted by a signal, this code locklessly clears
hsdev->pending.status.

If a hardware HID report interrupt arrives concurrently, it acquires
pdata->lock in sensor_hub_raw_event():

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    spin_lock_irqsave(&pdata->lock, flags);
    ...
    if (hsdev->pending.status && ...) {
        if (hsdev->pending.max_raw_size) {
            ...
            memcpy(hsdev->pending.raw_data + hsdev->pending.index,
                   ptr, copy_size);

Could the interrupt observe status as true and execute memcpy() copying
attacker-influenced HID data into hsdev->pending.raw_data, which now points=
 to
a freed stack frame since sensor_hub_input_attr_read_values() already retur=
ned?

This same pattern also appears in sensor_hub_input_attr_get_raw_value():

drivers/hid/hid-sensor-hub.c:sensor_hub_input_attr_get_raw_value() {
    ...
    if (flag =3D=3D SENSOR_HUB_SYNC) {
        wait_for_completion_interruptible_timeout(&hsdev->pending.ready, HZ=
*5);
        ...
        kfree(hsdev->pending.raw_data);
        hsdev->pending.status =3D false;
    }

If an interrupt arrives immediately after the wait is aborted and executes:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    } else {
        hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);
        ...
    }

Does this memory leak, since the kmemdup() allocates a buffer that the wait=
ing
thread has already abandoned?

>  	}
>  	mutex_unlock(hsdev->mutex_ptr);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912050257.8373=
40-1-lhfff@tju.edu.cn?part=3D1
