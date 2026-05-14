Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2193EDE5B
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766520; cv=pass; b=gjYXXrI1TRhbYLN/o6F7j+sBDT6rWphScfWx9Sc3FTOP48BL39woPPYbx+efN61harKUHmYGWxIWm1KXNjm+BIgJwHQH1dw9dQl1yIqq4cdRGlCTHYZvqmXizJkyV/qsECmrViAIMP/ZHyVL6L3J4xU3rNi7QuRqh5fbeFXiPVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766520; c=relaxed/simple;
	bh=aKCJjxQ7V3dO6eK1gNWZ6oqy7EqfvCbd5MBzRRyNsM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGy8wrfu/Bm+h6E09g4MgkQ9iL7eoY+kS48Lyjyri+v3e/kriiEHhpKyWR3wRHsudRxZlPz1sNsTsZG634dK8Qkh4p/rCVov3ILFDe5q8vsfnVBp17ifuZk/vkVJ97/LhIwG+yW5NQFzRjs0BYABA9N/npSaYt7TyM+8tIOA2eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQRapg8d; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQRapg8d"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so62713156d6.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 06:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778766518; cv=none;
        d=google.com; s=arc-20240605;
        b=bQrwHPPoGx/3c7zmW2cBoyizdd+pd42x3wIpf9D+N2m8ZY6i5IELimyN/Pht2TF+Ai
         xPJ/4hj3r3s0Lcg0n57Air5Uwy1flnuAjywiGSEcorcS2aavvJHmkh/re3i97NfkX0Rc
         rqlswyJeo5xBpltbHGnB+Y4PCeHo+BOG2TiRbwLHD9ZPX0wOrjaqf4P2h6e5YHF7b37P
         hvnA8oRkKQCzWETrPkxpNl0E9yX7mqFMurSkjgdVox0NG7zekLwrznwxiI497flwaKce
         5hy2n5+hacNVinlA+16Zvwz1xE3/7p9PGUeHpq9N9PK6BtID+GzTdhbmJEOQjOQH0QpT
         F4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7V+svfvmPORbGEpy9kH2oGvJhOmw0DtV4AhxNSn0F8=;
        fh=uiRmw8I4SjpSNrYYEBRSVViX68IBdo9+8R05LZoDLqg=;
        b=bBws+Vv50bzLztv9bOJojQd9LGhSEGAcxexPdBauBaGDtoDGP3mqDpLopMo6gaRwuV
         zb8fFKR01+124VyIwmsIiBXOSsFpKNRPcXrv6rb+RxTbWsA/50OPXiuRLNnVvaU4TGT/
         iDG6GILh4jNBlavMgoCIHzQ9sYAZ+zvUVi4D76HCzP6UojXZxDW/0EZ4u2bENrvHobWp
         mbuIta2EqR+CBY7SOUblFOfci68REIct57rCXdDKxIHOtLX0ODK24+jCmhyd0E6Y54h+
         u5hGmcQy6aLQ1v+boQmyAEmSyb//E+0bPT+AxGPKwBIOBMbGZpvF5L8cPyGN+EROgNZa
         xdjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778766518; x=1779371318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7V+svfvmPORbGEpy9kH2oGvJhOmw0DtV4AhxNSn0F8=;
        b=lQRapg8ds5I5FK04oVmObBP6O2rfGEqmjiGgZ2S8lRGhBmUBr3ozRINQgMwkaN0dhR
         4n4xk51l0rk/9kgqpkD5sgMfHff+w4IEXyYE//fK5bEMF4igoqdvMs3r4olhGOZtW/Jz
         FjAt2UixoMsdnoU40bzPzlPIm83GY/5I1IWtWnI8IIZHnmhM8zUxBT7WXZzZ1qDrFeYQ
         6lhN/7ZHYPgGH/w2v61pvBPalnY1u3WSsIFgtxi/4XcCurVQJpRl4oRfgnSWJ+l+QHDR
         O2pKotAaSLTq95CgnrBCSHi2WRksTZSs0K78u5hccnmw0j/GVL6AMUSNmJCo5spSaMf1
         NxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766518; x=1779371318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7V+svfvmPORbGEpy9kH2oGvJhOmw0DtV4AhxNSn0F8=;
        b=E7MN7AMjveD24hSpRQMISUXrvTO22gW73OdomYlNNxLIFbSf4fRTqkmLl1MIP6VRMu
         SMcf72qlaViZskbTF64oeGUJZhFPI6ORl2sl+bwajjEM7tKPmULsGuckyejO3VEPdrbs
         YTd39CPfdLHdB35Xt9eSt5yCpwCldS1i8kc/pFmxAbuUO1GsuSuAh3Eq3GHVOr/DwBgn
         wBlIp1VEX+Oe4UkCgje6v2/ovNGFjzf0PnZ9KujB9padtooLtgU4kvRtb+y33ZD335cE
         gnOb5OTcrApSA4EoHdziDh7Pcxgc2WfE37Cu/ieEXjMiW02wwV8ojV6zYGGBQ2QdP67h
         PLZA==
X-Forwarded-Encrypted: i=1; AFNElJ+K/tG6Sef5VWxJsgMt0DY+8Nb8LHgyEbwp4OsERPSw/OaJN+pG/moZEaWg3tkbBk7qQVnCQQcWjj/zOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5E4iSRN3PLkmbV94wlFKu1hEoEc1QICV/d1ADEEWME5UdhCl
	JmQivq+AYyJLmRxbuG+mt+Bd6vG22Q1fhF+6HyJXzDV4IJNRHAWVbDW3aYkL/Q200tlHStnEviG
	hCd4k4BxiLl1s+enOLATK6DEvRnqQPDQC0w==
X-Gm-Gg: Acq92OEBfNe+SMZyv6vPBL9ulNe8WY3eT1XhLAlpFU01B4YnJmZrgsSqLkdhVaDDL3x
	1RVhwwHRkskaGInrs+vFDKbQEKvVxra9LLS2X1Bng3p2zBiziNKt30lEegoIRXXc0LKP8JGotqm
	wZmc9Pr4WXm8rZCcFOdw0rUAOBf9MFxkglLDfobfR1OdtTPg/iEJLly2Y4JogGXxlQr+lLmQhHz
	EeW/j1HIAIQDlHOhXSSA4M85eypPVSl1TEpnDjTzt93R+jgRVRrIm5ZYG66ZKIY/3KMA5R+UwVM
	uRfpY7wI
X-Received: by 2002:a05:6214:4a87:b0:8ca:e16:9654 with SMTP id
 6a1803df08f44-8ca0e169b66mr10237246d6.51.1778766517852; Thu, 14 May 2026
 06:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513231445.3213501-3-derekjohn.clark@gmail.com> <20260514122200.E52C4C2BCB3@smtp.kernel.org>
In-Reply-To: <20260514122200.E52C4C2BCB3@smtp.kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 14 May 2026 06:48:26 -0700
X-Gm-Features: AVHnY4KSZC4VkJHQRXm-_XFmPM9aMSk8J4vuVM8tNCzABESdwXLpTFZ87pMFfAw
Message-ID: <CAFqHKTm0G_HznwTmcOCEumihzXzgSbAj7u8Xm_5GWKUB1g1fKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] HID: hid-msi: Add M-key mapping attributes
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] The `cfg_mutex` guard in `claw_hw_output_report()` is scoped to =
an `if` block, releasing the lock before the critical section executes.
> - [High] Lockless concurrent access to `profile_pending` between process =
and interrupt contexts causes data corruption and sequence mismatches on de=
layed responses.
> - [High] Unsafe assumption of USB transport in `claw_probe()` causes type=
 confusion and invalid pointer dereference for non-USB devices.
> - [High] Returning an error from `claw_profile_event()` for a spurious ev=
ent unconditionally triggers `complete()`, causing premature wakeups of unr=
elated commands.
> - [Medium] The function `claw_buttons_store()` illegally mixes scope-base=
d `guard()` cleanup with `goto`-based error handling.
> --
>
> commit 42be71c046dc9b6b31d28598f5e0bb568d78b7a1
> Author: Derek J. Clark <derekjohn.clark@gmail.com>
>
> HID: hid-msi: Add M-key mapping attributes
>
> Adds attributes that allow for remapping the M-keys with up to 5 values
> when in macro mode.
>
> > diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> > index 8915942af15e6..13ba2747fdb66 100644
> > --- a/drivers/hid/hid-msi.c
> > +++ b/drivers/hid/hid-msi.c
>
> [ ... ]
>
> > @@ -125,6 +294,31 @@ static int claw_gamepad_mode_event(struct claw_drv=
data *drvdata,
> >       return 0;
> >  }
> >
> > +static int claw_profile_event(struct claw_drvdata *drvdata, struct cla=
w_command_report *cmd_rep)
> > +{
> > +     u8 *codes;
> > +     int i;
> > +
> > +     switch (drvdata->profile_pending) {
> > +     case CLAW_M1_PENDING:
> > +     case CLAW_M2_PENDING:
> > +             codes =3D (drvdata->profile_pending =3D=3D CLAW_M1_PENDIN=
G) ?
> > +                     drvdata->m1_codes : drvdata->m2_codes;
> > +             /* Extract key codes; replace disabled (0xff) with 0x00, =
which is (null) in _show */
> > +             for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> > +                     codes[i] =3D (cmd_rep->data[6 + i] !=3D 0xff) ? c=
md_rep->data[6 + i] : 0x00;
> > +             break;
>
> Is it safe to read and modify profile_pending locklessly here in the
> interrupt handler?
>
> Since claw_buttons_show() modifies this state in process context under
> profile_mutex, if a sysfs request times out and a subsequent request star=
ts,
> could the delayed ACK from the first request cause this handler to see th=
e
> new profile_pending state and corrupt the new request's buffer?

The lock covers this case as it is only released after the completion
fires or time out, after this.

> > +     default:
> > +             dev_warn(&drvdata->hdev->dev,
> > +                      "Got profile event without changes pending from =
command: %x\n",
> > +                      cmd_rep->cmd);
> > +             return -EINVAL;
> > +     }
> > +     drvdata->profile_pending =3D CLAW_NO_PENDING;
> > +
> > +     return 0;
> > +}
> > +
> >  static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_rep=
ort *report,
> >                         u8 *data, int size)
> >  {
>
> [ ... ]
>
> > @@ -146,6 +340,9 @@ static int claw_raw_event(struct claw_drvdata *drvd=
ata, struct hid_report *repor
> >       case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
> >               ret =3D claw_gamepad_mode_event(drvdata, cmd_rep);
> >               break;
> > +     case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> > +             ret =3D claw_profile_event(drvdata, cmd_rep);
> > +             break;
> >       case CLAW_COMMAND_TYPE_ACK:
> >               break;
> >       default:
>
> When claw_profile_event() returns -EINVAL for a spurious event,
> claw_raw_event() breaks from the switch and unconditionally calls
> complete(&drvdata->send_cmd_complete).
That case is unlikely as the profile events are serialized by a mutex.
Holding the completion until timeout would only result in delaying
subsequent calls.

> Could this prematurely wake up a thread waiting on a completely different
> command, such as WRITE_PROFILE_DATA?
>
> [ ... ]
>
> > @@ -366,6 +563,161 @@ static ssize_t reset_store(struct device *dev, st=
ruct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_WO(reset);
> >
> > +static int button_mapping_name_to_code(const char *name)
> > +{
>
> [ ... ]
>
> > +static int claw_buttons_store(struct device *dev, const char *buf, u8 =
mkey_idx)
> > +{
> > +     struct hid_device *hdev =3D to_hid_device(dev);
> > +     struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> > +     u8 data[] =3D { 0x01, (drvdata->bmap_addr[mkey_idx] >> 8) & 0xff,
> > +                   drvdata->bmap_addr[mkey_idx] & 0xff, 0x07,
> > +                   0x04, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff };
> > +     size_t len =3D ARRAY_SIZE(data);
> > +     int ret, key_count, i;
> > +     char **raw_keys;
> > +
> > +     raw_keys =3D argv_split(GFP_KERNEL, buf, &key_count);
> > +     if (!raw_keys)
> > +             return -ENOMEM;
> > +
> > +     guard(mutex)(&drvdata->rom_mutex); /* all err_free paths must be =
in scope */
> > +     if (key_count > CLAW_KEYS_MAX) {
> > +             ret =3D -EINVAL;
> > +             goto err_free;
> > +     }
> > +
> > +     if (key_count =3D=3D 0)
> > +             goto set_buttons;
> > +
> > +     for (i =3D 0; i < key_count; i++) {
> > +             ret =3D button_mapping_name_to_code(raw_keys[i]);
> > +             if (ret < 0)
> > +                     goto err_free;
> > +
> > +             data[6 + i] =3D ret;
> > +     }
> > +
> > +set_buttons:
> > +     ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFI=
LE_DATA, data, len, 8);
>
> While reviewing the addition of these sysfs attributes, I noticed a
> pre-existing issue in claw_hw_output_report() that is exacerbated by
> the concurrent sysfs requests added here:
>
> drivers/hid/hid-msi.c:claw_hw_output_report() {
>     ...
>     if (timeout) {
>         guard(mutex)(&drvdata->cfg_mutex);
>         reinit_completion(&drvdata->send_cmd_complete);
>     }
>     ...
> }
>
> Since guard() is scoped to the if block, the mutex is immediately release=
d at
> the closing brace.
>
> Doesn't this mean hid_hw_output_report() and
> wait_for_completion_interruptible_timeout() execute entirely without
> the lock, defeating the intended serialization and allowing concurrent
> requests to race?
>
> > +     if (ret < 0)
> > +             goto err_free;
> > +
> > +     ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM=
, NULL, 0, 8);
> > +
> > +err_free:
> > +     argv_free(raw_keys);
> > +     return ret;
> > +}
>
> Is it safe to mix goto-based error handling with scope-based guard() clea=
nup
> in the same function?

I'll make this a scoped guard over claw_hw_output_report.

> According to the cleanup guidelines, functions should either convert
> entirely to scope-based cleanup, for example by using a DEFINE_FREE
> wrapper for argv_free, or not use guard() at all to avoid confusing
> ownership semantics.
>
> [ ... ]
>
> > @@ -432,8 +796,31 @@ static void cfg_resume_fn(struct work_struct *work=
)
> >               dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode =
settings: %d\n", ret);
> >  }
> >
> > +static void claw_features_supported(struct claw_drvdata *drvdata)
> > +{
>
> [ ... ]
>
> >  static int claw_probe(struct hid_device *hdev, u8 ep)
> >  {
> > +     struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent)=
;
> > +     struct usb_device *udev =3D interface_to_usbdev(intf);
>
> Is it guaranteed that this device is always connected via USB?

This function is only called by msi_probe, which checks for a valid
USB device as a first step.

> If this driver is bound to a device connected over a non-USB transport li=
ke
> I2C, Bluetooth, or UHID, hdev->dev.parent would not be a valid USB
> interface, which could cause an invalid pointer dereference here.
>
> Could this code check hid_is_usb(hdev) first or read the version from
> hdev->version instead?
>
> >       struct claw_drvdata *drvdata;
> >       int ret;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.32=
13501-1-derekjohn.clark@gmail.com?part=3D2
