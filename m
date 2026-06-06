Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C133815D6
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751648; cv=none; b=nKY3VNq8mHgsDIJLUpEeUHetFYtg2fKt3h6mBtNGNVYyN3RpUqjuJ2Xfqv8Vcj96qcxvgaDKO1fgF5ytp398RwH6K/l5pDKwcKJyWE528vU1KGeOFCAGRW9G+KH7xlTE7+1nQV6zWQhupHx9vOXjQo0TqRaEtfsaWdu0xIIiySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751648; c=relaxed/simple;
	bh=MQQ0AfwZago4VrMo3jZ/jTEjuQu9LYEWWIxY/ejqxIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syRJeutM6S4mROjw4K4M32sys4NDTgA7QvtiYvxZTrh/MaXrDcorb/d8O+AUPi3dbGyEO6UKce+DlXc4tIyeh2a4BU56t4iEuXYCaoi1rKR7j59J8O5Z5mgRkG8JtvlIIBmqjb1uk0rKApdvY7rtBcBNvI5QvSTVSJKRy1uRdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XDdYQQVl; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XDdYQQVl"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 9D7FC5E586
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 16:13:57 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 6AE055E5FA
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 16:13:56 +0300 (EEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 51B861FF3EF
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 16:13:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1780751635;
	bh=tGPrzwROkr8Aj3gANFYqST6rj2cZml9l2vibQA13lZI=;
	h=Received:From:Subject:To;
	b=XDdYQQVlJW0ZtlclWvZ8kbG8WVv2eIdZVH9Cv97mO0tM/pTSK3LzBbviGgVp8FL6v
	 pNwcrR1xBk4/qVoMqIdEBlJdBocOZ5bG1yorsdf6qSein31JfKsrmmQj/R7vMK5umA
	 +Kb+2tebB4IrFKaTfbjMPdD2VFihvyfOc7NSuPVYhVd2gKvRHfjpgBFiv0eEu2Rp9P
	 zs8MiA0v6EiH6FMTt+BgSxZ9Oei+Qle7Y1r0efVRjtcelptgPOIOsVFW4O+fw2Bso2
	 R82rduSFx1P0KFGPQEoYRgyATBmkXHJIH2+6kkERsayNa/sy5XgCGtNptu0nJWtm5d
	 jJcIy2wqwPIPA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso29801065ad.3
        for <linux-input@vger.kernel.org>;
 Sat, 06 Jun 2026 06:13:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+T1C1RI+Mfq4aoXKHBXExG/fzcAbdJxDMooKTmGtmnncb9Y6aB8yO97f+50GT649mzzveDvjUVNXakzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDiIQZabrLEOF5xu8hLM3+Pixoa5NVJEd1tF+mftWick622dg
	SKIdYwWIOXD6meSD9lWbmr5iiFovBtEC+zEfsv4WVIzIKLj8xEenqq1p41t82tjSvDjEVCuC69/
	6HZRGBMpFJZsNKX80hV1CP1qxzNEBzm4=
X-Received: by 2002:a17:902:e5d2:b0:2c0:cb90:1dfc with SMTP id
 d9443c01a7336-2c1e8219fccmr96708585ad.12.1780751633760; Sat, 06 Jun 2026
 06:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605113952.38435-1-yaseen@ghoul.dev>
 <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com>
 <ceb5ed4b-1654-463d-9cff-4a1b91d52e92@gmail.com>
In-Reply-To: <ceb5ed4b-1654-463d-9cff-4a1b91d52e92@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 6 Jun 2026 15:13:42 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFMm2o2G-fOixvu+QVXGsDC+E81+1Nsk4kQ7xbpnvhVPg@mail.gmail.com>
X-Gm-Features: AVVi8Cf0lQoiepH8dKUlun1vleyOXTgJuvJmAvkdSxvlVS4rbo2oh84ki8XgtAw
Message-ID: 
 <CAGwozwFMm2o2G-fOixvu+QVXGsDC+E81+1Nsk4kQ7xbpnvhVPg@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: skip interrupt IN polling for devices with
 no input reports
To: Denis Benato <benato.denis96@gmail.com>
Cc: Ahmed Yaseen <yaseen@ghoul.dev>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
 linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178075163553.1737654.18443134366217102899@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 6 Jun 2026 at 14:42, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 6/5/26 14:02, Antheas Kapenekakis wrote:
> > On Fri, 5 Jun 2026 at 13:40, Ahmed Yaseen <yaseen@ghoul.dev> wrote:
> >> usbhid starts polling a device's interrupt IN endpoint on open
> >> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
> >> input reports there is nothing to read there, so the poll is useless,
> >> and on some composite devices it is also harmful.
> > If it did have input reports, would starting the polling still cause
> > issues? Because if it would, the issue is in the polling itself.
> So far we haven't found an asus device that has more than one interface
> that supports reading data out of if.
> > Given the creativity of manufacturers when implementing hid protocols,
> > I find it certain that they do use the in endpoint even without input
> > reports. E.g., for feature reports. This could cause regressions.
> While I mostly agree with this it is also true that the general direction
> for the kernel (especially lately) has been to not do out-of-spec things
> at least by default.
>
> If things really regress it's expected to do so only an very few specific
> devices with a buggy firmware, and we can think of something different
> for those (hopefully very few ones).
>
> Perhaps someone concerned with security might be interested in what
> we have because it doesn't look very normal.
>
> Note that below I have written a few ideas that maybe are worth

The degradation would be silent.

> looking into.
> >> The ASUS ROG N-Key keyboards expose a second, input-less interface used
> >> only for RGB control via feature reports. Opening its hidraw node (any
> >> hidraw reader does, including SDL/Steam Input or a plain cat) starts the
> > cating a hidraw causing issues would be expected, so let's focus on the former.

Try to add spaces before and after your responses

> Simply opening an hidraw should not trigger a delayed disconnect of that device,
> I don't know why you would expect this to happen nor why you would
> consider it acceptable. It's a bug.
>
> Focusing on userspace software exposing the bug is not a realistic option
> because over the time we found a good chunk of software doing that:
> - logitech control software (forgot the name)
> - open razer software
> - sdl
> - asusctl (obviously it opens the device albeit in the future I will change this)
>
> and likely more given the fact not all software was identified.
> > Asusctl has a bug where if you add the quirk that separates the event
> > nodes per hid, this bug is reproduced as well. I chucked it to
> > complicated threading getting out of control. It is the reason we
> > skipped that patch that was in my series.
> I found and solved the bug already. Regardless the issue remains:
> Even with no asusctl at all, if a user has one logitech mouse
> (and its control software) and a razer keyboard (and its control software)
> the asus N-Key device will start an endless disconnect-reconnect loop.
>
> Any combination of two or more of those tools will trigger the issue
> on some devices (weirdly enough not every model is affected):
>
> this is not good.
> > Now, you say SDL/Steam do a spurious read as well, can you identify
> > the codepath so we can look into it? What devices are affected? The
> > early return fixes a warning on the Z13, but it also feeds through the
> > universal lamp interface on the new Xbox Allies. Is this a bug on
> > those devices or keyboards? If yes, it could be caused by userspace
> > hanging on that node
> Sure, and I agree with you that fixing all userspace tools is desirable
> but it's also unfeasible to fix them all, if we managed to do that
> there will be years before everyone receives a fixed version of every
> affected software and even then a core issue would remain:
> linux tries to poll something it can't have anything out from.
>
> I am much more oriented on the fact that kernel shouldn't
> be doing weird things (at least not by default) so this has to
> somehow be stopped regardless of how well userspace behaves.

The kernel is not doing weird things and I also did not ask you to fix
all userspace software. I asked for a reproduction scenario, as it is
not covered in the patch description. Relooking at the patch today, I
also do not understand what it does fully.

It skips enabling input interrupts (but not only that) for devices
that have no input reports. So the kernel behavior will depend on the
feature descriptor moving forward.

And that fixes a hang on the affected devices because enabling
interrupts on an endpoint without periodic input reports blocks a
parallel endpoint that does have input reports?

I would like this fix to target the actual cause that causes the block
but it is not clear to me what that is or what is affected.

Antheas

> If you have better ideas on how to fix the kernel we would
> like to hear those as well.
>
> Best regards,
> Denis
> > Antheas
> >
> >> pointless IN poll and keypress reports on the keyboard interface get
> >> dropped for as long as the node stays open: a lost key-down drops a
> >> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> >> reports never reach the URB layer.
> >>
> >> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> >> asus: early return for ROG devices") is what exposes it on these
> >> devices by keeping the input-less interface alive instead of ejecting
> >> it, so its hidraw node can be opened and the poll started.
> >>
> >> Skip the poll in usbhid_open() when the device has no input reports.
> >> Feature reports and hidraw output keep working over the control and OUT
> >> endpoints, so the interface is otherwise unaffected.
> I will write my review here to avoid forking the discussion:
>
> I agree with the general idea but perhaps we can avoid
> some hid devices to ever get HID_QUIRK_ALWAYS_POLL
> and that might be enough to skip the problematic code?
>
> Maybe there is value in doing this with a quirk flag in hid-asus.c
> affecting the least amount of devices?
>
> Or maybe just prevent devices with no data possibly coming out
> to ever get HID_QUIRK_ALWAYS_POLL?
>
> For how to best do this we will need to hear what Jiri and
> Benjamin have to say but if they think the proposed solution
> is the correct solution:
>
> Reviewed-by: Denis Benato <denis.benato@linux.dev>
> >> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> >> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> >> Tested-by: GameBurrow <gameburrow@pm.me>
> >> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> >> ---
> >>  drivers/hid/usbhid/hid-core.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> >> index 96b0181cf819..90a8b34d9305 100644
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -688,7 +688,8 @@ static int usbhid_open(struct hid_device *hid)
> >>
> >>         set_bit(HID_OPENED, &usbhid->iofl);
> >>
> >> -       if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
> >> +       if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
> >> +           list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
> >>                 res = 0;
> >>                 goto Done;
> >>         }
> >> --
> >> 2.54.0
> >>
> >>
> >>
>

