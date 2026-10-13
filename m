Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC23F1AA2
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884308; cv=none; b=c3dNPFKq0PfErvPZ4nuCQiOy9rotwl3Bjxz7H3JyWsCgLBQ24YylHEDIbhxGF1phWalww9gmXaUpSwamxEP6E5qLQ9qemEygAZygag3QdHEgLoN1Io+ElmYdn+UaKDKSw7uBaqxlQtVcoqAOZVYqZZgxCXbCSa31ubw7YZfOWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884308; c=relaxed/simple;
	bh=gHcgIZ2iMEVxfbz+UvcWB4uJgBLBhNxIHwxyOSMe8Cw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Rxdhc+reqa2Y5HHNTD5Jju9Vw7oly7ek72fpkD9AmHOTr7q/46WrWYYcWouA6txRASylIuDcHykwk1ylBM6wHqAeh0PJGnSzD/rByVR2tGM91J1V8LFhblahtrXMCRYo0+BNj9PwJyA8Ri/s8xNN77RZJOuno33d/2HgkCnNUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UltfJz7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UltfJz7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9BF1F00893;
	Tue, 13 Oct 2026 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884306;
	bh=uOoOIEgHggC1B9TX4S7hDvMXhv020FW8xLm5oKsO1tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UltfJz7UAgEVBLB8Uzd3X4FSw7N/P3GEzPLZuvA5NIXUcFJgKJrFhJ0M1OQi58XIn
	 pwK4MgrFznd4kKGl3ae02F/MupIWf2bMewt5udJyH+Peim7KHGOyVaxYvnkHgCjfnB
	 8D09DdSWIYpnTL0nIYvjKBeo+OWiZqHRjFMxb0jaZFmmm6AppFC1+ZtuOvMJgdFDwB
	 1tOdLxyTo7n/zqvUjx5GampefGar8sTLB64mc/FO7R5viPpQjufehl6cYR0VuonDc1
	 b9gAbBv+IQXihIjjKQsEGnN9ZTehS0qeAhrQTB5ZzQnNUjaqGyThmyO8Ekf0qAMQm7
	 TNWugjIZm2fNA==
Message-ID: <sashiko-outbox-169361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v5.15-v5.10 2/6] HID: hid-steam: Make client_opened a
 counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261013091215.529531-2-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
 <20261013091215.529531-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:38:25 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: hid-steam: Redundant manual refcounting in open/close callbacks
--

commit 606f575d1b062004ef69d4378f3403ab1764d5a8
Author: Vicki Pfau <vi@endrift.com>

HID: hid-steam: Make client_opened a counter

This patch changes the client_opened flag from a boolean to a counter. The
intent is to track how many clients have opened the hidraw node so that
concurrent opens and closes do not prematurely re-enable lizard mode.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 379e7765a93e9..78104e1246e82 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -624,7 +624,7 @@ static int steam_client_ll_open(struct hid_device *hd=
ev)
>  	struct steam_device *steam =3D hdev->driver_data;
> =20
>  	mutex_lock(&steam->mutex);
> -	steam->client_opened =3D true;
> +	steam->client_opened++;

[Severity: Low]
This isn't a bug, but is this manual refcounting redundant?

The commit message indicates this change is to handle multiple clients open=
ing
the device at the same time. However, the HID core already natively refcoun=
ts
and serializes the low-level open and close callbacks.

Looking at hid_hw_open() in drivers/hid/hid-core.c:

	if (!hdev->ll_open_count++) {
		ret =3D hdev->ll_driver->open(hdev);
		...
	}

Since the core only calls the low-level open callback on the 0 to 1 transit=
ion
and the close callback on the 1 to 0 transition, concurrent opens are handl=
ed
before reaching steam_client_ll_open(). Does this mean the manual counter
behaves identically to the original boolean flag and won't actually track
multiple clients at this level?

>  	mutex_unlock(&steam->mutex);
> =20
>  	steam_input_unregister(steam);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013091215.5295=
31-1-lee@kernel.org?part=3D2
