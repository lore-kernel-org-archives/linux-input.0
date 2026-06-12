Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E08219FC
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280245; cv=none; b=p2xV9SYTCAVM0NkQibywIiUhtC7ybL+L0sTfsLngONRNbO0/cIaJo2XaNvKy3W3fMaqjs5yUzTy0FYm8t31WMKVzS9yPj5npMmecDekhSfRb93zZWwt0DMZGEnrqlcbXgzWsWj6AUlv5VhyA4lfJKGIwlzDIbydJCpOj4u4oGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280245; c=relaxed/simple;
	bh=bRkwEDq/ZWCfIwZ1OwyESg8JPKGnBnOab0KpOKtBJ2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N45NlPMUqV/8YZZ8eVj0qeBMCLmmUcTtf0Gj2HEdvm+yMqBCjMHBer8xXNYjSC1fB4A8f0oDrN1Z6DgOA2GCl/3mqVL0CLsTzWEP76C/k7ZRnwcbZtkobKNCxA2jsgVNN/9fEj5b9Z4mJei8qg7kHjr5PFGVGe7n3636XgLQnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSu8BRuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSu8BRuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E45A1F00ACA;
	Fri, 12 Jun 2026 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280244;
	bh=soPQ0DXUFef/7RbsuiZ1TNAqyDDpP9KxH/qzXA/rtFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lSu8BRuBQGNZ/QwfPcWBBFrFQxu8Ln4zginQb1ZzO376EjM45T2X8g6E7HbG41fi6
	 hq19qliuwlMADyM3hr7kBddt6mry0LRcbYIcLk8iU+zFMOVRhp9f/6PNiUwboP1AhD
	 8cUFK0VJvDWtLZSi2hWn0sCVK7b2k7Tp+dEcoV8Rmf7zvz6uG/B4UABmA2AbHnUDFR
	 i9kwa7KOnpG8utlfEem8PKvOk9vasr7ZMzczW2tQAIM25Bz0W1JAdHQVOTjIYXK3Su
	 F1pD1kh4g0l20hmdUS+2lDRwgo4HGShlIqm6wgYXEObwrk1smyIAf0ojnY1GrxnEyp
	 Tt98X77rQghYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hidpp: fix potential UAF in hidpp_connect_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Kosina" <jikos@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <r7qq6043-p432-51o0-3s93-r9382q44n027@xreary.bet>
References: <r7qq6043-p432-51o0-3s93-r9382q44n027@xreary.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:04:03 +0000
Message-Id: <20260612160404.1E45A1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race condition causing Use-After-Free during hidpp_connect_=
event error cleanup.
- [High] Use-After-Free due to dangling hidpp->input if hidinput_connect() =
fails during initial probe.
- [High] NULL pointer dereference in input_ff_upload if hidpp_ff_init fails=
 midway.
--

commit 0f581c2f8ce1a26d47a4afafa4a00600b3d649dd
Author: Jiri Kosina <jikos@kernel.org>

HID: hidpp: fix potential UAF in hidpp_connect_event()

If input_register_device() fails, we call input_free_device(), but keep
stale pointer to the old device in hidpp->input, which could potentially
lead to UAF. Fix that by resetting it to NULL before returning from
hidpp_connect_event().

Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Jiri Kosina <jkosina@suse.com>

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index ccbf28869a968..2800c31e54e41 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4296,6 +4296,7 @@ static void hidpp_connect_event(struct work_struct =
*work)
>  	ret =3D input_register_device(input);
>  	if (ret) {
>  		input_free_device(input);
> +		hidpp->input =3D NULL;

[Severity: High]
This is a pre-existing issue, but does setting this pointer to NULL after
freeing the input device leave a race window?

Because hidpp_connect_event() runs asynchronously in a workqueue, incoming
HID reports can be processed concurrently by hidpp_raw_event() in
interrupt context.=20

Could an interrupt arrive right after input_free_device() but before the
pointer is cleared, causing hidpp_raw_event() to bypass the
"if (!hidpp->input)" check and dereference the freed memory?

Would it be safer to clear the pointer before calling input_free_device(),
or does this require further synchronization since hidpp_raw_event()
accesses the pointer without holding locks?

[Severity: High]
This is a pre-existing issue, but does a similar use-after-free exist
during the initial probe path?

In hidpp_input_configured(), hidpp->input is persistently set before the
HID core attempts to register the input device:

drivers/hid/hid-logitech-hidpp.c:hidpp_input_configured() {
    ...
    hidpp_populate_input(hidpp, input);
    ...
}

If input_register_device() subsequently fails inside hidinput_connect(),
the input core destroys the input_dev object, but hidpp->input is never
cleared.=20

Since hid_connect() can still succeed if other interfaces connect
successfully, incoming HID reports routed to hidpp_raw_event()
would then dereference the dangling hidpp->input pointer.=20

Could this lead to a use-after-free?

[Severity: High]
This is a pre-existing issue, but is there a potential NULL pointer
dereference if hidpp_ff_init() fails midway?

In hidpp_ff_init(), input_ff_create() is called early, which allocates
dev->ff and enables the EV_FF bit. If a subsequent memory allocation fails:

drivers/hid/hid-logitech-hidpp.c:hidpp_ff_init() {
    ...
    data =3D kmemdup(data, sizeof(*data), GFP_KERNEL);
    if (!data)
        return -ENOMEM;
    ...
}

The function returns without calling input_ff_destroy(). Later,
hidpp_probe() explicitly ignores this error:

drivers/hid/hid-logitech-hidpp.c:hidpp_probe() {
    ...
    if (ret) {
        hid_warn(hidpp->hid_dev,
            "Unable to initialize force feedback support, errno %d\n",
            ret);
        ret =3D 0;
    }
    ...
}

This allows the broken device to be registered. If userspace then sends an
EVIOCSFF ioctl, the input core invokes input_ff_upload(), which
unconditionally calls the driver's ff->upload function.=20

Since ff->upload was never assigned due to the early failure, could
dereferencing this NULL pointer cause a crash?

>  		return;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/r7qq6043-p432-51o0-=
3s93-r9382q44n027@xreary.bet?part=3D1
