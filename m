Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A4453A4D
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335902; cv=none; b=pRxQlQOjVtVks+oNlHKImIsgI38y1+G6fhqWZ85V06gYq8dWz/YuEWZpI1JdSNI2jzNUjj+iyB8YMv9WLYC9J+woSsa5vxMy0JDIJ1OoaL3N0HfkR9i3PJpgu37ZuuBSgwgDqrSD5U1s8qaBipAr7lYMBghUxt7ELSwRvD9NG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335902; c=relaxed/simple;
	bh=EvcjrdxCmH01MgLUKqfxahb6u0oXM/exWmgn7UWKre8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ue2jdgnDKKmGq2ZhRPUHzCZ7wiUN1jDB1zxVBGNREkBaqWAehXG4qF2HKfgjkUGRShsF/6Sv1HBYQyYtduAtgVh+3RqeV18+U6YFnDdG618zyBmBtRUxN7DzAMjisEp3/Rj73XVJeAbGjvhn2eI6FKKC8hNETI92qXj2LktxWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HptyU6Zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HptyU6Zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCC51F000E9;
	Wed, 29 Jul 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785335900;
	bh=ZLSnrMG5MauomZNj4mhWnkXYx39z6wJAYZAPAGAHCJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HptyU6ZmKMcMejNf5itGUpmCVvusmVCKT+ZYorj1xGOX93BJFWwK9Mkb1ddINtkPr
	 25x9rOvPuCEBUiyoQn4zy84VBx6P2kuem6dx9RBM3ev4eLpuhyUq7WQxZ9y/yN+8b8
	 YDaIBbYzU13RHB0mdnVDN4kAOXhZOfQZ6DlPKRvU6qdqkb9HLF52D1TyzCH+RvBNU7
	 yylv1C7P7Lv2RQX3sCayQnSdA5aJjuQ5aQwDUWQnj5nVFq/9nD1IV+WDF/rrpOa/Xy
	 MI6slsjq2UODSpVkQzf2YSUGe7Hq6rsKdPw7FqvvmiB5L3u+A2FZgdWk3CvKSlQBbX
	 +DWPVZr4dVqLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: universal-pidff: stop the device when
 force-feedback init fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baul Lee" <baul.lee@xbow.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729142432.16184-1-baul.lee@xbow.com>
References: <20260729142432.16184-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:38:20 +0000
Message-Id: <20260729143820.9CCC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing validation of input reports in `universal_pidff_probe`=
 causes an out-of-bounds heap write.
--

--- Patch [1]: [PATCH] HID: universal-pidff: stop the device when force-fee=
dback init fails ---
commit 551db56065200f5b5fc8ed4d3eebe2e09f3793b4
Author: Baul Lee <baul.lee@xbow.com>

HID: universal-pidff: stop the device when force-feedback init fails

This commit fixes a use-after-free issue when force-feedback initialization
fails. It ensures the hardware is properly stopped if initialization fails,
preventing the hidraw character device from outliving the device and writing
into freed memory on subsequent opens.

> diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universa=
l-pidff.c
> --- a/drivers/hid/hid-universal-pidff.c
> +++ b/drivers/hid/hid-universal-pidff.c
> @@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_device =
*hdev,
>  	error =3D init_function(hdev, id->driver_data);

[Severity: Critical]
This isn't a bug introduced by this patch, but does calling init_function()
here without verifying if the inputs list is empty risk an out-of-bounds
write?

If a crafted USB device exposes a PID usage page and output reports but no
input reports, hdev->inputs remains empty. When hid_pidff_init_with_quirks()
is called without inputs:

drivers/hid/usbhid/hid-pidff.c:hid_pidff_init_with_quirks() {
    struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct hid_=
input, list);
    struct input_dev *dev =3D hidinput->input;
    ...
}

Because the inputs list is empty, list_entry() points to the list head
itself. Due to the struct layouts of hid_device and hid_input, fetching
hidinput->input aliases directly to hid->hidraw.

This pointer to a much smaller struct hidraw object is then passed as a
struct input_dev pointer to pidff_init_fields().

If the descriptor contains the required output reports to pass
pidff_reports_ok(), can operations like this write out of bounds?

drivers/hid/usbhid/hid-pidff.c:pidff_init_fields() {
    if (pidff->type_id[PID_CONSTANT])
        set_bit(FF_CONSTANT, dev->ffbit);
    ...
}

>  	if (error) {
>  		hid_warn(hdev, "Error initialising force feedback\n");
> -		goto err;
> +		goto err_stop;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729142432.1618=
4-1-baul.lee@xbow.com?part=3D1
