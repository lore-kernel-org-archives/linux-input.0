Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C1408623;
	Wed,  9 Sep 2026 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985094; cv=none; b=OZ3e3knCyJyOmtIGOFWTxYZ42dOY+j9x6D7m0ZUwBLmI5CwSR0UHE3WATcqIMiyPW7RZZpP4ZYSh3tOfOcRnJpCKbQeDUP9Aft0PVSBffLPzGEHWNtRy4MwsNP0WJ7TpBYMqfIdtU9aVgeohivaMvnxGK8rOAsrj0vigYW93nsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985094; c=relaxed/simple;
	bh=7jsJaCUd4/gD/KltJOTwJr0EDDoanXwmn1HGsXrJxIk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VUATzice5g9lDVjyEXGRbk5RWpCOQ3HwfcX9FMJPIW2h3gFURxlm4Hq6/rIQtzobRCbsvx9Ryc+pAz/zaUo/OuCyJD0+t8O3kGCNNkGtKyfjy7ziZ8dv+Qm1g7thxuuKet4f5RjBK0JC3/GrMrr45Tt9JbyTcmQ8nXefcbYZThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5ejJ3LP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5ejJ3LP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC281F0089B;
	Wed,  9 Sep 2026 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985088;
	bh=dcusRtxSQFAuhQT36zKEZg3MK443Ox+3ZK2he3CnBdM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=M5ejJ3LPndGvgSrZ5unq3s5FO55zu5g2u2ol9KTQeghj+PWKk7hjqRiuf5dSaUeBm
	 2A/ZSbcgAsphv1RGo+09NI/yLVkQ1EULNyozs1EACiN1Y3myiqi9QN9b/CgWEBuh/2
	 kNuJ4LboegeBacbfb0utbAcG5tqTP+Igrq4B2gR00tqsTDQmQVqnGzUWyiMCGZXJRN
	 4QLheNuOtsYJi3irpFw9omAwPKZyTgAw4NWoJfDGqFGHuwsMD7ic5xg2cPhOoIaEUR
	 N7ds7MzsDpk6arO+O6ykmIEI13wj/YM2Rdd7Q+wehAKblZCNqsLyFANtba02uwZzXN
	 K83USjfgKayaQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id ECB4C198003A;
	Wed,  9 Sep 2026 16:18:05 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:18:05 -0400
X-ME-Sender: <xms:-76hajq8BjsWI8N_2J0hWsgwjH4UCZkSW8ea4FB--BHYRT6JQgs07Q>
    <xme:-76haocUAdzFguzB7td2ZqP8nQzblbqKbuytUrxMqEG_qtE_b8SAlto9xeKmeH_CS
    4UOBB8_YfREY10juJRL35z900J1o117LKdOmQo-VfcN15FqnqSdDK2l>
X-ME-Proxy-Cause: dmFkZTE1mRKOsuFgn9ZtDhU2n05yP8EOUKDTpZsxMvuXbpw2+GJQlhr/j+4swiq7ShTWqb
    Fi4QJ2EyhJCllrccYq97Qb6XG2aZnbqsAYoP9BrrQdD0jOvxlJpMqfB/XXzP7uC5kVViF5
    Ejd+dyQ4Jkbwhv0gWgRtdcw7Xln7Wp2hGwYK/qF9zswcb3DPyAUhJoLTMyswfoImlBjldI
    N3V/xQDnfqu3X1iE+yvRPNf/eTE88JUB/HD2tvlkMjpSJ82bYG8pet8/qQjok/ZxCdBVLy
    MLUzqVF44jJx5JN9kazIzqj7/8aBya9yT0gKRM9kGls1f+8TGI7zPPRiS+owCPL1UehRBT
    Tz/d4RgZwDGeThBrMlb49vMKm1Z1SUc4YjujfxSrDrnpuTOHTb1psooy6p53m4UNrKv5Tj
    IdSWn3XdCCUE8rfOBDDUmEtxaP239gqXMEnExFwmt58zOmueb/eebkt92nttdoFvgOnQ5e
    5sY33/eijuFyD62YXZHOQYZfn0uFuUQO4/jcMWBQBoQ1WSLlkW6BkKXV5aLL0GMFYyXoC9
    qYRhQZO78TN31EBPelNbrdL1r3S2YKnAUa91RifZga8Q2VSG5MF987aGpHjejp07snOHG2
    r3HJOA4c/w//ZeD4nBqg/yRiYNVpxsnaob9p2HRiPLdWDBVYOphyT+cdE0vA
X-ME-Proxy: <xmx:_b6hahoi0gyb80tDjUzwP70xillRshef7BHl662tdvacB8uwRLIM8g>
    <xmx:_b6hav-qlendBiqauQSXc1ZdzPHQGcRJKR4k6415a1NDO9hxcBQX4g>
    <xmx:_b6hav2KZGsEqabJ23SXEi3ZC8hYC9FUAo1t7qrCnagA44xa4QrSQQ>
    <xmx:_b6haqA6L99EcwBSVPEP03PuKLFxECYAg7mbSGrXcXjYfE_IBHRFvA>
    <xmx:_b6hamBSKQQXnJWEVPDKcH-C7wMce8m1qEVTeYxUsLoS6VKAumx0DsOH>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 95E6432A0081; Wed,  9 Sep 2026 16:18:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhZm66Q8iLEZ
Date: Wed, 09 Sep 2026 22:17:42 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, linux-hwmon@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Conor Dooley" <conor+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org,
 media-ci@linuxtv.org, "Lee Jones" <lee@kernel.org>, linux-rtc@vger.kernel.org
Message-Id: <1bebd94f-0967-4959-8323-bd4495215a53@app.fastmail.com>
In-Reply-To: <20260909133903.6428D1F00A3A@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-7-arnd@kernel.org>
 <20260909133903.6428D1F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 06/14] mfd: remove unused da903x driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:39, sashiko-bot@kernel.org wrote:
> Does this incomplete removal leave behind the orphaned header file
> include/linux/mfd/da903x.h? It appears the header is no longer used but
> was not deleted in this commit.
>
> Additionally, should the MAINTAINERS entry for include/linux/mfd/da903x.h
> (at line 7590) be removed along with it?

Right, fixed both.

> Finally, are there stale defconfig options (CONFIG_PMIC_DA903X=y) left in
> arch/arm/configs/pxa_defconfig (at line 322) and
> arch/arm/configs/pxa3xx_defconfig (at line 57) that should be cleaned
> up as well, to avoid minor kernel configuration warnings when running
> make defconfig?

I'm leaving these for a later point, the defconfigs are already very
outdated and in need of a refresh.

      Arnd
