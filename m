Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8E3ABDA8
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749749; cv=none; b=Agf2oJUM60b08f5SFkCm9ZasvQjLiFvffH1gS7NgEAbef+o7kg8oJJzPtIRVMikVWYHTmMgj+aaEgUFqkBDkGxpcOI9iTb5hqqqiODvx5d4Dct4FrCQ5PCDpCNvvQ/QaC7tz0xiqQdA9x6KoTkHIFSfVMVmxc7qxXk94fepiq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749749; c=relaxed/simple;
	bh=YsC4k+dpP+I4yK9ylOxhF491wL14p5IGLAkdSLplnSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtuA/1g+1uHswO2vUQy8JSrmVn04QDniKA1TyxyL7N5fANXgl5pcJtxeIQ5QG51kdlrMcD0FCuFzLdqnQuJxiYzEOniRWhZdQe0Aa5CDwP+tdM78kopGwuQCDBDrvpuslrGSFz5ibJ5IEPEXUXu1tUdzflgFjhi9oSNyotM0tL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opy1Ifks; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opy1Ifks"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso33134915e9.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780749746; x=1781354546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+7565wOGRhMgGnAnVEfA+MTDShbkLz9evE/tw3rT6M=;
        b=opy1IfksL61fYQUdDO7nR8c2/jIXkJiVhL+demxfFZczAfa+uXxrvrCMTZ+QqR9A6V
         RWXUbqlzi7M2225aGWj02+ItNjA8G/Nvl+66h33hFSqTIZP79nQunc6d10V5F2a4kG2L
         KBX85XzwQWiGcRFigDSScH3KBVZTMGhbs866tQE6vBoc/bmcb5gyJPVY9L9DLy2OiOVr
         ws3CIHportQxsMNRyMDoLUv1zkdJS3YuRHd6Y12WiSp1Pg527sPgD8e2UEAVgEX2QQbc
         8bIiIsEw1mxtlG2BTTkDtzRGA8vprs/wS5djjJ/xCAXDkBgnUcJvr/eBaseT1m41bRe6
         TKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749746; x=1781354546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+7565wOGRhMgGnAnVEfA+MTDShbkLz9evE/tw3rT6M=;
        b=CdJkkB1o2AkcXvqP3NHnMqpBWBOBXtX7eqoIz6BuLhdrpgWuQo6l3iwTE1Q/7Zj3fT
         fGEybcUgO6QeSyBO0fq2zLfN35TtdqiIy6QsCGDQfcITqbjKaDC+efLkdIopKz5Qr3Rl
         SAI+GBAq8poz22tRdP98G/NBpF+EWpLGoX2cH/eJ8W90S8sBjM+zt8AjpW6R//HREaMA
         6Xpz3DnXqpZUBd8dXZdhWS81NrjdsgHfw+SBbdSI6gcaSGqJth1ttqhyLVronHmpqguV
         GVQYtImQ+e7xZv0mCIuq7oj8p4hrShGSXMm+U1oAsB2/N6ocmrs9I302pnsF3OvECDWU
         YtgA==
X-Forwarded-Encrypted: i=1; AFNElJ8N6rTzNiRXoD1kso3/0bpJW9EOkE9lZIId8pUyua3QYb2wZhInJGj3UiNVZQhBvkvNJ9smwTNUfoUcpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynNNVe7m3/e5QlhrBfoy5UC3j1RgvZ+rFdfoXY+AkPL54Jwm64
	kbBNbogDhLwsI1UsxUjqRaUjRIXLeR/s4kIcs4tz1/e/rtTnQITzX2AU
X-Gm-Gg: Acq92OHHxL/Rf1WBNKAvomthoXwThoGRWseCuSWIOtg/Vweaj1hKwvEFpTFEpEZmMSV
	80gUf/04H5gnK6vxrNpZqVRAvBqiXnS7T7TdTktSo57z9jcYyteY6q4tvE0WhvBse0ddZu/VIeA
	mAATAahIhSPAbP5W3gFpHr51Y6SNHMOBYCijR0TZpTZ+7yzXWAc1NHNtbSFaLoI06e0UBW7igoE
	ObelLyliu444m4iEVrUhqFEeg3bWpuqrhNIeHAxsF14J/qIF/OveG/WHzqmFDxAx66d0c17e8wb
	S6vDzbU5GyMgRJ2nJTr0D0VszWqeHC0RstEXl+w3bm1NuyZePflkXVgavFb2HFniG7S6qbLKJPE
	GdaTGsn4CpfTFsY6QPd8qMU7RivVSt+qrvtG1t0wqInA5CIQ775pis/z2MfnOeP0QKQVxxy2j5b
	GvcH4PW+OEvTZhw68tZtsmBClaDPdUMOQkXhcbEmxhcA==
X-Received: by 2002:a05:600d:6444:20b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490c26e1acbmr94606345e9.12.1780749745963;
        Sat, 06 Jun 2026 05:42:25 -0700 (PDT)
Received: from [10.80.0.99] ([151.49.228.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm35237527f8f.13.2026.06.06.05.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 05:42:25 -0700 (PDT)
Message-ID: <ceb5ed4b-1654-463d-9cff-4a1b91d52e92@gmail.com>
Date: Sat, 6 Jun 2026 14:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: usbhid: skip interrupt IN polling for devices with
 no input reports
To: Antheas Kapenekakis <lkml@antheas.dev>, Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
 linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260605113952.38435-1-yaseen@ghoul.dev>
 <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/5/26 14:02, Antheas Kapenekakis wrote:
> On Fri, 5 Jun 2026 at 13:40, Ahmed Yaseen <yaseen@ghoul.dev> wrote:
>> usbhid starts polling a device's interrupt IN endpoint on open
>> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
>> input reports there is nothing to read there, so the poll is useless,
>> and on some composite devices it is also harmful.
> If it did have input reports, would starting the polling still cause
> issues? Because if it would, the issue is in the polling itself.
So far we haven't found an asus device that has more than one interface
that supports reading data out of if.
> Given the creativity of manufacturers when implementing hid protocols,
> I find it certain that they do use the in endpoint even without input
> reports. E.g., for feature reports. This could cause regressions.
While I mostly agree with this it is also true that the general direction
for the kernel (especially lately) has been to not do out-of-spec things
at least by default.

If things really regress it's expected to do so only an very few specific
devices with a buggy firmware, and we can think of something different
for those (hopefully very few ones).

Perhaps someone concerned with security might be interested in what
we have because it doesn't look very normal.

Note that below I have written a few ideas that maybe are worth
looking into.
>> The ASUS ROG N-Key keyboards expose a second, input-less interface used
>> only for RGB control via feature reports. Opening its hidraw node (any
>> hidraw reader does, including SDL/Steam Input or a plain cat) starts the
> cating a hidraw causing issues would be expected, so let's focus on the former.
Simply opening an hidraw should not trigger a delayed disconnect of that device,
I don't know why you would expect this to happen nor why you would
consider it acceptable. It's a bug.

Focusing on userspace software exposing the bug is not a realistic option
because over the time we found a good chunk of software doing that:
- logitech control software (forgot the name)
- open razer software
- sdl
- asusctl (obviously it opens the device albeit in the future I will change this)

and likely more given the fact not all software was identified. 
> Asusctl has a bug where if you add the quirk that separates the event
> nodes per hid, this bug is reproduced as well. I chucked it to
> complicated threading getting out of control. It is the reason we
> skipped that patch that was in my series.
I found and solved the bug already. Regardless the issue remains:
Even with no asusctl at all, if a user has one logitech mouse
(and its control software) and a razer keyboard (and its control software)
the asus N-Key device will start an endless disconnect-reconnect loop.

Any combination of two or more of those tools will trigger the issue
on some devices (weirdly enough not every model is affected):
this is not good.
> Now, you say SDL/Steam do a spurious read as well, can you identify
> the codepath so we can look into it? What devices are affected? The
> early return fixes a warning on the Z13, but it also feeds through the
> universal lamp interface on the new Xbox Allies. Is this a bug on
> those devices or keyboards? If yes, it could be caused by userspace
> hanging on that node
Sure, and I agree with you that fixing all userspace tools is desirable
but it's also unfeasible to fix them all, if we managed to do that
there will be years before everyone receives a fixed version of every
affected software and even then a core issue would remain:
linux tries to poll something it can't have anything out from.

I am much more oriented on the fact that kernel shouldn't
be doing weird things (at least not by default) so this has to
somehow be stopped regardless of how well userspace behaves.

If you have better ideas on how to fix the kernel we would
like to hear those as well.

Best regards,
Denis
> Antheas
>
>> pointless IN poll and keypress reports on the keyboard interface get
>> dropped for as long as the node stays open: a lost key-down drops a
>> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
>> reports never reach the URB layer.
>>
>> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
>> asus: early return for ROG devices") is what exposes it on these
>> devices by keeping the input-less interface alive instead of ejecting
>> it, so its hidraw node can be opened and the poll started.
>>
>> Skip the poll in usbhid_open() when the device has no input reports.
>> Feature reports and hidraw output keep working over the control and OUT
>> endpoints, so the interface is otherwise unaffected.
I will write my review here to avoid forking the discussion:

I agree with the general idea but perhaps we can avoid
some hid devices to ever get HID_QUIRK_ALWAYS_POLL
and that might be enough to skip the problematic code?

Maybe there is value in doing this with a quirk flag in hid-asus.c
affecting the least amount of devices?

Or maybe just prevent devices with no data possibly coming out
to ever get HID_QUIRK_ALWAYS_POLL?

For how to best do this we will need to hear what Jiri and
Benjamin have to say but if they think the proposed solution
is the correct solution:

Reviewed-by: Denis Benato <denis.benato@linux.dev>
>> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
>> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
>> Tested-by: GameBurrow <gameburrow@pm.me>
>> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
>> ---
>>  drivers/hid/usbhid/hid-core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> index 96b0181cf819..90a8b34d9305 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -688,7 +688,8 @@ static int usbhid_open(struct hid_device *hid)
>>
>>         set_bit(HID_OPENED, &usbhid->iofl);
>>
>> -       if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
>> +       if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
>> +           list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
>>                 res = 0;
>>                 goto Done;
>>         }
>> --
>> 2.54.0
>>
>>
>>
