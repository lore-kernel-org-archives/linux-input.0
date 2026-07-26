Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976D1E4BE
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785071070; cv=none; b=Wrw0pp9YzDP8GKdsEwsSUgSfilulBAWkjhIi6guTheYjQd/TcxmvFVpshQVRKJk51askmscHud7llZLW5HhQ/xKAekNlWwvJPS3s2lZx0RUJFrMqL59UAUKZkV+PzYXEQswK81Lymwo3+a87NY67NFNXXY0pqF2085ksIengNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785071070; c=relaxed/simple;
	bh=DdSo9jnO4hSikUPKZqBLTwfhaH6vKwrv78IpMskrURw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9rbEu4QNltIxTYRl50C9YvxVNgBLLIFCGS7qBW/kIOcIP+zAwMB39EZy67cnDBLrbg2Y+S6ruE7ZKuhan7d9vleJpUv5TlT9OTApjpM9rUIl8SmdLS7i+EyeSzvybT3pMzNZab3i1fnv5ZkT6BbZfOw+viQ6+r3WOhsFiJgq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax9B265i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax9B265i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165561F000E9;
	Sun, 26 Jul 2026 13:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785071069;
	bh=sK11Y+uhRRTFKJCOFA/rHdgtAVBlniZsxFFCBk+ycog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ax9B265iVxjwpXlOJlwbRrN4M3LZwM1WkqyBGdqeJ3ikNxqneaoUNsK8tRqypy96Q
	 pohqs0gjaYAiV8Feo8TvZsZrRc5EsHPuYXqLptDRx5wl3YWwY6fdg8plybHJ5EkOqN
	 WI8RdQ5T0fH3ki5UQrPZloovLXkMZBN1S0DBJ+dh9rZlG5OQc3eeNtpVGn0JfrezN8
	 KfuNpccKsawlouMWoWJory8oCl3M34/oDfMEx9FTe83Jmiy2ElC8t/FbI3abzm3Tmw
	 ZUALIlJH4kPK9OjIhlWB1AW2+uHe2SgePsR7BNZNlVntnU9z5KLEqZG3tvj8+/NKXJ
	 fhSEq87QDTncQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sony: clean up device list on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260726124551.15323-1-doruk@0sec.ai>
References: <20260726124551.15323-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 13:04:28 +0000
Message-Id: <20260726130429.165561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing usb_kill_urb() in sony_remove() leads to a Use-After-F=
ree and DMA to freed memory when the URB completes.
- [Critical] Multiple HID collections in a malicious device cause permanent=
 IDA leak and list corruption.
- [High] Unconditional calls to hid_hw_close(hdev) cause ll_open_count unde=
rflow for devices without battery support.
--

--- Patch [1]: [PATCH] HID: sony: clean up device list on probe failure ---
commit 4f91112bdbfa06050765a7259fe71fafc5ed58f1
Author: Doruk Tan Ozturk <doruk@0sec.ai>
Subject: HID: sony: clean up device list on probe failure

This commit attempts to fix a use-after-free by properly initializing the l=
ist
node and device ID, and making list removal idempotent. It introduces
sony_cleanup() to consolidate cleanup paths on probe failure and device
removal.

Link: https://lore.kernel.org/linux-input/20260724143925.007D61F00A3A@smtp.=
kernel.org/

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 253fff4066ebd..56471b7b052d1 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
[ ... ]
> @@ -2127,6 +2126,13 @@ static inline void sony_cancel_work_sync(struct so=
ny_sc *sc)
>  	}
>  }
> =20
> +static void sony_cleanup(struct sony_sc *sc)
> +{
> +	sony_cancel_work_sync(sc);
> +	sony_remove_dev_list(sc);
> +	sony_release_device_id(sc);
> +}
> +
>  static int sony_input_configured(struct hid_device *hdev,
>  					struct hid_input *hidinput)
>  {

[Severity: Critical]
This is a pre-existing issue, but what happens if a malicious USB device
exposes multiple HID Application Collections?

The HID core will invoke sony_input_configured() for each collection. Since
this function isn't reentrant for the same device, won't it allocate multip=
le
IDAs in sony_set_device_id(), permanently leaking the previous ones?

Furthermore, wouldn't a second invocation find the device in sony_device_li=
st
and call list_add_tail() on an already-linked node in
sony_check_add_dev_list(), corrupting the list?

[ ... ]
> @@ -2313,9 +2319,7 @@ static int sony_input_configured(struct hid_device =
*hdev,
>  err_close:
>  	hid_hw_close(hdev);

[Severity: High]
This isn't a bug introduced by this patch, but if sony_init_ff() fails for a
device without the SONY_BATTERY_SUPPORT quirk, won't this unconditionally c=
all
hid_hw_close() and underflow the hdev->ll_open_count?

>  err_stop:
> -	sony_cancel_work_sync(sc);
> -	sony_remove_dev_list(sc);
> -	sony_release_device_id(sc);
> +	sony_cleanup(sc);
>  	return ret;
>  }
[ ... ]
> @@ -2436,13 +2443,7 @@ static void sony_remove(struct hid_device *hdev)
>  	}

[Severity: Critical]
This is a pre-existing issue, but shouldn't we call usb_kill_urb() before
freeing the URB in this preceding block for GHL_GUITAR devices?

If the URB is still in flight, could the completion callback
ghl_magic_poke_cb() execute asynchronously after the sony_sc structure is
freed by devres, leading to a use-after-free and timer list corruption?

> =20
>  	hid_hw_close(hdev);

[Severity: High]
This is a pre-existing issue, but doesn't this unconditionally call
hid_hw_close() even if hid_hw_open() was never called (e.g., if the device
lacks SONY_BATTERY_SUPPORT)?

Would this corrupt the reference count and permanently break the hardware
state tracking if the device is later rebound via sysfs?

> -
> -	sony_cancel_work_sync(sc);
> -
> -	sony_remove_dev_list(sc);
> -
> -	sony_release_device_id(sc);
> -
> +	sony_cleanup(sc);
>  	hid_hw_stop(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726124551.1532=
3-1-doruk@0sec.ai?part=3D1
