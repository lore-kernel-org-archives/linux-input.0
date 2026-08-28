Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F684377541
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925143; cv=none; b=an4qzDU9YpNbCcxfjYPiJa82nkk6XBTVq+AQHY5MHaOMl89rsZ8y+pQr8rXHNcLMvbvan0NvXOxYZIaX6SL8/FozMgaQn+wuDke/WEKjMyZFOFtxxapSfxBuFPEgnryouBBxTwCTmWaTfC7Lx1iS+NeG2af9yOEYTdpZ0tAN73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925143; c=relaxed/simple;
	bh=3O1Kl677qMkBq5fS35V7IQWpCu63RuyjnxweQSq8cfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZuqerPC1aYycczNW7+CvKmz39dwet/Pjhe3s8YqULDuEPULirXpQcAbwIdwoiW8WPr3eZOa02w4VdMLbem7IxgAYhhyLHQmSnr9dlFA2gmZgM7khnGT2JyHFX7w9Uh87NmkSJQ5GkbTYtPOAinOBCp6JenwG4OXKldx//3SyChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6dF4eP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6dF4eP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA0D1F000E9;
	Fri, 28 Aug 2026 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787925142;
	bh=eNCZA21pqkj3YcYbhCTb22mCqMA4O7R7gctNq5kXBlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6dF4eP6ma4j8fT6rUgyJaHFIZR9swfUIPkKSxrmii+HxwldtOV6Yj9xm5RkpF13w
	 0r+SuldaiJp3UkRuWfNLbqFYFo05Slt43fErsIozx3WyyYyycYxaAGNqNB4u2Ibaf+
	 YwCaFkdyBlP+ozBYv5AzT2nzaO+VePADqL36+xZmPx4nMrEzd2F+K9jPrCVy1NixPN
	 Rt8hWvNHVIOE+PVapc5PDfq2omlV1C/OijrA9+P2gE9zrxVWmhI5mtocXxyUe/LL5x
	 Du5f/VCKfFw/cH9+VTBoweCPkfU7GJeoEPcF9sUU3N3sFG83o3WWI3IDYoCETeuTE7
	 whdh9jnLzSigQ==
From: sashiko-bot@kernel.org
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 atkbd_set_repeat_rate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeffin Philip" <jeffinphilip14@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260828134149.128160-1-jeffinphilip14@gmail.com>
References: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
 <20260828134149.128160-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:52:21 +0000
Message-Id: <20260828135221.DCA0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double-lock self-deadlock on `atkbd->mutex` in `atkbd_enable` and =
`atkbd_disable` when called from `atkbd_reconnect` and `atkbd_attr_set_help=
er`.
--

commit 590703593bcdcff9b9b0f25df1465a3e3cd68c7e
Author: Jeffin Philip <jeffinphilip14@gmail.com>

KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
   =20
This commit adds mutex guards in atkbd_enable() and atkbd_disable() to
presumably protect against concurrent access.

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 3509b58e64920..f7c71278ecaa4 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -694,6 +694,7 @@ static int atkbd_event(struct input_dev *dev,
> =20
>  static inline void atkbd_enable(struct atkbd *atkbd)
>  {
> +	guard(mutex)(&atkbd->mutex);
>  	guard(serio_pause_rx)(atkbd->ps2dev.serio);
> =20
>  	atkbd->enabled =3D true;
> @@ -706,6 +707,7 @@ static inline void atkbd_enable(struct atkbd *atkbd)
> =20
>  static inline void atkbd_disable(struct atkbd *atkbd)
>  {
> +	guard(mutex)(&atkbd->mutex);

[Severity: High]
Does this code cause a self-deadlock when called from paths that already
hold atkbd->mutex?

For example, when the system resumes and atkbd_reconnect() is called, the
mutex is acquired right before calling atkbd_disable():

drivers/input/keyboard/atkbd.c:atkbd_reconnect() {
...
	guard(mutex)(&atkbd->mutex);

	atkbd_disable(atkbd);
...
}

Similarly, writing to a sysfs attribute triggers atkbd_attr_set_helper(),
which acquires the lock before calling both atkbd_disable() and
atkbd_enable():

drivers/input/keyboard/atkbd.c:atkbd_attr_set_helper() {
...
	scoped_guard(mutex_intr, &atkbd->mutex) {
		atkbd_disable(atkbd);
		retval =3D handler(atkbd, buf, count);
		atkbd_enable(atkbd);
...
}

Since struct mutex is not recursive, attempting to acquire an already-held
mutex here will cause the thread to hang.

>  	guard(serio_pause_rx)(atkbd->ps2dev.serio);
> =20
>  	atkbd->enabled =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828134149.1281=
60-1-jeffinphilip14@gmail.com?part=3D1
