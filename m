Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244D3AEB5C
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451788; cv=none; b=G0hAyNXXcxi/A7vIQ3b+5DShDlw5o9brTNfoFSNnc4ArndUg/3/8sF6CAr457e6amYIeygtniKfj2mHomVkgOMQsXycUx32DsWU9abhcYzJFf2bFBxYKUYQ5th1dy+wDc5HNS7MiW47Vd9tWI05dZ7GqNoZoeFqnCJq6uQ09r1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451788; c=relaxed/simple;
	bh=Zyw+c3RVe6wODIa8A1UKs+e6CUjDpQeuZxD+J7ksKws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uxFGfpPTF6ptKfRmKeuCEpc4PZq/iuetKGc+UZCjXIw9BMb+MTHaSmadpji5DpasROACXmDCIBFqwkPg6r8z3f/V0O0Wrxo3O1nwOwObXc5OmjjE+KS9xQxCSqQB2UEwdGjc2xjW3HPPc5FCboCvF7WGb7aR0BvFEfrMMVODP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZG9YrCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZG9YrCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919E71F000E9;
	Fri, 26 Jun 2026 05:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451779;
	bh=9gUtUZQ9ze6fI4MRM6J/Awg4BtpMAMbawtMNBP7UBr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MZG9YrCHfsSmc2Dh+aGLU57fcqU/pd7Bekba+W3f5RVGdqPMrjxtSnHUX3lrgFE5Y
	 BukziNiSpO+BWPb6CPWsfIyE/M/6K0JdyDKoj6l5q3dbED1SusCAprUGpu3HKrPSjf
	 rHSdiELSmaGIg6ZRo0byeMOAkLR/ZsRXj0Jci5cXzO/jHf5BpZL47Pw816JCLpc2oH
	 8He41/NKEEoDR33PHcKXaoTy6DLva6+jpRQZhZDnwMR1Ki09aICwa1OBEdRm1+8pE6
	 3PuaYx9jUGeIzuO9T5dt39/lHmPB30DhuagX08jrC9AWSwQN7SvFvAqnK7bNlxv2Ge
	 gMM6wYj+Em04Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] Input: synaptics-rmi4 - change report_size to
 size_t in F54
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260626051802.4033172-9-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-9-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:29:39 +0000
Message-Id: <20260626052939.919E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The v4l2 device structure (vdev, queue, and lock) is embedded with=
in devm-allocated f54_data, causing a use-after-free and locking of a freed=
 mutex on device close if userspace holds the device open past removal.
--

commit f2033554c93a59d85d1cecf56a498ef9493e4022
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - change report_size to size_t in F54

Change report_size from int to size_t in struct f54_data and update all
its usages. This avoids signed/unsigned comparison warnings when
comparing with size_t variables and matches the signature of
rmi_read_block() which takes size_t for length.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 850e1742c480a..5d045ece3c2f2 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -105,7 +105,7 @@ struct f54_data {
>  	enum rmi_f54_report_type report_type;
>  	u8 *report_data;
>  	size_t max_report_size;
> -	int report_size;
> +	size_t report_size;
>  	int report_error;
> =20
>  	bool is_busy;

[Severity: High]
This is a pre-existing issue, but could embedding the V4L2 device structures
inside the devm-allocated f54_data lead to a use-after-free?

If a user holds the /dev/videoX node open during driver unbind,
rmi_f54_remove() completes and the devm framework frees the f54_data memory:

drivers/input/rmi4/rmi_f54.c:rmi_f54_remove() {
    struct f54_data *f54 =3D dev_get_drvdata(&fn->dev);

    video_unregister_device(&f54->vdev);
    v4l2_device_unregister(&f54->v4l2);
    cancel_delayed_work_sync(&f54->work);
    destroy_workqueue(f54->workqueue);
}

When the user later closes the file descriptor, it triggers the V4L2
release path. v4l2_release() calling vb2_fop_release() accesses the
embedded queue and attempts to acquire the vdev->queue->lock, which
points to the freed f54->lock:

drivers/input/rmi4/rmi_f54.c:rmi_f54_probe() {
    ...
    f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);
    ...
    f54->vdev =3D rmi_f54_video_device;
    f54->vdev.v4l2_dev =3D &f54->v4l2;
    f54->vdev.lock =3D &f54->lock;
    ...
}

Should the video_device be dynamically allocated and reference counted rath=
er
than relying on devm management?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D9
