Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053F3B6C19;
	Fri, 27 Mar 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607291; cv=none; b=rxJWW0AS35b6J9MweV6HYcNoaX9msZwrUE0944mVRWtUb0Atz7LmFgJNZbmnmO7p88p5L6Pe8CbbofEk3qoclHmU0EgcLyWptCevqdCkoM7l8us0/yXSFL5oznnAPY1dQuTIxLFsfILtUbQZtDZuqyv3ZlOPTIzMvw3qMB4i7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607291; c=relaxed/simple;
	bh=Vlajx8w8QNh8MvAeALtabdxLioTv1po+pKQpBqOE6sI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aeD02lL0N2TOSpTUC50NyhPjvuX1wZRe2fKMN6s2KW4O8HaikjptDQRA4RIhXxdgTmYGLxj9tT2RS8YhG4WLv2RooPAbgAaBS/EWuiOfVl7FHtD3CLg3CNcT/ky5G08KAvo3aOWq7X83eWDe6wgFtSujE7Nkv79rdH+4BdVLJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSCy+FAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSCy+FAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27792C19423;
	Fri, 27 Mar 2026 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774607290;
	bh=Vlajx8w8QNh8MvAeALtabdxLioTv1po+pKQpBqOE6sI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oSCy+FAeRTevbAAQCW8s9NYviKEa7deCMZd8kIo92P23+2+9OyCtNy8lrOregwRrQ
	 J9hVpveC6MBcwyNcoMPFSciEnt0GQQTII7zFfwOAzxf+iI4XJdeEF+PmTCiutK8tWV
	 6mXW4ZcClcNfSEyDuOahC1aE7N9ys+xvokk6g5RKyUJIS5xr66hW+WaqfJrcnmXsbt
	 3pFcIyFagt5FkVq6X+w1qnlMHVTC/wvEXHDgxFpMF7v1iVCBnhl1ude7SNqzfz8mB6
	 nR2qS1MfZEKCym8VOHaJXtO2q42AR6HedfuwokkdhUnGM/ZgAf2IrGANnTglf2rq6S
	 tmRvw+lqEho2A==
Date: Fri, 27 Mar 2026 11:28:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: FirstName LastName <bsevens@google.com>
cc: Stefan Achatz <erazor_de@users.sourceforge.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: roccat: fix use-after-free in roccat_report_event
In-Reply-To: <20260323161107.3478633-1-bsevens@google.com>
Message-ID: <n276n5pq-n63q-r452-pp1p-r8nq04098ro7@xreary.bet>
References: <20260323161107.3478633-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Mar 2026, FirstName LastName wrote:

> From: Beno=C3=AEt Sevens <bsevens@google.com>
>=20
> roccat_report_event() iterates over the device->readers list without
> holding the readers_lock. This allows a concurrent roccat_release() to
> remove and free a reader while it's still being accessed, leading to a
> use-after-free.
>=20
> Protect the readers list traversal with the readers_lock mutex.
>=20
> Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
> ---
>  drivers/hid/hid-roccat.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index fd0ea52f7cba..d6fff53d4ee7 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -257,6 +257,7 @@ int roccat_report_event(int minor, u8 const *data)
>  =09if (!new_value)
>  =09=09return -ENOMEM;
> =20
> +=09mutex_lock(&device->readers_lock);
>  =09mutex_lock(&device->cbuf_lock);
> =20
>  =09report =3D &device->cbuf[device->cbuf_end];
> @@ -279,6 +280,7 @@ int roccat_report_event(int minor, u8 const *data)
>  =09}
> =20
>  =09mutex_unlock(&device->cbuf_lock);
> +=09mutex_unlock(&device->readers_lock);

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

