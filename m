Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626480;
	b=hqJnKZvjHK24HJClgjADBwcqNWPeAmkzA+jX6300OpLVm5j5oqKDXYYhwkd832xWqRaZ
	 Yl2lLluJlHifypsWWqtCwAFHERXFBCjntQCjJwgsvn4MbVcKpmxW2OrLd+c2AFDuOssnE
	 60l+zWak0OlbDCaiYHOTtg47gj2zfE2wSD9ypOT4zeith6kAAPTP3hRb2f+5tjDqQTN/g
	 CQbSyBTuGQJVUKRV7q98xK/FP5pCOr/MFJ1ilC9BqEWYArxhSjv17wHRNmDGti0/6/PMJ
	 a2AzG+8pH6+o+/M+t7MvXqBM1mnBWeELcGgMsksQ+6j7hqICDpGXdeTlDXar9J0464Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=urHFx3b6gWNWRXANUCfTDqj3yvhkqieRlYBhS4ZuTZM=;
	b=eZKk8vGErkrfTrg3JHdQO/WFZR3w0gsDSVyzpooTaA/JXLG0KSRoBLx2nOMtMX3p/IIL
	 CrrPoLGqcLapW06c5aAzNqjOXyHFXejwBQ2p1NXWsTnjNAPvG6YEemlabsBu466fSTBVC
	 D5yRlcYTSGwBLnpelXYcM8Qz9nZhXEp4Bg+W3jm6V7Has8STgpazlzqZX6iaoZ6MwjOh9
	 l07od/SD2jt0Qykr46Dka0mUba1y83ugiwWXzedJNWIIO45t/2eqcj5gmKr/0G01jwMEh
	 uMvtimzQsc5UPvhe5XFMWfVco47IkRM8vBWOOczwbd0QGewBEqpsRRNwxVHS7VFwAqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MU0gnyYy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9541606A31E;
	Wed, 25 Nov 2026 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MU0gnyYy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F04C1F000C4;
	Wed, 25 Nov 2026 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626480;
	bh=urHFx3b6gWNWRXANUCfTDqj3yvhkqieRlYBhS4ZuTZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MU0gnyYyJ+IvbtkavoqG7K/VGO2N7wwWta4r2mJPkJuSzVj12EJ4UjpqOGCzKbWpP
	 X2DWXHIEYOsxY+oqSTgUTsCNSMQ+9vI9SAcUM2biMQ6/RF54a2esbbwRa8U2A0MDjd
	 Y5W9ca1X3Sy/mIm598DeEF1U07y+g+P9BhgVtdgW8jfR/e9Zy8oT+zl+rm1r1HnAVQ
	 RshfIfNPWeimqJxGklNsgwElPYJs1O4JBnU5S7NT6Mn650N+hEwTZl4o7MjSH9PNtI
	 wuaoXUlXrh5/HfL1TNZ+6iBuYUoiRLqb79WuJIUahU8sb6AdcMz2Ksdt3+urIf+W9g
	 bywjKw6ziOqlw==
Message-ID: <sashiko-outbox-233806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: bpf: fix use-after-free in hid_bpf_reg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261125164728.24914-1-rhkrqnwk98@gmail.com>
References: <20261125164728.24914-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:07:59 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] HID: bpf: use-after-free on struct hid_device in
  hid_bpf_unreg() [1]
--

commit 8a1a1e9fd3f55ee6ffdf0b624cf6f20fd17120ed
Author: Sechang Lim <rhkrqnwk98@gmail.com>

HID: bpf: fix use-after-free in hid_bpf_reg()

This commit holds an extra device reference across hid_bpf_reg() so that
concurrent device destruction cannot free struct hid_device before
hid_bpf_reconnect() runs.

> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index c90b68956cb3b..e2512bd6e6b29 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -198,6 +198,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *=
link)
>  		return PTR_ERR(hdev);
> =20
>  	ops->hdev =3D hdev;
> +	get_device(&hdev->dev);
> =20
>  	mutex_lock(&hdev->bpf.prog_list_lock);
> =20
> @@ -239,6 +240,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *=
link)
>  		hid_bpf_reconnect(hdev);
>  	}
> =20
> +	put_device(&hdev->dev);
>  	return err;
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can the paired
hid_bpf_unreg() hit a similar use-after-free on struct hid_device
[1]?

drivers/hid/bpf/hid_bpf_struct_ops.c:hid_bpf_unreg() {
	...
	hdev =3D ops->hdev;

	/* check if __hid_bpf_ops_destroy_device() has been called */
	if (!hdev)
		return;

	mutex_lock(&hdev->bpf.prog_list_lock);
	...
}

hid_bpf_unreg() reads ops->hdev without a lock or reference before locking
hdev->bpf.prog_list_lock:

CPU0                                    CPU1
hid_bpf_unreg()
  hdev =3D ops->hdev;
                                        hid_destroy_device()
                                          hid_bpf_destroy_device()
                                            __hid_bpf_ops_destroy_device()
                                              mutex_lock(&hdev->bpf.prog_li=
st_lock)
                                              e->hdev =3D NULL
                                              mutex_unlock(&hdev->bpf.prog_=
list_lock)
                                              hid_put_device(hdev)
                                          put_device(&hdev->dev)
                                            kfree(hdev)
  mutex_lock(&hdev->bpf.prog_list_lock)
    <-- use-after-free

In addition, if hid_bpf_unreg() takes prog_list_lock after
hid_bpf_destroy_device() sets hdev->bpf.destroyed to true but before
__hid_bpf_ops_destroy_device() clears e->hdev, hid_bpf_unreg() still sees
a non-NULL ops->hdev and calls hid_bpf_reconnect() on a device being
destroyed.

[1] https://sashiko.dev/#/bug/linux-6599bf1d-e091-4b20-bab0-cb93dd34be79

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125164728.2491=
4-1-rhkrqnwk98@gmail.com?part=3D1
