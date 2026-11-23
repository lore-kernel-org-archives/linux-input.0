Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449789;
	b=vZn7Rb4fgQC7H81Sxvd4jWKPV2bxewiLfAoAjRpZ9A93g8D03YEOGhI0kyJW5TGgIv+Y
	 loPNX7gZPaTRY0bL/eS/b6miyIwkW5E79o9uCd2zCGWOz4AAjeurluiKurCS19Upq4UQW
	 iNJ9NqM707iSdPIJ88vJXPlgKLuF1e98FwYoBKATL6sG36j8SW/IQcwSVySnCDlgKAQgX
	 sYDeeZLzp58O7q0AhOk/oPSqT3ycaRejVVG08CuBDyZZZqLpf/854yvRgIh68wmgWX24n
	 eXIcCDrycY0arhYXxrvE8WjzHJ1Y15yjut5SYCJv1Rgzj7413pYDTPZxq9O0Q2ptTJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2bKwX8/0xwPLG8NqRAEVEVQ9l8GTz67aGjgtFzQpugc=;
	b=RtEi0j01fVbxG/ZF3YaeettlZdsOoUsS98J2+3BKxBGFJkJ0/Y4XgUlpGoD8pRQH9Zlo
	 rAfbvQX5r9gfrXtAM93TCeUlNcrkBcqfA/RXUJo6L2OWI+fmR4itTrVP5wBNjp/GtpLt2
	 ux4yo1Pp1s7Kq74EFxr2lWhnNsY/HyNRQq8adMro+lhrC4Y4poLWwSBm2Y57yCYE1iRjf
	 6aONeOIU/ItETcX1i1aeLklBRG6uvlhJ/tmPPhTpXCvDdvAnrUFMuHQNoXvloGJasXRQ4
	 PNawsWzI6noAjZP7Uzbzn7NhYHClhPPGRPQvBgpT+KvsTpNTvK8znU373Xwbfr5toYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVd85TZt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0881606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVd85TZt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C811F000CF;
	Mon, 23 Nov 2026 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449788;
	bh=2bKwX8/0xwPLG8NqRAEVEVQ9l8GTz67aGjgtFzQpugc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVd85TZtwoWwQzUyHasU684eVLMD/QHnfkEAV5JVG1Mi/oq3GkcVg6PuKdl3DqxZZ
	 DpLhCq0lT2Z/mQnYjW3pJGHK47c60+41jqzr5ZOzKvnXeW4Wq1Kuy7LBkAI7pwsOYz
	 07x4KUDWURs7rmlOvxWnzwG4EqBZA7c7uIppqrBXM/aZ6jihFdkKYRbrJGUeeeKeMs
	 MDCh/r5beJC4qQKLTUpb8qlLPjRTVY6v0WT3vPXeoUv4lrMTozBKfyD/9HvQxH501q
	 zKjjmOTXUgs8LFmsqm9cJV1idAXAcgJgVf6DvCAGQcrrrD/DIzV0P2e+r2aVDNFT24
	 9QaKSKmoFAlDw==
Message-ID: <sashiko-outbox-229637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erlend Jacobsen" <erlendjacobsen@pm.me>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261123-b4-rdmctmzt-v2-1-8c18d7dac4bc@pm.me>
References: <20261123-b4-rdmctmzt-v2-1-8c18d7dac4bc@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:03:07 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: rdmctmzt: 60s retry delay in rdm_battery_work() on first
  answer
--

commit db1494c514873abbd1e68abaf2e2c2ff69742269
Author: Erlend Jacobsen <erlendjacobsen@pm.me>

HID: rdmctmzt: add RDMCTMZT keyboard battery driver

This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
dongles to poll battery status over the vendor raw-HID interface and
report the dongle's wireless link status.

> diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> new file mode 100644
> index 0000000000000..cad89c22577d4
> --- /dev/null
> +++ b/drivers/hid/hid-rdmctmzt.c
[ ... ]
> +static void rdm_battery_work(struct work_struct *work)
> +{
[ ... ]
> +	if (!linked) {
> +		/* A keyboard that comes back starts with fresh counts */
> +		rdm->silent =3D 0;
> +		rdm->fails =3D 0;
> +		wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> +	} else {
> +		rdm->silent =3D answered ? 0 : min(rdm->silent + 1, RDM_MAX_FAILS);
> +		rdm->fails =3D got ? 0 : min(rdm->fails + 1, RDM_MAX_FAILS);
> +		if (answered)
> +			wireless =3D USB_WIRELESS_STATUS_CONNECTED;
> +		else if (rdm->silent >=3D RDM_MAX_FAILS ||
> +			 rdm->wireless =3D=3D USB_WIRELESS_STATUS_NA)
> +			wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> +	}
> +
> +	/* Without a link the dongle reports when it comes back */
> +	if (got || !linked)
> +		delay =3D RDM_POLL_MS;
> +	else if (rdm->fails < RDM_MAX_FAILS)
> +		delay =3D RDM_RETRY_MS;
> +	else if (rdm->dongle && rdm->silent >=3D RDM_MAX_FAILS)
> +		delay =3D RDM_SEARCH_MS;
> +	else
> +		delay =3D RDM_POLL_MS;

[Severity: Low]
When a dongle keeps linked =3D=3D true while the keyboard is silent (such as
bcdDevice 0x0102 reporting link byte 0x00), three unanswered polls leave
both rdm->silent and rdm->fails at RDM_MAX_FAILS.  If the keyboard then
connects and answers RDM_CMD_START without returning a battery status yet
(for example, refusing with 0x0f before measuring the battery),
rdm->silent resets to 0 while rdm->fails stays at RDM_MAX_FAILS.

Does delay then fall through to RDM_POLL_MS (60 s) instead of
RDM_RETRY_MS (5 s) on that first answer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-rdmctmz=
t-v2-1-8c18d7dac4bc@pm.me?part=3D1
