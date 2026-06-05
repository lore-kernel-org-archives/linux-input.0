Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFC4D9900
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661446; cv=none; b=nxw5L4sUknVxGCl/OegqufIIIrQFso/e1qdszGDS8k3esvz7kXmOq+Jzu1RKXFdepkuhs7Dd3MYaN22PnJxmhxctWALso3iWPpKfmDhfhf75a2yFDMVLjF98Zl80gZ7yoQYapgXRTsox81CxWmrJhNh8STlnVks6lgqdx+FBSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661446; c=relaxed/simple;
	bh=d62Y9Sl1BoXlpnDPctEFqp8BabgWPwvDvISgheC89Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAet2V1xLjVQr4Oc1DQzwaeDfY9LnhDxvXIWjQgdss/2UFJEZpSW2K2W1rpRVWUKdDRdLxi031rIiNGCbGtf/o5dSQYUGF7CXSsIgNnZfvkz0BXtxidLNsRqNeHnxqoO5Rnn+Dda1JgE73PttVbauKsRA6uYeHMLNnUAOpKfKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aGCOVhYA; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aGCOVhYA"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id C88EAC1C40
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 15:02:33 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 2CD64BF191
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 15:02:33 +0300 (EEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 62CB81FEEE5
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 15:02:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1780660952;
	bh=/vG2H2QbF1rwizWTjBaJH665MPuY+9a4CWAkdsjenM4=;
	h=Received:From:Subject:To;
	b=aGCOVhYAbhCbdEdtJdsMncbVq2j3sT29VXQtCtM09aIIueNtXqvxUwTrFES+qSqvF
	 duIP3qDzSeyGX40fSmEU+gtxOAkviZ//mmifzrX+ls+zMvS7ryzuT+NdK4/7rIQNyd
	 Ilba7U9fmAUX61lfN7HyvSD+Hv8Q2d7e31YMZ23qI7IPbUBvFIPWT3oy50II59k1QC
	 NPKnuObb0j8GK4QOEBWrBgZ3GhH8hhp4osV10n8nENtg/uN06RGLlc5yeo04j4kvYq
	 ofDyI34cU2WsfBS7oLk8XVa9mQisTpo3x/XictCtloLo3/LDFnc4i0PbWQIBK8UER6
	 pWtSvGWEVBu4Q==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.44) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f44.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so1124114a91.3
        for <linux-input@vger.kernel.org>;
 Fri, 05 Jun 2026 05:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9AuuawwnrgTbhod3Yp5rS/NnRiGpGaGRa4yuXtich3MHRIwUgtKARieAXLBe90qkpBs9uGDtHBKu9VfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7l3Ic/j+gi+N5STBQr9W0D3rEUC/lhJHzdD1UllkWuRVzw5GR
	yMQ0Ejv5p3rByfGQDgDhpSfAULO8s6Swc6H0EGGBIucguwJQ7zAMwXgOS6EDdRPwhuew+iqNAr2
	UzrcJ7oSYjbXMJnfQu7PKatP0hg4jKVs=
X-Received: by 2002:a17:90b:2e45:b0:36a:95c:7613 with SMTP id
 98e67ed59e1d1-370ef3e8fe0mr3477313a91.10.1780660950874; Fri, 05 Jun 2026
 05:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605113952.38435-1-yaseen@ghoul.dev>
In-Reply-To: <20260605113952.38435-1-yaseen@ghoul.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 5 Jun 2026 14:02:19 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com>
X-Gm-Features: AVHnY4LhTykVmLzdXeOnp1SaHvRqh0VQHccMbcjp9hcFknY8zXb0Sn7vqi3XkvM
Message-ID: 
 <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: skip interrupt IN polling for devices with
 no input reports
To: Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
 linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178066095260.3187684.4232144408968182570@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 5 Jun 2026 at 13:40, Ahmed Yaseen <yaseen@ghoul.dev> wrote:
>
> usbhid starts polling a device's interrupt IN endpoint on open
> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
> input reports there is nothing to read there, so the poll is useless,
> and on some composite devices it is also harmful.

If it did have input reports, would starting the polling still cause
issues? Because if it would, the issue is in the polling itself.

Given the creativity of manufacturers when implementing hid protocols,
I find it certain that they do use the in endpoint even without input
reports. E.g., for feature reports. This could cause regressions.

> The ASUS ROG N-Key keyboards expose a second, input-less interface used
> only for RGB control via feature reports. Opening its hidraw node (any
> hidraw reader does, including SDL/Steam Input or a plain cat) starts the

cating a hidraw causing issues would be expected, so let's focus on the former.

Asusctl has a bug where if you add the quirk that separates the event
nodes per hid, this bug is reproduced as well. I chucked it to
complicated threading getting out of control. It is the reason we
skipped that patch that was in my series.

Now, you say SDL/Steam do a spurious read as well, can you identify
the codepath so we can look into it? What devices are affected? The
early return fixes a warning on the Z13, but it also feeds through the
universal lamp interface on the new Xbox Allies. Is this a bug on
those devices or keyboards? If yes, it could be caused by userspace
hanging on that node

Antheas

> pointless IN poll and keypress reports on the keyboard interface get
> dropped for as long as the node stays open: a lost key-down drops a
> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> reports never reach the URB layer.
>
> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> asus: early return for ROG devices") is what exposes it on these
> devices by keeping the input-less interface alive instead of ejecting
> it, so its hidraw node can be opened and the poll started.
>
> Skip the poll in usbhid_open() when the device has no input reports.
> Feature reports and hidraw output keep working over the control and OUT
> endpoints, so the interface is otherwise unaffected.
>
> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> Tested-by: GameBurrow <gameburrow@pm.me>
> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> ---
>  drivers/hid/usbhid/hid-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 96b0181cf819..90a8b34d9305 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -688,7 +688,8 @@ static int usbhid_open(struct hid_device *hid)
>
>         set_bit(HID_OPENED, &usbhid->iofl);
>
> -       if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
> +       if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
> +           list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
>                 res = 0;
>                 goto Done;
>         }
> --
> 2.54.0
>
>
>

