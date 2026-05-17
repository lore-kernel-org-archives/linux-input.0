Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB978F39
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778989814; cv=none; b=rF1YtMNHrnFQ/6tdJ1lsiANrizXtqRzQlpxmwkSABjs+3plZHq+IxLrocatqwQqWszwpCIW5k2AbOVOhMQ6+9VdVcboqHOdcwBDLub/ukCNH8HRScbasmMxJoS4JdR/kdCCA7yR4z1IubSD8y+gD9JDAY2lerSmjMDRrxpVNIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778989814; c=relaxed/simple;
	bh=tJVmRLIdYblVXdLCGwILu9l6pbP6jtWfE0u+FGREfsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sZZp2th8xVlgQw9P+TcLAf04G8Xsy6HfVN9m3ItPSH/PP773ZCTGKHXqZtNIWaCa4Nw5Pxy0aLx/XBpoGcsf1VIvUpo8fYDKNnf/T3JsqPPeo+2iOIfw80ZWtdQzTK/giquajCem67WwPj1BtHH6kufoCMMfmidiKM0ueQYHU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh57OuT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh57OuT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5457FC2BCB0;
	Sun, 17 May 2026 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778989814;
	bh=tJVmRLIdYblVXdLCGwILu9l6pbP6jtWfE0u+FGREfsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Qh57OuT1Ve77ya5hr6EAcjRZJRDLVcwiaw548czMjEVEpdpjgFDbQz108i8OdcOJW
	 6bdxo01BMPH3+rYQ5/vw0K6SecBSBeOfpM38fTB5IqhMNTkH9LuzKlUtXcJldgGHSZ
	 0dV4qgDgwRz+cx4pOZAppGZc2nDO+wBcDhFNy+rtHMh0EfKd0Nf/wr4ETTC40FwWm/
	 MxbSKXMuF70jGy635W0C+kGrqeVqcLo3QRdW4/kmYg6MqnZdZgNq1fzr41DpzzcsmX
	 JOcHtTGPjnRfNBAVmCDg5riWuGvObNCQpWYxjlen4/uJ5hyLF8QQT2i73a8ldd81y0
	 lsZPjbaI0HgWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517013925.3120314-5-derekjohn.clark@gmail.com>
References: <20260517013925.3120314-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 03:50:13 +0000
Message-Id: <20260517035014.5457FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware state machine desynchronization due to abandoned interrup=
tible waits and lack of request tracking.
- [Medium] Data race on shared state variables `rumble_intensity_left`, `ru=
mble_intensity_right`, and `profile_pending`.
--

commit 9659fef77f1187c96b3944136a0f1b514f35ccfc
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

This commit adds intensity adjustment for the left and right rumble motors
to the MSI claw driver. It implements sysfs show and store attributes and
handles the hardware profile events for the rumble intensity states.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 4443f53b54cb1..6658d7f2b2ddc 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -403,6 +413,12 @@ static int claw_profile_event(struct claw_drvdata *d=
rvdata, struct claw_command_
>  			drvdata->led_mc.subled_info[2].intensity =3D frame->zone_data.zone[0]=
.blue;
>  		}
> =20
> +		break;
> +	case CLAW_RUMBLE_LEFT_PENDING:
> +		drvdata->rumble_intensity_left =3D cmd_rep->data[4];
> +		break;
> +	case CLAW_RUMBLE_RIGHT_PENDING:
> +		drvdata->rumble_intensity_right =3D cmd_rep->data[4];
>  		break;
>  	default:

Is there a data race on rumble_intensity_left and profile_pending here?

The store functions update rumble_intensity_left while holding rom_mutex,
and the show functions set profile_pending while holding profile_mutex.
However, it appears claw_profile_event() can be triggered concurrently by
in-flight hardware responses in the HID event handler, writing to
rumble_intensity_left and clearing profile_pending without holding either
mutex.

[ ... ]
> @@ -822,6 +838,126 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
>  }
[ ... ]
> +static ssize_t rumble_intensity_left_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	u8 data[4] =3D { 0x01, (rumble_addr[0] >> 8) & 0xff, rumble_addr[0] & 0=
xff, 0x01 };
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	drvdata->profile_pending =3D CLAW_RUMBLE_LEFT_PENDING;
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, dat=
a,
> +				    ARRAY_SIZE(data), 8);

Can this sequence lead to desynchronization of the hardware state machine?

Since claw_hw_output_report() uses an interruptible wait with a short
timeout (8ms), if the wait times out or is interrupted by a signal, the
hardware will likely continue processing the command.

If a subsequent sysfs operation (like rumble_intensity_right_show) then
sets profile_pending to CLAW_RUMBLE_RIGHT_PENDING, could a delayed ACK
from the previously aborted left rumble request arrive?

Because claw_profile_event() relies solely on the global profile_pending
state without validating payload addresses or transaction IDs, it seems
this delayed ACK would mistakenly apply the left rumble response to the
right rumble variable.

Additionally, could a delayed generic ACK from a timed-out SYNC_TO_ROM
prematurely complete the wait here, causing the show() operation to return
immediately with stale data while leaving profile_pending dangling?

> +	if (ret) {
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +		return ret;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_left);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517013925.3120=
314-1-derekjohn.clark@gmail.com?part=3D4
