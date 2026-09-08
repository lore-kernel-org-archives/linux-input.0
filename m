Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB724C9001
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890500; cv=none; b=EBKEENGzX+dcMl4veXFJMWGePmqq1xidklo67NN5LMzPHJgTTaxfE9gj32jV6j6KEi17tZISM4zJjNlpi9k36iFLR+wEt4Qa108a62Du9w271qfvmEkRa4fXiGmStzMZ4uOSQMs9QZbyx7h5r9xFStmR9FBMxLEucAnEsSHOnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890500; c=relaxed/simple;
	bh=z9MV916dtREXN0SckaHmmWifTPCAgpPOeZjaWj9CCjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e47O2H292JGCc5sTPl4kmFVW3KUlhGOG6cGHdQExhg+IBWfyLBICIBDHQfQIdu+bB9C8feY8Q24vMkkbM26O94KQ+763llbEqsd2KUT1BzMJhaLqgna/zzzNRpXzltf0WZS1VWjz1h4LCcBKCd7KPpRnrK+fUeLalGY7p2nfjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHNFI7RA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHNFI7RA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20601F00A3E;
	Tue,  8 Sep 2026 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890498;
	bh=uiutDKebPJ7lgu0DPI+naoH5WaAc4AkmaLUA+PcuOAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHNFI7RADOjGMMsAj6fcV7apO08/YmiWN9JOJDsoVkJ655JN7ZeF0X8jK3ML+iZ55
	 CGbuoLoqK8vHySulNbUxLmCqlc8whZ0pJDuYVzPouMGrOU4O3RoITchv3rISOHuMzw
	 ZlEKMQ35QVEDmtVfnDkndZXjfRPsZz/mdz4gWkYs7zh+ORkblRx5LzrsJTnJxRrAWB
	 2CFfzUONi5hyTECjwt0RP05rLtKRJZ0keRuizniX/TL657XsxnqPmuCW2vxs5pKcRR
	 To0jAqqs98haq+P/1UzaB7e40sPU9PtrKrYylDKeebxsUfAVxsgHmsQvRP3xM9aZgf
	 +j118RSzxUndA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908174433.74260-11-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-11-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:01:38 +0000
Message-Id: <20260908180138.C20601F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Initialization race: Force-feedback is explicitly disabled after=
 the input device is registered, which can overwrite initial userspace effe=
cts.
- [Medium] The patch modifies `ally_config_remove` to check `cfg->resp_curv=
e_support`, which is an unrelated silent fix.
--

commit c8ce80cc859079772aca255e9aa0ce6f78c88d5a
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support to force feedback

Unlike ROG ally the X version and following ones uses DInput protocol
and the force feedback needs to be implemented as its protocol is
vendor-specific, therefore add support for FF_RUMBLE with magnitude
scaling on a work-queue based approach to avoid using possibly
sleeping calls in atomic context.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f338c0eed54b3..a75e6bd947907 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2544,7 +2580,8 @@ static void ally_config_remove(struct hid_device *h=
dev, struct ally_config *cfg)
>  	 * create them, so a device without those capabilities does not
>  	 * trigger a "not found" warning.
>  	 */
> -	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
> +	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
> +	    cfg->resp_curve_support) {

[Severity: Medium]
This modifies the sysfs group cleanup behavior for joystick response curves,
which appears unrelated to the stated goal of adding force-feedback support.

Should this change be split into a separate patch to keep changes focused a=
nd
match the commit message?

>  		for (i =3D 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
>  			sysfs_remove_group(&hdev->dev.kobj,
>  						   ally_cal_attr_groups[i]);

[ ... ]

> @@ -3074,9 +3264,17 @@ static struct ally_handheld *hid_asus_ally_probe(s=
truct hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
> =20
> -		spin_lock_irqsave(&ally_data_lock, flags);
> -		ally_drvdata.ally_x_hdev =3D hdev;
> -		spin_unlock_irqrestore(&ally_data_lock, flags);
> +		/*
> +		 * Make sure rumble starts disabled: this is the interface that
> +		 * owns the force-feedback output report. Failure is non-critical.
> +		 */
> +		scoped_guard(mutex, &ally_drvdata.intf_mutex) {
> +			ret =3D ally_x_send_ff_off(hdev);

[Severity: Medium]
Because ally_x_setup_input() runs just before this block and registers the
input device, the device node is exposed to userspace before this hardware
initialization packet is sent.

Can this result in a race where a userspace daemon immediately opens the de=
vice
and sends an initial rumble effect, which then gets silently canceled by th=
is
OFF packet?

> +			if (ret < 0)
> +				hid_warn(hdev, "Failed to disable force-feedback: %d\n",
> +					  ret);
> +		}
> +
>  		break;
>  	case HID_ALLY_INTF_KEYBOARD_IN:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D10
