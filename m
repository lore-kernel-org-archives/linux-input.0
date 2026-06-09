Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1A377EC7
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008537; cv=none; b=ms2WJhnB4af+TrURUtablJrrHP6GAGkAODchxr62uDJ/f0yVyTA0OGczMi+BUexzOlgKoFh++X6JbKDsjXsWYgqvDa2OQyHaYABarujFXAUFASIXXpWfzInoy0CejSESV0xvolibipn3TkFQNYRd8eW+8QLrxPNo3ePv26gLOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008537; c=relaxed/simple;
	bh=DhTCCnCz7zObPJOk7NmYesJtOM/1jG9iuIReHpVrkv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A1v9kO8t2QssMnsDuQN3jxlte7GCKukMoKzBTnJFSDVbmLAp0Jyk+ByNXtcJXRhbVeiZfZAPfblTVThbsg+CV0AJr7CqdolUJ7jHfA+3mdtpd/X4FXW38lolrqqm8ZxvhwzJj7ugb/DgbxuD/XoyTGj6CACIeliZGSLgOCZuITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olojvfut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olojvfut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF781F00893;
	Tue,  9 Jun 2026 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781008536;
	bh=oRT14UQAghT1PobQ6ELbYfidyKcI29UergMZjiaJzjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olojvfutK1PUpihyAVSU/3ZiKa+54Szk9pClibHYIlUAeYsuUceWDDBsyOY14loK6
	 qSQCbhAm2nFMaXYkuJuURmcR/rUVyhNXU4iSi3vF6hTVWOv5eegaopOPtq5iC66L4v
	 Vk4izDXYWs6Lv0lzp+eSfTyY66f5wMaOhUYfTyt2ahjvz/tA0wf3LGNkOwqFHP4mUS
	 A9aCAT66Ppt0NOLW550PA6xAFKIRW9Aug3YVjqNb4eY1wbgsnrUE3hgKFz1vFmQiXR
	 qbVavRMpviZ4wnpHKQ1NcNxrZDt7H5ysZe1oIzFDGCd/kXPmY+GmRO9mjQTKtrv3uK
	 0MVHxP8eX7vjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260609121353.3743782-1-lee@kernel.org>
References: <20260609121353.3743782-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:35:35 +0000
Message-Id: <20260609123536.0AF781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless TOCTOU Use-After-Free of sibling devices in wacom_mode_ch=
ange_work
--

commit bb8e808fb26bf4a0ca1a10604a506fb1d60c8173
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad

This commit resolves a time-of-check to time-of-use race condition in
wacom_intuos_pad() that could lead to a use-after-free. It introduces
RCU protection for the touch_input pointer, wrapping lockless readers
with rcu_read_lock() and writers with rcu_assign_pointer().

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2220168bf1164..7ba5898265481 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
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
This is a pre-existing issue, but is it possible for a sibling device to
still be used after this synchronize_rcu() call?

Looking at wacom_mode_change_work(), it reads shared->pen and shared->touch
locklessly:

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
	if (shared->pen) {
		wacom1 =3D hid_get_drvdata(shared->pen);
		wacom_release_resources(wacom1);
		hid_hw_stop(wacom1->hdev);
    ...
}

If a context switch occurs right after shared->pen is evaluated as true,
could a sibling device be physically disconnected, triggering
wacom_remove_shared_data() to nullify shared->pen and free the object?

Because wacom_mode_change_work() does not hold an rcu_read_lock(), this
synchronize_rcu() wouldn't block it. When the workqueue resumes, could it
pass the now-freed pointer to hid_get_drvdata() and cause a use-after-free?

> =20
>  		kref_put(&data->kref, wacom_release_shared_data);
>  		wacom_wac->shared =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121353.3743=
782-1-lee@kernel.org?part=3D1
