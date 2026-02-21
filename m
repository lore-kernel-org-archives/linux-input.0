Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5B2DECA8;
	Sat, 21 Feb 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667298; cv=none; b=tciKDQOdeEQu+QM49cfRpt5JQcbM8acD0JzoUm/RbxFvPCUuKpuRQUSlCeW/iJI7pzpcd67H95kCTvy7mtegDawO6rU4BRf061AN1A4kuJtQ2METYOa+Bpq50wcKIP2Qi6VkPLskQidO6cMd/H9ftDNixaZ87mWeDh2Ac/x2HcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667298; c=relaxed/simple;
	bh=hkSeGuS1y4o33bSzqRDo/rppJDHhaDJDxaPnSg5wlao=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bCPZEv58IFCMX8g8h39MFs4/OX7+sZNsH8gi4FvZTvB7jtmcHEOlS3DfcVX4CF4oGRjeflpaSSAY2KJmBBkDF5nr+nm3WrjlNaSFkBTnwt7nLkewYjzzZkLa+GIwiXXQyQMU3UNvQRuqF27Nbt/uXKg8DQvqvIu8MsxJXO30IQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4k6N3VA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4k6N3VA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0717C4CEF7;
	Sat, 21 Feb 2026 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771667298;
	bh=hkSeGuS1y4o33bSzqRDo/rppJDHhaDJDxaPnSg5wlao=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=L4k6N3VAXe+JmzJJ4dgLlXtGX0US6fAARNi9Yn73Zx2tNh1xKkvS5da41OLr/XOa6
	 KyP7rLs0ILacup6JCFcn1wnUr9g3vG1kqmRsUYnbJH0UnqE+EWDqgcv2geXBURg3ws
	 ekxE1ugpogKkZO7neLtAttP/bCDstoZIuevkIwfGl9+/25ehRV8K56NYIOcWB0tWio
	 8WgHmP1VGHAYcVrXTw+Rt8bFTuRWuu7k85+buCA2eHRHNo9wc14u/inFCpviePf+rv
	 ts/de5jb+OrqI+3pKLAaEhHxXp1TVu0ebkLEHHWDUtcMq8xKUGRGWrepOBOYT0tcrC
	 QoUNhd+OhFTlw==
Date: Sat, 21 Feb 2026 10:48:15 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Rebe?= <rene@exactco.de>
cc: Lukas Bulwahn <lbulwahn@redhat.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] HID: quirks: really enable the intended work around for
 appledisplay
In-Reply-To: <944F8139-6528-442E-BFC2-9609A7DACA2D@exactco.de>
Message-ID: <9pos2s83-p7q0-oq36-oqo3-s555o07p31n9@xreary.bet>
References: <20260205081131.426899-1-lukas.bulwahn@redhat.com> <944F8139-6528-442E-BFC2-9609A7DACA2D@exactco.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Feb 2026, Ren=C3=A9 Rebe wrote:

> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> >=20
> > Commit c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for
> > appledisplay") intends to add a quirk for kernels built with Apple Cine=
ma
> > Display support, but it refers to the non-existing config option
> > CONFIG_APPLEDISPLAY, whereas the config option for Apple Cinema Display
> > support is named CONFIG_USB_APPLEDISPLAY.
> >=20
> > Refer to the intended config option CONFIG_USB_APPLEDISPLAY in the ifde=
f
> > directive.
> >=20
> > Fixes: c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for app=
ledisplay")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---
> >=20
> > Note this fix suggests that the patch of commit c7fabe4ad921 in this fo=
rm
> > was never effectively tested, checking the effect that the commit messa=
ge
> > claims it would have.
>=20
> Thanks for spotting this. It was tested when I did this years ago. Though=
, maybe I
> tested before adding the #if IS_ENABLED, anciently hit some key in Vim, o
> something was renamed since then.
>=20
> Either way, I=E2=80=99ll get the display out of the basement and re-test =
it the coming days.

Is there any results of this testing, please?

Thanks,

--=20
Jiri Kosina
SUSE Labs

