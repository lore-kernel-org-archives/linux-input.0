Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7528BA83
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942992; cv=none; b=b73/CwaLdWRKeU+gxi4xgjxLb0HDwUm5ybEhwiTwJzcQkUBFzR3eKw6r2HdG1aZSV30cxmWaejoF9vmm9Rpko6msBtC4YrThMkWrTm53DFOy4m4E4QCi5eu1/x3Ks75n+dHEU2ahbjo7bUc6DyeeNIUhKDqTYCVePxJu41Mo41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942992; c=relaxed/simple;
	bh=mcSR2qIwNsitWjlZm+naFr0QDV9dw8aizk5Cud0lTZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmy37z4A3wT37b1g4YjzJHA6276eL7F+/x/jx6omi0CQ2KD9UrZuBu9cZdAAY9x3IA71+k8BRpW9D73pbwf+KtgoxJnGr2L4QM3BpYS4IgEsf3+veFLwdIOILLQkbfagPF4Sav2c5mhzP84aXNK22mc92fgTIdIEqobbt1iwaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z7nocTH6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z7nocTH6"
Message-ID: <36479176-9583-478b-b16a-03ba725b3f81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768942984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eX08a1Xo1FykKaAySdzZA2ja3RJ9QlhpXfL7oRz7KY0=;
	b=Z7nocTH6K2VwbojyP8+iVf24/c7a3+7kD3RCZBmquaRkgdrTG3ZllXmkuRVAzBsj7Qc+6p
	NQFOvZXXVr8g2zvOFiJUWjbzLlDODVUkF8cw4RiZHdPiwmglmDcLjw96DS9gZa5dzG7fUa
	3d+w1S5YKl87/Yz0BBUCS308cikP760=
Date: Tue, 20 Jan 2026 22:03:01 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v11 02/11] HID: asus: initialize additional endpoints only
 for legacy devices
To: Antheas Kapenekakis <lkml@antheas.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>
References: <20260116133150.5606-1-lkml@antheas.dev>
 <20260116133150.5606-3-lkml@antheas.dev>
 <14407ba9-34f1-4114-bfb3-043b53ea7769@linux.dev>
 <CAGwozwGyUpBq4GGvyDHj089a9-vxNOnqgSBys3-CC_+tKDywaA@mail.gmail.com>
 <fe66c416-161c-489e-a38f-9dc7729c6ed7@linux.dev>
 <CAGwozwESNrQZ240_qDMf1pdpCRXooxstGcqP10cGp=q-F_SrAQ@mail.gmail.com>
 <8102eb26-5206-49e6-a994-a9d3ea480255@linux.dev>
 <CAGwozwH71LDiBFM-Ro9UpZNy29C6HHwCNZjwCS3F1hMfuUXZ4g@mail.gmail.com>
 <be8ba636-ae07-4d42-88ca-57ecf10b7dae@linux.dev>
 <CAGwozwGdhu_chetK6uQ=FXctC1D8LABj5QxVff1B486EKYSLug@mail.gmail.com>
 <e4349b27-86e1-41d6-864f-5ad6d353dc46@linux.dev>
 <CAGwozwF--y3vsqhdqYFV_x1ff7jfSkYaQHeV1OV70yue7Huk=A@mail.gmail.com>
 <89a67ace-6fef-72e0-4ef3-be828dd85e3d@linux.intel.com>
 <CAGwozwGdDe+M36RE_CMjXePBX-CVRORjHZbOroS+e_Dc_Am2vg@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAGwozwGdDe+M36RE_CMjXePBX-CVRORjHZbOroS+e_Dc_Am2vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/20/26 18:41, Antheas Kapenekakis wrote:
> On Tue, 20 Jan 2026 at 14:56, Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
>> On Sat, 17 Jan 2026, Antheas Kapenekakis wrote:
>>> On Sat, 17 Jan 2026 at 18:05, Denis Benato <denis.benato@linux.dev> wrote:
>>>> On 1/17/26 17:16, Antheas Kapenekakis wrote:
>>>>> On Sat, 17 Jan 2026 at 17:12, Denis Benato <denis.benato@linux.dev> wrote:
>>>>>> On 1/17/26 17:10, Antheas Kapenekakis wrote:
>>>>>>> On Sat, 17 Jan 2026 at 16:13, Denis Benato <denis.benato@linux.dev> wrote:
>>>>>>>> On 1/17/26 16:07, Antheas Kapenekakis wrote:
>>>>>>>>> On Sat, 17 Jan 2026 at 14:51, Denis Benato <denis.benato@linux.dev> wrote:
>>>>>>>>>> On 1/17/26 00:10, Antheas Kapenekakis wrote:
>>>>>>>>>>> On Fri, 16 Jan 2026 at 21:44, Denis Benato <denis.benato@linux.dev> wrote:
>>>>>>>>>>>> On 1/16/26 14:31, Antheas Kapenekakis wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Currently, ID1/ID2 initializations are performed for all NKEY devices.
>>>>>>>>>>>>> However, ID1 initializations are only required for RGB control and are
>>>>>>>>>>>>> only supported for RGB capable devices. ID2 initializations are only
>>>>>>>>>>>>> required for initializing the Anime display endpoint which is only
>>>>>>>>>>>>> supported on devices with an Anime display. Both of these
>>>>>>>>>>>>> initializations are out of scope for this driver (this is a brightness
>>>>>>>>>>>>> control and keyboard shortcut driver) and they should not be performed
>>>>>>>>>>>>> for devices that do not support them in any case.
>>>>>>>>>>>>>
>>>>>>>>>>>>> At the same time, there are older NKEY devices that have only been
>>>>>>>>>>>>> tested with these initializations in the kernel and it is not possible
>>>>>>>>>>>>> to recheck them. There is a possibility that especially with the ID1
>>>>>>>>>>>>> initialization, certain laptop models might have their shortcuts stop
>>>>>>>>>>>>> working (currently unproven).
>>>>>>>>>>>>>
>>>>>>>>>>>>> For an abundance of caution, only initialize ID1/ID2 for those older
>>>>>>>>>>>>> NKEY devices by introducing a quirk for them and replacing the NKEY
>>>>>>>>>>>>> quirk in the block that performs the inits with that.
>>>>>>>>>>>>>
>>>>>>>>>>>>> In addition, as these initializations might not be supported by the
>>>>>>>>>>>>> affected devices, change the function to not bail if they fail.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
>>>>>>>>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  drivers/hid/hid-asus.c | 16 ++++++----------
>>>>>>>>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>>>>>>>>>>>>> index 323e6302bac5..dc7af12cf31a 100644
>>>>>>>>>>>>> --- a/drivers/hid/hid-asus.c
>>>>>>>>>>>>> +++ b/drivers/hid/hid-asus.c
>>>>>>>>>>>>> @@ -90,6 +90,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>>>>>>>>>>>>  #define QUIRK_ROG_NKEY_KEYBOARD              BIT(11)
>>>>>>>>>>>>>  #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
>>>>>>>>>>>>>  #define QUIRK_ROG_ALLY_XPAD          BIT(13)
>>>>>>>>>>>>> +#define QUIRK_ROG_NKEY_LEGACY                BIT(14)
>>>>>>>>>>>> These past days I have taken a look at new 2025 models and they do make use of ID2,
>>>>>>>>>>>> and won't do harm sending ID1 either. I think you can safely remove the if and send regardless.
>>>>>>>>>>> Hi Denis,
>>>>>>>>>>> it is not the responsibility of this driver. ID2 is used by Anime
>>>>>>>>>>> models. It is a concession to make sure that we do not cause a
>>>>>>>>>>> regression that will cause warnings for a lot of users.
>>>>>>>>>> Who decided it is a concession?
>>>>>>>>> I would rather remove the extra calls unless they are shown to be
>>>>>>>>> needed, which they might be for these PIDs.
>>>>>>>> They are needed on older laptop and to not regress userspace.
>>>>>>>>
>>>>>>>> You just named _LEGACY an usb pid that is not legacy.
>>>>>>>>> The quirk is named legacy because we can't retest these devices. If we
>>>>>>>>> can, then we could remove the quirk and the inits if not needed.
>>>>>>>> We can't retest every device, and that pid is used in pre-2021 models,
>>>>>>>> and these are the unknown, I am criticizing the name of the quirk here,
>>>>>>>> not what it does.
>>>>>>> If you can test whether your device needs them that would be great.
>>>>>> That is pointless.
>>>>>>>> I am also questioning if the quirk is even needed since sending
>>>>>>>> those commands to (at least) recent hardware that doesn't use
>>>>>>>> those endpoints carries no downsides, while removing them
>>>>>>>> surely does.
>>>>>>> We have not found a device yet that needs them. I do not want to keep
>>>>>>> sending unneeded commands. It could cause obscure bugs or interfere
>>>>>>> with userspace software such as the one you maintain. So at least for
>>>>>>> new hardware that is possible to test we should remove them.
>>>>>> There is new hardware that needs them, as I said, including 2025 models.
>>>>> I was not aware of that. As far as I know they are not needed. Do you
>>>>> have a bug report with a specific laptop model I can look at?
>>>> There is current effort to integrate commands that requires those
>>>> initializations on 2025 laptop, why would I strip out a command
>>>> that I already know is required anyway?
>>> Hi,
>>> yes ID1 is required for RGB, I have a draft patch for it that would
>>> lazily do it if RGB is supported.
Generally speaking yeah a positive answer (ASUSTEK ...) means
the feature is supported. A negative answer (generally 0xFF 0xFF 0x00 ....)
means the feature is not supported.

Those messages are also an init for models that supports the feature,
and generally asus has hooked functions not directly connected
to the main function of the endpoint to those handshakes
(the only example on my mind is 5a [] making some fn keys behaving
different than booting/pre-os, basically for UEFI settings I guess).

The disassembled AsusKeyboardFilter.sys seems to call those regardless,
but a list of devices is nowhere to be found, probably because the .inf
already lists the vid and pid for the driver to load.
>>> I recall now a previous discussion about it being required for some
>>> laptop shortcuts but we never found a laptop that needs it so I forgot
Perhaps, I can't find it on my notes. In general keyboard configuration
has been scattered on a lot of "devices": certain laptops have an additional
i2c device, that is separate from the keyboard device, that  does things
like locking certain keys... don't be surprised if one command
does more than what you are used to.

On the ally 5a also changes gamepad configuration, not just leds
as usual.

Before the bootloader if you press the vol+ a boot menu will appear
and the device will enter keyboard mode (ASUS implemented this to
allow easier UEFI usage), but as soon as you init the device [5a handshake]
it re-enters its default state (xbox360), exiting the keyboard state.

>>>> No, this is not the way to go to knowingly and willingly cause
>>>> troubles (both known and unknown) to others just because
>>>> you think it's better this way.
>>>>
>>>> Change the name of _LEGACY to something else, have this accepted
>>>> and then if I see it's appropriate  to remove the if and send those
>>>> regardless I will.
>>> Sure, up to you if you want to change the name. What would you like it
>>> be? I would like this series to merge
>> Can you name it e.g. something that should be neutral such as:
>>
>> QUIRK_ROG_NKEY_ID1_ID2_INIT
>>
>> I'm not sure if ROG NKEY should still be included into the name based on
>> what Denis mentioned about recent models but at least it gets rid of the
>> "legacy" connotation. If wider scope is necessary you could use just
>> QUIRK_ID1_ID2_INIT.
> It's NKEY only so QUIRK_ROG_NKEY_ID1ID2_INIT would be more appropriate
> (all recent models are NKEY)
Given that those devices are the main way to control the hardware
(for things that are out of scope of wmi) you could also call those
_SYSTEM or something that denotate the importance of those devices
in controlling what the firmware does.

I am fine even with what Ilpo suggested, I simply don't want
to associate those vid:pid with something that is necessarily
"old" as they have been in use for a long time and at least on ROG
virtually all of them have those vid:pid...

The overwhelming majority: so much so that the easiest way to
tell models apart is to check for DMI since software cannot easily
distinguish them from USB alone.

> Sounds like a plan, I will resend tomorrow. If anyone wants to leave
> any more comments now is the time.
>
> Antheas
>
>> --
>>  i.
>>
