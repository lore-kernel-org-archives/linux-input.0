Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794494500;
	b=3n5fvAFpg8Uxi9dC5ixo50OU5ssyGOl9j5XXAaIzR459wQMMUgFvZ/1RwibORKlr58YC
	 lAWmvT7ub4rMRxlcm5lmLyLSV/nevxRVklNYzmbFgfPeNaKhaP46Wvo/8b02wms32BLfH
	 SUu4Jytr7yjcS2CiPrDliackjvi+caZoRlazDWA5z4zUFMcY1f28rBERsm2UE6/Yam3Rm
	 ekMm/GfAj7byAHaVK/y2aanL/4hziB0ey+302cpd8h5ZgkO34qqUE1RSdzGsSzMwBs6rb
	 PN2cm+BaJlmK0/8GkH2A/wkQOk8XvUVD7htqYsnCoscwQK4lrPL/aQ4mlFKwHJ/h0ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XMi2uNf4kEINwwVJKB9mZlyjoAtUla5QJEuCFYr6TrU=;
	b=3YOIW1Hkny9RDMiHS15/+N72F7rc/SMYxCRI3aVXSeyiI76JlFtFKavGiEyoeLk9IN0b
	 ++mvb7t/4MdlKtOmB6qrVNgfrT3Abr4Hp/vU9w2Ovc717peUU6P3wGZDZ/YU9n/cMQP8f
	 jwu4raMZ45aGN9haAgj+CvyceQmv3irOb3msOjmui+0c6GGDAN3r6OzCD7iAaHdbi8auC
	 +26Ps0Q2Yj4U/CUFw1DH4Fu+ivcW/zix14/dLogeoX+l4EYaLJkNlLl6HnzMhpsYwzzqH
	 8d3FT5dZwTXyBP4Imsoo1MeCSRoTDPn+D6J/76CwJ4QGUvrjTD0lSR64r+7UfeLfnTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbTdd8G+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CA606A327
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 14:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B2CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbTdd8G+
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b394e2af9cso22305847b3.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794494499; cv=none;
        d=google.com; s=arc-20260327;
        b=F6Q9jmAMhLmgEeepXvtJpims7yhcjvDB0Mj3j4T1Kr0+/UNzrhgQ7v9KBavjJ23eGf
         yLzXSBomdtMFHYm7iDaxZo1u6LnDS+lr9pQb4Q4b1VoH4RLMB/SJvxcVfS1DGPqLCObU
         ffg17iZRk0/pJZWOv3y3jdLm5DuPL1YRCyBcw2gpgIbNIV9s7roxUdogzy2TvAG5Tl9B
         1R7oZk4ZvNM1kzH44ElDb82h8hG/q57/Dqk9SlmjD1sWi1bGO+W+aGXDIZwRVhDHsHQh
         UhkYv1gqhXv0MMB3mvIDpioUgJ0gG/fciXfWCboLVfQPglE6OSf9brwQ2PuFLc/jJ7iB
         BFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XMi2uNf4kEINwwVJKB9mZlyjoAtUla5QJEuCFYr6TrU=;
        fh=+4g3It5SG4nbDf+SbRJjwPku44cAL7eEU5oQiy09pAI=;
        b=KrHiejrq2BRZXg7MQiXENhs9pB9c2oXqbwHK70vHqtXV9O/Hctu1V6pQ0wWwRt3pRH
         P4nmU2k29k4aYcpZAOge6mZBCk48kIhUo69H0lTnkJYUhTr7emmngkJ9RMEmDMpI9wTp
         qjJN+ilIKpQCD9mJHZx5fT76HPc4qA5lGkwCpPEFnsTCMuP3kgxXeYON9SdKO0cnefDY
         cQ13lb2oR7wdTF29wua3QhjqEPS99rbbKOjoclruUt5o3qZMJTS/MKUktQdr7WjTAIO8
         4oZP7+UJhieECjb/1RTCX7a423XXMeX5/lREsFpBDo/9lqa1TjUmC3GUvpevXe64Caab
         BEnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794494499; x=1795099299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XMi2uNf4kEINwwVJKB9mZlyjoAtUla5QJEuCFYr6TrU=;
        b=qbTdd8G+dLlaj7SJd2HpetcaoEL9IjmajHjCzxZ2eHJ6H4j4bjzy5dSiOme4XarRKY
         ND9a7w9hoISAoGFlJgadrUzRKFg/dMvYwtJMzGOH2WBia01oUvIjHThuaBW43cwTsSb6
         GljlxIrj1G0n3pBvAHencUrts6z7PBYJwKTqGyT3bxDhISvRSm7CrXzJS+wr5WCkqOlE
         /5KDdYwcvxSRfKl4kMnlFjVRnJ7XO6ukBvI40PO50TBcD6jR+44SPs/Nz9QUyvLrx7ux
         4tAigew1cMbEP2snTGRCnaL3YAzMT5rikILAXuR2FNaSvfhTy080jvDhrHnVW58/O5VP
         TZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494499; x=1795099299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMi2uNf4kEINwwVJKB9mZlyjoAtUla5QJEuCFYr6TrU=;
        b=03dHH2ysphSOlUCWY8YRt/YL/B9xEORddXHhVShcjFHJfP/X0eF9AqwHoZH17tYkP1
         JqwTJT6Wqyxj9/mQ6kdMpnOzNNhmMab4Bg2NMd0xgxdzf9yhmShr9LVtznN1nA0PcTT3
         5hrhwDV8drRrlZFU/xAhbVEoRk8S66A8NncngZp9538S7drVNU6zsdKO/nKSRQJMN7Ou
         RmbeM0P2kBBUpMwQAlMPPfPse+81aOXVqSaBKxd4S3ZsWrHpNbhdr0EQmRg+lo7ZbJ3k
         gLHJU84F2y8SAzcvnlBQECV73tsbgA4UnXbBBCug+Qyksy3+EdVjOpOnratJ+KG1FTfS
         xR+Q==
X-Forwarded-Encrypted: i=1; AL+hErFJpSfcnxrFgURjMwmydG40W/ukgICJp7A7Rjlrlaj7L/7zQhZ1Wp5A65snig2u0YDP1v7gaTszTlPJWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YpbpchuQqBlOOw9Ln3Zd2kakXkZZrN0RhepSCCR4ppiZf9sZD
	qN6Y1BVUkVZcKMKsiKrgXcCgpb+2vUO9/lPfxTdLtM/zmsemwNYRcsN+474pRBmh0gCPMwJ0yjY
	EqnpNO700RpsOTKVuerwo+OVdPQtn9Ak=
X-Gm-Gg: AYBFou3XAesIkCUwLZMFpeamiKAJW2dflLoQsLiPwU2vYMDdGhgqVA2VVsoQ+2FreO2
	VqwPnvkzPGDLRtM/JL6UeBr9luqnCSr88P1/myIYWYc2gFFvcik3zFUsZp3E43dx0KHi4WpY6Iu
	cOMNG0EKrIO/UBD6GFl2NaTlYNlyhvXdrfe7P6/Xr68V+H8sm27Y1pYi4y2L34f2KDVJcEGZI+b
	WxkH4H8r3JfzlYKY+t3eZRBt3T98LAMV123hBQ2eLoZFb2QzUHSvSUNSoXudLjki98PaRPnEAof
	F5cAtLKBUXaUENnG2YJvCdRgbEyioaiImi5wBX7HnYBdgYAbzmrvPYid9TkXUYh80UmwbsBqlly
	ZmbmkeIBGrnfXfrY4Rd2JoLx26cV7sAE0G09Cq9dPKFOyo7IFYMm4z8F+87zPjUV6vi8LaqG6
X-Received: by 2002:a05:690e:12cf:b0:67c:efb:636d with SMTP id
 956f58d0204a3-67c67fd681cmr3269299d50.109.1794494497955; Thu, 12 Nov 2026
 06:41:37 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
 <2f722967b6db0692d4dd4164aff39b62@gmail.com> <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com>
 <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com>
In-Reply-To: <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Thu, 12 Nov 2026 15:41:26 +0100
X-Gm-Features: AclHuK_YniiwxVYgwOckPS4sO-hO7pcdzoav-6qrvltxQQYqKoQ5yDSshyui9Mk
Message-ID: <CAPb1+K1mmyvipXSx96-j-+zgxeTztLNfYYTuERw0Ykf5WDv9sg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

A follow-up to my last mail. I ran the rmmod test a second time with
the same result: no crash, and rmmod blocked for 3m7s, again with 12
=E2=80=9CFailed to send command to device!=E2=80=9D lines 15.36 s apart. Th=
is time the
kernel printed a hung task warning, which shows where it waits:

INFO: task rmmod:6286 blocked for more than 122 seconds.
      Tainted: G S  7.3.4-1-cachyos #1
task:rmmod state:D
Call Trace:
 schedule+0x6f/0xb0
 schedule_timeout+0x31/0x140
 wait_for_completion+0xc7/0x1f0
 __flush_workqueue+0x198/0x420
 drain_workqueue+0x4f/0x150
 destroy_workqueue+0x56/0x390
 hidpp_ff_destroy+0x42/0x50 [hid_logitech_hidpp]
 input_ff_destroy+0x33/0x70
 input_unregister_device+0x48/0x70
 hidinput_disconnect+0x45/0xc0
 hid_hw_stop+0x8c/0xc0
 hidpp_remove+0x39/0x60 [hid_logitech_hidpp]
 hid_device_remove+0x4a/0xa0
 device_release_driver_internal+0x1c2/0x320
 driver_detach+0x8f/0xd0
 bus_remove_driver+0x102/0x190
 hid_unregister_driver+0x22/0xb0
 __se_sys_delete_module+0x291/0x3d0

So with your patch the final teardown now runs from
input_unregister_device() while the module is still loaded, which is
what we wanted. The 3 minute wait is destroy_workqueue() draining the
queued commands, each of which times out after the driver=E2=80=99s 3 x 5 s
retry. I have not tested whether the series=E2=80=99 changes to the send pa=
th
and removal order shorten this on this kernel.

Thanks,
Gideon

On Thu, Nov 12, 2026 at 3:30=E2=80=AFPM Gideon Heinz <gideonheinz02@gmail.c=
om> wrote:
>
> Hi Dmitry,
>
> I tested your input core patch (=E2=80=9CInput: destroy force-feedback de=
vice
> on input unregistration=E2=80=9D) on a real kernel: CachyOS 7.3.4 (stable=
,
> which already has an equivalent G920 init fix) plus only your patch,
> with the stock hid-logitech-hidpp driver. The hidpp series is not
> applied, since it doesn=E2=80=99t apply to 7.3.4 as is.
>
> Same reproduction as before: fftest holding the G920 event node at the
> effect prompt, rmmod hid_logitech_hidpp from another terminal, then
> fftest exiting. The machine no longer goes down. The module unloaded
> cleanly and the system stayed responsive.
>
> One observation: with the stock driver, rmmod blocked for about 3
> minutes. After =E2=80=9CUnloading HID++ force feedback.=E2=80=9D dmesg sh=
ows 12
> =E2=80=9CFailed to send command to device!=E2=80=9D lines, 15.36 s apart =
(the 3 x 5 s
> retry per command), then rmmod returned. I assume these are the queued
> effect erases timing out because the transport is already closed, and
> that the series=E2=80=99 changes to hidpp_send_message_sync() and the
> synchronous erase would remove this wait, but I have not tested that
> combination on this kernel.
>
> Tested-by: Gideon Heinz gideonheinz02@gmail.com
>
> Thanks,
> Gideon
>
> On Thu, Nov 12, 2026 at 11:48=E2=80=AFAM Gideon Heinz <gideonheinz02@gmai=
l.com> wrote:
> >
> > Hi Dmitry,
> >
> > I tested the out-of-tree equivalent you suggested, ff->destroy =3D NULL=
;
> > in hidpp_ff_stop(), on top of the 33-patch v2 module (G920 046d:c262,
> > 7.3.1-1-cachyos).
> >
> > Same reproduction as before: fftest holding the event node at the
> > effect prompt, rmmod hid_logitech_hidpp from another terminal, then
> > entering -1 in fftest.
> > This time fftest exits normally, the machine stays up, and there are
> > no errors in dmesg.
> > The only message is the single =E2=80=9CUnloading HID++ force feedback.=
=E2=80=9D at rmmod time.
> >
> > I=E2=80=99ll try your input core patch on a rebuilt kernel later and re=
port back
> >
> > Thanks,
> > Gideon
> >
> > On Thu, Nov 12, 2026 at 3:43=E2=80=AFAM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Hi Gideon,
> > >
> > > On Thu, Nov 12, 2026 at 02:30:39AM +0100, Gideon Heinz wrote:
> > > > Hi Dmitry,
> > > >
> > > > I tested v2 of the series on my G920 (046d:c262). Everything on my
> > > > list works except one scenario that takes the whole machine down, w=
ith
> > > > and without your series (last item).
> > > ...
> > > >  - rmmod with fftest holding the device open: rmmod returned after
> > > >    2.99 s with "Unloading HID++ force feedback" and nothing else in
> > > >    dmesg. When I then exited fftest (entering -1), the machine went
> > > >    down: the first time with a garbled panic screen that I couldn't
> > > >    read, and on later attempts as a total hang with no output. The
> > > >    same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
> > > >    driver also hangs the whole system, so this predates the series.
> > > >
> > > >    To reproduce: with the module loaded and the G920 plugged in, st=
art
> > > >    fftest on its event node and leave it at the effect prompt, run
> > > >    "rmmod hid_logitech_hidpp" from another terminal, then enter -1 =
in
> > > >    fftest.
> > > >
> > > >    I could not recover a trace yet and will send one if I manage to=
.
> > > >
> > > >    My guess, from reading the code and not verified by a trace:
> > > >    hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
> > > >    callbacks in the ff_device as pointers into the module. With fft=
est
> > > >    holding the evdev open, the input_dev outlives the driver, so wh=
en
> > > >    fftest closes, the final input_dev release calls ff->destroy in
> > > >    module code that rmmod has already freed.
> > >
> > > Thank you very much for the thorough testing!
> > >
> > > Your diagnosis is spot on. Opening /dev/input/eventX pins the evdev c=
dev
> > > (and through it input_dev), but does not hold a module reference on t=
he
> > > underlying HID driver. When rmmod unloads hid_logitech_hidpp while ff=
test
> > > still has the file descriptor open, __input_unregister_device() disco=
nnects
> > > evdev (flushing effects, closing the device, and marking evdev dead s=
o all
> > > subsequent ioctls and writes return -ENODEV) and runs ff->stop(), aft=
er
> > > which rmmod frees the module text. When fftest finally exits and clos=
es the
> > > file descriptor, input_dev_release() calls input_ff_destroy(), which
> > > invokes ff->destroy() pointing into the already-unmapped module text.
> > >
> > > Rather than working around this in individual drivers with a separate
> > > ff->stop() callback, input core should call input_ff_destroy() direct=
ly in
> > > __input_unregister_device() once all handlers are disconnected and th=
e
> > > device is removed from sysfs. At that point nothing touches dev->ff
> > > anymore, and calling input_ff_destroy() there guarantees ff->destroy(=
)
> > > always runs while the driver and its module are still loaded (while t=
he
> > > second input_ff_destroy() call in input_dev_release() becomes a no-op=
 once
> > > dev->ff is NULL).
> > >
> > > Could you try the input core patch below (with patch 22/33 "HID:
> > > logitech-hidpp: shut down G920 force feedback on input unregister" dr=
opped
> > > from the hid-logitech-hidpp series, since ff->stop is removed and
> > > hidpp_ff_destroy() will now run on input unregistration)?
> > >
> > > Alternatively, if you prefer to test with your out-of-tree module bui=
ld
> > > without rebuilding the kernel, you can test the equivalent effect by
> > > setting:
> > >
> > >         ff->destroy =3D NULL;
> > >
> > > inside hidpp_ff_stop() in hid-logitech-hidpp.c.
> > >
> > > Thanks.
> > >
> > > ---
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Subject: [PATCH] Input: destroy force-feedback device on input unregi=
stration
> > >
> > > When an input device is unregistered while userspace holds an open fi=
le
> > > descriptor to its event node, input_dev_release() is deferred until t=
he
> > > last file descriptor is closed. Because input_ff_destroy() was only
> > > called from input_dev_release(), force-feedback teardown (ff->destroy
> > > and freeing ff->private) could run after the parent driver had alread=
y
> > > unbound, freed its device state, or even been unloaded via rmmod,
> > > causing use-after-free errors or page faults in unmapped module text.
> > >
> > > Commit ef166ce08801 ("Input: stop force-feedback timer when
> > > unregistering input devices") added a separate ff->stop callback for
> > > ff-memless, but left ff->destroy invoked from input_dev_release().
> > >
> > > Once __input_unregister_device() has disconnected all input handlers
> > > (which flushes effects, closes the device, and marks evdev dead) and
> > > deleted the device from sysfs, nothing accesses dev->ff anymore. Call
> > > input_ff_destroy() directly in __input_unregister_device() so that
> > > ff->destroy() always runs synchronously while the driver and its modu=
le
> > > are still active, and remove the now-redundant ff->stop callback. Kee=
p
> > > input_ff_destroy() in input_dev_release() (where it is a no-op once
> > > dev->ff is NULL) to handle input_free_device() on devices that were
> > > never registered.
> > >
> > > Fixes: 509ca1a93836 ("Input: implement new force feedback interface")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/input/ff-core.c    |  2 +-
> > >  drivers/input/ff-memless.c | 23 -----------------------
> > >  drivers/input/input.c      |  5 ++---
> > >  include/linux/input.h      |  3 ---
> > >  4 files changed, 3 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> > > index 0e5d1d1ceb46..133b4622dc49 100644
> > > --- a/drivers/input/ff-core.c
> > > +++ b/drivers/input/ff-core.c
> > > @@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(input_ff_create);
> > >   *
> > >   * This function is only needed in error path as input core will
> > >   * automatically free force feedback structures when device is
> > > - * destroyed.
> > > + * unregistered or destroyed.
> > >   */
> > >  void input_ff_destroy(struct input_dev *dev)
> > >  {
> > > diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> > > index d1fefd1dfc0d..3069436148ec 100644
> > > --- a/drivers/input/ff-memless.c
> > > +++ b/drivers/input/ff-memless.c
> > > @@ -483,32 +483,10 @@ static void ml_ff_destroy(struct ff_device *ff)
> > >  {
> > >         struct ml_device *ml =3D ff->private;
> > >
> > > -       /*
> > > -        * The timer is normally shut down in ml_ff_stop() when the d=
evice
> > > -        * is unregistered. However, we still shut it down here as a =
safety
> > > -        * net and for cases where the device was never registered (e=
.g.
> > > -        * error paths during probe).
> > > -        */
> > >         timer_shutdown_sync(&ml->timer);
> > > -
> > >         kfree(ml->private);
> > >  }
> > >
> > > -static void ml_ff_stop(struct ff_device *ff)
> > > -{
> > > -       struct ml_device *ml =3D ff->private;
> > > -
> > > -       /*
> > > -        * Even though we stop all playing effects when tearing down =
an
> > > -        * input device (by the way of evdev calling input_flush_devi=
ce()
> > > -        * that calls into input_ff_flush() that stops and erases all
> > > -        * effects), we do not actually shutdown the timer, and there=
fore
> > > -        * we should do it here to prevent it firing after the input
> > > -        * device is unregistered and its associated resources are fr=
eed.
> > > -        */
> > > -       timer_shutdown_sync(&ml->timer);
> > > -}
> > > -
> > >  /**
> > >   * input_ff_create_memless() - create memoryless force-feedback devi=
ce
> > >   * @dev: input device supporting force-feedback
> > > @@ -543,7 +521,6 @@ int input_ff_create_memless(struct input_dev *dev=
, void *data,
> > >         ff->playback =3D ml_ff_playback;
> > >         ff->set_gain =3D ml_ff_set_gain;
> > >         ff->destroy =3D ml_ff_destroy;
> > > -       ff->stop =3D ml_ff_stop;
> > >
> > >         /* we can emulate periodic effects with RUMBLE */
> > >         if (test_bit(FF_RUMBLE, ff->ffbit)) {
> > > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > > index 210635ef147e..7be69deed8eb 100644
> > > --- a/drivers/input/input.c
> > > +++ b/drivers/input/input.c
> > > @@ -2286,10 +2286,9 @@ static void __input_unregister_device(struct i=
nput_dev *dev)
> > >                 input_wakeup_procfs_readers();
> > >         }
> > >
> > > -       if (dev->ff && dev->ff->stop)
> > > -               dev->ff->stop(dev->ff);
> > > -
> > >         device_del(&dev->dev);
> > > +
> > > +       input_ff_destroy(dev);
> > >  }
> > >
> > >  static void devm_input_device_unregister(struct device *dev, void *r=
es)
> > > diff --git a/include/linux/input.h b/include/linux/input.h
> > > index 3381608127f7..02047cc45d04 100644
> > > --- a/include/linux/input.h
> > > +++ b/include/linux/input.h
> > > @@ -549,8 +549,6 @@ extern const struct class input_class;
> > >   * @set_autocenter: Called to auto-center device
> > >   * @destroy: called by input core when parent input device is being
> > >   *     destroyed
> > > - * @stop: called by input core when parent input device is being
> > > - *     unregistered
> > >   * @private: driver-specific data, will be freed automatically
> > >   * @ffbit: bitmap of force feedback capabilities truly supported by
> > >   *     device (not emulated like ones in input_dev->ffbit)
> > > @@ -579,7 +577,6 @@ struct ff_device {
> > >         void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
> > >
> > >         void (*destroy)(struct ff_device *);
> > > -       void (*stop)(struct ff_device *);
> > >
> > >         void *private;
> > >
> > >
> > > --
> > > Dmitry
