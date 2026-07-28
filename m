Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B0471253
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264945; cv=none; b=naHWjNlpDKaQeB5a4yuQcB1W7YeWzmU6oosaZB8p82kSHsRLM6J/C6djCzQFpcUkvhaffloLIlW6km+rt7cqvqBiNlqTv/dtmWBDsFg6fxPPZ9FuXOUjxztPNmx5EGj772oZlQ2EuhY19qAxiUIqHeFVgYfN1y2Oulhv9KPt38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264945; c=relaxed/simple;
	bh=qRCJPsodGK1hM/14idXNYO9T/4m2WNKi2FrudGIiLLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnD9ru/3Vz0fc7i3B4UJ3Cbb2+s3gkvPgRh3JkyneNshfUfM5K25Ps5GdRLE9+KEyCWwbvn2yBQU/D02dXMb65gQK5IYsjviuOuf6ecykBDHYHgBJbSO48Hh8bvhfwe5nAW0rKR2aEU8WMulAlUa4K+pNuzXmSZ1EH146IOCPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL29OlAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL29OlAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F091F000E9;
	Tue, 28 Jul 2026 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785264942;
	bh=Ko4Jw1DMwCPBS/9MQxK5e3TxuTCPkJShymTZh+Mrpzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EL29OlAogqqlpL2Q7PIk78LUpiBfVD1zeGVX91TbpypMQQqp90x2iACPQVkTH871S
	 M1ABArPhijfyMe1QD6jszVSJuaIqd4G+nbjF/pG5g0cig2jQKNxf3EqDaNB1KitxiB
	 0v63okddfWpQh19XbL9FDf/wU4rNPFKaZy9hpP1wY7NGxApz2zG8bOgLjbemZLDBeS
	 kGBumk7CdWQMSn2S2kIaahAq29+kgs6jLD2/1qsjZFqK/ea/FzETtxzoy6VIG6Vp30
	 Dpabqbttgy9RgyrWG3Bm9EJzUo2fltNNt3t6FA1fVbaty4286Q/Iug4FRz0Mk6+wai
	 dG8Mg+4CjrqZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: magicmouse: avoid NULL pointer deref when there
 is no input device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBWaWxsYXNlw7FvciBNb250Zm9ydA==?= <pepemontfort@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260728184059.688513-1-pepemontfort@gmail.com>
References: <20260715195853.1302765-1-pepemontfort@gmail.com>
 <20260728184059.688513-1-pepemontfort@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:55:41 +0000
Message-Id: <20260728185542.65F091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded recursion in `magicmouse_raw_event()` when processin=
g `DOUBLE_REPORT_ID` leads to kernel stack overflow.
- [High] Dangling `msc->input` pointer leading to Use-After-Free if `input_=
register_device()` fails.
--

--- Patch [1]: [PATCH v2] HID: magicmouse: avoid NULL pointer deref when th=
ere is no input device ---
commit 43afb4a20d87a9959f50f2b092097b19eab03cdd
Author: Jose Villase=C3=B1or Montfort <pepemontfort@gmail.com>

HID: magicmouse: avoid NULL pointer deref when there is no input device

This patch guards against NULL pointer dereferences in the raw_event and ev=
ent
callbacks for the magicmouse driver. It bails out if the input device is NU=
LL,
which is a legitimate state for some hardware interfaces that do not regist=
er
an input device but still bind to the driver.

Link: https://lore.kernel.org/linux-input/20260714102540.3EB2E1F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/20260728072554.47069-1-signshop.a=
lec@gmail.com/

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 802a3479e24b9..7164ced590764 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -390,6 +390,14 @@ static int magicmouse_raw_event(struct hid_device *h=
dev,
>  	struct input_dev *input =3D msc->input;
>  	int x =3D 0, y =3D 0, ii, clicks =3D 0, npoints;
> =20
> +	/*
> +	 * This driver also binds interfaces that hid-input does not create an
> +	 * input device for, so msc->input can legitimately be NULL here. Leave
> +	 * their reports to the generic HID paths instead of dereferencing it.
> +	 */
> +	if (!input)
> +		return 0;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the !input check miss
dangling pointers if input_register_device() fails?

During device initialization, hid_hw_start() calls hidinput_connect(). This
function allocates an input_dev and invokes the driver's input_mapping
callback, which caches the pointer:

drivers/hid/hid-magicmouse.c:magicmouse_input_mapping() {
    ...
    if (!msc->input)
        msc->input =3D hi->input;
    ...
}

If input_register_device() subsequently fails, the HID core frees the
input_dev but does not notify the driver, leaving msc->input dangling.

magicmouse_probe() can then succeed without realizing the input device was
freed, as it either returns early or evaluates the dangling pointer as true:

drivers/hid/hid-magicmouse.c:magicmouse_probe() {
    ...
    if (is_usb_magicmouse2(id->vendor, id->product) ||
        (is_usb_magictrackpad2(id->vendor, id->product) &&
         hdev->type !=3D HID_TYPE_USBMOUSE))
        return 0;

    if (!msc->input) {
        hid_err(hdev, "magicmouse input not registered\n");
    ...
}

When a raw HID report arrives, would this freed pointer bypass the !input
guard and be dereferenced?

>  	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
>  	if (size < 1)
>  		return 0;

[Severity: Critical]
This is a pre-existing issue, but does this function have an unbounded
recursion bug when processing a DOUBLE_REPORT_ID?

If data[1] is 0, the first recursive call returns immediately:

drivers/hid/hid-magicmouse.c:magicmouse_raw_event() {
    ...
    case DOUBLE_REPORT_ID:
        ...
        magicmouse_raw_event(hdev, report, data + 2, data[1]);
        magicmouse_raw_event(hdev, report, data + 2 + data[1],
            size - 2 - data[1]);
        return 0;
    ...
}

However, the second call will process the remainder of the buffer, reducing
the size by only 2 bytes per iteration. With a maximum-sized HID report, co=
uld
this cause up to ~8192 recursive calls, exhausting the standard 16KB kernel
stack and leading to a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728184059.6885=
13-1-pepemontfort@gmail.com?part=3D1
