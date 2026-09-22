Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC78329C48
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118915; cv=none; b=WXTCO7bLZ5rYhtf96iL50lGBimLMHazqFyq+AU/KDp2R3WD58VH8ZxQgKAdo1SZMUfO1r0A5hNhfKJRnheD+xBaAY5M6oYFW9pauohCc2cWE990+kOa/f7AQ9mGYX9WygqApW2+dR9e6BAgdL4cPnAIbM5PdIsKzapPGul7aJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118915; c=relaxed/simple;
	bh=APHI8Shr/T+f8dcevsFVYn4UXWn3ERQrS9OTcF4t6uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTSqLAe3E2cH+ThgoHStpeszqvisgM10d6NPtFSgm1s636IWrx7pV7g0AKKLzgChPIhi9Y5RfeCNwK7SSScsmmQQoLHh//NSwdkKx+mzVocWpGcyP6hYH0vi3OYbzXtx03E5e6gFG6lprI3UjZH86KtYSrIZmnORcMBILZwBPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKkWAX6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKkWAX6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D561F000FF;
	Tue, 22 Sep 2026 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790118913;
	bh=UImzsuOEswpId9gf6FYKZmZq1tPS0FLpBCx/XFuSc08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKkWAX6PELTf2ws/WZ4P7ApXHDc++cgcVYP7Rb5ywRzrj/5rD3vxuuWz71EQlaqRa
	 JTtp/pYfzNGKBiIirr38S09CJ572KydJsUHoOoiVyCl2NoA4DdDgzIqIt98AgcC8AF
	 dO9hvECgFDE5++ZGd2hNy6y2mKZ3OpGItHYjlfKNm8+ldcgePbzuuj14iKqbQjLhry
	 c1A1YAU08CeIytPiR7iB/WQ0hb+7e0iMT/YSws+53+NfzO3hGQqcWUY226Xm5htWzJ
	 53H8e5LuXAYjRvGDeEAGV6Q21dahSFGYbcUIju0NTSDOqRp1pUnB9Y/pBh6cUOUWr3
	 tvIKh+P72/CQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/12] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260922230205.6847-10-denis.benato@linux.dev>
References: <20260922230205.6847-1-denis.benato@linux.dev>
 <20260922230205.6847-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 23:15:13 +0000
Message-Id: <20260922231513.B0D561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: asus: UAF in usbhid_output_report due to race in ally_x_setup=
_input error path
--

commit 8ccfbfaa682d3590de29005dd9112219250dde2e
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support to force feedback

This commit adds force feedback support to the ROG Ally X gamepad interface.
It implements a work-queue based approach for sending FF_RUMBLE packets as
output reports to avoid sleeping calls in atomic context.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bb664bd9e140b..a8ecc95f2db1f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2845,6 +2845,11 @@ static int ally_x_setup_input(struct hid_device *h=
dev, struct ally_handheld *all
> =20
>  	return 0;
>  ally_x_setup_input_err:
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	if (ally->ally_x_hdev =3D=3D hdev)
> +		ally->ally_x_hdev =3D NULL;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +

[Severity: High]
Does unpublishing ally_x_hdev here without acquiring intf_mutex break
serialization with hid_asus_ally_init()?

If the CFG interface probes concurrently with the Gamepad interface, and the
Gamepad probe fails at input_register_device(), this error path unpublishes
ally_x_hdev without holding intf_mutex.

Could hid_asus_ally_init() concurrently snapshot the gamepad hdev before it
is unpublished, and subsequently call ally_x_send_ff_off()?

Meanwhile, the Gamepad probe returns an error, prompting the HID core to ca=
ll
hid_hw_stop() on the gamepad interface. hid_hw_stop() calls usbhid_stop(),
which frees the urbout pointer.

Could ally_x_send_ff_off() then call hid_hw_output_report() on the stopped
transport, racing with the free of the urbout pointer and causing a
use-after-free?

>  	input_free_device(input);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922230205.6847=
-1-denis.benato@linux.dev?part=3D9
