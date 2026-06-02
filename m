Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099436A03A;
	Tue,  2 Jun 2026 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399560; cv=none; b=hNZjKzNAkIop0G0GDvWSAYhYdSnYM9GeJPjXeX6thFjo3LXg71a9NkncPyi93dmSBMrbLpNLtJvpXre4gjDL3yezhAQOQw8fTVLIu9ywcQQB/xQtYc799C/nOzYl252zUkMgtYIkPy5D0A+l7FfjYMLw21MHiZRJshnJ7QGFF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399560; c=relaxed/simple;
	bh=Pz62QgA5sydDrg/K6JTj/fvfr0i81/qK2+zQrnMrFeY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i35Xjn+uCSmi3ieaXo6eN7WYqRvFzzCxe2U+hCtLBbWlWMy4wTj8w72VDd4ouQ62eh/kJZ12+g1q0lj5H67PO+jZsfOgia+cMxlEPNYBx9xu8AW7Mnd15iQIJDuBtVEopd5w5PAfrlKE+tFHnrtzArQ+XVLYQSUSy9KLjKJdMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LBfNWYS2; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LBfNWYS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780399557; x=1780658757;
	bh=Pz62QgA5sydDrg/K6JTj/fvfr0i81/qK2+zQrnMrFeY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LBfNWYS2Fh/wtB/Iu3e4+/JfZHsiOCawsX2MJO+YiVz3uczNAfhpjcrHB0YnTRrWO
	 GBYeIxl7bMvkJ9mgg0zhp24QFpIEKVPSTnIhz2sEb+Gv080S+dvg2WVD3zK8B1Ow2g
	 KGnddv202TByvv/Tdf8lun6LP4EFtshdnoHKa4ZJWLkEZCkXU8nB+8/xcKTCPjk0qX
	 IpCOnUBpO862HD1XdPyrVbm7UJTRzI+U9Kj9ZHhN7Un/f7sICPU45R+zAaV7BtBoLp
	 5tlkoAE753vRNER1VRhu2CjqI6BdziiPX2u2iJnaRN2Z3r1b5TpBwOD2XlDlkXvVS4
	 kYOGc9aMefvoQ==
Date: Tue, 02 Jun 2026 11:25:52 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev
From: Tj <tj.iam.tj@proton.me>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Rafael Passos <rafael@rcpassos.me>
Subject: Re: [REGRESSION] RIP: 0010:hidinput_setup_battery.isra.0+0x6d/0x370 [hid]
Message-ID: <21e69916-1cf1-462a-9578-145918a07de4@proton.me>
In-Reply-To: <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>
References: <ah6vRH9J9LSvnKWW@mail.iam.tj> <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: b930cfe45a05467e32eade3f4c0a9f3c5e328cfb
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

v7.1-rc6 + "HID: Input: Add battery list cleanup with devm action"=20
confirmed fixes the hidinput/bluetooth issues. Thank-you.

On 02/06/2026 10:54, Thorsten Leemhuis wrote:
> On 6/2/26 12:24, Tj wrote:
>> Hitting this repeatedly with v7.1-rc6. Do not have time right now to
>> bisect it (and there are two other regressions at the same time).
> Again, not my area of expertise, but this looks somewhat similar (but
> also somewhat different!) to this recent regression report from Rafael:
> https://lore.kernel.org/all/20260602011949.2825852-1-rafael@rcpassos.me/
>
> Rafael (CCed) sent a fix for it already applied:
> HID: Input: Add battery list cleanup with devm action
> https://lore.kernel.org/all/20260602030519.3097058-1-rafael@rcpassos.me/

