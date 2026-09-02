Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD1486BB9
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357907; cv=none; b=P/aKJhMjCj8fl1ZYMu53qYq9hOqFxpxH2g38/02HZVe/18lr8WyqfM2wwQuOiNWgadsw/BEnEewQhyD2vW4j4zwe3fjVo7K9v9kkuGRdAtA+abh0zUnRaNVYjkZ5kksNEa7QgC8HcYD+3cjpQGug6qDn3Q85s62wpihCnRmwF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357907; c=relaxed/simple;
	bh=BNzwUj9pwcOvPNv1ir9NhAFky5TjRQuJ5/rPHdKolqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EhErNCDV/kxnUxmX3+8zzm3dGZdVgNpHN8+KMKjZX0y8NzFzzfOxCrwINZ3iUAQ7iH44MjFJpXhk/ccI+yeil61KPXgzGH6WcZUUKG9B8VzW5fSwXHY0Fa6q/K7fdEdWb4HpVd+Eev6Y83z7mHNHUJZWcxgJjwKYqH8lUngrkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1Kz7Eiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1Kz7Eiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851581F000E9;
	Wed,  2 Sep 2026 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357905;
	bh=srf6dc34ff9pyKBuzNzeHlyit4ezSA58oSG34XohXbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1Kz7EiyDymoK55Mhe/eCGeKTtwKUz7FVrPoG3oATySHWkrUiOn3ZIz0tbpT1ebE3
	 Y2OV+aQ3BQFoEmi+krawXno6e4y9Jh/njR5uuPuEvebN/xH059eZSaTH7QghJJgnfl
	 p7IGzZYaqSRA0tzDyWomHsnZTQsaijE5rDFNGPBsIbTHc0txV6EpWe4IsQWS/pT1p3
	 boRxTtS/8P1oTr9xudo638dtPxalf0sgHnK2dLoNCfjgO+5WGKxxZRpjQlwuDTPMcK
	 0LUQ38QP2Q7xm39iDTLlsmUG8vtDLsxLC7fHTyI2IfN3Jmcyf0Cve4+Dlg1iwgRSLt
	 TXXjcmjC1R4Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] HID: wacom: Redesign shared sibling data
 lifecycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902134417.1270552-5-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
 <20260902134417.1270552-5-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:05:05 +0000
Message-Id: <20260902140505.851581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in wacom_mode_change_work due to unsafe RCU access =
and lack of sibling synchronization.
--

commit 144702a97dac139acf4377ec2bc37fa17f37b11a
Author: Lee Jones <lee@kernel.org>

HID: wacom: Redesign shared sibling data lifecycle

The Wacom driver coordinates state between sibling interfaces of
the same physical device using a shared structure 'wacom_shared'.
This redesigns the sibling data lifecycle by eliminating a volatile
representative pointer and storing stable static copies of the required
attributes for sibling matching. It also switches to kref_put_mutex()
to secure the lifecycle against concurrent probe/disconnect races.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 12f6a32cbc5fc..9b991078a36d8 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -883,17 +900,19 @@ static void wacom_remove_shared_data(void *res)
>  				rcu_dereference_protected(wacom_wac->shared->pen,
>  							  lockdep_is_held(&wacom_udev_list_lock));
> =20
> -			if (touch =3D=3D wacom->hdev) {
> +			if (touch =3D=3D res_wacom->hdev) {
>  				rcu_assign_pointer(wacom_wac->shared->touch, NULL);
>  				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> -			} else if (pen =3D=3D wacom->hdev) {
> +			} else if (pen =3D=3D res_wacom->hdev) {
>  				rcu_assign_pointer(wacom_wac->shared->pen, NULL);
>  			}
>  		}
> =20
>  		synchronize_rcu();

[Severity: High]
This is a pre-existing issue, but does synchronize_rcu() properly protect
against concurrent access in wacom_mode_change_work()?

When a sibling device is removed, this devres cleanup clears the sibling
pointers and calls synchronize_rcu(). However, wacom_mode_change_work()
retrieves the sibling pointer outside of an RCU critical section:

	struct hid_device *pen =3D rcu_access_pointer(shared->pen);
	struct hid_device *touch =3D rcu_access_pointer(shared->touch);

	if (pen) {
		wacom1 =3D hid_get_drvdata(pen);
		wacom_release_resources(wacom1);
		hid_hw_stop(wacom1->hdev);

Since wacom_mode_change_work() executes in a sleepable workqueue context and
uses rcu_access_pointer() instead of rcu_dereference() inside an
rcu_read_lock(), does synchronize_rcu() actually wait for the workqueue to
finish?

If wacom_mode_change_work() is executing concurrently with sibling removal,
could it dereference a dangling sibling pointer leading to a use-after-free
when the sibling's devres cleanup frees the memory?

> =20
> -		kref_put(&data->kref, wacom_release_shared_data);
> +		if (kref_put_mutex(&data->kref, wacom_release_shared_data, &wacom_udev=
_list_lock))
> +			mutex_unlock(&wacom_udev_list_lock);
> +
>  		wacom_wac->shared =3D NULL;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134417.1270=
552-1-lee@kernel.org?part=3D5
