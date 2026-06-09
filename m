Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA5377EC7
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008427; cv=none; b=dOHKJaFAWup2na+O1JkZoCowlo2+fguWyMTktdwc99kfcD0e06qXn05KFKX46T7yPdvxofxLEiYVulV3JGR+TIGgFrYeGvUbhzWIW312e4JICjGQNzBFltyqlihiOrWBmnPvgsQJvxjZ2CdZttoqW0UsF1Pys156VInLoH83rmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008427; c=relaxed/simple;
	bh=mivGEmt3cKiUGCMF9cZUWQtNNYN0xhsp81SfhjFkKRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lp1LQqCE1Ryf1g/Htp/VtvKaefb8tDeIBiQzy8xoI7k5mt+/lsefJzRHQlS2VL5X7P+fIKHLJ31KekshM8Lq3AcrBtulykWghBmKKSPeSDWj2rj+0GZy52TxIkM/77bCrVK4vgle93iwxRhutQI2txIjRddLfBH7SPQp9tSrY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FED5r03L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FED5r03L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414371F00893;
	Tue,  9 Jun 2026 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781008426;
	bh=kwjM2DyIr8zmllTRHIRE4GGcmR3+pnBwf25iCmkp03U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FED5r03LMOTC/75n8efKOEbxaNq+kTi5J75iZqU5D0PC/8kK3Vy8tv7/S0r6eZs3N
	 T24k3i4KK21dbuDEPZl5ZYMll8/8TSda5a5Ppq+zjOFmWcHHO+VNqaf8dJoayCFHgV
	 89q2/pw8UHLJ5XWcriWjtY8b928n5ALxukHDKZ8fW5dXIL3KUIF/6iTWFdsVwsjAFR
	 Cpq2BcFcwD9FJFURW3qBJBWW5k35QorA+cLTk2DmkNyWeLEe3Up2EUjAWFb8aMeW+C
	 J1fmJ5zWu60sinEQrrAkBgd6sBpyTN9XxUg9ZlFYo52zyBLjI8G3SQGTPQCu9uk88T
	 tXYrgWwppdJQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] HID: wacom: Fix Use-After-Free in
 wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260609121353.3743782-2-lee@kernel.org>
References: <20260609121353.3743782-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:33:45 +0000
Message-Id: <20260609123346.414371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `wacom_mode_chan=
ge_work()` misuses `rcu_access_pointer()` to fetch RCU-protected pointers w=
ithout holding `rcu_read_lock()`, leading to a Use-After-Free.
--

commit 4eb3f98aa9f594548c94852bcf57eb40ae946cd8
Author: Lee Jones <lee@kernel.org>
Subject: HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

This commit resolves a Use-After-Free vulnerability in
wacom_bamboo_pad_pen_event() by introducing RCU protection for the pen and
touch pointers within the wacom_shared structure. It annotates the pointers
with __rcu, wraps lockless read access with rcu_read_lock() and
rcu_dereference(), and updates writers using the appropriate RCU assignment
primitives. It also updates pointer access in wacom_mode_change_work() to u=
se
rcu_access_pointer() to avoid warnings.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 7ba5898265481..9b352027aa980 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2797,16 +2808,19 @@ static void wacom_mode_change_work(struct work_st=
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
>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);

[Severity: High]
This isn't a bug introduced by this patch, but does wacom_mode_change_work()
misuse rcu_access_pointer() here by fetching RCU-protected pointers without
holding rcu_read_lock(), which still leaves an exploitable Use-After-Free?

If the sibling device is unbound concurrently, its wacom_remove() triggers
wacom_remove_shared_data(), which nullifies the shared pointer and calls
synchronize_rcu(). Because the worker does not hold rcu_read_lock(),
synchronize_rcu() will not wait for it.

Doesn't this allow the sibling device to be completely freed while the work=
er
is still actively dereferencing its memory via hid_get_drvdata(),
wacom_release_resources(), and hid_hw_stop()?

Could using rcu_access_pointer() (which is explicitly intended for pointers
that will not be dereferenced) be papering over the underlying race conditi=
on
just to silence sparse/lockdep warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121353.3743=
782-1-lee@kernel.org?part=3D2
