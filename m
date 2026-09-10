Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EC306B3D;
	Thu, 10 Sep 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010980; cv=none; b=Fxdr87O5DQI7F6g3gzcrPisTDlBrq6IAwDM2pna1+relI0G8Wq1i9CEE9nkUVXrBNIQepG/AhegWLsf8l/rBcztGCkuBXfvS8KlnaSx1YdqmeuFcmyPemA/rN6aFXHfcQyxMozFYirwSHMP3oYbNemCAqbIYoKpzyEQxPCSOKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010980; c=relaxed/simple;
	bh=UuocKBYAy4U6OR6qlsxRVH4miwlVRY6qcdEKNxihDIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsyI3zcOxHxUNbbceD+6suCN9MHRlpGip3pS9Zy2ydLi6p1L1mWtZQF4LurGShFZC02cw9ubQbjB9BSjnK8p4SlvkA4tRTxkF4np+FCqwswE+uxsMixnZfFSbRRK/zmHYzDCXCkcFUUzM3JG55YJKN5r4Jpyxv8mJHpUQMZ1NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1tlEbgN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1tlEbgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF911F000FF;
	Thu, 10 Sep 2026 03:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789010979;
	bh=UuocKBYAy4U6OR6qlsxRVH4miwlVRY6qcdEKNxihDIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1tlEbgN4u8ou/OIhmHMI/ym2GGE2GJ7b9CLwDZrqxoFSdcqYEPYQHkbT0MgajagV
	 ON+80bZnVGggs8s2UrJhE1Ui6Y9p0hpa8g0PGoeit7Z0rbGC/SPCN5wnLYdvfnSA8X
	 oV9BcYG8bew2ljf3TU7/bWJoKQu59Eb7C1vMxcxA25B/EpBBXFkNW8Ql++urhbNjpl
	 XPVv3onN0jAhrnwTBJeYB7TgarSToVN/fybhVANxBpEDqUXyKVF+DcX3c3PdRchjR/
	 vlkajVkHuyWprRL4xRAkhGSyQrx1utJgODp8UXM4Yixh17k/Doc+xJ6nQZ5JhbEvT2
	 1xibd/Ka0fvNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] HID: hid-oxp: retain fractional brightness when
 reading RGB status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-input@vger.kernel.org, lee@kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910032115.28669-4-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-4-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:29:38 +0000
Message-Id: <20260910032939.1CF911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Multiply the hardware brightness level by the LED brightness range before
> dividing by four. Dividing first reported every intermediate hardware
> level as zero instead of 25, 50 or 75 percent.
>=20
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D3

