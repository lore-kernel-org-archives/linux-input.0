Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637265;
	b=K3vjTbeP5aYCkN7yVPYe6gjW38j6bMyDDJFRSuLXunhoSf0Ft/u7he/YFfJQdwBaw2WI
	 KDFXX5ZmnyCm7eset91P/+gUQM+aupTzTnnv73wiGnaeVEWfbKIMqJjnDDYjR7b0BryZa
	 9e8Rj1nHextNfj/ml/zezVlQDw0QjsB8dmH7vreHjvDyoQa3KAA8HXUr2z7Z5ipMIenun
	 HgQNNdEnuMmWn7jIV4xCXAsUF8fTeQE4vLD41EReGBvrsm3uJZP56nyBZ8T6is50VBmzk
	 Yh5G3GilxT+OzzZ6Lv6bGfX3kkjhBnpGWIkH0yrF2Po7yffaWpOmRxPPc6G/JaBhImg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gDSG+eucBSeH0u25Yd9mt4CAWbYNhLqvSxR4RyZ0NfU=;
	b=IEi9Z1ZQn/sl/SHxO+9vKIPaxSUO+HhIXe4RSmiOqsm56g8mqaGrWtR6LTCvHrAjurKT
	 jO4Nb0k/3VfTuwKQnSPh4Rc/juXsHbHQajVvTugmsA9WdJjcEpHl0C0i1fn7IHVUgqB8t
	 gXrsMqfBLduDYhcfUMYzhcpkc1L9/mmWOELJfPE4nxXIknWv60/1Y8Le51LQSyq3Vtfsy
	 f9gm0WN+BtQAmkejQe0c0ALqI+vpUB7mZ98ylI3f3bgNAYecZqPB8hzdgiTzcmGKZqa6w
	 aIF6GPvj+j0dcz9O3KcVjePyvW2K5DIe/W6AggZHEeovmD7BKuXnWrpiwXy07zuqsHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCCQwuDN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1A606A334
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCCQwuDN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6A61F000C4;
	Sat, 14 Nov 2026 06:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794637264;
	bh=gDSG+eucBSeH0u25Yd9mt4CAWbYNhLqvSxR4RyZ0NfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCCQwuDNAtpDFWuw4IBmH66jHblt+2QNp9OKKIrAWcLuzLA2kJhKlPUTuv4WQgSeD
	 UU7wQlXE/TpvfHmappJaYbLQA29AN3sFsJ4sDhOOhle86umJO5xTNWwu+AakwjpksS
	 iBFHAAxM2oYk+wfnksDm0vR4nMZBMrqzatMy9GE515sZEHdiabxjVN/w8uRnY1ShlG
	 BFrBhlMqnx1w8K1Mg+k0B1BpKJ/7P4bvGfZt0lZFFh5PSmLC5ND9VzLjhbhr7fKHSm
	 E9AwgDP1xRxEfUKz9Ep4Mx+CWnWykqxtNXwrBPI49IX21euPseLhMiLIQhB5WtOw9R
	 sElM9EtMoKTXg==
Message-ID: <sashiko-outbox-214211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] HID: rmi: fix device lifecycle, suspend, and
 reset work handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261113-hid-rmi-v1-4-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
 <20261113-hid-rmi-v1-4-afc43d97d766@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 06:21:03 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] HID: rmi: race between rmi_event() and rmi_suspend() queuing
  reset_work
- [Medium] HID: rmi: disabled IRQ on hid_hw_open() failure in
  rmi_post_resume()
--

commit d4708cefad45f4f15a5ff3b156b07b3725726356
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: rmi: fix device lifecycle, suspend, and reset work handling

This commit gates reset work scheduling and power management callbacks on
RMI_STARTED and RMI_SUSPENDED, ensures rmi_driver_resume() runs even if
rmi_reset_attn_mode() fails, and uses disable_work_sync() in rmi_remove().

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index d9181fd66c5c8..8783edb7fd6a1 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -31,6 +31,7 @@
>  #define RMI_READ_REQUEST_PENDING	0
>  #define RMI_READ_DATA_PENDING		1
>  #define RMI_STARTED			2
> +#define RMI_SUSPENDED			3
> =20
>  /* device flags */
>  #define RMI_DEVICE			BIT(0)
> @@ -428,6 +429,8 @@ static int rmi_event(struct hid_device *hdev, struct =
hid_field *field,
>  	struct rmi_data *data =3D hid_get_drvdata(hdev);
> =20
>  	if ((data->device_flags & RMI_DEVICE) &&
> +	    test_bit(RMI_STARTED, &data->flags) &&
> +	    !test_bit(RMI_SUSPENDED, &data->flags) &&
>  	    (field->application =3D=3D HID_GD_POINTER ||
>  	    field->application =3D=3D HID_GD_MOUSE)) {
>  		if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS) {
> @@ -469,12 +472,16 @@ static int rmi_suspend(struct hid_device *hdev, pm_=
message_t message)
>  	struct rmi_device *rmi_dev =3D data->xport.rmi_dev;
>  	int ret;
> =20
> -	if (!(data->device_flags & RMI_DEVICE))
> +	if (!test_bit(RMI_STARTED, &data->flags))
>  		return 0;
> =20
> +	set_bit(RMI_SUSPENDED, &data->flags);
> +	cancel_work_sync(&data->reset_work);
> +

[Severity: Medium]
Can rmi_event() still queue data->reset_work after cancel_work_sync() retur=
ns
in rmi_suspend()?

Low-level HID transport drivers such as i2c-hid and usbhid invoke
hid_driver_suspend() before disabling hardware interrupts or stopping input
URBs, and without holding hdev->driver_input_lock:

CPU0                              CPU1
rmi_event()
  !test_bit(RMI_SUSPENDED, ...)
                                  rmi_suspend()
                                    set_bit(RMI_SUSPENDED, ...)
                                    cancel_work_sync(&data->reset_work)
  schedule_work(&data->reset_work)
                                    rmi_driver_suspend()
                                  kworker
                                    rmi_reset_work()
                                      rmi_reset_attn_mode()  <-- runs while
                                                                 suspended

Neither rmi_reset_work() nor rmi_reset_attn_mode() checks RMI_SUSPENDED, so
reset_work will issue bus transfers and reconfigure RMI functions concurren=
tly
with rmi_driver_suspend() or while the device is suspended.  Using
disable_work_sync() in rmi_suspend() paired with enable_work() on error and=
 in
rmi_post_resume() would close this race.

>  	ret =3D rmi_driver_suspend(rmi_dev, false);
>  	if (ret) {
>  		hid_warn(hdev, "Failed to suspend device: %d\n", ret);
> +		clear_bit(RMI_SUSPENDED, &data->flags);
>  		return ret;
>  	}
> =20
> @@ -486,27 +493,31 @@ static int rmi_post_resume(struct hid_device *hdev)
>  	struct rmi_data *data =3D hid_get_drvdata(hdev);
>  	struct rmi_device *rmi_dev =3D data->xport.rmi_dev;
>  	int ret;
> +	int err;
> =20
> -	if (!(data->device_flags & RMI_DEVICE))
> +	if (!test_bit(RMI_STARTED, &data->flags))
>  		return 0;
> =20
>  	/* Make sure the HID device is ready to receive events */
>  	ret =3D hid_hw_open(hdev);
>  	if (ret)
> -		return ret;
> +		goto out;
> =20
>  	ret =3D rmi_reset_attn_mode(hdev);
>  	if (ret)
> -		goto out;
> +		hid_warn(hdev, "Failed to reset attention mode: %d\n", ret);
> =20
> -	ret =3D rmi_driver_resume(rmi_dev, false);
> -	if (ret) {
> -		hid_warn(hdev, "Failed to resume device: %d\n", ret);
> -		goto out;
> +	err =3D rmi_driver_resume(rmi_dev, false);
> +	if (err) {
> +		hid_warn(hdev, "Failed to resume device: %d\n", err);
> +		if (!ret)
> +			ret =3D err;
>  	}
> =20
> -out:
>  	hid_hw_close(hdev);
> +
> +out:
> +	clear_bit(RMI_SUSPENDED, &data->flags);
>  	return ret;
>  }

[Severity: Medium]
Does jumping to out when hid_hw_open() fails leave data->rmi_irq disabled?

If hid_hw_open() returns an error (for example, -EINTR from
mutex_lock_killable(&hdev->ll_open_lock)), jumping to out clears RMI_SUSPEN=
DED
without calling rmi_driver_resume().  Because rmi_suspend() disabled the
transport interrupt via rmi_driver_suspend() -> rmi_disable_irq(), the devi=
ce
is left active after resume with data->rmi_irq permanently disabled, droppi=
ng
all subsequent attention reports.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-hid-rmi-v1=
-0-afc43d97d766@gmail.com?part=3D4
