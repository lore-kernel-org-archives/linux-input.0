Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF3258CE7
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665370; cv=none; b=Q1XSoeYW/dz++sGCRUbqU92zWUhtQdjsQOHldMGXGz8MdvwE992XQNaMWh8yaeaWjq8DKSSw1EljCXjuAu51Oe7YZYGcXqgfTqqDWMgQkVWeezfhxB4AcpPvAR3zapsj1fdxUbCefIX10zvWxUVPrXCx+remqHt9ZPSnIy3P3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665370; c=relaxed/simple;
	bh=qUwGLOWia8iWpuqWCl58Rbt6ssgJo5oaXJ5tlmeGxho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dgbbhv/Rixst350zM7iTbmNtwfwmIYf/5Ow4I02s4xUjX+pFvUfwxEbzZGhIPv30FYlAhHPh17QtQWGXAusAFrvUqXLngtUht/hBc/qfKB0iWMN7KP1ZgQedoj5kTcL0Wk/tfh53vHUtKWnd5NRv+I8o7+E4VbBGDs2k6YIE5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eon1s97i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eon1s97i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74371F000E9;
	Sun, 28 Jun 2026 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665369;
	bh=Ou4jK+AX/7O1XipzKeDY17uAfl8VXMJrhHSqFsuy3FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eon1s97iLv1REjxIKKGXS4PkhzR8dHOSfarvVlud1UUxA+tXC769s3vVmftFfqCfw
	 INqQn9IdlagUg9oDW/qEs1mhtcKPTs2QvNvzHfeUjhT18pg+z3Fbs1Y/22J849dBdW
	 V6O7D85ni+Fcfzb5MK6IEYNIPMlVfpHXl2PnsHfr7W8KHbt/P6rRdgDZmAwb/htpTp
	 sJBxqZjbfx1U/yn/Ekx8m6qqfjKilTeJpnM1N555CSXlCWRn6eRQ+nkA2yUdfu2nbb
	 2I2yab9tgGUoXQ15GnGgwZcro2kWeYNHA9PMXFq4u0OWVcXvq+/Y5dRvPVHncB9nrn
	 YjN5O/7dX+80w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] HID: cougar: reject short vendor reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260628163527.14279-2-alhouseenyousef@gmail.com>
References: <20260628163527.14279-1-alhouseenyousef@gmail.com>
 <20260628163527.14279-2-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:49:28 +0000
Message-Id: <20260628164928.E74371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `cougar_raw_event()` accesses `shared->input` without synchronizat=
ion against `cougar_remove()`, leading to a potential Use-After-Free if the=
 keyboard interface is unbound.
- [High] A deadlock occurs if `devm_add_action_or_reset()` fails during pro=
be.
- [High] A race condition between `kref_put()` and list lookup leads to a U=
se-After-Free of `cougar_shared`.
--

commit 27f66ec84e2d69ee2a0830cfc45515ced43d2bb5
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

    HID: cougar: reject short vendor reports

This commit fixes an out-of-bounds read in cougar_raw_event() by ensuring
that vendor-interface reports are large enough before parsing them. Short
reports are now properly rejected with an error.

> diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
> index ad027c45f1628..7156658166f51 100644
> --- a/drivers/hid/hid-cougar.c
> +++ b/drivers/hid/hid-cougar.c
> @@ -270,6 +270,9 @@ static int cougar_raw_event(struct hid_device *hdev, =
struct hid_report *report,
>  	if (!shared->enabled || !shared->input)
>  		return -EPERM;
> =20

[Severity: High]
This is a pre-existing issue, but is cougar_raw_event() accessing shared->i=
nput
without synchronization against cougar_remove()?

If a thread is preempted right after checking shared->enabled and shared->i=
nput,
and cougar_remove() runs concurrently, it will set shared->enabled to false=
 and
call hid_hw_stop(). This destroys and frees the input_dev structure.

When the first thread resumes, wouldn't it pass the freed shared->input to
input_event(), resulting in a Use-After-Free?

> +	if (size <=3D COUGAR_FIELD_ACTION)
> +		return -EPERM;
> +
>  	code =3D data[COUGAR_FIELD_CODE];
>  	action =3D data[COUGAR_FIELD_ACTION];

[ ... ]

While reviewing this file, I noticed a couple of other pre-existing issues =
in
functions outside of this patch.

drivers/hid/hid-cougar.c:cougar_bind_shared_data() {
...
	mutex_lock(&cougar_udev_list_lock);
...
	error =3D devm_add_action_or_reset(&hdev->dev, cougar_remove_shared_data, =
cougar);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but could this create a deadlock=
 if
devm_add_action_or_reset() fails during probe?

If it fails, it synchronously executes the cleanup callback
cougar_remove_shared_data(), which calls kref_put(). If the refcount drops =
to 0,
cougar_release_shared_data() is called and attempts to acquire
cougar_udev_list_lock. Since that lock is already held by
cougar_bind_shared_data(), this would cause a deadlock.

drivers/hid/hid-cougar.c:cougar_remove_shared_data() {
...
	if (cougar->shared) {
		kref_put(&cougar->shared->kref, cougar_release_shared_data);
		cougar->shared =3D NULL;
	}
...
}

[Severity: High]
This is also a pre-existing issue, but might there be a race condition betw=
een
kref_put() and the list lookup?

The refcount is decremented to zero without holding cougar_udev_list_lock.
Before the object is removed from the list in cougar_release_shared_data(),=
 a
concurrent call to cougar_get_shared_data() might iterate the list and use
kref_get() on this object while it is pending deletion.

Would using kref_get_unless_zero() during the lookup, or holding the list l=
ock
during kref_put(), prevent this Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628163527.1427=
9-1-alhouseenyousef@gmail.com?part=3D2
