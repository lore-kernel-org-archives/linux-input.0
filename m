Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2B3FADFD
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035939; cv=none; b=cOJUg14EclSzipusD+L5I3HEMjZt7izHqsXsuslhJIbKUU1PHCLjMxiKdlwmqWiVrgpZ49gamnpQCzWVVHFQHshm/GD2W4FZtMxZV4mntNbS9lAmgpyqEvkQFc4ZMeA5oNHel9u1xbO/+RBMnALAUxlH9TpEOt7qC/CEjVdWoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035939; c=relaxed/simple;
	bh=XN/wlBv+e27eSWQ13qXPs0b9SDmKB+zJjIFmGyrFoWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mOLKMv6ivV0HlLC/qo/c39Pz5kooGlgekhO8Coe9zeT4X/TyAV09aria45iA+d8EZaA+bXO6pDgqwxajn0wQPMp5Lfe+Jyy/hWdcFeqTANpnB6bx4CKK0tac85hB44TMTF9vsnCvDmpuQLlZVLi3YDOpCx6coT75rjwdtGAI/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqjcetBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqjcetBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FA21F000E9;
	Tue, 14 Jul 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035937;
	bh=ZrWWWVVERHN1UdAx8IheKDMzLXKExJE6OteYuzyScCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqjcetBWFOH0QEnL91Kome30HdOsQ/dA8PkSg/G3MCPeb5I83/+0KUmXDYNRD5Wfj
	 +PpABmSztZKJXot3vaPCcoiDMZTFr69P47I+tMMrnZz0hFF7SV4doVikPXjjOYAlG8
	 ZuPW2FXwXd27pDllniD+M2GiP3f6gjkZ7vqqSjW30EuHUd3J18SYfobduMi7K5jUIF
	 b7Jjbmh4psHBErunyQgeXp3mxNygs6HnNcg6RwApA2JwXCIw9jSP1c+tvTJLhME8vN
	 BuH3ejxEQZh2K9aH4uRa79mQWbBVru1EosDFFPIsRBWYwwoKSP36XCUqq474THNi87
	 9KYQvejsIxIpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: cougar: fix out-of-bounds read in
 cougar_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714131611.269929-1-yaojiale02@163.com>
References: <20260714131611.269929-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:32:17 +0000
Message-Id: <20260714133217.69FA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] Unbounded error logging in interrupt context can lead to log flo=
oding and Denial of Service.
- [Low] The newly added `hid_err` log message is missing a terminating newl=
ine character.

Pre-existing issues:
- [High] TOCTOU race condition during device unbinding leads to a Use-After=
-Free of the keyboard's input_dev (`shared->input`).
- [High] Self-deadlock on `cougar_udev_list_lock` during error handling in =
`cougar_bind_shared_data()`.
- [High] Race condition between `kref_put()` and list lookup causing Use-Af=
ter-Free of the `cougar_shared` structure.
- [High] The probe function dereferences `hdev->collection` without verifyi=
ng that any collections were actually parsed.
--

--- Patch [1]: [PATCH 1/4] HID: cougar: fix out-of-bounds read in cougar_ra=
w_event ---
commit bb404070c5edd2b402b1e549ba66068e04c7d429
Author: Jiale Yao <yaojiale02@163.com>

HID: cougar: fix out-of-bounds read in cougar_raw_event

This patch adds a bounds check to cougar_raw_event() to prevent out-of-boun=
ds
reads when handling malformed HID reports shorter than 3 bytes.

> --- a/drivers/hid/hid-cougar.c
> +++ b/drivers/hid/hid-cougar.c
> @@ -270,6 +270,12 @@ static int cougar_raw_event(struct hid_device *hdev,=
 struct hid_report *report,
>  	if (!shared->enabled || !shared->input)
>  		return -EPERM;

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race condition here
during device unbinding?

If a device disconnect is triggered while a USB event is being processed,
cougar_raw_event() checks shared->enabled locklessly on one CPU.
Concurrently, cougar_remove() on another CPU could clear shared->enabled
and call hid_hw_stop(), destroying the input_dev.

Could the interrupt handler then resume and dereference the freed
shared->input in input_event()?

> +	if (size < 3) {
> +		hid_err(hdev, "Received HID report of bad size (%d)",
> +			size);

[Severity: Medium]
Could this un-ratelimited error logging lead to a log flood if a
malfunctioning or malicious device continuously sends reports shorter than
3 bytes?

Since cougar_raw_event() runs in interrupt context, this might cause high
CPU usage and flood the kernel ring buffer.

[Severity: Low]
Also, does this log message need a terminating newline character?
Without the \n, subsequent kernel messages might be incorrectly appended
to the same line.

> +		return -EPERM;
> +	}
> +
>  	code =3D data[COUGAR_FIELD_CODE];

[ ... ]

[Severity: High]
This is a pre-existing issue, but does cougar_bind_shared_data() have a
self-deadlock on cougar_udev_list_lock during error handling?

If devm_add_action_or_reset() fails, it invokes cougar_remove_shared_data()
which drops the kref to zero, triggering cougar_release_shared_data():

drivers/hid/hid-cougar.c:cougar_release_shared_data() {
    ...
    mutex_lock(&cougar_udev_list_lock);
    ...
}

Since cougar_bind_shared_data() already holds cougar_udev_list_lock when
calling devm_add_action_or_reset(), will this attempt to re-acquire the
already held mutex block all further probes?

[Severity: High]
This is a pre-existing issue, but is there a race condition between
kref_put() and list lookup that could cause a use-after-free of the
cougar_shared structure?

During device unbind, cougar_remove_shared_data() calls
kref_put(&shared->kref) without holding cougar_udev_list_lock. If the
refcount drops to 0, cougar_release_shared_data() blocks on the lock.

Concurrently, a new device probe calling cougar_bind_shared_data() holds
the lock and traverses the list:

drivers/hid/hid-cougar.c:cougar_bind_shared_data() {
    ...
    mutex_lock(&cougar_udev_list_lock);
    list_for_each_entry(shared, &cougar_udev_list, list) {
        ...
        kref_get(&shared->kref);
        ...
    }
}

Could it find the zero-refcount object, increment it, and then after the lo=
ck
is dropped, the blocked release function frees it, leaving the newly
probed device with a dangling pointer?

[Severity: High]
This is a pre-existing issue, but does the probe function dereference
hdev->collection without verifying that any collections were actually
parsed?

drivers/hid/hid-cougar.c:cougar_probe() {
    ...
    if (hdev->collection->usage =3D=3D COUGAR_VENDOR_USAGE) {
    ...
}

If a USB device supplies a HID report descriptor containing no collections,
hid_parse() succeeds but hdev->collection remains NULL. Will this
unconditional access cause a panic on probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714131611.2699=
29-1-yaojiale02@163.com?part=3D1
