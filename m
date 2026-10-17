Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AB1917CD
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213433; cv=pass; b=JYmLwj1e1DHlogUYYOPQI2FiKz9q8UUFr1ahDNV8A1gGR7MBkZ4Pg2y3ItncFcL+1fQyoO2dGIM7LrAP2OzoTbGNsu2hmbXuJymL429oToqtS/4wkhOeYCERDDSuvDIRZJxJXr8iWZ5Gf13lB9Fr5oYsreD8gZjIxNJFatpx5/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213433; c=relaxed/simple;
	bh=rFc5pmBoKf0Jr8nuAmxu9DZjfgjdETCBQfYkiWBsF7Q=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yff8z6aAJYA67R+22/78k+0qN0tiwFhkO5kEseIhH9kMTB4NGYuZZIuBp7QBKwNR6lrWgtt3F+SBPcp1zbmQdtPEVEctKbdWVhoARp/wEn+kgj7sIC2lSL2icVEgAHRTCam5v20ACCGweK3ZEWoL31YHhgLxvyWHPQCJlT+M6to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LO3QIBVI; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO3QIBVI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so584537e87.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 22:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792213429; cv=none;
        d=google.com; s=arc-20260327;
        b=ocJsbqioFqevONAOYmMS1nIaWtk6lhbiSrCDRhjNMmvsS+9rvbFaWjtSAvcxrPlxUU
         Kya9e2s5UOUu4Rb3aZpglRmMd6Cu3FMFcM7MsyBaNSAT5J4Zuz6Ee4l5+BrgzdwK/9bT
         tQS8KXMTMAi+Kf27L3uKlnTnXttsOg6eJIs6niMCPw7BEnWqysRQyUCJn3EY8au0+VAB
         9Bxa7XUlIldP8sNe6Qh9Xaetai/WXzLRRHhiHBEo9+3CZHeOzUWDgvwvJzpNwK2qIUZJ
         Gsd0kJoeSxn8gQMBmDBDbXup3TK63fLu6LP3eJlO02m8rq9OtzURaP08WELsAYAV8Afb
         sM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=m6XoZYBu5zhYS5FkzvDafnCISCLsuUj82v4c2gFuPm4=;
        fh=NSgzkeHIZ8n5u3UQTELtvs2rL2gofNpFvXaV2CQ81vA=;
        b=Ph4Jp+1Nj6x+g9mzXZ0L5Rtc7sETMPd9z1Jj+C4mlJmeFdZJuwGH7MnGDtxTtGmmxc
         QwB8JmS0baU7TsvbBp/Ql5TXCkZHEwquRkwFHEec3YEl3fLotw6XTTrWWfYE6JCYBMeM
         o30oB8KrjfZbBBun+vUf9k5TK0x+HhoonZIWWv7G5qC8wI28ieBbr7Zf0605PNJ6wxTr
         a2EIxi3B8bdCzs1hsrW/8qOAmhMOhJDki3Myvv23WIHxpuBbBDSKcfpk9CqSYtAG0FAq
         BlXoVx/llACZ77m5Bd2EfYiruJcJ3L7Ux79cbTqSuY+livzt8w3ybozQT0se6fGpfVuq
         mP2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213429; x=1792818229; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m6XoZYBu5zhYS5FkzvDafnCISCLsuUj82v4c2gFuPm4=;
        b=LO3QIBVI/pWu2nANCE2WrSVjgSTcJZ3lDe37rdPBl3jrXqiHElMcym2rLaKPqCb7eN
         wQpiwzhsiw1ghhqhPfw8tiEgIS66QCWS1AiqbsoUUzLqI07c4HfAEfB3tXsla8SfDH+v
         htW1PHIuzPGrkGW67/+xbspcxI3hUw3r9t12RtC6z0umUI3Y4eqKLHf00YLymBwN/b02
         kx/NidVtB56hSgxI6BS3WEwv1oddc+AFDO00kSvdycWd0alOtB57aSQDV2dKn3tdjdkO
         rpXN4XIAJ0wWESTgE9XW14eO+ENxyLhUJ2x5xilRwOGTHh7LR0C6pJmmDv1uPNDyQ8KA
         AtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213429; x=1792818229;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m6XoZYBu5zhYS5FkzvDafnCISCLsuUj82v4c2gFuPm4=;
        b=iZtb/5JBBTOFQKoJ8Rb1fm+exacu7zi5jBdl9qiCHY8dCGNb6Ve/CUNLKusKxC2D7X
         1DKvXw14UUpP2UFRyMwQm7XdZP/Rwzn2qc7tabKfbRMYT6cBdhYsIJ1DrfIGiaeGBUI8
         dlRu9sEX977Wm9FzQNPriVZugow23kPh0nqQgdLpovMY9AEb74Jq6Ok17fH+ZsvS+LLs
         lIn/BPMeLnlTlUift67gbHJT4SDhm8QwaX8tYmfvFivd0ZuZ/Vyhmu36v7Ch6+QUYrdI
         JmErqPOWF0HKVAPrvqUSJIr0U4MJhgl5H64nnVAjcUkHDJ1eVGDN0PlGuaJIbLWCwroF
         dVsw==
X-Gm-Message-State: AFq9FYIRxaZ4o+q35f0AsfD6ufJy/lwcYQLtdfVZ2gV3HsMX89QMM3TD
	g4ot760vUEsD+uvWGXUDONj5RdKjZBOlRb9u5bV0WbP0BJCjuaCXhaVI8NNctd3eqpE1bhtgN2T
	AeOu4IijtHzKwSFQkzX1hYSixzrV5suE=
X-Gm-Gg: AYBFou2D8ZcIwljFdKZ11IlaOKBwbNK6Iu5my1zIpq+1W/b0Z0D+NlXjjU3kua+oqGo
	qj4AhgrbFvDBdNhsTGmJ62FMDllDbJ0YsFaDKNLd6RQ36ThK/9pP6GHpOxOMHcukvT+3Bju+XTT
	5U81z7iuq3ArwzR2HO6UMfzsD6mIAnKkP9Q0ovN+EE34Rj4lyu/V+1+FH2fExh/xIj0Wwq5KkWN
	gQ5N2b7J4D2kAO9tFNl1lTGfX/Yxeir0jZX58MekDquLD+AlqSg8wzeZ5CEPJft6oFhPHH67OsW
	j68I5jbM9udyhqEe9KZvglDrCCdCb9Hc4GYxQKA0QZsIFwdMuxGhg81ezY+m4QgiFA==
X-Received: by 2002:a05:6512:2513:b0:5be:53a4:81ea with SMTP id
 2adb3069b0e04-5be53a48296mr91822e87.25.1792213428919; Fri, 16 Oct 2026
 22:03:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 01:03:47 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 01:03:47 -0400
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <atJz_OR-rIVb-RDW@google.com>
References: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>
 <atJz_OR-rIVb-RDW@google.com>
From: Jame Jao <jaojame6@gmail.com>
Date: Sat, 17 Oct 2026 01:03:47 -0400
X-Gm-Features: AclHuK-pF8BNRZFF_bOPDRq5e9lluuSO415Y8wis45koCdJxcs4_8Bvjc6DXDLA
Message-ID: <CAN52AYs19_b749avEjT-1ZaNZs6qp+3YyTHJgxRiAJTLyhJedg@mail.gmail.com>
Subject: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 14 2026
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000caf554065e0234ac"

--000000000000caf554065e0234ac
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

thanks, the quirk works.  Patch below; it is also attached as
atkbd-tm2426.patch in case anything gets wrapped on the way.

Test setup: Xiaomi Redmi Book Pro 14 2026, board TM2426, BIOS RMAPT4B0P0909
(2026-05-21).  Arch linux-zen 7.2.9 build with this patch on top; the only
other local change in that build is an unrelated platform/x86
suspend/resume patch, input code is otherwise untouched.

With i8042.dumbkbd=1 removed from the kernel command line and the quirk
active:

  uname -r        7.2.9-zen1-1.2-zen

  /proc/bus/input/devices
  N: Name="AT Translated Set 2 keyboard"
  P: Phys=isa0060/serio0/input0
  H: Handlers=sysrq kbd leds event3
  B: EV=120013          (EV_LED is present; dumbkbd used to give EV=100013)

  /sys/class/leds
  input3::capslock  input3::numlock  input3::scrolllock

  writing input3::capslock/brightness 1 then 0 round-trips, and the Caps
  Lock lamp follows the key again.

The built-in keyboard produced 127 key events with 34 distinct key codes
during the test, so it really is usable without the workaround.

Minor observation: the two "Spurious ACK" lines in dmesg come from an old
local userspace helper that pokes /dev/port for the LED; that helper is
redundant now and I am removing it.

From: Eason <jaojame6@gmail.com>
Subject: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book
Pro 14 2026

The built-in keyboard of the Xiaomi Redmi Book Pro 14 2026 (board TM2426)
types in GRUB but stops delivering keystrokes once the kernel has booted.
The same failure mode is already handled for the sibling machines
"Xiaomi Book Pro 14" (TM2424) and "REDMI Book Pro 16 2026" (TM2425) by
skipping ATKBD_CMD_RESET_DIS in atkbd_probe(), which the embedded
controller that emulates the PS/2 keyboard does not survive.

Add the TM2426 DMI entry with the same callback.  Testing without
i8042.dumbkbd=1 on this machine, the built-in keyboard delivers key
events again, and the driver now registers the LED class devices that
dumbkbd used to remove (input3::capslock, input3::numlock,
input3::scrolllock).  Writing input3::capslock/brightness round-trips and
the Caps Lock lamp follows the key again.

Tested-by: Eason <jaojame6@gmail.com>
Signed-off-by: Eason <jaojame6@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1962,6 +1962,14 @@ static const struct dmi_system_id
atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Xiaomi Redmi Book Pro 14 2026 (TM2426) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "REDMI Book Pro 14 2026"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };

-- 
2.51.0

Thanks,
Eason


On Fri, 16 Oct 2026 12:02:21 -0700, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Jame,
>
> On Fri, Oct 16, 2026 at 01:41:19PM -0500, Jame Jao wrote:
> > Hi Dmitry and linux-input,
> >
> > I would like to report a built-in keyboard compatibility issue on the
> > Xiaomi REDMI Book Pro 14 2026 (TM2426).
> >
> > Original failure, observed on Arch Linux 7.2.8-zen1-2-zen:
> > The internal keyboard could not be used after Linux booted; an external
> > USB keyboard was needed. Adding i8042.dumbkbd=1 made it usable.
> >
> > Current verification (2026-10-17):
> > The machine still boots with i8042.dumbkbd=1. The built-in device is
> > "AT Translated Set 2 keyboard", isa0060/serio0/input0, with EV=100013
> > and no EV_LED capability. There is no input Caps Lock LED interface.
> > I understand the missing LED interface is an expected consequence of
> > dumbkbd, rather than a separate LED regression. A local userspace
> > workaround writes SETLEDS through /dev/port; it is not an input driver fix.
> >
> > Hardware:
> >   sys_vendor: XIAOMI
> >   product_name: REDMI Book Pro 14 2026
> >   board_name: TM2426
> >   BIOS: RMAPT4B0P0909, 05/21/2026
> >   EC firmware: 1.9
> >   CPU: Intel Core Ultra 5 338H
> >
> > Current kernel:
> >   Linux 7.2.9-zen1-1.1-zen, x86_64
> >   Arch package linux-zen 7.2.9.zen1-1.1
> >
> > This is a locally built zen kernel with a small bitland-mifs-wmi
> > suspend/resume error-handling change only. No atkbd/i8042 or graphics
> > change was made in that local patch. Kernel taint is 576 (U and W);
> > unsafe xe options and an intel_bios_init warning are also present.
> >
> > The current upstream atkbd.c DMI table, inspected on 2026-10-17, has
> > atkbd_deactivate_fixup entries for Xiaomi Book Pro 14 (TM2424) and
> > REDMI Book Pro 16 2026 (TM2425), but no matching product entry for this
> > 14-inch REDMI model. This suggests the same quirk might be applicable,
> > but that is only a hypothesis: I have NOT tested that change on TM2426.
> >
> > Source inspected:
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/heads/master/drivers/input/keyboard/atkbd.c
> >
> > Limitations:
> > I have not repeated a boot without dumbkbd during this reporting session,
> > and have not reproduced the original failure on current mainline or
> > drm-tip. The original no-workaround failure above is historical; the
> > current device capability and DMI information were checked again today.
> > Please do not treat this as a tested patch or a Tested-by statement.
> >
> > Could you advise whether testing atkbd_deactivate_fixup for this DMI
> > product is the appropriate next step, and what diagnostic data would
> > be useful?
>
> Yes, can you please try adding a quirk similar to TM2425 and let us know
> if this solves the issue for you? Then we can include it in the kernel.
>
> Thanks.
>
> --
> Dmitry

--000000000000caf554065e0234ac
Content-Type: text/plain; charset="US-ASCII"; name="atkbd-tm2426.patch"
Content-Disposition: attachment; filename="atkbd-tm2426.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: ff3dc2967b950b9b_0.1

RnJvbTogRWFzb24gPGphb2phbWU2QGdtYWlsLmNvbT4KU3ViamVjdDogW1BBVENIXSBJbnB1dDog
YXRrYmQgLSBza2lwIGRlYWN0aXZhdGUgZm9yIFhpYW9taSBSZWRtaSBCb29rIFBybyAxNCAyMDI2
CgpUaGUgYnVpbHQtaW4ga2V5Ym9hcmQgb2YgdGhlIFhpYW9taSBSZWRtaSBCb29rIFBybyAxNCAy
MDI2IChib2FyZCBUTTI0MjYpCnR5cGVzIGluIEdSVUIgYnV0IHN0b3BzIGRlbGl2ZXJpbmcga2V5
c3Ryb2tlcyBvbmNlIHRoZSBrZXJuZWwgaGFzIGJvb3RlZC4KVGhlIHNhbWUgZmFpbHVyZSBtb2Rl
IGlzIGFscmVhZHkgaGFuZGxlZCBmb3IgdGhlIHNpYmxpbmcgbWFjaGluZXMKIlhpYW9taSBCb29r
IFBybyAxNCIgKFRNMjQyNCkgYW5kICJSRURNSSBCb29rIFBybyAxNiAyMDI2IiAoVE0yNDI1KSBi
eQpza2lwcGluZyBBVEtCRF9DTURfUkVTRVRfRElTIGluIGF0a2JkX3Byb2JlKCksIHdoaWNoIHRo
ZSBlbWJlZGRlZApjb250cm9sbGVyIHRoYXQgZW11bGF0ZXMgdGhlIFBTLzIga2V5Ym9hcmQgZG9l
cyBub3Qgc3Vydml2ZS4KCkFkZCB0aGUgVE0yNDI2IERNSSBlbnRyeSB3aXRoIHRoZSBzYW1lIGNh
bGxiYWNrLiAgVGVzdGluZyB3aXRob3V0Cmk4MDQyLmR1bWJrYmQ9MSBvbiB0aGlzIG1hY2hpbmUs
IHRoZSBidWlsdC1pbiBrZXlib2FyZCBkZWxpdmVycyBrZXkKZXZlbnRzIGFnYWluLCBhbmQgdGhl
IGRyaXZlciBub3cgcmVnaXN0ZXJzIHRoZSBMRUQgY2xhc3MgZGV2aWNlcyB0aGF0CmR1bWJrYmQg
dXNlZCB0byByZW1vdmUgKGlucHV0Mzo6Y2Fwc2xvY2ssIGlucHV0Mzo6bnVtbG9jaywKaW5wdXQz
OjpzY3JvbGxsb2NrKS4gIFdyaXRpbmcgaW5wdXQzOjpjYXBzbG9jay9icmlnaHRuZXNzIHJvdW5k
LXRyaXBzIGFuZAp0aGUgQ2FwcyBMb2NrIGxhbXAgZm9sbG93cyB0aGUga2V5IGFnYWluLgoKVGVz
dGVkLWJ5OiBFYXNvbiA8amFvamFtZTZAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBFYXNvbiA8
amFvamFtZTZAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYyB8
IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2JkLmMgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJk
L2F0a2JkLmMKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9hdGtiZC5jCisrKyBiL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYwpAQCAtMTk2Miw2ICsxOTYyLDE0IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBhdGtiZF9kbWlfcXVpcmtfdGFibGVbXSBfX2luaXRj
b25zdCA9IHsKIAkJfSwKIAkJLmNhbGxiYWNrID0gYXRrYmRfZGVhY3RpdmF0ZV9maXh1cCwKIAl9
LAorCXsKKwkJLyogWGlhb21pIFJlZG1pIEJvb2sgUHJvIDE0IDIwMjYgKFRNMjQyNikgKi8KKwkJ
Lm1hdGNoZXMgPSB7CisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJYSUFPTUkiKSwKKwkJ
CURNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiUkVETUkgQm9vayBQcm8gMTQgMjAyNiIpLAor
CQl9LAorCQkuY2FsbGJhY2sgPSBhdGtiZF9kZWFjdGl2YXRlX2ZpeHVwLAorCX0sCiAJeyB9CiB9
OwogCi0tIAoyLjUxLjAK
--000000000000caf554065e0234ac--
