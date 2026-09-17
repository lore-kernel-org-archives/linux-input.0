Received: from outbound.st.icloud.com (st-2005d-snip4-6.eps.apple.com [57.103.79.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207834AA019
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683818; cv=none; b=kYupvwMOGr3Mcz5Rvukzo0llNrMxwk4gVnDZoZiDQrCWWVevQXQO7zZj34ZXoEm3S9nv35DnYf5Oyqoq4zO05sXDkDV69bE5iSGA94i5pynsRQZ9/Q96Ps5F0BZcUVi8MkZJcy3vFyxqK/W3JthRnK1iHSBeQ33Kmoj0/ZktfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683818; c=relaxed/simple;
	bh=kugFPBA4tTBAdX3vaHtWW0B4rH5DShiF7hvNxNYsH8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr17uuyvQvis5nEB2za3itKQmMHon3Zch8oHBygmXe4W1k3iAYUjp7ZTGlPDqQuhu74wXoq65x0sL77PJPFghG/0NBx7l0JUj5pkAcHorv4vgVV+sEWcycvLmOZMDAzNGGAvaaSZ2SKgs9DoBEttex3dahGtbNiRz6XVldyPAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=RqAVgsvq; arc=none smtp.client-ip=57.103.79.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="RqAVgsvq"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id 0317718003DD;
	Thu, 17 Sep 2026 22:23:31 +0000 (UTC)
X-ICL-RepId: 01a0b177-c643-71ce-9121-a6b8c2e1b462
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhAAkMDWBxBDUAdVQFLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwRJA01fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDgBWH1sRSlZeCBcGWxQERAFdBV0CSQhPAV8FWABHF04AVA5SH0EUEFYBWwRyHVgMWgxERV8VB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1789683814; x=1792275814; bh=kugFPBA4tTBAdX3vaHtWW0B4rH5DShiF7hvNxNYsH8E=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=RqAVgsvqYSKxMi4pi3IoFvQybuBAdjDwK63jqJV2YwgO/uXVHQSkefxwFbdVdIKxIVBASeQS+eD0GUrUZjJsloc648Ese3Zmp4y5j7ZCEWddMIF64Cdve2e5HaCYvvDKVaPL8Kivl50MsJhy1XRJbWqIWAamV+PsmjLeo4zKkRXzh7BXB7Wjc946qpQ6sce5hFQkhtLLZF7rWPVg/nCgSNQoNmXR8wl4leyzpifL8kS/Gu2culgBa4y9E9nqzmyU7xOiIWEmTWPIDQozMM7Xqpv1aQqM+BaJSbeXMjSTY5HG7VvYwLCFJr7/WN01Fj0GwlweprIuNJklPLaCjTjNQg==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id C66DD1800343;
	Thu, 17 Sep 2026 22:23:29 +0000 (UTC)
From: =?UTF-8?q?Mat=C3=ADas=20Mart=C3=ADnez?= <hello@matias.me>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v3] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Thu, 17 Sep 2026 19:23:27 -0300
Message-ID: <20260917222327.63999-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAGwozwEkgP9-VwhW81=WEvJOac5iD+PFO4tA4eVrFP_qDVaiWA@mail.gmail.com>
References: <CAGwozwEkgP9-VwhW81=WEvJOac5iD+PFO4tA4eVrFP_qDVaiWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vC00ifSTAagcc5B6Ut9Mvcv68Kn-g7vU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMyMiBTYWx0ZWRfXzZfDEDv+aIHV
 ZgkXYZp7lZ5i7Ot4AcRw4cCfJv1QqqNFhgG9CbVNmRHZkxwl6+NdHTMoqyxonlvGX3HM/cjjE3O
 s58F6enMTgRAuSiSSREzm/0JnDN1ybCexRre/h0UFGAINxp+ZX0O0z/+WaSfblZdLgcuL4L32wr
 Z/aNC+c/dRVVhjgbNWNVcgUvTkb/a+17PW9kFwgXsf/OpR5krI18xcJZhpjMKRVosq8IYEpRzlO
 6P+NyyJtQ6/MOpDcnqvuApul2J7aHoIrpMtMgLsDYAz+UYKoFFcF3vUk/XTs7WKdkQv3+kESLUs
 IenEvogzzEQFZMSWXQBkIaCcdrkVFbxE7WNuvqk94KOCwUmsrEa/TjBuvSlOe0=
X-Authority-Info-Out: v=2.4 cv=A79h/qWG c=1 sm=1 tr=0 ts=6aac6864
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UXTgv3SQjDT3V-MyfE8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vC00ifSTAagcc5B6Ut9Mvcv68Kn-g7vU
X-JNJ: AAAAAAABWM2/d37/K2wwaDF51dXRxolePJhEmnPPf2pVP2THYVl4Pce4MHotcFTGDsi32YJL+fgGTiqwfWwjiq9hMzbvI2+48hiYygD0XOr47MdHXJhQYwguMCowcxJh5HZ03/G6Jzm1d9XINZncAKCqH2BdMQ0QsvMDjYmOJ/0eU2lKFTYzDFUNzzUxHgL4j6s8sdR1f3V7L906j8eKAG9to75ltksPNkZetZuaXxRA+zmDbaV+B+o+yjctyHKiEUkJFz86R7gpMPq3mni7UoGDIBzZgRbFKk0NQsJXuOeBt/hxboKD8JLNc3pT7Q6twimMlTv4UT62AujcKJo1JkzDF1137s/5alxzxlGzoIKTAZVjfkq8aodRbpck396vTcFV59wAraK4OcjZnetrKzbYFdfn8VFkoQOccRgJHYJMMdbYgjheps4+KQDv3lzlacqjhg+7Pa249X6xtij2naIMNPkDJghwxvwfsskI+gNBcTeb2ImdpmSuqyMes44ybjIGK9L7EfMQLviymvnc54RnHh4x4bnwiF/LtPrXJjxXAR8a89LO5tC5ysCus7f6CyZ8s5hdtf3tIfupDe+bL565DsIHwHxU0VPwx7XczmpvcW/2kXgkUbAST8/MFZrTldb/NyST1X2WgVP5+Y9Jk7uOvEMK19ddX4bzZN50Wr4aHkINFhha50DXQRsnyBGkE/3s7mn2G/ZN/z+MILmovhHbUAM5kq8vXsLz5x8jTfAAVVZ+CnO6LP863fTWoVyRi8UvNlS15PU96EqpiiHIk/RNs8qj7wfQhCaNxIqvtmRhZl6vwp3eaUap7XdRkvqhVZTs5e30LRktWzGL1vPQYvy9CJzOAT/gbiXEQDCXSoltDd19yCMHiCOf9Eo9tryioWCwpbtpuzl6/MflY/k0kXoWQDUOayor8qMNOONeCBILDUVveg4t3ZAy9k/XNhk0FDEJ+NQ01FOgJepU4rnLV6SHL4HOtQX
 oY9xkBFhVb9enRQqu0KnIm2zSBPBy3E0wYq7JjBldnfGTHrOA6dZVNmAe2/H0PabL4vufdoslTKVXsyz082NtenMwi+8KUwFxXfWw5tULlAYdnis+q5yO/n+r7NsXUE6x4rzBK3cAl8nnpbJNKlpY/JGCiXHzYLJU3AEvf1wAlNvZxGvbpGnLsS3N5rYM137eix7nJRoiXqydsNNbFETHCEYvPNe9E6mCs13nPOFUUfTUdr+XJVefC/JZdJskUiS6eo8Hfon2f1XvFU7qYRoLgOKKPIu2Kc8kNXPSa3f/1Sbn8Ak7zoTCsRI7WMOKz8oJe/yCVUNoJkl4ZTL497P1K/UMO2RRsnfmwjMRx3Xx3BpLdS/bF4ETmKlcniXgTF6+mi9x1nhPgPVZf2smAd7iKJa3

On Thu, 17 Sept 2026 at 23:48, Antheas Kapenekakis <lkml@antheas.dev> wrote:

Hi Antheas,

Thanks for going through v3, and for all the help along the way. This
driver exists because of your protocol work in Handheld Daemon and
your reviews of every revision here.

> After you submitted your patch series to the lore, why didn't the
> review take place here and take place downstream?

Sequencing rather than intent. The OGC kernel folks wanted the driver
submitted and tested in their tree first, and their maintainer's
review landed on the already-merged downstream PR after v1 and v2
were on the list. I folded it into v3 rather than ignoring it. Agreed
that from here on review belongs on the list.

> The rby Denis should not be added by you. It should be added by
> denis by replying to the mailing list and then you carry it forward
> on future revisions (for provenance).

Understood, I carried it over from his downstream review round.
Denis, if you are still fine with the driver as of v3, could you
confirm your Reviewed-by here? Otherwise I will drop the tag in v4.

> Consider exploring similar ABIs in e.g., Legion Go S hid and
> mirroring their ABI. Then remove this file. This is not the only
> breathing device. Moreover, delta_t values are ignored and you are
> introducing an ABI for them?

The delta_t point is fair: hw_pattern accepts timing values this
firmware cannot honor, and the sc27xx precedent does use them. For
context, hw_pattern was my reading of your v1 suggestion to find an
accepted ABI for the pulsing mode, and the downstream review
preferred the generic trigger ABI over adding a custom effect
attribute, so the two reviews point in opposite directions here.
hid-lenovo-go-s documents its effect/effect_index attributes in its
own ABI file, so a doc file exists on that path too, though shared
with a second driver it could become a common one. I am happy to
switch to effect/effect_index mirroring hid-lenovo-go-s (values
monocolor and breathe) if that is the preferred direction. Jiri,
Benjamin, a preference either way would settle this.

> I am not sure of the struct naming or whether a struct is needed in
> this case. if you do not use most of the report, consider
> documenting it somewhere else and doing direct accesses to the
> appropriate bytes.

The packed structs came from the downstream review, mirroring
hid-lenovo-go; they replaced a set of byte-offset defines and the
static_asserts pin the wire sizes. I would mildly prefer to keep
them, but I am fine either way if the maintainers have a preference.

> If you set vibration, you need to expose it to userspace. Otherwise
> this driver degrades functionality over userspace implementations.

Agreed. v4 adds an attribute for the vibration level (the firmware
takes three) plus an index listing the options, instead of writing a
hardcoded default.

> Prefer removing semicolons; they have a particular smell ;)

Will reword the comment.

> Consider dropping the hid_device ... check block unless it is
> necessary. it seems like a premature test that can go wrong and you
> touch the device. Particularly, hid_device_io_start is a bit
> unconventional.

Agreed, v4 drops the probe-time status check and with it the
hid_device_io_start call. Every sysfs read already talks to the
device live, so the check adds nothing, and without it the driver
generates no traffic unless userspace asks, which also keeps it inert
next to userspace implementations like yours.

> I'd suggest waiting a week before the next revision and up to two
> weeks for jiri/Benjamin to reply with some comments as I think I
> was the only one that reviewed the previous revision.

Will do. v4 waits for Jiri and Benjamin, and goes out as a fresh
thread.

Thanks again,
Matías
