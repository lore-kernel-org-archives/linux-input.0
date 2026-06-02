Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F5333429
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365834; cv=none; b=DiasZDN+u1SDPnwccfmgHhIpZXWqTST5/RPuLY7epbd4tQS7WoIX7XiCvyc4IpisTsgTuzKqsmhGumKWXpksE/dzfPWssvtlP4eWMLqNxf7Qd23nnafvwbMnuGFNknSjMKzymV6ffwqc0Jgjk+gN59gHCe3iJ41kJSdwalZg4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365834; c=relaxed/simple;
	bh=8swP5F0DUNgEv3RwL4HvOHEVmpBFX4CPn++dyuxHP8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ldOAGRr/TZZyOV1oLKc3HSnSLf2zhXYuZA3221fJUpPKqQGlgYOAhfkxxq4rA3uASlG7GTc6yMFyKh/h6Ol0eSQoN0lH8neDtz+MJNqD/b5uBYcVcKa2TVmxkivuEQoDltrL/+guEZB5mxTnueI8IkgkbfWt8w/+FVFmrzTPKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRaypwNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRaypwNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4256D1F00893;
	Tue,  2 Jun 2026 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365832;
	bh=tYBQf0ulx5RQobWigWGRu0TqJoEylBkJwxGkDBg3MYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gRaypwNfivh186W4wm0N02Yfdsmc2wN9e6h/0RBYTJZYNh0plcDh0gK5jkkLIJfE/
	 9AFqK5Mpg62LW4cv0UY9w04fMnfQW0z9BRSYcp5Qph9Pwe33grK9wGKvYtIT/FbIsS
	 rTFQWZKDB8WAHA2jFi90SCve7Pbl4gnveEx+/q4LTDkDn9+7WoW8GtnWTEnd88xrg7
	 lHz4T+GsaSuqVLuGPvxj2Vf8zoz4BdBT8oIzcG5bAwGOci0Pr127cFcIuhd80MQLKS
	 VaA3rjPEDFjKGB08B19DiGaJcSJcXn/w+bKrf/WNzXCApjlHyG9yAKjVA3yOU5BIpa
	 mgg3hCHhzMMvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: Input: Add battery list cleanup in
 hidinput_disconnect()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260602015029.2838058-1-rafael@rcpassos.me>
References: <20260602015029.2838058-1-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 02:03:51 +0000
Message-Id: <20260602020352.4256D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a Use-After-Free (UAF) and a soft-lockup race=
 condition by manually unlinking `devm`-managed battery structures from `hi=
d->batteries` during `hidinput_disconnect()`.
--

commit f0760b781af9f4b5e629ebfa0c88970cbaaea8fe
Author: Rafael Passos <rafael@rcpassos.me>

HID: Input: Add battery list cleanup in hidinput_disconnect()

The batteries list (hdev->batteries) is not cleaned up during
hidinput_disconnect(), but struct hid_battery entries are allocated
with devm_kzalloc. When a driver is unbound, devm frees those entries
while their list_head nodes remain dangling in hdev->batteries.

> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index d73cfa2e73d33..95815e140fdf2 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -2408,6 +2408,15 @@ EXPORT_SYMBOL_GPL(hidinput_connect);
>  void hidinput_disconnect(struct hid_device *hid)
>  {
>  	struct hid_input *hidinput, *next;
> +#ifdef CONFIG_HID_BATTERY_STRENGTH
> +	{
> +		struct hid_battery *bat, *tmp;
> +
> +		list_for_each_entry_safe(bat, tmp, &hid->batteries, list) {
> +			list_del_init(&bat->list);

[Severity: High]
Does this introduce a use-after-free and a race condition?

If a driver releases its devres group before calling hid_hw_stop(), the
battery structures allocated with devm_kzalloc() will be freed early. For
example, wacom_mode_change_work() in drivers/hid/wacom_sys.c acts like
this:

wacom_mode_change_work()
   wacom_release_resources(wacom1);
   hid_hw_stop(wacom1->hdev);

Since wacom_release_resources() releases the devres group, the battery
memory is freed before hid_hw_stop() calls hidinput_disconnect(). When we
reach this loop, we will iterate over and modify already-freed memory.

Additionally, hid_hw_stop() can be called asynchronously without holding
hdev->driver_input_lock. Modifying hid->batteries here can race with
concurrent readers like hidinput_update_battery(), which iterates over
the list, potentially causing a crash or infinite loop.

Could the cleanup be handled by adding a custom action during battery setup
via devm_add_action_or_reset(), so it is guaranteed to happen exactly when
the devm resource is freed?

> +		}
> +	}
> +#endif

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602015029.2838=
058-1-rafael@rcpassos.me?part=3D1
