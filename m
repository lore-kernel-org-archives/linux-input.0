Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA92D1F44
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534289; cv=none; b=ZbHO4aVvmVMPeenPz+aPqgTRP+6eavpdribZd6fHIokNpj/zmBQhNdJNFwl5S2lg+x/nid3uVvcT/SwNCGi9/XliZ82diWgo2XEOW+BPzFeluac9eH1tt9+VPe8eSryDmhJrJrFamzdxRByvK3QpfjEC6fTCfRJb+zn2EdtIZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534289; c=relaxed/simple;
	bh=NklJIS2/KTCA1qpXoaecInzLTKYcNUX7wGHnRo0eogo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/Q+5YpY2YWOynsnGT4ZaOxcJdg9E3fsNwZangCfvSohsw5Sl5lOMZSGmVAASv06ZB2NfHhiAWUDk6a9GCs1MHi/QnK6x17vP42EkWbxNRcmru+gNCggiRZIyQ8VrDFdIVKV1kJ1DsK9LJJNmgJwWFjtxnuiZ3wtTUJ4yZbnJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAzHhZj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAzHhZj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10D41F000E9;
	Sat, 23 May 2026 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779534288;
	bh=v8BgrstwtnOeDOzHlHrhaStciWK3oDyJsYOf9xlqfow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAzHhZj8pj49FQ6YFfgOnkLEBR0V3gGIqpS9hYZxEK+DbFuUjBDQ7jPu/mLOmfScP
	 pmMvDnpr5QMbH4rgVHqr738kGEpBYsWUL3fpmk2++K42xloyp6RlZIT2+646LZw8G2
	 55vMQNtJLy0BLrytk5MUusv/j95endfZyP5cF+Wg+jSLj5fjSpbVeiwLg+jL7THEKf
	 lR0Uw6mvKyga6u6Yt/3RFqTxP8XEZw5Y5bI2Ossv/uj9/+rUAhwtvTgNKe+0bQ0WyB
	 k1UOYmjskP53CXIQnHj+XhHaI/EylncljRkBWRxMzPhn/ogoLiQsd3eFLoJsT4ZcIU
	 YcxrtlMVTQPEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matteo Croce" <technoboy85@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260523105545.68079-1-technoboy85@gmail.com>
References: <20260523105545.68079-1-technoboy85@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 11:04:47 +0000
Message-Id: <20260523110447.F10D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Demoting the `bsize < rsize` warning to debug level masks legacy A=
PI misuse and silently drops valid short reports.
--

commit c89b6cb8fc074729ec292f2ffe95d958722d1447
Author: Matteo Croce <teknoraver@meta.com>

HID: core: demote warning to debug level

This commit demotes the "Event data for report was too short" message from
a warning to a debug log to prevent syslog flooding from devices that
regularly send short reports.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 41a79e43c82b3..503b9bfa5d379 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2072,8 +2072,8 @@ int hid_report_raw_event(struct hid_device *hid, en=
um hid_report_type type, u8 *
>  		rsize =3D max_buffer_size;
> =20
>  	if (bsize < rsize) {
> -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %zu)\n",
> -				     report->id, rsize, bsize);
> +		hid_dbg_ratelimited(hid, "Event data for report %d was too short (%d v=
s %zu)\n",
> +				    report->id, rsize, bsize);
>  		return -EINVAL;
>  	}

[Severity: High]
Does demoting this warning to debug level mask legacy API misuse and silent=
ly
drop valid short reports?

The bsize < rsize check correctly returns -EINVAL to reject events where the
allocated buffer is too small, preventing out-of-bounds memory accesses.

If the UPS device triggers this warning because a core API or legacy driver
incorrectly uses the old hid_input_report() function, the legacy API
implicitly sets the allocated buffer size (bsize) equal to the received
payload size (csize). When the device sends a valid short report
(csize < rsize), bsize also becomes less than rsize, causing the HID core
to incorrectly conclude the buffer is too small, drop the report, and print
the warning.

Silencing this warning fails to fix the root cause. The valid short reports
are still incorrectly dropped, but now they are dropped silently, potential=
ly
leaving the device broken. Furthermore, demoting this warning hides genuine
buffer under-allocation vulnerabilities in other HID drivers.

Should the caller be updated to use hid_safe_input_report() with the actual
allocated buffer length, so the short reports can be successfully processed
via zero-padding instead of returning -EINVAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523105545.6807=
9-1-technoboy85@gmail.com?part=3D1
