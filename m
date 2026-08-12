Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248ED367B79
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565650; cv=none; b=MhcSboVes9n1PXC78l+dYi351YT5p4TSd8w3Cog3VUPR551FSkHNCKXCZpge8o8t2b7zFPDnmIIgpYmklD4xhow3im+UsXnaZVHp9XhY63qKl3+QnnZaY0oMdi16d3ZCS6bNTYGDvHiOqkOV/i7wSrq2aljsv0kG4eqHwdLdEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565650; c=relaxed/simple;
	bh=vBtwxNoQilzVmuImBgmgdTqqbFpZLVjbVLqlMBaToaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f4aUIaFpGrGJBxCwT9Wd3QoozVHhW6A1CRrTFKna6eyw+76UP3LcirL2SnKCNX9S37CcfJaWhCNpBwNznyhMe705EariP493OLrKfbzewm9J0WwAZj3QtffimZUA29YccfFzOo/vzE6rAeEXpnc/XxHGzV854JMxLbSyilkmY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLE37cWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLE37cWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA091F000E9;
	Wed, 12 Aug 2026 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565648;
	bh=MyJv3ehJNfYOrsLu9VBI9eGEul2RkFgLiCND5xsJYCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLE37cWziKpaQNHGbS3wJmoA05+UD8IfAJb+qHMra4AUzd7tGI961UKN+8pxXb9EN
	 cdtR4LVTQc/uHD8ge4NblSNDfiinRasUxaEvj6opRR8bW7HACSEuSLU1DvWrmAyZJn
	 /R5YxDxnFdv9GpTg/evIH7tmRXTpTGrLWRxYS8sKAB4Kn2oX+o1od2fMVIvFuHonOR
	 8bfoIIBVO/334o93YYrgU5YiMmHydyN0mzHMhVFWRF2NIkEkx7pAGopbfDVmX2pkUq
	 ystrPHG84D6vcasCjWSNyZtkfbslYHwSc4WfX36U1QYJ7QFhmbhBDqWx5/sIjyzS6h
	 WMhIOImDBIxaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] HID: logitech-hidpp: enable reprogrammable
 buttons on Signature M650
Reply-To: sashiko-reviews@lists.linux.dev
To: "Elliot Douglas" <edouglas7358@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260812195842.77724-3-edouglas7358@gmail.com>
References: <20260812195842.77724-1-edouglas7358@gmail.com>
 <20260812195842.77724-3-edouglas7358@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:14:08 +0000
Message-Id: <20260812201408.6AA091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of `reset_hi_res_work` in `hidpp_probe()` err=
or path.
--

--- Patch [2]: [PATCH v3 2/2] HID: logitech-hidpp: enable reprogrammable bu=
ttons on Signature M650 ---
commit 21d2c84d622f6c1b7cd8dfbe446bc728f3b8bf10
Author: Elliot Douglas <edouglas7358@gmail.com>

HID: logitech-hidpp: enable reprogrammable buttons on Signature M650

This patch enables reprogrammable buttons on the Signature M650 mouse over
Bluetooth. It handles the short click-like events emitted for side buttons
by using HID++ REPROG_CONTROLS_V4 diversion to provide real press and
release timing. The diverted controls are reported as BTN_BACK and
BTN_FORWARD.

Link: https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Star=
ted-Signature-M650

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
[ ... ]
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]

While reviewing this file, I noticed a pre-existing issue in hidpp_probe():

> hid_hw_start_fail:
> 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> 	cancel_work_sync(&hidpp->work);
> 	mutex_destroy(&hidpp->send_mutex);
> 	return ret;

[Severity: High]
This is a pre-existing issue, but does this error path need to cancel
reset_hi_res_work?

During hidpp_probe(), hid_device_io_start() is called, which enables
incoming packets. If a device with the HIDPP_QUIRK_RESET_HI_RES_SCROLL
quirk sends a battery event before the probe finishes, the event handler
can call:

    schedule_work(&hidpp->reset_hi_res_work);

If a subsequent operation fails and the code branches to hid_hw_start_fail,
it cancels hidpp->work but does not cancel hidpp->reset_hi_res_work.

Since devres automatically frees the hidpp_device struct when probe()
returns, can this pending work item execute hidpp_reset_hi_res_handler()
and cause a use-after-free when it dereferences the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812195842.7772=
4-1-edouglas7358@gmail.com?part=3D2
