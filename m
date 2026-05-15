Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA04DB54C
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859372; cv=none; b=ftc00ulwM40NKZbdaCunLMG+NRXvh3v8G9MUWzQccgoSbSjWVhhxzMz3PFmVJ+oC+p6sErDZCADTMyIqgstbKqEed0sWuu5MUmFpU2jGLAwnRiXdIUMfz85T2ShTQB0sLekWOFRqYWa+T+GX9B+qZLNxr2hHme9OBJqShSaO+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859372; c=relaxed/simple;
	bh=wabesbTe7rHEIRiJidq51AQ7del6Jx08wefHsPelN5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VEeef/wNeFbAfFEd2dmf1Q9Sj1Hy0eskDJHOjaJKLeXwjfV6I96HnRTXb3e8snqj4g2sDPYchb7ftChCHms8osPJUsSfuvzK1OdCaT/FjNNyHYG1YDAeQ+QJTBAx17mNGO4Bb5+W5i3uE+sf8WcD/IK27oX4B7lAz1BZuI60BsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmzsvopg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmzsvopg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D3DC2BCB0;
	Fri, 15 May 2026 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859371;
	bh=wabesbTe7rHEIRiJidq51AQ7del6Jx08wefHsPelN5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mmzsvopgDGC2RCWq0nnZRjotI0aIpFBBltkoUMgIR05YRWxsMJ2TwuKroAPAhGtfK
	 EuIunWSbYN9A/zSTC5nxasbBqiVmlpJFwVZTZq7ypOVmUXzMACCjyIRWIGsipqDmax
	 UQNXmpMTcn0QfsuNAIAt7iHI/ZWfe0f3HVkmBgkFXFB96K5ZCn5a1ummtIJfvkvawp
	 VTmWmwnMuvsJQcLH9LHzi5qdcPrb23E4QDBA0QHszDRk24N094j3ivJ/PZWwOFnWKJ
	 vIcIswJdTWG6JQKKubq+auid/MEAylAqZ7n2uzWh5TBBmyEo2zQgKZmBB91aMpCXxD
	 03lj6nYLNV4ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] HID: lenovo-go: drop dead NULL check on
 to_usb_interface()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis Clinckx" <clinckx.louis@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <66162775a1a939891fde1a96660825df6f3188ca.1778701376.git.clinckx.louis@gmail.com>
References: <66162775a1a939891fde1a96660825df6f3188ca.1778701376.git.clinckx.louis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:36:10 +0000
Message-Id: <20260515153611.25D3DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Resource Leak and Use-After-Free due to Asymmetric Device Cleanup
--

commit 7509c2865ff8f5400d44c180711298e07d9096ba
Author: Louis Clinckx <clinckx.louis@gmail.com>

HID: lenovo-go: drop dead NULL check on to_usb_interface()

to_usb_interface() is a container_of_const() macro: it performs
pointer arithmetic and never returns NULL. The if (!intf) and if
(intf) tests in get_endpoint_address() can never fire. Remove them
in both drivers.

[ ... ]

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 3fa1fe83f7e5e..e0c9d5ec9451b 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -641,9 +641,6 @@ static int get_endpoint_address(struct hid_device *hd=
ev)
>  	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
>  	struct usb_host_endpoint *ep;
> =20
> -	if (!intf)
> -		return -ENODEV;
> -
>  	ep =3D intf->cur_altsetting->endpoint;
>  	if (!ep)
>  		return -ENODEV;

This isn't a regression introduced by your patch, but I noticed an issue wi=
th
how -ENODEV is handled by the driver.

If get_endpoint_address() returns -ENODEV (e.g., when the USB interface has=
 no
endpoints and ep is NULL), hid_go_probe() successfully binds the device:

hid_go_probe() {
    ...
    ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    ...
    ret =3D hid_hw_open(hdev);
    ...
    ep =3D get_endpoint_address(hdev);
    if (ep !=3D GO_GP_INTF_IN) {
        dev_dbg(&hdev->dev, "Started interface %x as generic HID device\n",=
 ep);
        return 0;
    }
    ...
}

However, hid_go_remove() skips the cleanup if ep is -ENODEV:

hid_go_remove() {
    int ep =3D get_endpoint_address(hdev);

    if (ep <=3D 0)
        return;
    ...
}

Does this asymmetric cleanup cause a use-after-free or leak of the input de=
vices
and HID parser buffers since hid_hw_close() and hid_hw_stop() are skipped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778701376.gi=
t.clinckx.louis@gmail.com?part=3D2
