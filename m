Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D82373BE0;
	Thu, 10 Sep 2026 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011329; cv=none; b=beRn/LqFPHLFSgiW+5tdQijzO+AtZ2sYf3/SZjaH0KsLQX61UPn+rL3ajmbEIasN1zxnI9K0v8V30AiGyk22L6mQKPXLcAi1gIOF6Awm+qGdOvZ7D6NHED5KvP/lcSHgpG1l7sXbwsKMQdOXx3A8Jr77+mFS6/Z2Hcs1AiXoRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011329; c=relaxed/simple;
	bh=NpttXPEI58+xrMFr9jvr3layLsFd6bB2WH9QY2JbHVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6ynkqRd66dXJHrilQzEE9FegiYGRCFTYbISonSn3JslY2LzhaGrR6gK52vbuT8kq7OUhZYCvIu+WyoL/yRWBjQuAdeXD9/aE7pYnoVOGwljLQt4HkJ6fshyCPt35vuCMiRiarE0NJ3vBVtOqvUFcesSvEdYsiZHyDaMEAAQe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTnrqTMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTnrqTMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892CF1F00893;
	Thu, 10 Sep 2026 03:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011326;
	bh=NpttXPEI58+xrMFr9jvr3layLsFd6bB2WH9QY2JbHVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTnrqTMGRj5d8dtJVQCWz2ABJunvtCM/cGyweifw5WSdDbdD9THcy58iVCQfH3qkb
	 iUEqUtgCkIFcR5TlTQZ4JnvvSJQmiBCY/LOHh604zAcvEtNxcIMSIitaz5dzppBm0z
	 jvF9NEUbqmU4F1TJ+dDQ8oLqkjIQL2DxE1+LxuLVSDQc7yKuaisYalUoZNVqyT3Bn9
	 91nGmNdIbjdfsFRjdIMRS2iFldq+BnynJPitJl/LKj92wKWBWcKmsB0vIJw5mEVjaI
	 4//Qo1XvDUE5Sqn1aiN1iq2GyWNi1SSHj0VMsPIEJZwMT6g+q4uI5IA8lEeBfeCgBC
	 NkJPy8hkzhpKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] HID: hid-oxp: keep configuration state per HID
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260910032115.28669-10-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-10-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:35:26 +0000
Message-Id: <20260910033526.892CF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Replace the shared driver state and mutable LED object with devm-managed
> state owned by each configuration HID. Resolve callbacks through their
> HID, LED or embedded work object instead of the last interface probed.
>=20
> Hybrid devices have distinct Gen1 RGB and Gen2 controller interfaces.
> Sharing the transport pointer and work state lets one overwrite the other.
> Keep the HID drvdata pointer valid until LED and sysfs objects have been
> released, then clear it before freeing the configuration allocation.
>=20
> Fixes: 252c4bf1d931 ("HID: hid-oxp: Add Second Generation RGB Control")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D9

