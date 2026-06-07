Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990BAF9E8;
	Sun,  7 Jun 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851104; cv=none; b=DKHrit8Xw80lMgRDUU5vebitoivXVHaYvRpcUnnP8CEhfRYK4eSz4QRlkftkLzvyLfSCZ2oDOI1rDnCMnGS6bS3C0KhwwC2Ge+2uWUEbgUX85l/kt65vHn4qugYKoCFkWiUJcsBUw8CtigSZxY74BE825F07qg7Z0a+hDWXIKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851104; c=relaxed/simple;
	bh=GjyhGzsLw2NZ5VYLPHou+5nDWn+scOoYWyBpxrWilH4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+w1QSfJsiRwf2qtZJ30i/gzS7n09oKJGqH4Trfi1f1Zm2voddpkqc+53R9NWb/LdEYXPbORo5M0XbnxrLcP33YE8fuYJuqaZNaSPJS2S/+4bf+4g/AjrWCqhxWO8xxHiyvLKILt8VViNneh4R0IfKFn922nKJEoDanspX5KjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev; spf=pass smtp.mailfrom=ghoul.dev; dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b=hf3Cf3dr; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b="hf3Cf3dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ghoul.dev;
	s=protonmail; t=1780851093; x=1781110293;
	bh=vfcUgLdeDIcgB9Qv5T42xl+pYHFxOYE2pzGjXLMyLbI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hf3Cf3drU74eofgvIQ00jnwAZNzcaMWJa0ltpJIkQmBD8KRbWWUfvKELKkppiY4uT
	 w6rWydUxA5v3OufnskqXLGKqmgscXafWviynR4B8d0XcGiYyNWgZ9PNT7sgyib07ky
	 LOgaJMtrER0DsWU14uXMNZ4RLsctBABOq+TzvHGGat5L1E5lEpDemHYhSGAMgXTgeh
	 4tM8+mtNR0sPfNjvVxXcOgr8YYTqXR2Uvel/snrpI5bLn5zoiYoaFQ6WwBLLLUn/DX
	 kdqhGgV5LY1xI/qe8hCNw07QkZKs8bMRskPgRMecquo8sdQgsvU9AY9rDLxw+mzI3V
	 NvUyEjh9HHUTg==
Date: Sun, 07 Jun 2026 16:51:24 +0000
To: Antheas Kapenekakis <lkml@antheas.dev>, Denis Benato <benato.denis96@gmail.com>
From: Yaseen <yaseen@ghoul.dev>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: skip interrupt IN polling for devices with no input reports
Message-ID: <20a9d77f-c60a-44ba-ac39-15107fc81256@ghoul.dev>
In-Reply-To: <CAGwozwFMm2o2G-fOixvu+QVXGsDC+E81+1Nsk4kQ7xbpnvhVPg@mail.gmail.com>
References: <20260605113952.38435-1-yaseen@ghoul.dev> <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com> <ceb5ed4b-1654-463d-9cff-4a1b91d52e92@gmail.com> <CAGwozwFMm2o2G-fOixvu+QVXGsDC+E81+1Nsk4kQ7xbpnvhVPg@mail.gmail.com>
Feedback-ID: 177610485:user:proton
X-Pm-Message-ID: 9d879738ad56bc6f8e065f686774cefdbeaad699
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/06/2026 18:13, Antheas Kapenekakis wrote:
> On Sat, 6 Jun 2026 at 14:42, Denis Benato <benato.denis96@gmail.com> wrot=
e:
>>
>>
>> On 6/5/26 14:02, Antheas Kapenekakis wrote:
>>> On Fri, 5 Jun 2026 at 13:40, Ahmed Yaseen <yaseen@ghoul.dev> wrote:
>>>> usbhid starts polling a device's interrupt IN endpoint on open
>>>> (usbhid_open() -> hid_start_in()). If the report descriptor declares n=
o
>>>> input reports there is nothing to read there, so the poll is useless,
>>>> and on some composite devices it is also harmful.
>>> If it did have input reports, would starting the polling still cause
>>> issues? Because if it would, the issue is in the polling itself.
>> So far we haven't found an asus device that has more than one interface
>> that supports reading data out of if.
>>> Given the creativity of manufacturers when implementing hid protocols,
>>> I find it certain that they do use the in endpoint even without input
>>> reports. E.g., for feature reports. This could cause regressions.

The ASUS ROG N-Key Device does have feature reports. They are used for=20
RGB control on the keyboard. I have confirmed this with a test by not=20
registering the hidraw node for this interface at all and noted that RGB=20
stops working after. So hiding or ejecting this interface is not an=20
option. Therefore, after this patch, I myself, together with Kerim and=20
GameBurrow have paid attention explicitly to ensure there are no=20
regressions to the LED controls, while fixing the keyboard issue.

Also worth noting that feature reports travel over EP0 via=20
usbhid_{get,set}_raw_report() in both directions. The interrupt IN=20
endpoint is only ever used to receive input reports: hid_irq_in() passes=20
everything it gets to hid_safe_input_report(HID_INPUT_REPORT, ...).=20
There is no code in usbhid that reads feature reports from the interrupt=20
IN endpoint at all, so skipping that poll cannot break any feature=20
reports on any device. This is also mentioned in my patch description:

=09"Feature reports and hidraw output keep working over the control and=20
OUT endpoints, so the interface is otherwise unaffected."

Regarding a manufacturer using in endpoint without an input report, even=20
today, the HID core would drop that data before it reaches hidraw:=20
__hid_input_report() bails when hid_get_report() finds no matching=20
report. That bail is also before the driver's ->raw_event() callback, so=20
no driver or hidraw reader can currently be relying on such traffic.

>> While I mostly agree with this it is also true that the general directio=
n
>> for the kernel (especially lately) has been to not do out-of-spec things
>> at least by default.
>>
>> If things really regress it's expected to do so only an very few specifi=
c
>> devices with a buggy firmware, and we can think of something different
>> for those (hopefully very few ones).
>>
>> Perhaps someone concerned with security might be interested in what
>> we have because it doesn't look very normal.
>>
>> Note that below I have written a few ideas that maybe are worth
>=20
> The degradation would be silent.
>=20
>> looking into.
>>>> The ASUS ROG N-Key keyboards expose a second, input-less interface use=
d
>>>> only for RGB control via feature reports. Opening its hidraw node (any
>>>> hidraw reader does, including SDL/Steam Input or a plain cat) starts t=
he
>>> cating a hidraw causing issues would be expected, so let's focus on the=
 former.
>=20
> Try to add spaces before and after your responses
>=20
>> Simply opening an hidraw should not trigger a delayed disconnect of that=
 device,
>> I don't know why you would expect this to happen nor why you would
>> consider it acceptable. It's a bug.
>>
>> Focusing on userspace software exposing the bug is not a realistic optio=
n
>> because over the time we found a good chunk of software doing that:
>> - logitech control software (forgot the name)
>> - open razer software
>> - sdl
>> - asusctl (obviously it opens the device albeit in the future I will cha=
nge this)
>>
>> and likely more given the fact not all software was identified.
>>> Asusctl has a bug where if you add the quirk that separates the event
>>> nodes per hid, this bug is reproduced as well. I chucked it to
>>> complicated threading getting out of control. It is the reason we
>>> skipped that patch that was in my series.
>> I found and solved the bug already. Regardless the issue remains:
>> Even with no asusctl at all, if a user has one logitech mouse
>> (and its control software) and a razer keyboard (and its control softwar=
e)
>> the asus N-Key device will start an endless disconnect-reconnect loop.
>>
>> Any combination of two or more of those tools will trigger the issue
>> on some devices (weirdly enough not every model is affected):
>>
>> this is not good.
>>> Now, you say SDL/Steam do a spurious read as well, can you identify
>>> the codepath so we can look into it? What devices are affected? The
>>> early return fixes a warning on the Z13, but it also feeds through the
>>> universal lamp interface on the new Xbox Allies. Is this a bug on
>>> those devices or keyboards? If yes, it could be caused by userspace
>>> hanging on that node

Affected devices include the ROG STRIX 2025 lineup: Scar 16/18=20
(G635L/G835L) and G16/G18 (G615L/G815L). My patch has been tested on=20
both Scar 18 and G18. Additionally a user with a Scar 18 2024 model=20
(G634JZR) has reported the issue as well; they were unable to=20
participate in testing but reproduce the issue with the same cat command=20
(reproduction command provided below). It is likely the G16/G18 of 2024=20
will also be affected. Models prior to 2024 appear unaffected so far.

A user with an Xbox Ally X has tested this for me as well as of writing=20
this email. So we are able to confirm that this device is unaffected and=20
no regressions are noticed on that device from my patch, including the=20
lamp/RGB controls.

I do not have access to a Z13 at the moment. If you have one, it would=20
be very helpful for me if you could test for any regressions on that=20
device and if the device is affected by the bug, and whether or not this=20
patch fixes the issue.

I would also like to take this opportunity to mention that the 3 testers=20
and I are all daily driving a kernel with this patch applied, and over=20
the last few days, have noticed no issues with any devices.

>> Sure, and I agree with you that fixing all userspace tools is desirable
>> but it's also unfeasible to fix them all, if we managed to do that
>> there will be years before everyone receives a fixed version of every
>> affected software and even then a core issue would remain:
>> linux tries to poll something it can't have anything out from.
>>
>> I am much more oriented on the fact that kernel shouldn't
>> be doing weird things (at least not by default) so this has to
>> somehow be stopped regardless of how well userspace behaves.
>=20
> The kernel is not doing weird things and I also did not ask you to fix
> all userspace software. I asked for a reproduction scenario, as it is
> not covered in the patch description. Relooking at the patch today, I
> also do not understand what it does fully.

The reproduction scenario is in the patch description:

=09"Opening its hidraw node (any hidraw reader does, including SDL/Steam=20
Input or a plain cat) starts the pointless IN poll and keypress reports=20
on the keyboard interface get dropped for as long as the node stays=20
open: a lost key-down drops a letter, a lost key-up leaves the key stuck."

i.e. run "sudo timeout 15 cat /dev/hidrawX" against the N-Key RGB=20
interface, then type on the internal keyboard.

>=20
> It skips enabling input interrupts (but not only that) for devices
> that have no input reports. So the kernel behavior will depend on the
> feature descriptor moving forward.

What the patch does is the last paragraph of the description:

=09"Skip the poll in usbhid_open() when the device has no input reports."

Interrupt IN endpoint on a device with 0 input reports isn't doing=20
anything anyway. The other things the early return skips only matter=20
when input is possible.

>=20
> And that fixes a hang on the affected devices because enabling
> interrupts on an endpoint without periodic input reports blocks a
> parallel endpoint that does have input reports?
>=20
> I would like this fix to target the actual cause that causes the block
> but it is not clear to me what that is or what is affected.

As per my investigations with usbmon, I can see that the keyboard=20
interface's input reports never reach the URB layer while the RGB=20
interface is being polled. From the patch description:

=09"usbmon shows the dropped reports never reach the URB layer"

So the blocking likely happens inside the device's firmware, and not in=20
the kernel, so the kernel cannot fix that part. What the kernel can do=20
is to stop arming the IN URB on an endpoint that as per its own=20
descriptor, can never produce data.

>=20
> Antheas
>=20
>> If you have better ideas on how to fix the kernel we would
>> like to hear those as well.
>>
>> Best regards,
>> Denis
>>> Antheas
>>>
>>>> pointless IN poll and keypress reports on the keyboard interface get
>>>> dropped for as long as the node stays open: a lost key-down drops a
>>>> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
>>>> reports never reach the URB layer.
>>>>
>>>> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
>>>> asus: early return for ROG devices") is what exposes it on these
>>>> devices by keeping the input-less interface alive instead of ejecting
>>>> it, so its hidraw node can be opened and the poll started.
>>>>
>>>> Skip the poll in usbhid_open() when the device has no input reports.
>>>> Feature reports and hidraw output keep working over the control and OU=
T
>>>> endpoints, so the interface is otherwise unaffected.
>> I will write my review here to avoid forking the discussion:
>>
>> I agree with the general idea but perhaps we can avoid
>> some hid devices to ever get HID_QUIRK_ALWAYS_POLL
>> and that might be enough to skip the problematic code?
>>
>> Maybe there is value in doing this with a quirk flag in hid-asus.c
>> affecting the least amount of devices?
>>
>> Or maybe just prevent devices with no data possibly coming out
>> to ever get HID_QUIRK_ALWAYS_POLL?

Thank you for the review!

I would like to also highlight one thing here; the HID_QUIRK_ALWAYS_POLL=20
is not given to this specific device. It was already in the if=20
condition, for the devices that do use it; my change only ORs a second=20
independent condition into it. So keeping devices away from that quirk=20
would not change anything here.

Adding a quirk flag for this specific device is something I too have=20
considered and will be happy to change it like so if Jiri or Benjamin=20
feel it is more appropriate. My reasoning for taking the current route=20
is that it would prevent any hidden issues that might arise similarly,=20
and fix the whole class of this issue rather than for one vendor when=20
the likelihood of a regression is very low from skipping interrupt IN=20
polling if a device doesn't have input reports in the first place.

Best Regards,
Yaseen

>>
>> For how to best do this we will need to hear what Jiri and
>> Benjamin have to say but if they think the proposed solution
>> is the correct solution:
>>
>> Reviewed-by: Denis Benato <denis.benato@linux.dev>
>>>> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
>>>> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
>>>> Tested-by: GameBurrow <gameburrow@pm.me>
>>>> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
>>>> ---
>>>>   drivers/hid/usbhid/hid-core.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-co=
re.c
>>>> index 96b0181cf819..90a8b34d9305 100644
>>>> --- a/drivers/hid/usbhid/hid-core.c
>>>> +++ b/drivers/hid/usbhid/hid-core.c
>>>> @@ -688,7 +688,8 @@ static int usbhid_open(struct hid_device *hid)
>>>>
>>>>          set_bit(HID_OPENED, &usbhid->iofl);
>>>>
>>>> -       if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
>>>> +       if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
>>>> +           list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list=
)) {
>>>>                  res =3D 0;
>>>>                  goto Done;
>>>>          }
>>>> --
>>>> 2.54.0
>>>>
>>>>
>>>>


