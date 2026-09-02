Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D172330B3F
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357748; cv=none; b=VLnMkp2tw0OwfZw2BfZ0T7SOgItfzh/ldnaaLsg2YpjsghdImkmOf9Fxep7QxNuUuQnd9AeBxWWnzLw6K4g7/AWG0GmUt5bgeZtw0Ln7J2LT5gT3PxXl7duP4ic2RgQ6XbCYE2eyDiaFW5mMyBm3jI3mcVtbfAYYCTS2T+F1lAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357748; c=relaxed/simple;
	bh=6VUatotTruyPxPwKVzfXl5woGkcojzMWT+W2RNQI0Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qH9Il6PWRft+P1x/9rCSJU8kyn24jPZwku9hjF/CX5aTMg+uJq3wMQsvvpXYm14vj9e4puTf9OlSVLoQbU05DI4mKTeg2b38H4y4EXMhSBLy0gN6DthbN4pdNd8aznwaEKWOpBi+7bKDrGqDyhbXH+UfuNurB5rB0uAXEMKG3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FirKTAvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FirKTAvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B101F000E9;
	Wed,  2 Sep 2026 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357747;
	bh=Q537csGCyJE79lGMsQhFRT8xS2O+zseqil/b/Unqs10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FirKTAvH/Dq07y0/BlAAqzWTGZeHdg5ssAlsTmd+7gtap+V1B9bzllGd6p7wIgmWT
	 5edroSvSfOM3FIYmq/J6voCilAfBXwApAY8GjXoOfaz3XqRCSat8ZdvJYorPGQQknb
	 O9Sg9YeH4HhY2Jb+7dlOwtmTQoarIt2QeoehuTnxXEs2+qyGcVAQuPNPKKYXsCnAUB
	 1lzd0osw9tO4Qo67KIcHadnbK+XDRHSsfVt3p0YN2UfJb8f2GdaAJq8TM7KhLAYhLN
	 m9k6DLqP7Sxu7pwjdkMywdvgQw6mPCJTtHbqX0pKt6hQdfi/6pdS6aBEl6NI8pEJuy
	 WXgRhjR1C8gTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] HID: wacom: Fix Use-After-Free in
 wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902134417.1270552-4-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
 <20260902134417.1270552-4-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:02:26 +0000
Message-Id: <20260902140226.C3B101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Cross-device Use-After-Free in `wacom_mode_change_work()` due =
to lockless access to sibling devices without RCU read lock.
--

commit 4b7151c8603346fbd9de5581ed53af8776799547
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

This commit fixes a Use-After-Free in wacom_bamboo_pad_pen_event by introdu=
cing
RCU protection for pen and touch pointers. It adds rcu_read_lock() and
rcu_dereference() wrappers to lockless readers, while using rcu_access_poin=
ter
in wacom_mode_change_work() to suppress warnings.

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 1af0d518260d6..12f6a32cbc5fc 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2833,16 +2844,19 @@ static void wacom_mode_change_work(struct work_st=
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

[Severity: Critical]
This is a pre-existing issue, but can this lockless access to sibling devic=
es
result in a cross-device Use-After-Free?

If wacom_mode_change_work() runs on a sibling device (e.g., touch) and reads
shared->pen using rcu_access_pointer() without holding rcu_read_lock():

1. Concurrently, the pen device is physically disconnected or unbound.
2. The pen device's unbind path calls wacom_remove_shared_data(), which
   nullifies shared->pen and calls synchronize_rcu().
3. Because wacom_mode_change_work() does not hold rcu_read_lock(),
   synchronize_rcu() does not block, allowing the pen device's unbind to
   complete.
4. The pen device's struct wacom is freed via devres (devm_kzalloc in probe=
).
5. wacom_mode_change_work() then proceeds to dereference the freed pointer
   via hid_get_drvdata(pen) and calls wacom_release_resources(wacom1) and
   hid_hw_stop(wacom1->hdev) on it.

While the commit message notes this lockless access is a pre-existing issue,
could this still be triggered during a hot-unplug of a composite device dur=
ing
a mode change event?

>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);
>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134417.1270=
552-1-lee@kernel.org?part=3D4
