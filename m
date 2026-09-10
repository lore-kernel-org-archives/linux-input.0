Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653336728D;
	Thu, 10 Sep 2026 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011199; cv=none; b=F/S9dj11KWNfyPfsPm08EE1Jobz/AHq+r6iczCQpYdUwWW/6RBWq9PCqRAw7+nkfEHZaJduy6aQT9+QlB/fWqJdJFEPUAAeP+wXepEaW3hpybxxX3H6oILyh8jG348cJ6DeWCK2TgjoRsGqLZOOlZ9xqqCQodF9Pd00ZkIS12jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011199; c=relaxed/simple;
	bh=rnu0gcNjLru6Wfyxxgx6akGpcPi9KX9oP3OK4rwX6v0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DMbbhtdLA8qbHQjtsrngO80jk+gZpSA3OkxW9DnlOtZ6UUVHe1qcfL3VVIcuSO9YWSWNqGe/Cm9NzLk5af3wYChBancNhA4F0RK2z6Csxk7gKH1Xjz7K2knxi7946s7NFbvscLVh+Mcxi4i5rhotJDNJ7TYzjuhgxaMTKyjC2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNl/iHUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNl/iHUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEB1F000FF;
	Thu, 10 Sep 2026 03:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011198;
	bh=rnu0gcNjLru6Wfyxxgx6akGpcPi9KX9oP3OK4rwX6v0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNl/iHUENgSGIO+s5h97bazAIzvAvt+9eTjgnK/6HFt8LLuaz41jhLt6j2vLW8+By
	 f98scAv7wnPe+2kkd4Dr70DvI5Q+EBHcn1W5+Z7GKxbHUGG0TRx7EUjG/hhW3yCuAF
	 Kyi/hg4nY2VLY9LudTbl4X9Ki8fcs8SxWolu0vSz0ICO9Pyvf/GMF/1mJgilcDgzEl
	 kItrmRHMijSt7Ew5COX7Pya7x6dN8tR0eJilo3IaxEnhIrz6pANuaK+ZM1xAg5iMSb
	 tyllpSzkpCddhY+eS8DsOR7wgbHawcsyfPcIVXlKsJHrgnn4GjBq9Dnp4QeWyHcXwv
	 O9DCufIADVtQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] HID: hid-oxp: fix multicolor LED intensity
 scaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260910032115.28669-6-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-6-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:33:17 +0000
Message-Id: <20260910033318.1AAEB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> The controller accepts eight-bit RGB components, but the sub-LED channel
> maximum currently inherits the 0-100 overall brightness range. This
> prevents userspace from selecting channel intensities above 100.
>=20
> Set each channel maximum to 255 and use the multicolor LED core helper to
> scale components with the requested brightness. This also replaces the
> private truncating calculation with the LED core's rounded calculation.
>=20
> Keep the existing Gen1 and Gen2 color packet layouts unchanged.
>=20
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D5

