Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8225579826;
	Tue,  8 Sep 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882869; cv=none; b=BdOBveFkz6QXPgMHrtG5JE3QnPfUHDUVlNH3RBZRQoo3Dl+PCCmC1t4ZV1Ym/zx3hq2Q75g7m+0UagvGGutRtKpV3pKzYW9krgCy+76Vrcjp1S5AAWIZN6FgS6BS7JW7GjsOOxwPE3mX9odoAVCvYyEcYW9ozIeFD6Eq7q8a/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882869; c=relaxed/simple;
	bh=8ro/tg7Ivm1ZXMwMRiUNjqAROHDo6oPa4yYbhL3KoRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPD3iixCOJGUuQ2lP3ZpaS6o/9uUT+yMro4m24FN/q0BhP3zC2dSzmh+Zl2sgdooDUzQKvv7X/egqM3eJWjdPqmKR/2Ve0QHidHZJaN5fcGGW/uACYTCpZEHt/5vC/wb3jQVMCsv9F9JwbXSkFHTmdlHoEiAz30ouax0WZPQ1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHkVV0+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHkVV0+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05FD1F00A3D;
	Tue,  8 Sep 2026 15:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882863;
	bh=8ro/tg7Ivm1ZXMwMRiUNjqAROHDo6oPa4yYbhL3KoRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AHkVV0+X3421vTGHFXBNEqA0Gljx9uzcBKVmLY4wwrvteoumde+HHKAbUxiIikapi
	 uT5ALxQoTo9ABMTWwyph1QLZP83ldMlp1JjFYgqTG9nrTRiB3IEfG4jWu7j9epURhe
	 RL6GJjpWkQeAnQtGMbNimo+UUPqIlDYRP8cIynWc4ZWiJ1ogA5ZB0vdO8Rqo9XUkkR
	 peMRNcOdYBOfWgMXdKJ9Xby2Y0KSwDZ8Jkbpfwneu+3qHXxVUygeA6nF45ygo/razr
	 OeIYwyRRPPDbXzfK7QxLHcDTIjKvdhCMQUjJwracrMmXbWCGdQ9mcgeOECHVlDLGPB
	 MQnKPgjXYXUYQ==
Message-ID: <97ba50e7-9631-471b-a5cc-f2d92ade95be@kernel.org>
Date: Tue, 8 Sep 2026 17:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wrongly bound Elantech touchpad on Lenovo Yoga Slim 7
To: Jiri Slaby <jirislaby@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>
References: <s5hleyqwowl.wl-tiwai@suse.de>
 <CAO-hwJK-7migm7VWkwvTPHwxgTZEbNX0XYpk0A1pr6N2jkYrxw@mail.gmail.com>
 <0af0150d-c66e-3f46-f9a5-bb2886045e03@redhat.com>
 <b5ba00c3-4842-4f39-a33f-93e4fe0794f7@kernel.org>
 <979164e2-2c1d-4c6a-9af5-7c25f556ed93@kernel.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <979164e2-2c1d-4c6a-9af5-7c25f556ed93@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8-Sep-26 10:44, Jiri Slaby wrote:
> Use hansg@kernel.org, not @redhat.com

Thx.

> On 08. 09. 26, 10:27, Jiri Slaby wrote:
>> Hi,
>>
>> I am resuming an ooold thread...
>>
>> On 05. 02. 22, 12:12, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/4/22 18:39, Benjamin Tissoires wrote:
>>>> Hi,
>>>>
>>>> [adding Dmitry, the maintainer of the input tree and Hans, a colleague of mine]
>>>>
>>>> On Fri, Feb 4, 2022 at 5:57 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> we've got a bug report on openSUSE Bugzilla about the broken touchpad
>>>>> on Lenovo Yoga Slim 7:
>>>>>    https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
>>>>>
>>>>> The touchpad is an Elantech one, connected over i2c, and there are two
>>>>> drivers supporting it.  Unfortunately, the default one the system
>>>>> binds, elan-i2c input driver, doesn't seem working properly, while
>>>>> i2c-hid driver works.
>>>>
>>>> Hans, we do have a similar bug on RHEL at
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029078 (sorry, private
>>>> bug).
>>>>
>>>> IIRC you worked on the discrimination between i2c-hid and elan_i2c (I
>>>> might be completely wrong though).
>>>
>>> Yes I did work on that, but then the other way around making sure
>>> that the i2c-hid driver would not bind to some devices which need
>>> the elan_i2c touch*pad* driver.
>>>
>>> And indeed as Dmitry points out:
>>>
>>>> I believe we need to do what Hans did for Elan Touch*screen* driver and
>>>> avoid binding to the device if it has i2c-hid-specific _DMS in ACPI.
>>>> I.e. we need to replicate elants_acpi_is_hid_device().
>>>>
>>>> Even better would be to factor it out, maybe not into a shared module
>>>> but simply shared header with static inline function that we could share
>>>> between elan drivers and maybe others as well.
>>>
>>> I did fix a similar problem for the touchscreen driver last year or so.
>>>
>>> I agree with Dmitry that we should try to avoid DMI matching here;
>>> and I also agree that having some header with a static inline
>>> acpi_is_hid_device() device helper would be good.
>>>
>>> I'm a bit worried about the acpi_is_hid_device() approach though,
>>> there is a lot of copy and pasting going on when vendors create
>>> ACPI tables and sometimes a "PNP0C50" CID is present combined
>>> with a valid i2c-hid _DSM method even though the device is not
>>> an i2c-hid device, also see the i2c_hid_acpi_blacklist[] in
>>> drivers/hid/i2c-hid/i2c-hid-acpi.c .
>>>
>>> It seems to me that the problem is that the Lenovo Yoga Slim 7
>>> is using what seems to be a very generic "ELAN0000" ACPI hardware
>>> id instead of one of the many more specific ones.
>>>
>>> So we could limit the acpi_is_hid_device() check to just the
>>> "ELAN0000" ACPI hardware id I guess?
>>>
>>> So I see the following 2 options:
>>>
>>> 1. Add an unconditional acpi_is_hid_device() check to elan_probe()
>>>     and watch out for any bug-reports that this is causing breakage
>>>     elsehwere
>>> 2. Add an acpi_is_hid_device() check to elan_probe() for ACPI enumerated
>>>     touchpads with a hardware-id of ELAN0000 only; and still
>>>     watch out for any bug-reports that this is causing breakage
>>>     elsehwere just to be sure
>>
>> I assume noone ever tried to implement this, right? Or was some alternative approach merged in the meantime?

I indeed believe that no-one ever tried to implement this (but I did
not check).

>> openSUSE still drags the Takashi's downstream patch with a DMI check. It would be nice to sort this out upstream and drop that private one ;).

Ack, that would be great also to fix the issue on other distros.

Note my suggested approach of using an acpi_is_hid_device() check
in the elan touchpad driver does carry a risk of causing regressions.

But I think it is worth a try, maybe combined with limiting
it to a HID of "ELAN0000" or first try without and on
regressions on devices with another HID add that ?

And if this approach fails (causes regressions) then we should
upstream Takashi's downstream patch with a DMI check.

Regards,

Hans



