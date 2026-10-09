Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AA3B9D98;
	Fri,  9 Oct 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585789; cv=none; b=PYzK6Q5RsMfBYUkBbIG+RajBcSUVz60t4TWIP/CaNNmL4IgbBk/xiZxDWw+7/Q5Tk2hXwp+sJuA9GO0KH34kOLHnKLr5s8hPMUZUI9/LX6z3RLHdiN+jLyfMaGGntlBIDQaYw5FzII/XoDm38h0wHS7mGiS+TR/8LFw/ZNwtv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585789; c=relaxed/simple;
	bh=t0Cuus17c2jhVpB24oJNjpT9ohWUgou9/KKAbMac6sE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YquOMVkuE5bBAnNt1fhC1R+7ORjY1mrWDom1sH0ebx5WJxPPBjlooUqHb1GtqlMdzOQ2fNNN2y2kaqBWPucjzGxXCSfyUo/I0j484BtLtzEq+nCiJU52FKat36i+f4C7G5oWWovUkWJOdEKr8W+NEZ+DxbeQEmupDTo5ng1tc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWYjIFqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWYjIFqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704D11F000FF;
	Fri,  9 Oct 2026 22:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791585788;
	bh=+pO0HrJhJqvLuPJQS/64z/UpGim+n4GcYOaIbZsRbLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWYjIFqirimRdWt10k477XglwxY8CKao5tpo3h/khaKtqh6nc6izMOuTp8XKVrnvQ
	 cHDJhf4fNiGB+ZKX+PfGarR4Iax+hNB9Brdn4r1MnmKISIdTKG2yczwKAWfV0PZRWp
	 0KRkWuYirHZCq54qOZw7bw2qtZuGk2bTwcH+nhsnV3DMS4FSfZg3+cypy6fSl3Zkip
	 ct7bEbSlbcTLCjg7lUG86eanAQVkaAnoavEoIvKyIUgvtXd8MqROJhIRHlmPYd69it
	 VokXhpjEuWRsslseLBzFwPNXI6KQUjUcrvkwLwDT6o+0SCSteXtBnYeXPRgsI6Bnxp
	 dD3Lm+1LZlAOw==
Message-ID: <sashiko-outbox-166155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] HID: spi-hid: add power management
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20261009-send-upstream-v5-10-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-10-384af01da3ee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:43:06 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] spi-hid: hid_driver_reset_resume() races with error recovery dur=
ing resume
--

commit e43c402ebe88a8dd98c0bab5a81f64d825faf560
Author: Jingyuan Liang <jingyliang@chromium.org>

    HID: spi-hid: add power management implementation

This commit implements power management callbacks for the HID over SPI
driver. It introduces suspend and resume operations, handling device
power state and reset coordination during system transitions.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index f4e9b4e1294ed..66bfc251bd915 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> +static int spi_hid_resume(struct spi_hid *shid)
> +{
> +	int error;
> +	struct device *dev =3D &shid->spi->dev;
> +	bool was_reset =3D false;
> +
> +	guard(mutex)(&shid->power_lock);
> +	if (test_bit(SPI_HID_DEAD, &shid->flags)) {
[ ... ]
> +	enable_irq(shid->spi->irq);
> +
> +	/*
> +	 * For devices that may wake up, process work that was pending when
> +	 * suspend cancelled reset_work. Otherwise suspend already dropped it.
> +	 */
> +	if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> +	    test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> +	    test_bit(SPI_HID_ERROR, &shid->flags))
> +		schedule_work(&shid->reset_work);
> +
> +	if (shid->hid) {
> +		if (was_reset)
> +			spi_hid_wait_for_reset(shid);
> +		error =3D hid_driver_reset_resume(shid->hid);

[Severity: Medium]
Does hid_driver_reset_resume() race with error recovery here?

In spi_hid_resume() (drivers/hid/spi-hid/spi-hid-core.c), the power_lock is
acquired at the beginning of the function and held until it returns.

If a wakeup-capable device suspends while an error recovery is pending
(the SPI_HID_ERROR flag is set), spi_hid_suspend() cancels reset_work and
leaves the device powered on.

During system resume, spi_hid_resume() reschedules reset_work to handle the
pending error. However, because the device was left powered on, was_reset is
false, causing spi_hid_resume() to skip spi_hid_wait_for_reset().

It then immediately calls hid_driver_reset_resume() while still holding
power_lock. Because reset_work requires power_lock to execute
spi_hid_error_handler(), the scheduled error recovery is blocked until
spi_hid_resume() returns.

Consequently, hid_driver_reset_resume() attempts to communicate with the
device synchronously while it is physically still in an unresponsive error
state, which will time out or fail, aborting the device resume.

> +		if (error) {
> +			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
> +				__func__, error);
> +			return error;
> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-upstr=
eam-v5-0-384af01da3ee@chromium.org?part=3D10
