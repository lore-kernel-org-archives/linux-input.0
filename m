Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8B424D46;
	Tue,  8 Sep 2026 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856071; cv=none; b=hhVxFhstJFRYtsSo7rWv16Olaqi16VJssp9AsB445Coc1rSXuaniCeODwTt0wZRVzCN05nWPPxzXJqPJNyLWf/YmBDHAbzTpKXmvHrMvWR0qs0KzlOTX/teLlDjqeremthFiLfl6iw0rBNpD0cVlv5zd0nK38dru4U9skQmGAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856071; c=relaxed/simple;
	bh=FTvLSOhadhTu6lMQFsIBAOUQvhsywgx47TwQAUtekyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2FgUAZ/GTEMAJDACEhKiUGrbiYoUm+vtW5Q/Cc1/IlfbK4Ax/Yk2g3yJ6VHWe2ROMqm5IyLk17Adgo1QouZpdZcY4MCXeZj4I5kpzQtyYXm6Ix09FYTWhTTCKGkDei7pggUTi+XIozzwv74+O0/D7kBQ7HecS6QdAW6c2+tLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut0qLpm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut0qLpm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFAD1F00A3A;
	Tue,  8 Sep 2026 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856069;
	bh=87vLGeLKcMe8wOMwunzlmPirL92y71FZBrhkM52WkuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ut0qLpm270BmP73NPzh6QMBGrFKUijJuh4Er8DZ3F5EfMFLhbAEk8woEAIj7KojBL
	 iSGEnFwSpg02DYC4RKgXw2A1UQnKVjUCUopIkyqbethhbqGITfRrjMf7bqspIA9uq9
	 xComlGH2z+TJ4NKkzMY2O/qI/X7IE112FgA6/LZJIIiZdgjQjlNypAG0HvD/mzERcb
	 HkZ/uySVa+2j8VKsYKez+leVmlMMFnWdWrQ7cPNi+6fuFGPdamMVUDjiFdlYUIFrCU
	 K8FxS1kYoNxLWU22liXbeWCclYYZSnqLskrKZwXLjlqD9Aq241gfToeZUAXwIbdeX1
	 HCZ/yadZZFRyA==
Message-ID: <b5ba00c3-4842-4f39-a33f-93e4fe0794f7@kernel.org>
Date: Tue, 8 Sep 2026 10:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wrongly bound Elantech touchpad on Lenovo Yoga Slim 7
To: Hans de Goede <hdegoede@redhat.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>
References: <s5hleyqwowl.wl-tiwai@suse.de>
 <CAO-hwJK-7migm7VWkwvTPHwxgTZEbNX0XYpk0A1pr6N2jkYrxw@mail.gmail.com>
 <0af0150d-c66e-3f46-f9a5-bb2886045e03@redhat.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <0af0150d-c66e-3f46-f9a5-bb2886045e03@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am resuming an ooold thread...

On 05. 02. 22, 12:12, Hans de Goede wrote:
> Hi,
> 
> On 2/4/22 18:39, Benjamin Tissoires wrote:
>> Hi,
>>
>> [adding Dmitry, the maintainer of the input tree and Hans, a colleague of mine]
>>
>> On Fri, Feb 4, 2022 at 5:57 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>
>>> Hi,
>>>
>>> we've got a bug report on openSUSE Bugzilla about the broken touchpad
>>> on Lenovo Yoga Slim 7:
>>>    https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
>>>
>>> The touchpad is an Elantech one, connected over i2c, and there are two
>>> drivers supporting it.  Unfortunately, the default one the system
>>> binds, elan-i2c input driver, doesn't seem working properly, while
>>> i2c-hid driver works.
>>
>> Hans, we do have a similar bug on RHEL at
>> https://bugzilla.redhat.com/show_bug.cgi?id=2029078 (sorry, private
>> bug).
>>
>> IIRC you worked on the discrimination between i2c-hid and elan_i2c (I
>> might be completely wrong though).
> 
> Yes I did work on that, but then the other way around making sure
> that the i2c-hid driver would not bind to some devices which need
> the elan_i2c touch*pad* driver.
> 
> And indeed as Dmitry points out:
> 
>> I believe we need to do what Hans did for Elan Touch*screen* driver and
>> avoid binding to the device if it has i2c-hid-specific _DMS in ACPI.
>> I.e. we need to replicate elants_acpi_is_hid_device().
>>
>> Even better would be to factor it out, maybe not into a shared module
>> but simply shared header with static inline function that we could share
>> between elan drivers and maybe others as well.
> 
> I did fix a similar problem for the touchscreen driver last year or so.
> 
> I agree with Dmitry that we should try to avoid DMI matching here;
> and I also agree that having some header with a static inline
> acpi_is_hid_device() device helper would be good.
> 
> I'm a bit worried about the acpi_is_hid_device() approach though,
> there is a lot of copy and pasting going on when vendors create
> ACPI tables and sometimes a "PNP0C50" CID is present combined
> with a valid i2c-hid _DSM method even though the device is not
> an i2c-hid device, also see the i2c_hid_acpi_blacklist[] in
> drivers/hid/i2c-hid/i2c-hid-acpi.c .
> 
> It seems to me that the problem is that the Lenovo Yoga Slim 7
> is using what seems to be a very generic "ELAN0000" ACPI hardware
> id instead of one of the many more specific ones.
> 
> So we could limit the acpi_is_hid_device() check to just the
> "ELAN0000" ACPI hardware id I guess?
> 
> So I see the following 2 options:
> 
> 1. Add an unconditional acpi_is_hid_device() check to elan_probe()
>     and watch out for any bug-reports that this is causing breakage
>     elsehwere
> 2. Add an acpi_is_hid_device() check to elan_probe() for ACPI enumerated
>     touchpads with a hardware-id of ELAN0000 only; and still
>     watch out for any bug-reports that this is causing breakage
>     elsehwere just to be sure

I assume noone ever tried to implement this, right? Or was some 
alternative approach merged in the meantime?

openSUSE still drags the Takashi's downstream patch with a DMI check. It 
would be nice to sort this out upstream and drop that private one ;).

Thanks.

>>> I'm not sure what's the best fix for this, but below a quick
>>> workaround using a deny list with DMI matching.
>>> If this is OK, I can resubmit the patch for merging.
>>>
>>> Any comments appreciated.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>> -- 8< --
>>> From: Takashi Iwai <tiwai@suse.de>
>>> Subject: [PATCH] Input: elan_i2c: Add deny list for Lenovo Yoga Slim 7
>>>
>>> The touchpad on Lenovo Yoga Slim 7 doesn't work well with elan-i2c but
>>> rather better with i2c-hid.  Add a deny list for avoiding to bind with
>>> elan-i2c.
>>>
>>> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>   drivers/input/mouse/elan_i2c_core.c | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
>>> index 47af62c12267..fd08481f7aea 100644
>>> --- a/drivers/input/mouse/elan_i2c_core.c
>>> +++ b/drivers/input/mouse/elan_i2c_core.c
>>> @@ -18,6 +18,7 @@
>>>   #include <linux/acpi.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/device.h>
>>> +#include <linux/dmi.h>
>>>   #include <linux/firmware.h>
>>>   #include <linux/i2c.h>
>>>   #include <linux/init.h>
>>> @@ -1222,6 +1223,20 @@ static void elan_disable_regulator(void *_data)
>>>          regulator_disable(data->vcc);
>>>   }
>>>
>>> +static const struct dmi_system_id elan_i2c_denylist[] __initconst = {
>>> +#if IS_ENABLED(CONFIG_I2C_HID_ACPI)
>>> +       {
>>> +               /* Lenovo Yoga Slim 7 is better supported by i2c-hid */
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "82A3"),
>>> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga Slim 7 14ITL05"),
>>> +               },
>>> +       },
>>> +#endif
>>> +       { }
>>> +};
>>> +
>>>   static int elan_probe(struct i2c_client *client,
>>>                        const struct i2c_device_id *dev_id)
>>>   {
>>> @@ -1233,6 +1248,10 @@ static int elan_probe(struct i2c_client *client,
>>>
>>>          if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
>>>              i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>> +               if (dmi_check_system(elan_i2c_denylist)) {
>>> +                       dev_info(dev, "Hits deny list, skipping\n");
>>> +                       return -ENODEV;
>>> +               }
>>>                  transport_ops = &elan_i2c_ops;
>>>          } else if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) &&
>>>                     i2c_check_functionality(client->adapter,
>>> --
>>> 2.31.1
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>
> 
> 

-- 
js
suse labs

