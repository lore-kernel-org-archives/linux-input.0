Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286272618
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427144; cv=none; b=CxXWYHWZtP2LM1JGng5sukFpWpEiyhVdnp3x7Ig+Xpl7BMQMylSoMTlgGjjlVHpXElRHnezAU1mTBHRbtrp2B11OEn2wfcHm+RpTMtcIrFQVelmf3hcJ26skmgKX496MiasGbhmHaeOjLjw6aTs3M3POk9HSYDqoSQijqCNJv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427144; c=relaxed/simple;
	bh=EYMt1QRG3ssKbnrXDaGcbvXDyK8VQc2T5T1MZLAjhVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O3njY+6FggX65+pSek/iF/ZMh7UELT/v4muElZPd56as/eVvMaDQAak5A1rRaiF+XGUKanBqIkm2z7fQ1fliQDFEd1CdU+4M+lCNa2hUUq9ejz1gS4PlzliJioPzt5GpmO1VtnyeE5vkmDcBIwetKrotk756YMf9S/aA2RxPASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2iHmeEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2iHmeEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65C11F00A3A;
	Tue,  7 Jul 2026 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783427143;
	bh=9a7pfQhVMe2y39BZM92KsHlXgimMDvUqRsB1sqUZrEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2iHmeEWioI0psIyPnWLscy/5VjB0aHTlfkwtcFVR6ZYl+6k5i8e3p1uqbx6PuvjJ
	 wvxS3NhO4qX3CIxE9YNfoH2nCH2fOLgqJU/KVDnWLbO4mDkUYWcokahEu5rH+1H0Lf
	 QGeinpj1b/eY5bzGBdwSaWaWchy6JkGgxcB9ANAtCPaLrfcWv1IEW13ye932ZNOdpn
	 HdkaGpxUuT0z20zgunSuT/QC+g7MDbS/guZf7B7zkjrkdVTFDnJjyyKwFQRrwkTWxq
	 tbuySu5yCGnDJjuzwCyYKYTNDOua1Ha4aG4ti8a9/NCBj1eDzqUDi3vqmBJN68HbiA
	 pvA0mpAKZvuOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: wacom: Redesign shared sibling data lifecycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707121051.1683937-4-lee@kernel.org>
References: <20260707121051.1683937-1-lee@kernel.org>
 <20260707121051.1683937-4-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 12:25:42 +0000
Message-Id: <20260707122542.E65C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent sibling unbind causes Use-After-Free in wacom_mode_chan=
ge_work()
--

--- Patch [4]: [PATCH 4/4] HID: wacom: Redesign shared sibling data lifecyc=
le ---
commit 5aab8fc5d0e17a15712b387b6273c3b728adb79d
Author: Lee Jones <lee@kernel.org>

HID: wacom: Redesign shared sibling data lifecycle

The Wacom driver coordinates state between sibling interfaces of the same
physical device using a shared structure 'wacom_shared' inside
'wacom_hdev_data'. This patch redesigns the sibling data lifecycle to use
stable static attributes for sibling matching and serializes refcount drops
in wacom_remove_shared_data().

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
This is a pre-existing issue, but while reviewing these RCU lifecycle chang=
es,
I noticed a potential use-after-free condition involving the pointers being
managed here.

When a sibling interface is concurrently unbound, wacom_remove_shared_data()
clears the pointer and calls synchronize_rcu() here.

However, looking at wacom_mode_change_work() in drivers/hid/wacom_sys.c, the
shared sibling pointers are accessed without holding an RCU read lock:

    struct hid_device *touch =3D rcu_access_pointer(shared->touch);

    if (touch) {
        wacom2 =3D hid_get_drvdata(touch);
        wacom_release_resources(wacom2);
        hid_hw_stop(wacom2->hdev);
    }

Because wacom_mode_change_work() does not enter an RCU read-side critical
section, synchronize_rcu() won't wait for it to finish before returning
and allowing the sibling device to be freed.

Could this sequence lead to a use-after-free if wacom_mode_change_work()
subsequently dereferences the touch device pointer after it has been freed
by the driver core?

> -		kref_put(&data->kref, wacom_release_shared_data);
> +		if (kref_put_mutex(&data->kref, wacom_release_shared_data, &wacom_udev=
_list_lock))
> +			mutex_unlock(&wacom_udev_list_lock);
> +
>  		wacom_wac->shared =3D NULL;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707121051.1683=
937-1-lee@kernel.org?part=3D4
