Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309843BED1F
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193635; cv=none; b=PNQ16Gqrfd8zdlge0j6XIId7/dmRpqq0kl2034KDJUMlcfextWi4tAA0nBKaOAziANiK1bdC2XXZFSFZTDxjz2m9DbTdw3vZjZaLGLpTp48OAwbh/c+ukqc2ExAgEfGOXmyntLvuVtyHUN2yhcejyLsXzsZWf7H1XzFMPTNPukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193635; c=relaxed/simple;
	bh=JtfNbd/H9RXa7FpbzQ4+pYdtaL1NRmJPK8MK/07YVK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggSeiKVewx6pF8ody68YzWH5xN6vN3GLbzb6zSv/irJxK0cRNKplWiwGHrWW4REpz1KHI3n1+oNNdWQQ66ltRFJkMl+xYpjgak1DaqfzjHbDRYsU2VqKO66PzjvyiTYl//DeHPzU4p+HLstBtbRHfPErFv5o8/I3cLK3plK4R3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncW6PuBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncW6PuBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CB11F000E9;
	Thu, 16 Jul 2026 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784193633;
	bh=WmT49SAo43v5vShywgEA9dJ46iWfA7SEojwjGIwfakI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ncW6PuBa6GyDTujx9Gja2yjwHr6nJaKBmfXxebHeAGhFY2ahUjBivs2Y2fCSlDu/X
	 +07J/82u3F5UDTA/T3Sj5y7QSErsbU83hH1l3MpY1wB6rk9sHLOeG8Y5AU95TJbe0F
	 JhM3pCfXCNgCoXEe6bnEvae4bK65P2vDD8a7WsfG5b+RSWHFZkHaoLNB9COJx1tYLH
	 YO6fbBupp5ypPDhNHnwojn6VTO091NOJ3BxyBzgySBH0AKMf6oUEfk0lG366lxTeuG
	 gXJjRL7AVIptV5Edv5/kC0foQU1n+fjU+ypeRpvpDOkKWrctItvizJp5EpjaI98JP+
	 0nw17MdNGr/+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] HID: wacom: Fix Use-After-Free in
 wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260716090726.2711293-3-lee@kernel.org>
References: <20260716090726.2711293-1-lee@kernel.org>
 <20260716090726.2711293-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:20:32 +0000
Message-Id: <20260716092033.39CB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbinding the primary interface leaves a dangling or unbound `data=
->dev` pointer in `wacom_udev_list`, causing a crash on subsequent device p=
robes.
- [High] Lockless and un-synchronized dereference of `shared->pen` and `sha=
red->touch` in `wacom_mode_change_work()` leads to a Use-After-Free.
--

--- Patch [3]: [PATCH v6 3/4] HID: wacom: Fix Use-After-Free in wacom_bambo=
o_pad ---
commit bc217aafc6e3e6dc78c0e754ee61de0854395e8e
Author: Lee Jones <lee@kernel.org>
Date:   Thu Jul 16 09:07:14 2026 +0000

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

This patch resolves a use-after-free vulnerability when a sibling device
is removed while events are being processed in wacom_bamboo_pad_pen_event().
It introduces RCU protection for pen and touch pointers in the wacom_shared
struct to synchronize readers and writers safely.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index c6b37931d02d1..5578de80f4c80 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -876,11 +876,18 @@ static void wacom_remove_shared_data(void *res)

[Severity: High]
This isn't a bug introduced by this patch, but can unbinding the primary
interface leave a dangling pointer in wacom_udev_list, causing a crash on
subsequent device probes?

If a device with multiple interfaces is probed, and the first interface
allocates wacom_hdev_data, the second interface will increment its refcount.

If the first interface is unbound, its hdev is destroyed by the HID core, b=
ut
the shared data structure is kept alive by the second interface's refcount.
Does this leave a dangling pointer?

When a new device is probed, could wacom_get_hdev_data() iterate over
wacom_udev_list and call wacom_are_sibling(), resulting in accesses to the
freed hdev?

drivers/hid/wacom_sys.c:wacom_are_sibling() {
    ...
    if (features->oVid !=3D HID_ANY_ID && sibling->vendor !=3D oVid)
        ...
    if (!(sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
        ...
}

Could this lead to accessing a freed hdev or dereferencing an invalid offset
if hid_get_drvdata(sibling) returns NULL?

>  				    shared);
> =20
>  		scoped_guard(mutex, &wacom_udev_list_lock) {
> -			if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> -				wacom_wac->shared->touch =3D NULL;
> +			struct hid_device *touch =3D
> +				rcu_dereference_protected(wacom_wac->shared->touch,
> +							  lockdep_is_held(&wacom_udev_list_lock));

[ ... ]

> @@ -2793,16 +2804,19 @@ static void wacom_mode_change_work(struct work_st=
ruct *work)
>  	bool is_direct =3D wacom->wacom_wac.is_direct_mode;
>  	int error =3D 0;
> =20
> -	if (shared->pen) {
> -		wacom1 =3D hid_get_drvdata(shared->pen);
> +	struct hid_device *pen =3D rcu_access_pointer(shared->pen);
> +	struct hid_device *touch =3D rcu_access_pointer(shared->touch);
> +
> +	if (pen) {
> +		wacom1 =3D hid_get_drvdata(pen);

[Severity: High]
This isn't a bug introduced by this patch, but does the lockless and
unsynchronized dereference of shared->pen and shared->touch in
wacom_mode_change_work() lead to a use-after-free?

The patch introduces rcu_access_pointer() here to avoid sparse warnings, but
reads the pointer using rcu_access_pointer() which is intended only for
testing for NULL, not for subsequent dereferencing outside an RCU critical
section.

Since wacom_mode_change_work() does not hold rcu_read_lock() nor acquire a
stable reference to the underlying hid_device, if the pen or touch device is
concurrently unbound, wacom_remove_shared_data() nullifies the pointers and
calls synchronize_rcu().

Because wacom_mode_change_work() does not hold the RCU lock,
synchronize_rcu() doesn't wait for it to finish.

Once the device is freed, won't wacom_mode_change_work() proceed to
dereference the dangling pointer in hid_get_drvdata(pen) and hid_hw_stop()?

>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);
>  		wacom1->wacom_wac.has_mode_change =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716090726.2711=
293-1-lee@kernel.org?part=3D3
