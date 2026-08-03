Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D5423EAD;
	Mon,  3 Aug 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778320; cv=none; b=HnSWGVsdSzSHQ8znJL0xqygiYpQh1LMl0b1cQhorGQnQVMOVlYt7In4fRd23JAPKOkja54rbCOQEuD/915D+mYn+aW4L1qAenrEO/44LQdMLjHq8yQ6KgB3jXR+C5D5f8PwtnB2eTYUBXlP9NDzRCPry/Io25XR9TjMrJXNWRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778320; c=relaxed/simple;
	bh=ZmTv11aSUoLZcLqs/EOTw3gAfXe+3/Az12ow0b0KYVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SCNKeMUpZdcgKXKmK6PmXEU0wZ++8czQtmrch2l02T8X/B49Q5T+KpqhlVc7TuprtJHlW6TDl9tllFn+dfarO2xOQXN1iq4zPh2VlmRqiy91/ax46YtAKI0+UMOxj98pUEuzTNMrqBiHfbL5MgmXPObyOlC1ggRpIdZZLrReP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML4ARUX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML4ARUX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD1D1F00A3A;
	Mon,  3 Aug 2026 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778319;
	bh=ZmTv11aSUoLZcLqs/EOTw3gAfXe+3/Az12ow0b0KYVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ML4ARUX+dx2fj7QJge8F0uw6c8QSp1tYgxwcVTSb9YHcQIrWN105UfD2aJdjaZ7yQ
	 KgByCiZpqDja/EI/ZpU1B3woBBgRY8bDev1f6ErLxL2RP0bQCELW+Vl8n2RLdiek8B
	 OzzskEO43KvuBGQmbNyJ8b9687MezFwSpr6JUhTGXk/gC/40jgPUtIvVdStv+zNQ0Q
	 nT7faVZkgmIqa+ykqTNIXfTjalSNJhMHpIehla0IGGaKn5laIWCmUTho9wKzV3HqTT
	 lqZVZwnljsvaKi4/Y47O2IaMuFYmuM7K7IDPH5p8b61v2a/+GUSubORNHRUa1xNbgZ
	 86ISGVWtMhEjg==
Date: Mon, 3 Aug 2026 19:31:56 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?GB2312?Q?=D0=BB=D6=C2=B0=EE_=28XIE_Zhibang=29?= <Yeking@Red54.com>
cc: linux-input@vger.kernel.org, hansg@kernel.org, dmitry.torokhov@gmail.com, 
    bentiss@kernel.org, dianders@chromium.org, linux-kernel@vger.kernel.org, 
    sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
    superm1@kernel.org
Subject: Re: [PATCH v7] HID: i2c-hid: Refactor _DSM helper and add
 i2c-hid-acpi-prp0001 driver
In-Reply-To: <tencent_76FCB13C1FB6FBFFA004F2D19AF6E458030A@qq.com>
Message-ID: <03p5n920-8r8n-nqs5-p353-o7q1qo68sr6o@xreary.bet>
References: <360r0r52-n546-s91n-s51p-893o79415s74@xreary.bet> <tencent_76FCB13C1FB6FBFFA004F2D19AF6E458030A@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Jun 2026, =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) wrote:

> Move the _DSM call that gets the HID descriptor address from
> i2c-hid-acpi.c into i2c-hid-acpi.h as a static inline so both the ACPI
> and the new PRP0001 driver can use it. While refactoring, move the
> blacklist check and the _DSM call to the top of probe() to avoid a
> pointless alloc when the device is blacklisted or does not implement the
> _DSM.
>=20
> Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
> are declared with _HID "PRP0001" and _DSD compatible "hid-over-i2c" but
> lack "hid-descr-addr" from the _DSD and provide the HID descriptor
> address only through an ACPI _DSM. The OF driver fails to probe them
> because it requires hid-descr-addr. Add a new driver that handles these
> devices by calling the shared _DSM helper.
>=20
> Link: https://lore.kernel.org/tencent_F6FC553D1BB737FC00062AD0FEF43C580F0=
A@qq.com
> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separat=
e modules")
> Signed-off-by: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.co=
m>
> ---
> v2: Name the unused parameter and document why
> acpi_device_fix_up_power() is skipped.
> v3: Add a dev_warn() asking users to contact vendors for firmware
> updates, and use existing locals in devm_kzalloc() and
> acpi_device_fix_up_power().
> v4: Double the power-up delay from 250ms to 500ms.
> v5: Document why of_match_ptr() on the of_match_table is safe when
> CONFIG_OF=3Dn.
> v6: Increase power-up delay from 500ms to 750ms. During cold boot on low
> battery, 500ms causes non-fatal I2C transfer errors (-ENXIO). 750ms
> fixes them.
> v7: Drop I2C_HID_ACPI_PRP0001 Kconfig entry and build the driver under
> CONFIG_I2C_HID_ACPI instead. Also wrap acpi_handle_err parameters across
> two lines.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

