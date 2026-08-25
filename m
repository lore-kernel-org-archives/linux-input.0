Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCD2D8DA8
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678768; cv=none; b=Il+/Dcv4Xlp5RoF5oCKpHvfug1IPR2B9RW6noVOwX/IoTM+Fhly2OcMAszKfD6CVJClnozQbux0TImWVe8/AmDZ4Nk5lP8/l/ZSLIrWQUqWgPnX6EQ2zqGjiR1FzUB9qGlP7s5X4DhMxCYidSlgH/tEMusJCEPEE+UH7xaOotKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678768; c=relaxed/simple;
	bh=32D8dUPOlPGbfwS3fSjhQzjrAngMud7mdK1MVlHwahQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OpwhhcYBBUcST4ac4QoDZh3CvJsTZ3ap9ELnIYW6SeeoxcZa/fHcyzAs6kO3YqI7QfozS7M2u42Nkpa9ZM5GcebRwP0dRDsPIcOBvpQcUxprQLUeOohUTo4Z7kHy0XT9avgmrZbXV0dnugJn+nUvQrZnIVhXpWJkTEwokv/eMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3LT/Etk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3LT/Etk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0B1F000E9;
	Tue, 25 Aug 2026 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787678766;
	bh=M/Gh+q/zimBGsLLvzMHJnf6FZbv4bkPMbVHIKRPepGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3LT/EtkQ1HRqfhu8RnhL9XKaQ7CRDWnaixceB0Pn8uwS+bK04tvFVCEXWKCPIR0X
	 wIq+sloHy13TBKx3+aGcBO+CjAnXUT/SXkdJn7qCWd2mZmn0oqgCfsjfvBQIJDuNb0
	 ea3hJXjhm1Ajx0+boUT9gVwMZrl6FdmsstS6Ap7JLS6183cG5LIr8KpVtIPnxgD+hP
	 Ps4XKpwfv5omQ/R0HR6Va5B9fq9it8Zqccn2Pv46PngOZDvFKPXvzzy6IcdF4+GHq1
	 kmBYzvmZ5Rd3JYzOQAxJ/YtRnoWp248mfrv4rqoYuUbux3iEPDeFO/4/kpOz6R2bIp
	 PH/Tp7SmFXQ8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825151242.576456-3-lee@kernel.org>
References: <20260825151242.576456-1-lee@kernel.org>
 <20260825151242.576456-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:26:06 +0000
Message-Id: <20260825172606.B0D0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of delayed work on probe error path leads to =
Use-After-Free.
- [High] Lockless accesses to sibling pointers lead to TOCTOU Use-After-Fre=
e if a sibling device is disconnected concurrently.
--

commit d8ed179fe9b3b266143b25a166ed9a9b3fca09e0
Author: Lee Jones <lee@kernel.org>

    HID: wacom: Fix Use-After-Free in wacom_intuos_pad
   =20
    wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
    inside the interrupt handler context, leading to a Use-After-Free if
    the sibling device is disconnected. This patch resolves the race by
    introducing RCU protection for the touch_input pointer.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2738d4f515e6a..b88726cbbb4ec 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -875,10 +875,16 @@ static void wacom_remove_shared_data(void *res)
>  		data =3D container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
> =20
> -		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> -			wacom_wac->shared->touch =3D NULL;
> -		else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
> -			wacom_wac->shared->pen =3D NULL;
> +		scoped_guard(mutex, &wacom_udev_list_lock) {
> +			if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> +				wacom_wac->shared->touch =3D NULL;
> +				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> +			} else if (wacom_wac->shared->pen =3D=3D wacom->hdev) {
> +				wacom_wac->shared->pen =3D NULL;
> +			}
> +		}
> +
> +		synchronize_rcu();

[Severity: High]
This isn't a bug introduced by this patch, but does wacom_mode_change_work()
still have a TOCTOU Use-After-Free race with this function?

wacom_mode_change_work() accesses the shared->pen and shared->touch pointers
locklessly, dereferences them via hid_get_drvdata(), and then calls blocking
operations:

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
	if (shared->pen) {
		wacom1 =3D hid_get_drvdata(shared->pen);
		wacom_release_resources(wacom1);
		hid_hw_stop(wacom1->hdev);
    ...
}

If a sibling device is concurrently disconnected, its wacom_remove_shared_d=
ata()
executes. The synchronize_rcu() added here does not protect process-context
readers in wacom_mode_change_work() that do not hold an RCU read lock.

The disconnected sibling's devres cleanup runs, freeing the sibling's memor=
y,
while the concurrent wacom_mode_change_work() from the still-connected sibl=
ing
dereferences the freed pointer.

Can we safely access these pointers in wacom_mode_change_work() without hol=
ding
wacom_udev_list_lock or using another mechanism to prevent the sibling from
being freed?

[ ... ]

> @@ -2343,9 +2349,15 @@ static void wacom_release_resources(struct wacom *=
wacom)
> =20
>  static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
>  {
> +	struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wacom_wac=
);
> +
> +	guard(mutex)(&wacom_udev_list_lock);
> +
>  	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> -		wacom_wac->shared->type =3D wacom_wac->features.type;
> -		wacom_wac->shared->touch_input =3D wacom_wac->touch_input;
> +		if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> +			wacom_wac->shared->type =3D wacom_wac->features.type;
> +			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_i=
nput);
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but does wacom_parse_and_register() leak the
wacom->init_work on its error path, potentially leading to a Use-After-Free?

During probe, wacom_query_tablet_data() schedules wacom->init_work with
a 1-second delay. If a subsequent initialization step fails (such as
hid_hw_open() returning an error), the code jumps to the error path, which =
calls
wacom_release_resources() but fails to cancel the delayed work:

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
fail_hw_stop:
	hid_hw_stop(hdev);
fail:
	wacom_release_resources(wacom);
	return error;
}

The probe function will propagate the error and devres will automatically f=
ree
the wacom structure. When the timer expires, the delayed work will execute =
and
dereference the freed wacom structure.

Should we add a cancel_delayed_work_sync(&wacom->init_work) in this error p=
ath?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825151242.5764=
56-1-lee@kernel.org?part=3D3
