Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CA218845
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852658; cv=none; b=KDP0oGrUhNHygy9tAWeZldrN032O28r0CEf/IETnfxtK3OjPLUy5r2WPw43S2biNA0VTyWZplcRWkCy4j/3PU+OmXW6AYom5iktYEZqo0uwDuyyHEd8lncrtA4a8kIYyrskW8sfQTEuOIdOD4jeIYmWEx7YwJUs7CpevNvY3Gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852658; c=relaxed/simple;
	bh=0lwPvAxsbAv1b8yVowffgrHDKj95MP1u1b30u5nm0AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edtkPvH1bHgmeaAljVe4gUTEJGNvV5XerRTvRzrOh5cl3zF0NwIMRiNnIz+1/9sgYq/lXOJiKMhMnfAScvj8u/pM0CotAnDesYafvW+/9ns8cHyH2muslOeYvysswrc7mkpNlUok5mUxh8Pze2Q1d8w6ORraSmzKfMwzyfoZB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CLhKRYu8; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CLhKRYu8"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id B06FFBD8C0
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 20:11:31 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id B9C34BC16D
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 20:11:28 +0300 (EEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 304051FF01C
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 20:11:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1780852288;
	bh=lP34alYXKSXdX10Tsq06/SvUAkF1mO4zX+4ngXpjbUw=;
	h=Received:From:Subject:To;
	b=CLhKRYu8oGGvLGTzo9AR3vnj2ZYZ8CVGC+geZGCjkV3Ej+pBdz3mrYh8zFtLSmga4
	 tmO94kGeeZNdQw6laEO3rE1PKyDQ/nYmId37qH8asGU80Ms4ZcHg01GSGjB+nka0Ew
	 vE6iIFxQxJLrdJud6V1uPsTKxiAh8Oe1t30TV+U29VIUR9stQmhWYTxB/nr8f9v47m
	 tqR4fsi9iMbP6C9NQrclYacB3uPyQ6ggefT26ZbJ3aR613YuvulFQxXI0fjo+Ym6Bb
	 yBpxVgdvcTaRa0FcSr880EAnKxNUfK9LXgny9nCmOjtqZg2OzT37EBegsbZ5TFL+EN
	 fWNdPy8VFwoFQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c85822059d8so2246624a12.1
        for <linux-input@vger.kernel.org>;
 Sun, 07 Jun 2026 10:11:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/6JdsKr5M0NwvvErNuo5F1GREQt/8UFvB5GRRx2uIcZJvCuBJ+7knm4BqO24KgnYD8quL3D9jJ5IqN/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGVjl++M6o1+10qT8nQPkmES9L/debll/ll4ippecSjelypcj
	+LXHRQLLrmBcnnIWMwEchGN9wc/+IL0WkZU+IqQEY2JV3pae1bb5lkM6+uKH7zlpzXQ3sUKd5Ad
	Ksj7/xJJ/+EgCTyEvg3wHevz2LO03JZQ=
X-Received: by 2002:a05:6a20:244b:b0:3b4:7758:e397 with SMTP id
 adf61e73a8af0-3b4ccd71185mr14123618637.16.1780852286806; Sun, 07 Jun 2026
 10:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605113952.38435-1-yaseen@ghoul.dev>
 <CAGwozwFWbW=v2B7ruS4OUGuPhjSayw4Qxj3K+bCzwmgQu158Ng@mail.gmail.com>
 <ceb5ed4b-1654-463d-9cff-4a1b91d52e92@gmail.com>
 <CAGwozwFMm2o2G-fOixvu+QVXGsDC+E81+1Nsk4kQ7xbpnvhVPg@mail.gmail.com>
 <20a9d77f-c60a-44ba-ac39-15107fc81256@ghoul.dev>
 <CAGwozwHHF5URNDxus5_WgPNiPc7VD_Gc4NJhV3eDDGdX6e53OA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHHF5URNDxus5_WgPNiPc7VD_Gc4NJhV3eDDGdX6e53OA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 7 Jun 2026 19:11:16 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF-xyXa9kZGB_w3yjVQsFJHx9ys3YmDyLwYojSLLh5pCw@mail.gmail.com>
X-Gm-Features: AVVi8CdtRQqM-rDXT0fojzLMWQ0ZioZHMmwLVzbnMRwrSTCteWUJ5q9YcJKRMXk
Message-ID: 
 <CAGwozwF-xyXa9kZGB_w3yjVQsFJHx9ys3YmDyLwYojSLLh5pCw@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: skip interrupt IN polling for devices with
 no input reports
To: Yaseen <yaseen@ghoul.dev>
Cc: Denis Benato <benato.denis96@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
 linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178085228847.807251.7914060467001157078@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 7 Jun 2026 at 19:03, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Sun, 7 Jun 2026 at 18:51, Yaseen <yaseen@ghoul.dev> wrote:
> >
> > On 06/06/2026 18:13, Antheas Kapenekakis wrote:
> > > On Sat, 6 Jun 2026 at 14:42, Denis Benato <benato.denis96@gmail.com> wrote:
> > >>
> > >>
> > >> On 6/5/26 14:02, Antheas Kapenekakis wrote:
> > >>> On Fri, 5 Jun 2026 at 13:40, Ahmed Yaseen <yaseen@ghoul.dev> wrote:
> > >>>> usbhid starts polling a device's interrupt IN endpoint on open
> > >>>> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
> > >>>> input reports there is nothing to read there, so the poll is useless,
> > >>>> and on some composite devices it is also harmful.
> > >>> If it did have input reports, would starting the polling still cause
> > >>> issues? Because if it would, the issue is in the polling itself.
> > >> So far we haven't found an asus device that has more than one interface
> > >> that supports reading data out of if.
> > >>> Given the creativity of manufacturers when implementing hid protocols,
> > >>> I find it certain that they do use the in endpoint even without input
> > >>> reports. E.g., for feature reports. This could cause regressions.
> >
> > The ASUS ROG N-Key Device does have feature reports. They are used for
> > RGB control on the keyboard. I have confirmed this with a test by not
> > registering the hidraw node for this interface at all and noted that RGB
> > stops working after. So hiding or ejecting this interface is not an
> > option. Therefore, after this patch, I myself, together with Kerim and
> > GameBurrow have paid attention explicitly to ensure there are no
> > regressions to the LED controls, while fixing the keyboard issue.
> >
> > Also worth noting that feature reports travel over EP0 via
> > usbhid_{get,set}_raw_report() in both directions. The interrupt IN
> > endpoint is only ever used to receive input reports: hid_irq_in() passes
> > everything it gets to hid_safe_input_report(HID_INPUT_REPORT, ...).
> > There is no code in usbhid that reads feature reports from the interrupt
> > IN endpoint at all, so skipping that poll cannot break any feature
> > reports on any device. This is also mentioned in my patch description:
> >
> >         "Feature reports and hidraw output keep working over the control and
> > OUT endpoints, so the interface is otherwise unaffected."
> >
> > Regarding a manufacturer using in endpoint without an input report, even
> > today, the HID core would drop that data before it reaches hidraw:
> > __hid_input_report() bails when hid_get_report() finds no matching
> > report. That bail is also before the driver's ->raw_event() callback, so
> > no driver or hidraw reader can currently be relying on such traffic.
>
> Interesting, so it should noop. Muting the in endpoint would not
> affect feature reports that get sent over the in endpoint? I do not
> think this patch will cause regressions for Asus devices. I'm more
> concerned with other ones. E.g., the Legion Go S has a malformed
> report, and I do not recall which endpoints it uses. Then, the Win 5
> also does a mix. Those are two devices I'd be concerned with, but
> there are a myriad of other hid devices this could affect.
>
> I'd rather if possible the fix goes towards fixing the underlying
> issue that blocks processing inputs from other devices. This way, even
> for devices with an actual input report that is infrequent, this issue
> stops being present, even if the blocking wouldn't have been
> perceptible.
>
> I can reproduce on my Z13 in the following days.
>
> Best,
> Antheas
>
> > >> While I mostly agree with this it is also true that the general direction
> > >> for the kernel (especially lately) has been to not do out-of-spec things
> > >> at least by default.
> > >>
> > >> If things really regress it's expected to do so only an very few specific
> > >> devices with a buggy firmware, and we can think of something different
> > >> for those (hopefully very few ones).
> > >>
> > >> Perhaps someone concerned with security might be interested in what
> > >> we have because it doesn't look very normal.
> > >>
> > >> Note that below I have written a few ideas that maybe are worth
> > >
> > > The degradation would be silent.
> > >
> > >> looking into.
> > >>>> The ASUS ROG N-Key keyboards expose a second, input-less interface used
> > >>>> only for RGB control via feature reports. Opening its hidraw node (any
> > >>>> hidraw reader does, including SDL/Steam Input or a plain cat) starts the
> > >>> cating a hidraw causing issues would be expected, so let's focus on the former.
> > >
> > > Try to add spaces before and after your responses
> > >
> > >> Simply opening an hidraw should not trigger a delayed disconnect of that device,
> > >> I don't know why you would expect this to happen nor why you would
> > >> consider it acceptable. It's a bug.
> > >>
> > >> Focusing on userspace software exposing the bug is not a realistic option
> > >> because over the time we found a good chunk of software doing that:
> > >> - logitech control software (forgot the name)
> > >> - open razer software
> > >> - sdl
> > >> - asusctl (obviously it opens the device albeit in the future I will change this)
> > >>
> > >> and likely more given the fact not all software was identified.
> > >>> Asusctl has a bug where if you add the quirk that separates the event
> > >>> nodes per hid, this bug is reproduced as well. I chucked it to
> > >>> complicated threading getting out of control. It is the reason we
> > >>> skipped that patch that was in my series.
> > >> I found and solved the bug already. Regardless the issue remains:
> > >> Even with no asusctl at all, if a user has one logitech mouse
> > >> (and its control software) and a razer keyboard (and its control software)
> > >> the asus N-Key device will start an endless disconnect-reconnect loop.
> > >>
> > >> Any combination of two or more of those tools will trigger the issue
> > >> on some devices (weirdly enough not every model is affected):
> > >>
> > >> this is not good.
> > >>> Now, you say SDL/Steam do a spurious read as well, can you identify
> > >>> the codepath so we can look into it? What devices are affected? The
> > >>> early return fixes a warning on the Z13, but it also feeds through the
> > >>> universal lamp interface on the new Xbox Allies. Is this a bug on
> > >>> those devices or keyboards? If yes, it could be caused by userspace
> > >>> hanging on that node
> >
> > Affected devices include the ROG STRIX 2025 lineup: Scar 16/18
> > (G635L/G835L) and G16/G18 (G615L/G815L). My patch has been tested on
> > both Scar 18 and G18. Additionally a user with a Scar 18 2024 model
> > (G634JZR) has reported the issue as well; they were unable to
> > participate in testing but reproduce the issue with the same cat command
> > (reproduction command provided below). It is likely the G16/G18 of 2024
> > will also be affected. Models prior to 2024 appear unaffected so far.
> >
> > A user with an Xbox Ally X has tested this for me as well as of writing
> > this email. So we are able to confirm that this device is unaffected and
> > no regressions are noticed on that device from my patch, including the
> > lamp/RGB controls.
> >
> > I do not have access to a Z13 at the moment. If you have one, it would
> > be very helpful for me if you could test for any regressions on that
> > device and if the device is affected by the bug, and whether or not this
> > patch fixes the issue.
> >
> > I would also like to take this opportunity to mention that the 3 testers
> > and I are all daily driving a kernel with this patch applied, and over
> > the last few days, have noticed no issues with any devices.
> >
> > >> Sure, and I agree with you that fixing all userspace tools is desirable
> > >> but it's also unfeasible to fix them all, if we managed to do that
> > >> there will be years before everyone receives a fixed version of every
> > >> affected software and even then a core issue would remain:
> > >> linux tries to poll something it can't have anything out from.
> > >>
> > >> I am much more oriented on the fact that kernel shouldn't
> > >> be doing weird things (at least not by default) so this has to
> > >> somehow be stopped regardless of how well userspace behaves.
> > >
> > > The kernel is not doing weird things and I also did not ask you to fix
> > > all userspace software. I asked for a reproduction scenario, as it is
> > > not covered in the patch description. Relooking at the patch today, I
> > > also do not understand what it does fully.
> >
> > The reproduction scenario is in the patch description:
> >
> >         "Opening its hidraw node (any hidraw reader does, including SDL/Steam
> > Input or a plain cat) starts the pointless IN poll and keypress reports
> > on the keyboard interface get dropped for as long as the node stays
> > open: a lost key-down drops a letter, a lost key-up leaves the key stuck."
> >
> > i.e. run "sudo timeout 15 cat /dev/hidrawX" against the N-Key RGB
> > interface, then type on the internal keyboard.
> >
> > >
> > > It skips enabling input interrupts (but not only that) for devices
> > > that have no input reports. So the kernel behavior will depend on the
> > > feature descriptor moving forward.
> >
> > What the patch does is the last paragraph of the description:
> >
> >         "Skip the poll in usbhid_open() when the device has no input reports."
> >
> > Interrupt IN endpoint on a device with 0 input reports isn't doing
> > anything anyway. The other things the early return skips only matter
> > when input is possible.
> >
> > >
> > > And that fixes a hang on the affected devices because enabling
> > > interrupts on an endpoint without periodic input reports blocks a
> > > parallel endpoint that does have input reports?
> > >
> > > I would like this fix to target the actual cause that causes the block
> > > but it is not clear to me what that is or what is affected.
> >
> > As per my investigations with usbmon, I can see that the keyboard
> > interface's input reports never reach the URB layer while the RGB
> > interface is being polled. From the patch description:
> >
> >         "usbmon shows the dropped reports never reach the URB layer"
> >
> > So the blocking likely happens inside the device's firmware, and not in
> > the kernel, so the kernel cannot fix that part. What the kernel can do
> > is to stop arming the IN URB on an endpoint that as per its own
> > descriptor, can never produce data.
> >
> > >
> > > Antheas
> > >
> > >> If you have better ideas on how to fix the kernel we would
> > >> like to hear those as well.
> > >>
> > >> Best regards,
> > >> Denis
> > >>> Antheas
> > >>>
> > >>>> pointless IN poll and keypress reports on the keyboard interface get
> > >>>> dropped for as long as the node stays open: a lost key-down drops a
> > >>>> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> > >>>> reports never reach the URB layer.
> > >>>>
> > >>>> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> > >>>> asus: early return for ROG devices") is what exposes it on these
> > >>>> devices by keeping the input-less interface alive instead of ejecting
> > >>>> it, so its hidraw node can be opened and the poll started.
> > >>>>
> > >>>> Skip the poll in usbhid_open() when the device has no input reports.
> > >>>> Feature reports and hidraw output keep working over the control and OUT
> > >>>> endpoints, so the interface is otherwise unaffected.
> > >> I will write my review here to avoid forking the discussion:
> > >>
> > >> I agree with the general idea but perhaps we can avoid
> > >> some hid devices to ever get HID_QUIRK_ALWAYS_POLL
> > >> and that might be enough to skip the problematic code?
> > >>
> > >> Maybe there is value in doing this with a quirk flag in hid-asus.c
> > >> affecting the least amount of devices?
> > >>
> > >> Or maybe just prevent devices with no data possibly coming out
> > >> to ever get HID_QUIRK_ALWAYS_POLL?
> >
> > Thank you for the review!
> >
> > I would like to also highlight one thing here; the HID_QUIRK_ALWAYS_POLL
> > is not given to this specific device. It was already in the if
> > condition, for the devices that do use it; my change only ORs a second
> > independent condition into it. So keeping devices away from that quirk
> > would not change anything here.
> >
> > Adding a quirk flag for this specific device is something I too have
> > considered and will be happy to change it like so if Jiri or Benjamin
> > feel it is more appropriate. My reasoning for taking the current route
> > is that it would prevent any hidden issues that might arise similarly,
> > and fix the whole class of this issue rather than for one vendor when
> > the likelihood of a regression is very low from skipping interrupt IN
> > polling if a device doesn't have input reports in the first place.
> >

I missed this part of the response. Here I'd add that
HID_QUIRK_ALWAYS_POLL is part of six if statements so your patch is
not equivalent to HID_QUIRK_ALWAYS_POLL. If it should be, perhaps an
alternative for fixing just asus devices would be to OR that quirk
when hid-asus initializes for all devices. I am not sure if it is a
firmware issue, if it is a kernel issue that can be mitigated without
quirks or skipping enabling the in endpoint, I'd prefer that. Failing
that, a quirk would perhaps limit the affected devices

Antheas

> > Best Regards,
> > Yaseen
> >
> > >>
> > >> For how to best do this we will need to hear what Jiri and
> > >> Benjamin have to say but if they think the proposed solution
> > >> is the correct solution:
> > >>
> > >> Reviewed-by: Denis Benato <denis.benato@linux.dev>
> > >>>> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> > >>>> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> > >>>> Tested-by: GameBurrow <gameburrow@pm.me>
> > >>>> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> > >>>> ---
> > >>>>   drivers/hid/usbhid/hid-core.c | 3 ++-
> > >>>>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > >>>> index 96b0181cf819..90a8b34d9305 100644
> > >>>> --- a/drivers/hid/usbhid/hid-core.c
> > >>>> +++ b/drivers/hid/usbhid/hid-core.c
> > >>>> @@ -688,7 +688,8 @@ static int usbhid_open(struct hid_device *hid)
> > >>>>
> > >>>>          set_bit(HID_OPENED, &usbhid->iofl);
> > >>>>
> > >>>> -       if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
> > >>>> +       if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
> > >>>> +           list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
> > >>>>                  res = 0;
> > >>>>                  goto Done;
> > >>>>          }
> > >>>> --
> > >>>> 2.54.0
> > >>>>
> > >>>>
> > >>>>
> >
> >
> >

