Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF64483A5
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113889; cv=pass; b=rSM060gB4tO0mCyh1ZZ0AcvB4I5BsVln3MAhTi8dYdwrGvj/omc5G4s4dxpOanvNqaXSOLO3TWRyljRGIEYR2CYPl/lBsIcxkPIWdpYhxhrTUCp7fQg9Dov0gfU1ONzK3qBY4J5eONzZ84jgPtlZRCWFycOtNf2iYLWE15CsfxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113889; c=relaxed/simple;
	bh=pw0VlWhAo+fb4k7qpjT4ZOrIw0oytN8I6SWR8Kn8BVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjGbabnTF/P1dQXq6oO0ehLLRDWqeNEgkkyRtZwHoKMnFBM3A656XK7ty9VVgKuP8EfZNUWEgcNH9dyQ7kroHUyM3eqnto2iIjoTZVa4q/TMF63SgjkvUPbyO6+ikUr53NUKyI7GUeEJHr63WOAzhCwHWxkAU+lncMdj9iQfrNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVDjbN6q; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVDjbN6q"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9063b380982so28326636d6.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 04:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784113887; cv=none;
        d=google.com; s=arc-20260327;
        b=J4htMsknoc/CtFr9HaycolyUZUIS9up7gY18QF4G9NRCAK9kTd9mvJNrX8Zx15RP8+
         njNSUBsPgkxQoyn1ROFC5enlh4gQLnbeIaiHy/xa0LqW2vaUmegVayyfOog72O8qVkFs
         SYf5yAkrl92ak8heglcPqsSN/j2sD4uAbZdiQn7YBeOfx7lCznXJf/INy2HKcQrSKP8A
         /ShI95XPcM3TBENaku36iW/yIBU9kXdPw2zsea6Q0/nMSu8j65vbkYduWtGmVUtUiJVY
         u15hiEyw0CqBNc23bnJrOgcfwv5w0XTqyVCJEEi+IMrMu61xcRjustM1uO3Y9DNLIzVB
         4Mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szTnsO4LxhNwbRzQB5bKuJP2l0ME8GfVemJxWYZ+tbI=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=mv1MsJs5X3ips2bvxhrCB1b5P6UOF33QI8kJoeKw0eefDZD/VHaOmo0tWePCn8hgeV
         e/8mW4Dd+vJQmlcBugrNpecFAIjzdhC2UbhyU57ChI19X8J4r+S8Ea8Z5Q49MIok0uyb
         cdM5jE4R5O7Z0k4CkEqLwu+nqLSX1FX0wRfpgpxnuBztkOsE64pV/Q4VYVCrzR+aS9IB
         BeaPuRQIaXD32/lzM1LTfu6QAIbiM0CPdyp87fq0Vd+hHwRndnBGi5pTnEojcmYfWBQD
         ZPD2/Y5nzHTl6BpG5bXlTkplbq5QAICrQK1WUJs9jH+xq55+Z0TYcqcl2ENIW+4HKzpX
         /zsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784113887; x=1784718687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=szTnsO4LxhNwbRzQB5bKuJP2l0ME8GfVemJxWYZ+tbI=;
        b=SVDjbN6qNp5aY1e5i67femBCL33Fv+UE5Ep17uOOOwhPJ26s7B84mt3IMlJ9p6xhdk
         QfrN/Nx0CLXjV+KApaHe1f/JqRRqQqF+qI/0nUrv40UXVLSY5bbfTxu68LDJiKKwCjIR
         nb5m75K33d4GjrqiujottyipD4whpOuoSnPWF7LatEOp0LA1uCChByKXIXhNFAAl6eXi
         plDhehVH7sMPG1TumhKRbYumXlVDThMVnzqYL16zE5XtY9kkdtiR1PtTGxzYsDPpoLUB
         3vT4Yj1LLhHEG9clOryWumjL/AaVFEmwLh6IGcJ+STQOWEsLVz6emfnI20RV2qiFrKlT
         dMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113887; x=1784718687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szTnsO4LxhNwbRzQB5bKuJP2l0ME8GfVemJxWYZ+tbI=;
        b=PuOnVFu9vg+hy+tx00rwSsHSWejeOj9v+4gGB+Wm+Rp5ACw+zNcq7s570BrTwzEjCZ
         JqKzOQPNxdTZbrufr2FLxfrKQ8hgHS2sBF7YL6XTlAn1wDSqCunF41axGuW0HMXQDnAq
         Z9fX2ooxFlnbgbLWtZg/d/UyXUijqSJHyjyndvm/eU/SxKuST14dDxVnoMLsVD+dFO7N
         W5UoHiBZ7vjgo0IalGFmAMjZSLm8gvvXRM/c+vVinPZwKbJgMcSte5vXNsWfhcc/HpK+
         H5aD6Vifhf0vIsT88Dhe82L0juwHmLAspKSVvc7X3AdMb8+R/AyB74jmwXbIpMvqJ9RW
         WLuA==
X-Gm-Message-State: AOJu0YzrOHGFJ1pLC053i5DaKX2hrjb8ia/2fbHkEUmg9aDL7Wm1PXoU
	UXlUHekvSemQTY9R2BcR5yuU9OeA7zYZC7tDnQk9FFRRKTmsA77YY5SwG6ztPdc+hTFfWJwi5uc
	BSovYyzWuevmQNr31g37/XBpCPiqwde8=
X-Gm-Gg: AfdE7cnNayDuUQma6HiAGj2cq6pczFbd83Xmo9wmdKjTWmG4k/HFrmPR4E0pMfdHcGW
	gK3oKBQmDnrEpDNakJ+GUPR1qyDQWYUU9hGuY9S6yWjLYHa/pSkLi7Gkq+l7X+KKofz/U0B4B9a
	fUbzmhFKyq08e4TIQnjrcfHk7Wm5GJx2HFCexAGHP8u8p+HL43IOMJpGIUdAGRdlEuGek9DKM2y
	YCrm/iWcnQKiJ6b9f3b7hPmig9eEOEogR4PTtteGThGl+evQUGlGfy5hyUNaMMPp12/nW6ltGQ=
X-Received: by 2002:ad4:4eee:0:b0:8f0:9d9c:52c1 with SMTP id
 6a1803df08f44-90758df4b08mr23233976d6.38.1784113886944; Wed, 15 Jul 2026
 04:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714102640.18075-1-derekjohn.clark@gmail.com>
 <20260714102640.18075-3-derekjohn.clark@gmail.com> <20260714104459.05A741F000E9@smtp.kernel.org>
In-Reply-To: <20260714104459.05A741F000E9@smtp.kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Wed, 15 Jul 2026 04:11:14 -0700
X-Gm-Features: AUfX_mzVZzGf1HSP1Fc-2S8G-lc1uXLUT8nmPZJ-nOhashmkn5Ec1aJOhrhjKEo
Message-ID: <CAFqHKTnhVr=FHvUAPxrgCTT8eWnn1nV9pKZoRkVbtvA4CcMDeA@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] HID: hid-msi: Add M-key mapping attributes
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 3:44=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Non-atomic update of drvdata->profile_pending can overwrite conc=
urrent state changes, leading to sysfs read failures.
> - [High] Orphan ACKs from SYNC_TO_ROM commands are ignored and leave the =
`orphan_ack_pending` flag set if they arrive while waiting for a READ comma=
nd, causing the next WRITE command to time out.
> --
>
> --- Patch [2]: [PATCH v12 2/4] HID: hid-msi: Add M-key mapping attributes=
 ---
> commit 21a823af0d7845d277f06cccaf5818c1b1be1ce7
> Author: Derek J. Clark <derekjohn.clark@gmail.com>
>
> HID: hid-msi: Add M-key mapping attributes
>
> Adds attributes that allow for remapping the M-keys with up to 5 values
> when in macro mode.
>
> Link: https://patch.msgid.link/20260529072111.7565-3-derekjohn.clark@gmai=
l.com
>
> > diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> > index 8a48ce099c1ca..9d3249fa50291 100644
> > --- a/drivers/hid/hid-msi.c
> > +++ b/drivers/hid/hid-msi.c
>
> [ ... ]
>
> > @@ -143,6 +327,39 @@ static int claw_gamepad_mode_event(struct claw_drv=
data *drvdata,
> >       return 0;
> >  }
> >
> > +static int claw_profile_event(struct claw_drvdata *drvdata, struct cla=
w_command_report *cmd_rep)
> > +{
> > +     enum claw_profile_ack_pending profile;
> > +     struct claw_mkey_report *mkeys;
> > +     u8 *codes, key;
> > +     int i;
> > +
> > +     scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> > +             profile =3D drvdata->profile_pending;
> > +
> > +     switch (profile) {
> > +     case CLAW_M1_PENDING:
> > +     case CLAW_M2_PENDING:
> > +             key =3D (profile =3D=3D CLAW_M1_PENDING) ? CLAW_KEY_M1 : =
CLAW_KEY_M2;
> > +             mkeys =3D (struct claw_mkey_report *)cmd_rep->data;
> > +             if (be16_to_cpu(mkeys->read_addr) !=3D drvdata->bmap_addr=
[key])
> > +                     return -EAGAIN;
> > +             codes =3D (profile =3D=3D CLAW_M1_PENDING) ? drvdata->m1_=
codes : drvdata->m2_codes;
> > +             for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> > +                     codes[i] =3D (mkeys->codes[i]);
> > +             break;
> > +     default:
> > +             dev_dbg(&drvdata->hdev->dev,
> > +                     "Got profile event without changes pending from c=
ommand: %x\n",
> > +                     cmd_rep->cmd);
> > +             return -EINVAL;
> > +     }
> > +     scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> > +             drvdata->profile_pending =3D CLAW_NO_PENDING;
>
> [Severity: High]
> Can this unconditionally clearing profile_pending overwrite concurrent
> state changes?
>
> If Thread A times out waiting for M1, and Thread B starts waiting for M2
> by setting profile_pending =3D CLAW_M2_PENDING. If the delayed USB ACK
> for M1 then arrives, claw_profile_event processes it and executes:
>
>     scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
>         drvdata->profile_pending =3D CLAW_NO_PENDING;
>
> Doesn't this clobber Thread B's pending M2 state, causing the M2 ACK to
> be rejected and Thread B to permanently time out?
>

This is not a possible scenario in v12. If M1 ACK is received after
profile_pending is set to CLAW_M2_PENDING it will first be checked
against the bmap_addr for the M2 button. When this check fails it will
return -EAGAIN which will soft break from the event, keeping the M2
ACK primed. If M1 was requested twice and the first times out then
this scenario could happen ass the address would match, but in that
case we're already reporting an error to dmesg and the device is
behaving out of specification.

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
> > @@ -171,9 +388,23 @@ static int claw_raw_event(struct claw_drvdata *drv=
data, struct hid_report *repor
> >                       complete(&drvdata->send_cmd_complete);
> >               }
> >
> > +             break;
> > +     case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> > +             ret =3D claw_profile_event(drvdata, cmd_rep);
> > +             /* Stale address received, ignore and keep waiting */
> > +             if (ret =3D=3D -EAGAIN)
> > +                     return 0;
> > +             if (drvdata->waiting_for_ack &&
> > +                 drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PR=
OFILE) {
> > +                     drvdata->cmd_status =3D ret;
> > +                     drvdata->waiting_for_ack =3D false;
> > +                     complete(&drvdata->send_cmd_complete);
> > +             }
> > +
> >               break;
> >       case CLAW_COMMAND_TYPE_ACK:
> > -             if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_GA=
MEPAD_MODE)
> > +             if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PR=
OFILE ||
> > +                 drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_GA=
MEPAD_MODE)
> >                       break;
> >
> >               if (drvdata->orphan_ack_pending) {
>
> [Severity: High]
> Does this early break for READ commands permanently skip processing
> the orphan ACK?
>
> If a WRITE_PROFILE_DATA command is sent followed by a SYNC_TO_ROM
> command, orphan_ack_pending is set to true. If userspace then
> immediately issues a sysfs read, setting waiting_cmd to
> CLAW_COMMAND_TYPE_READ_PROFILE, and the generic orphan ACK arrives:
>
> claw_raw_event() will evaluate the condition above, execute the early
> break, and bypass clearing orphan_ack_pending.
>
> Later, when another write is issued, won't its real generic ACK be
> incorrectly consumed as the leftover orphan ACK, causing the new write
> to time out since its completion is never signaled?

This finding is valid. I'll refactor how this is handled to simplify
it and add an 8 or 25ms fsleep to __claw_hw_output_report() if an
orphan ACK is pending, which should provide time for the ACK to
arrive.

- Derek

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714102640.18=
075-1-derekjohn.clark@gmail.com?part=3D2
