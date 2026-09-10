Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABC373BE0;
	Thu, 10 Sep 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011148; cv=none; b=I9aLLBLk5YAhLKk/KIjvF8OHb19fl+5r88HbMQ9Nk7bM7hCsof0OaCYNJ/Ph/fBPfGXx50I5sAlcyeFcskt6j2spRM1lyqxMTOy+Xy8goD7A37YjUkxtWr3uMb6gfzeVV5gF4ghiPD/OzzVHdT91MKoCNDW1HqMlS7+0cPMC5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011148; c=relaxed/simple;
	bh=qQH2MMqkYIIN8l3R9CeZE5FUEi96mGt1BsL6xFnEd74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B8br5V+Y1/Vb5kgeTX6Np54hoTH55dGTFfdw7FmaGnR+cKwYLwVPG1jNXWhfs/tfIrVoZCxaVoQYYQn1+q3TFw3Zjukai3rE5qU9aF0S6Pz6K2j0trFuUBo033V+VfnV+HqzEQ6rlB4rb76hqrK6QfxGmg314rwiRhp9NsfDlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVY5XdG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVY5XdG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163781F000FF;
	Thu, 10 Sep 2026 03:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011146;
	bh=qQH2MMqkYIIN8l3R9CeZE5FUEi96mGt1BsL6xFnEd74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVY5XdG+UWr7Q+YOzukUJLz6a0PhbN7sn6SAxydW/6cMviMoYBWdzOiYeNN8Cwu9W
	 6mFjuDVYKR477AqIcQvOoo0O1d++cb1L0uGjLJch0+eFqjICyYJ452BmSktuNAyBD3
	 dUDu3M9dHpNIKW05YukEoKVv8aIs6TAiyQPRRQLjb/oTfaIvJ81O6ZqlS83gSQq2dW
	 8ohUREqoLspco10xgoPTkIO3mQLS14Xu+A5o18yEHg9bvilX+cOE95GJB5o4WEYrvQ
	 sSi18As6B78ZxJaaa0aNPJycXv6UjBT1d5/xbsIfoj/R08iquefJYHfpceEAredJYY
	 0ppixQAg/tDkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] HID: hid-oxp: stop configuration work during
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260910032115.28669-9-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-9-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:32:25 +0000
Message-Id: <20260910033226.163781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Configuration callbacks can queue delayed RGB, button-mapping, and MCU
> initialization work. Normal removal previously closed the HID transport
> without synchronously stopping that work, while a later configuration
> probe failure could leave work queued as devres released its objects.
>=20
> Track which work items have been initialized, reject new output once
> teardown begins, disable initialized work synchronously, and drain an
> in-flight transport write before closing the device. Use the same
> shutdown path for normal removal and every probe-error unwind after work
> can have been exposed.
>=20
> This also avoids operating on uninitialized work for HID interfaces that
> do not own configuration state.
>=20
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D8

