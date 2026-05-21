Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C4372685;
	Thu, 21 May 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375050; cv=none; b=JlT5FQTF65ZIEILT/dhYrl0SCAlIQhN2wjrD+NvJa+IhxLMGXBBHYpJgJU3GTxR6KQKVz0H62SgOvb2cH20wUUB773HCCthw2nOefQi06louyMZDc9klaAry3cYmUNv9timnFLTYzQPLy67zx4gsjZ6ljI4/UBA+PjeCYaTKVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375050; c=relaxed/simple;
	bh=EKaRMIOTfOCk03oWwTI1dmIqlCCC7V1dPNZhii4ZUoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LknZIssCCmw61j3MPnQM1bgTrSmMwycnt1ConCI7kbwUaaHFIbUV5aQwER3iXN/g6lingsoUDbYqGmOeik0hRsVbWj35dKbNhE+Nj/MPpVy4YqdCZbMf813jt0AYX8+E0UDhAlGmhdx/P4TAvza5doyfUsQ62vTBL8R4rwpE4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQU4+jf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQU4+jf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF41F000E9;
	Thu, 21 May 2026 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375049;
	bh=LzRKABOfZTXVKFpBlQvUpwymM0OBfllpSlh3whhPYm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MQU4+jf4KEtnUEQ+G4QsA9CiiZt2nntU5Rke20ItHqEqdSRDBD7f2ljk4H6LYCJKF
	 Ha/3NexfYiGX1X0XsKVvReHHOzs5wnvjkdXGz4//7anNtrXY1hQov6iRUedfziqNKk
	 jIPrgou/5Btip+bfNY+BtMbZW7bdebc74ZPRZ+7NLL88AICvv6I/9pQ4uXZFC5pwEP
	 4wudRkoa9P8BXty3Ia3uUblW+5lRsR76MGMCdkGgiJS8/I3R/Wbgl5PHTefW935xyC
	 s64PmfSmDIYUm1FaYjomAuabjCM0q1mtY3DiLxC5/6xDQ5zY5vV5QxA5BvG0IRniNc
	 KFWTY8ap7PqcQ==
Date: Thu, 21 May 2026 16:50:45 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH 00/11] HID: storing pointers in
 'hid_device_id::driver_data'
Message-ID: <ag8bARsGNVqA8xbQ@beelink>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>

On May 18 2026, Pawel Zalewski (The Capable Hub) wrote:
> The <linux/mod_devicetable.h> has multiple structs that follow
> the pattern of having either 'driver_data' or 'driver_info'
> fields which are of the 'kernel_ulong_t' type. Then how to 
> interpret that field is user defined, some users will treat
> the value as an actual integer, others as a valid pointer to
> dereference. 
> 
> One of instances of the above is the 'hid_device_id::driver_data'
> field, for the most part it is used for setting HID quirks and
> treated as an integer value for storing metadata in the subsystem
> drivers. But in a few instances it is used as a valid pointer to
> dereference, namely in:
> - hid-tmff
> - wacom

I would agree with sashiko that the series introduces an anti-pattern by
allowing .driver_data to be an arbitrary pointer. The reason is that we
can dynamically set driver_data through the kernel command line, and
when it's used as a pointer, bad things will happen.

I would think we should fix the 2 offenders to enforce not using a
direct pointer but an offset in a table of pointers.

How does that sound for you?

Cheers,
Benjamin

>  
> One of the ways to fixing this duality and improve code readability
> and type-safety a bit is to use a '{kernel_ulong_t, const void *}'
> union. That way the current drivers that treat 'hid_device_id::driver_data'
> as an integer value for storing metadata are unaffected. The drivers
> that actually store pointers in there benefit from a removed cast
> (and more clear intent) at the cost of using the new 'const void *'
> field instead.
> 
> With the union in place, some of the existing initializers for static
> const data now need a named field for the 'driver_data' - this is
> also addressed in the series as part of the pre-clean up in 
> patches 1-4. 
> 
> It was found that some modules use a bit of a type-unsafe way of storing
> integers in the 'void *driver_data' pointer of the 'struct hid_device'
> - this required a cast during storage via 'hid_set_drvdata' and a cast
> during retrieval when using 'hid_get_drvdata'. I can see why this was 
> done - as we potentially save on an allocation - but really code is
> more readable and better quality without resorting to this. This issue
> is also addressed in this patch series in patches 5-8 as part of the
> pre-clean up.
> 
> The actual implementation and post-clean up can be found in 
> patches 9-11.
> 
> The change also makes the code more portable on architecture 
> like CHERI [1], where a pointer is replaced with a new primitive
> (called the capability) at the architecture level and is as twice as
> wide as the greatest representable address, ie. for 64 bit address
> space capabilities are 128 bits wide (the other 64 bits are used to
> store meta-data relating to the 64 bit address). So you can not store 
> valid pointers inside 'unsigned long' as effectively a different set of
> instructions is being generated by the compiler based on the data-type
> that was used in C (ie. capabilities have their own set of load/store
> that also copy over the meta-data which are orthogonal to the load/store
> instructions used for plain integers that would invalidate the meta-data).
> There is slightly more detail to this, but the above is enough to
> explain the motivation - the proposed changes make the code a bit
> better even without considering CHERI at all - as it is more readable 
> and type-safe.
> 
> The series was built and tested under QEMU (boots with relevant 
> configs set to Y) on arm64.
> 
> This series is part of a larger effort led by Uwe [2]
> 
> [1] https://cheri-alliance.org/discover-cheri/
> [2] https://lore.kernel.org/all/cover.1776429984.git.u.kleine-koenig@baylibre.com/ 
> 
> ---
> Pawel Zalewski (The Capable Hub) (11):
>       HID: hid-input: use named initializer for 'hid_battery_quirks[]'
>       HID: hid-quirks: use named initializer in 'hid_quirks[]'
>       HID: hid-asus: use named initializer for 'asus_devices[]'
>       HID: i2c-hid-dmi-quirks: use named initializer for 'i2c_hid_elan_flipped_quirks[]'
>       HID: hid-belkin: clean up usage of 'driver_data'
>       HID: hid-cypress: clean up usage of 'driver_data'
>       HID: hid-gfrm: clean up usage of 'driver_data'
>       HID: hid-ite: clean up usage of 'driver_data'
>       HID: mod_devicetable: 'hid_device_id::driver_data' add union
>       HID: hid-tmff: use 'hid_device_id::driver_data_ptr'
>       HID: wacom: use 'hid_device_id::driver_data_ptr'
> 
>  drivers/hid/hid-asus.c                   |  46 ++-
>  drivers/hid/hid-belkin.c                 |   5 +-
>  drivers/hid/hid-cypress.c                |  32 +-
>  drivers/hid/hid-gfrm.c                   |   8 +-
>  drivers/hid/hid-input.c                  |  38 +-
>  drivers/hid/hid-ite.c                    |   9 +-
>  drivers/hid/hid-quirks.c                 | 575 ++++++++++++++++++++-----------
>  drivers/hid/hid-tmff.c                   |  22 +-
>  drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |   2 +-
>  drivers/hid/wacom_sys.c                  |  14 +-
>  drivers/hid/wacom_wac.c                  |  10 +-
>  include/linux/mod_devicetable.h          |   5 +-
>  12 files changed, 496 insertions(+), 270 deletions(-)
> ---
> base-commit: 25ccf4586bead3fe3cf2c57ff0480f31a0e335ad
> change-id: 20260427-mod-devicetable-hid_device_id-7f30d877387c
> 
> Best regards,
> --  
> Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
> 
