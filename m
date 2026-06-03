Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DCE472785;
	Wed,  3 Jun 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487957; cv=none; b=AfQoILzkZ72caLmYbq0pCV/JglCER9Bvy0BxwVvrNA2ZFcENqNNA43HdW9Ehu4IRUSFmVvFI2m2CUI5hnt+LU2DN1uTleD2lHD27zBVrKoGQyOfwgMtKmhPr5Vvw1hxFLDF8+KYIn1Q6VjoHaOb7GclN4atk7qync4bbkAGyqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487957; c=relaxed/simple;
	bh=RzD8bPqVdJFjK2E6UjIC/SYqAW4+29SzBWPC+H6bcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMuiWPlNsu6YUkEY1A+e3ku9eNGSHu9MkFhpl2EWetFUW5t5SSCSvpZEYec3A1i78dOeRlnU66Em/3DpBOsWJ20MGRJKW+lZ/BVXYcONQrC7777bQyfKDJoO9tU/EgHPL3rLfU3G3h9UB/4ZoYHg01HqgObFVj0GNa8B5sXP/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXRy79W1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXRy79W1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D61F00898;
	Wed,  3 Jun 2026 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780487956;
	bh=kJhhH3qFKRx4ctiNj+l5MQXDc6cisR45gA19BWF8ve4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXRy79W1DE+WSM6ks9Znugdi9EQmWdtEAD4NYsmDkVDCZMhQTTHjcP2bhttYFUdUx
	 iF1G9rmQMhW7VQ8iqIDFHfFzgzt+vS1iX28UboXwrx8kognFEkzKNxdF+O/O43moGu
	 Cei/C/eKMX54ct/OgFfkiurMS3LmH56vp8Y+QsXd6g8kdhUQ2yL4Z0UjPT1rfBaI7e
	 581oYMLTmEPzQFZjDaeIneAIRGDk2zE9GyYGaI3LjOB0hky7KO1/fqOSXb2Mewrrwp
	 ClmNdPm9rUKrw7gwU6iVgoYjv0ndOrX6xmTEQQLkXO47dVm8XooAyjPLen8kZ5buIH
	 SqjT34/6YrRig==
Date: Wed, 3 Jun 2026 13:59:11 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@red54.com>, 
	linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dianders@chromium.org, 
	jikos@kernel.org, linux-kernel@vger.kernel.org, superm1@kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, Xu Rao <raoxu@uniontech.com>, 
	Kwok Kin Ming <kenkinming2002@gmail.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 2/3] HID: i2c-hid: Move common ACPI _DSM helper into
 core
Message-ID: <aiAW9sSLVqmT6l87@beelink>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601181510.38705-1-Yeking@Red54.com>
 <tencent_71AA07C8BAF64FE0F9B0FDFC072BB08B3605@qq.com>
 <ah_2JXN7AAos4kjM@beelink>
 <7ff8529d-6b20-4088-aa10-77b304da49b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ff8529d-6b20-4088-aa10-77b304da49b4@kernel.org>

On Jun 03 2026, Hans de Goede wrote:
> Hi Benjamin,
> 
> On 3-Jun-26 11:43 AM, Benjamin Tissoires wrote:
> > On Jun 01 2026, 谢致邦 (XIE Zhibang) wrote:
> >> Move the _DSM call that gets the HID descriptor address from
> >> i2c-hid-acpi.c to a shared helper in i2c-hid-core.c so both
> >> i2c-hid-acpi.c and i2c-hid-of.c can use it.
> >>
> >> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> >> ---
> >>  drivers/hid/i2c-hid/i2c-hid-acpi.c | 32 ++++-----------------------
> >>  drivers/hid/i2c-hid/i2c-hid-core.c | 35 ++++++++++++++++++++++++++++++
> > 
> > I'm not a big fan of removing 25% of the i2c-hid-acpi.c code and inject
> > it in i2c-hid-core.c.
> 
> It is only 35 new lines in i2c-hid-core.c, so it is not that big / much code.

My concern is not so much about these 35 lines of code, but the fact
that i2c-hid-acpi.c is now down to only 3 functions:
- i2c_hid_acpi_probe()
- i2c_hid_acpi_shutdown_tail()
- i2c_hid_acpi_restore_sequence()

So then, what's the point of keeping it as a separate driver? (more
rethorical question than anything).

> 
> > There's something I can't really understand in the problem:
> > - we are talking about non arm architecture, which should not have OF in
> > 	them
> > - the current compatible hid-over-i2c loads the OF version?
> > - how can you make the device working without the couple of ACPI
> > 	functions that are in the i2c-hid-acpi.c driver for powering up and
> > 	down the device?
> > 
> > If the platform is indeed ACPI + x86(_64), then shouldn't we tackle the
> > problem in the i2c-hid-acpi driver, or add a secondary leaf driver for
> > this particular platform/device? Kind of what we have with
> > i2c-hid-of-elan.c
> 
> As part of the work to use ACPI on ARM systems, it is possible now a days
> to inject DT snippets into ACPI tables.
> 
> The problem on these Loongson laptops is that they have created this
> very ugly mixed-mode where they put a PRP0001 ACPI HID on the ACPI
> node for the touchscreen, which means it contains an embedded DT
> snippet and in that snipped out "compatible=hid-over-i2c" but NOT
> also "i2c-hid-descr-addr=x". To get the i2c-hid descriptor address
> the implemented the ACPI _DSM on the same ACPI device/fwnode.
> 
> The ACPI core sees HID=PRP0001 so it creates an of-compatible 
> modalias / match and not an ACPI one, so the i2c-hid-of driver will
> bind.

But if this fix is for just one platform, why not keeping the design
clean and have a dmi_match instead in a separate driver, like the
i2c-hid-of-elan does for Elan touchpads/touchscreens?
i2c-hid-acpi-loongson.c for instance.

> 
> Note these "fixed" (as in we cannot fix them) ACPI tables use
> the generic i2c-over-hid OF/DT compatible _not_ something
> more specific so we can also not do a more specific driver like
> i2c-hid-of-elan.c.

Do they use anything else than the compatible DT entry? regulators and
others? If not, then the device is pure ACPI, and should not be handled
by i2c-hid-of.c at all, no?

> If we could fix the ACPI tables we would just
> change the ACPI HID to the standard PNPxxxx ACPI HID for i2c-hid
> devices.
> 
> The first version of this patch-set added an of match table
> to i2c-hid-acpi making it also load and probe i2c-hid devices
> described in devicetree on devicetree only systems which IMHO
> is very messy.

Yeah, this one is slightly less messy than the previous versions. It is
just sad to mess up with a clean separation and make the i2c-hid-acpi
driver just a placeholder for a probe function.

> 
> So this new series is the least ugly way to deal with this.

so far :)

Cheers,
Benjamin
