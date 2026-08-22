Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77238F92D
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435498; cv=none; b=rbDgcqWiD9bZ8phBtcIptu75bdfMdQl5Xv24l1M8I8hg4XM5qXbQ8OIjY8lnUDnSpqS7Ymc9pIZ5DGyIcBQYzCOXR2SNSaJ2v6UTBN+mcgS0rPYgWXhAnl4LC9CW3ukGIex/GyiCo8TQ9e6709PPt5lToRACR1oFqKf2P09WS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435498; c=relaxed/simple;
	bh=Z3p6M1oqMbduY/ZFexiZQSfBHSd5Ugtvr1eItUodlZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CVQlyAq1tOgJqQCt8+++WiDV0mYMqArL/sivyvyFGx9M9xiLwVP0oUV4+x4ihwB08BTRIzhdcX2zxJMpQJpqCS7gbIv+TKqLm6Y6wzXhsKL/IMXZlkiH4PPR5jp7LH2iXg/RGei7Ny5eiEPgbxFX0b7Tnnu1r1L81l2PyrUFfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmC83UQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmC83UQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFBE1F00A3A;
	Sat, 22 Aug 2026 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435495;
	bh=3qVreF6U0LUJxwiIOHm87eXtmBvpIfMaDIQ9wGux3V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmC83UQWV61a3/TmQj16ctkHrsgo/O+TugTyECqX8hOc4ahLG5gYpkMkBey+nrA1O
	 rnfeBll0R+eSzfjwz+mOfLqo13bQQDUbUqwNLpb30oL+HMaVymvNlCCNebnuhkg/rZ
	 gLMa3VobRG0Z2KBG7h8IT2QTTThs+MBKkjff/7Uup84DcYyVIWP1qxsuBD1jIEq1dc
	 UDRVbhdsEf2HtpervpQ6z2JY+QjqiSyGMZROOolfPwFYsxlw9GHxmxjuDvk8BzVvmM
	 X8fbj2Q6TU8EISRf6CjzMsVc9Gv9iWVPZ9RlWvRAkzwrkXRWsbwm4wxThFdN5oKTH3
	 qV9E8jv/gd71Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] HID: ft260: i2c: silence sysfs store big-numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822213941.98882-6-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-6-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:51:35 +0000
Message-Id: <20260822215135.8AFBE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The patch unconditionally overwrites the error code from `ft260_hi=
d_feature_report_set()` with `count`, masking hardware write errors from us=
erspace.

Pre-existing issues:
- [Critical] Double free on UART probe error path and Use-After-Free during=
 device remove.
- [High] Native endianness is incorrectly leaked to the device when parsing=
 multi-byte sysfs attributes.
- [High] Teardown order of the wakeup timer and workqueue during device rem=
oval allows a Use-After-Free via a re-scheduled work item.
- [High] Manually freeing `dev` with `kfree()` while a devres-managed GPIO =
chip is still registered creates a use-after-free window.
--

--- Patch [5]: [PATCH 05/13] HID: ft260: i2c: silence sysfs store big-numbe=
rs ---
commit ebf18ef9c09c87f02215b8dbbbe0f60a02ef6565
Author: Michael Zaidman <michael.zaidman@gmail.com>

    HID: ft260: i2c: silence sysfs store big-numbers
   =20
    FT260_ATTR_STORE returned the feature-report transfer length from
    ft260_hid_feature_report_set() instead of the sysfs write size. For
    values like 1000, userspace writes more bytes than the HID report
    length, so the VFS retries the remainder and reports "Invalid argument"
    even though the attribute was applied correctly:
   =20
      $ echo 1000 > .../clock
      bash: line 1: echo: write error: Invalid argument
      $ cat .../clock
      1000
   =20
    Return count after a successful parse so the full write is consumed.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 4435a39fce239..8db896f164cd0 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1479,6 +1479,7 @@ static void ft260_attr_dummy_func(struct hid_device=
 *hdev, u8 req, u16 value)
>  				hid_err(hdev, "%s: failed!\n", __func__);      \
>  			else						       \
>  				func(hdev, req, name);			       \
> +			ret =3D count;					       \
>  			mutex_unlock(&dev->lock);			       \
>  		} else {						       \
>  			ret =3D -EINVAL;					       \

[Severity: High]
Does this unconditionally overwrite the error code from
ft260_hid_feature_report_set()?=20

Since the else branch lacks curly braces, it appears ret =3D count executes
even if ret < 0. Could this mask hardware write errors from userspace by
incorrectly telling the VFS that the write succeeded?

[Severity: High]
This isn't a bug introduced by this patch, but does FT260_WORD_ATTR_STORE()
leak native endianness to the device?=20

drivers/hid/hid-ft260.c:
#define FT260_WORD_ATTR_STORE(name, reptype, req, func)		       \
		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
				 __le16, u16, kstrtou16, func)

It passes a __le16 type directly to kstrtou16(), which seems to write the v=
alue
in native byte order, assigning it to the little-endian report structure
without cpu_to_le16() conversion. Could this cause incorrect device
configuration on big-endian architectures?

[Severity: Critical]
This is a pre-existing issue, but does ft260_probe() have a double free on
the UART probe error path?

drivers/hid/hid-ft260.c:ft260_probe()
hid_fail:
	kfree(dev);
	return ret;

If ft260_uart_probe() fails after tty_port_init(), ft260_uart_port_remove()
calls tty_port_put(), destroying the port and freeing dev. The error path
then calls kfree(dev).

Similarly, in ft260_remove(), does this sequence cause a use-after-free?

drivers/hid/hid-ft260.c:ft260_remove()
		ft260_uart_port_remove(dev);
		/* dev is still needed, so we will free it in _destroy func */
		if (dev->chip_mode & FT260_MODE_UART ||

This dereferences dev->chip_mode immediately after ft260_uart_port_remove()
has dropped the final port reference and freed dev.

[Severity: High]
This is a pre-existing issue, but could the teardown order of the wakeup ti=
mer
and workqueue in ft260_remove() allow a use-after-free?

drivers/hid/hid-ft260.c:ft260_remove()
		cancel_work_sync(&dev->wakeup_work);
		tty_unregister_device(ft260_tty_driver,
					   dev->index);
		ft260_uart_port_remove(dev);

The workqueue is cancelled before the timer is deleted inside
ft260_uart_port_remove(). If the timer fires in this window, could it check
dev->reschedule_work and reschedule the work item, which would then execute
after dev is freed?

[Severity: High]
This is a pre-existing issue, but does manually freeing dev with kfree()
while a devres-managed GPIO chip is still registered create a use-after-free
window?

drivers/hid/hid-ft260.c:ft260_remove()
		i2c_del_adapter(&dev->adap);
		kfree(dev);
	}

And in the ft260_probe() error path:

drivers/hid/hid-ft260.c:ft260_probe()
hid_fail:
	kfree(dev);
	return ret;

Since the GPIO chip is managed by devm_gpiochip_add_data(), it remains
registered until the core processes devres actions after the function retur=
ns,
leaving a window where the GPIO chip can be accessed while its backing data
(dev) has been freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D5
