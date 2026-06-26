Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D93BC669
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451954; cv=none; b=u/ArpKxbxDQQV1Z0OlfNP57ld6Q3eXwA+zUBWLiOlosDz3a53QOdfpBgnq/ePuYY2817cPZg9uHC4QAublk4Mp3heA7Tq6MicKm0rt51dYJgTi/cBTWWIpnkJjqQSebJ0W75fNHlasaRUi86dUQJGFFf5s2/mxKKHl6V2y9Up5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451954; c=relaxed/simple;
	bh=Z2jfCMp9YJiX4TswgLwqjturPJXQiLqR15+JgbYANNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDsab51v3iuN3zsYpz1fDoN0zAC7tsZdvZJWb0QRqcPPFNh2bINqB0CIQ0gLQ2l+9pIcAtUJVDMsefmPADn5eorGWmGSxQLwxp0MBjtI55b4jes8posQkul1Yq4FNfWGavss+984rYWkWjEVbqtviwIqw6+bLlSNRohMVnt0EHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKZugHD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKZugHD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D2B1F000E9;
	Fri, 26 Jun 2026 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451946;
	bh=DkQhSj/s8GiJTx2efj6ew3GL+h02dcEcRpmVWIONJOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKZugHD+O1GczmLVAina15afYjLgf0Zq7sHWs9FOjNKyV5a6Ws9QW2nKCjFDsn8sQ
	 MnUMIVXrPKDaFsGUval4gx9gYPea/UtAx1YNdeKGSx+5e53gXTsETnekPNJwfdex1I
	 nXX1pvBfDMAwHskypCJflqQPXx5neEwwk2MSFk2jmvHNsXSg5trsWGP9IIm0mngDS3
	 GLbniF8B7n6APnn0mtmrqoJramUZg2l8KZVknXsH6QmukkobVza0Qy/6P6x2sEQSLL
	 sz0SV69Ir+hxnWPEzuG56j5yVI3elQYkYNf/CPqLRIdmjf2iD+VKyT6d9pJS2fbhb8
	 X6ZI2FdcSsJEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] Input: synaptics-rmi4 - zero report size on F54
 work error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-2-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:32:25 +0000
Message-Id: <20260626053226.42D2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] V4L2 structures are embedded in a `devm` allocated struct, leading=
 to a Use-After-Free if a file descriptor is kept open after device unbind.
--

commit 509674cded5ede5f74a6a2812b17819c5b929655
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - zero report size on F54 work error

This commit fixes a heap buffer overflow in the F54 diagnostic code. It
modifies the error path in rmi_f54_work() to ensure the report_size field is
always set to 0 on failure, preventing stale larger payload sizes from being
copied into shrunken v4l2 buffers.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 61909e1a39e24..8eac320c43e35 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
[ ... ]
> @@ -588,16 +588,16 @@ static void rmi_f54_work(struct work_struct *work)
>  		if (error) {
>  			dev_err(&fn->dev, "%s: read [%d bytes] returned %d\n",
>  				__func__, size, error);
> -			goto abort;
> +			goto out;
>  		}
>  	}
> =20
> -abort:
> -	f54->report_size =3D error ? 0 : report_size;
> -error:
> +out:
>  	if (error)
>  		report_size =3D 0;
> =20
> +	f54->report_size =3D report_size;
> +

[Severity: High]
This is a pre-existing issue, but since we are modifying the v4l2-related f=
54
struct, is it safe to embed the video_device in a devm allocated struct?

Looking at rmi_f54_probe() and rmi_f54_remove():

drivers/input/rmi4/rmi_f54.c:rmi_f54_probe() {
    ...
    f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);
    ...
    f54->vdev =3D rmi_f54_video_device;
    ...
    ret =3D video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
    ...
}

drivers/input/rmi4/rmi_f54.c:rmi_f54_remove() {
    ...
    video_unregister_device(&f54->vdev);
    ...
}

When rmi_f54_remove() completes, the driver core frees the devm allocated
memory for f54. If a user keeps /dev/videoX open during unbind, the
video_device refcount remains above zero, but its memory has been freed.

Would subsequent system calls (like ioctl) from the open fd attempt to
dereference vdev->fops from the freed f54 memory, resulting in a
use-after-free?

>  	if (report_size =3D=3D 0 && !error) {
>  		queue_delayed_work(f54->workqueue, &f54->work,
>  				   msecs_to_jiffies(1));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D2
