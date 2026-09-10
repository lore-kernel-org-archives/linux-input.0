Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113838F92F
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058551; cv=none; b=Isp0dQfuJLn3cT5X9sD+WgcL12UyCYDoPJGygsQKl539LiwJLx+vYkqqSo0O+AOuCkiCS1C0viOHnX3KqbDvhV7dGS/FvWRgX4gSUWw19s8ttT+Xow4IkkCtTGkt65PxpnqeVQPptAfyLPNeVjMd+Xuv7583QWOk6jb+fiB4hhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058551; c=relaxed/simple;
	bh=6R8tmC/f3MWQ2Soy7JintTYFlCViY9rIjHDns534hng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mig5muj6uDyN+174leqCdH3SfJ+EJ3o3PykARq/LOIoJj9dxsZdxWERnKtjTCK14f0A+B039zFeqG80NmFdsNsPjzf37vDXcZJ6pXFeRf0RHHCbcN6pNrTPaL5uwCsuaAL9BjAzB8wpPfghCoZYxGuUhn/UkqD7VaQzfKI35wYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF6rJXgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF6rJXgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7E51F0089E;
	Thu, 10 Sep 2026 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058550;
	bh=ROlKeVZqIkqH4HBdB9CQyqHjIC++rIaUSpbLqqkYPEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WF6rJXgW5ogBbIsXHROimQUw0lT5ynO10W7qZPC9zZ8IImN1Ux+5EWsTzDQgJw0FZ
	 wu4YXxw8yGTNCpBx4uXGlofMj3UQCB6pKwwUbSf/n0gZROuonF+efw0gvlE7PcsICZ
	 BWNcMhNfx3HALIb43E3S+4lGnyf5e7TAcEOX6lh7wphZ782KXxuES7o3cY1OMnDikX
	 HuaPkNcmrEvKI3wWOfbBJgXJrrTF6zQAdWIDZi9rMnYwx/4WdQlY8nvtddb+p75SNO
	 tibwRvFXxcL7D07gw0vJF0D2AIVJ0w2G6+P8y3AmXwLV7viVQW2nbH1cHif7NEiLbC
	 o16J9GTgoUbEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: multitouch: use GFP_ATOMIC for
 report/application allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260910162331.31578-1-ngocthang2710.1999@gmail.com>
References: <20260910155305.58E4A1F000FF@smtp.kernel.org>
 <20260910162331.31578-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:42:29 +0000
Message-Id: <20260910164229.CC7E51F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but lockless modific=
ation of the `td->applications` list can race with concurrent iterations, l=
eading to list corruption.
--

commit b30bba4fe7febcb978a1ecb8c9146a4d278538eb
Author: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

HID: multitouch: use GFP_ATOMIC for report/application allocations

This commit fixes a lockdep warning by changing devm_kzalloc() calls in
mt_allocate_report_data() and mt_allocate_application() to use GFP_ATOMIC.
This resolves the issue where these functions could be called in softirq
context and improperly attempt to sleep.

Reported-by: syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D093e05755c2d99caab91
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 451c7324e6a06..5fdc383aadef3 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
[ ... ]
> @@ -633,8 +634,9 @@ static struct mt_application *mt_allocate_application=
(struct mt_device *td,
>  	unsigned int application =3D report->application;
>  	struct mt_application *mt_application;
> =20
> +	/* may run from hid_report_raw_event() in (soft)irq context */
>  	mt_application =3D devm_kzalloc(&td->hdev->dev, sizeof(*mt_application),
> -				      GFP_KERNEL);
> +				      GFP_ATOMIC);
>  	if (!mt_application)
>  		return NULL;
> =20

[Severity: High]
This is a pre-existing issue, but does lockless modification of the
td->applications list later in this function race with concurrent iteration=
s?

A malicious USB device could send a touch report to arm the
mt_expired_timeout timer, and subsequently send an unmapped feature or input
report. The unmapped report triggers mt_report() -> mt_allocate_application=
()
in softirq context, mutating the td->applications list via list_add_tail().

Concurrently, the timer callback mt_release_contacts() iterates this same
list locklessly:

mt_release_contacts()
    list_for_each_entry(application, &td->applications, list) {
        ...
    }

Similarly, a local user writing to the quirks sysfs attribute triggers
mt_set_quirks(), which also iterates the list without synchronization.

Could this concurrent modification and iteration corrupt the linked list
pointers and lead to a use-after-free or kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910162331.3157=
8-1-ngocthang2710.1999@gmail.com?part=3D1
