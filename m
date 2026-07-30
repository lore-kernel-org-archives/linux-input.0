Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6B40244D
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405452; cv=pass; b=tusHOx6uhC2rsPUgxIx9nC1ONvW6V3DYl4Zcr7xxyTrdHrEZha9YuXE7765JQmFpA50dfb0viNwn5Wpzz3ceWwlYAiQwyWwAKLqVvufI+K5/MfQEAFmezKULDM4wrBLojnL2PvC+HMsnBrmpLrrnVjwKRvMx0bLuTT4iUmfiKsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405452; c=relaxed/simple;
	bh=LBXcc5ZNOrfYwXQE5iKn5Chey6yldeb84DsYLyk90DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxhpWjvv9eU+rReUcA8afqNU98NvFLDVUnTbBv1OjkxZdI3StukGxYEZunlcWZKGsqmT/yZlAXrBgCcjQwUZAF53FNX08ZmEGvhFnLsqL/GMk2I9bol91SfmC3sog8dR9BBC0FI2LK2WNWcer6tStp0027CfaCf1ZnEmNAajIQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxqkwXA3; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxqkwXA3"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-977310532a7so411181241.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 02:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785405449; cv=none;
        d=google.com; s=arc-20260327;
        b=cj0Lw95hIZemDXhULg4NbOA/4bXAka94BFqIsnwecpzPUa8uAI0PtvLhESfYXG0MlH
         Rqc4eMWWybsqrlcFzXrGN/wQLpvqgcpeacnmT9dBzhUgiqpU9eu+tmcjMdPv2IKxsade
         W4Hrg1IHhNUfTGUBRXD4+5DrlSggVomZIw+KXgPYmBZePG2mGp8Cn7oKu2b/W9F61jlR
         UriQVBr8qWJbH0oBNsKM9lZFTWaUiM5AMNVxyKbMhm8VZcxrQsfm6gZkelX/IdMhyURN
         lXVq/i96apqN3rmL+6ZF/nRETp60Jrxd4TR1xegSw+1xTR2UVP1FTVmmr5yjcMltqI7L
         719w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5bFJTdkqLSzO7fDbden/wf/7NBWQ+U5kH4/1k85+Bs=;
        fh=BQhjr51uKMQLBZvoGGjX/lZVMPemmy0HowhKlrU5Z+8=;
        b=Jn36A1Qjj4cifiHhPJFt+5mTXEJo1+MgKqUNtAa0QkykwEULAAvJ/k94bXuzhfOmGW
         9tZ9UktUUODgLz374IlPjIPHXzT9D/jBVNk/3HbZ9iZU+lfqRY5ugaVfDIvaij1bZ4Sz
         31ncajrHcY4AQGN9caRsGyPnlogrTf/nW3bD7ddYvRBGNPTUr3OsgEQPDZk1UuW2Am9J
         mcLgaErknH1CatDKhrhMz5ME5BHAoETLjDy3jj9WRIC40T/noMx+Y8u9F/wwyxQyzSLj
         uemx65z8W1gKyiOJ9bl2kg1ge6eE/XcYYcl9LHT/8Q1dmKh8jiUpF6NtzP+A80PbAkgp
         Lrkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405449; x=1786010249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5bFJTdkqLSzO7fDbden/wf/7NBWQ+U5kH4/1k85+Bs=;
        b=YxqkwXA3xL8zm/jVrmsNB4bmX9xhB439hWLpT12xUL+65uXUmlHfJMcJ91v/ND0i9K
         teCqdusHYtmsQfOkhlDkbeoPbLOhh65PyxViFTvf56YDFLOblxGQbnIPKV1qYy6fgOlT
         A0SsEMHghCneYCc44PrwVifO/okbW9IJJ2OewXh+odAee7EAQ9NTlFgPRSkH8HuPJlGw
         VE4asKY5YNv1gulrWfz19R1ht9Etfwi6rHTpqqkAU64CIvve5cuY9GidI1LQEAsi47Cu
         fC4lndt2+im2DV9j0KSWbDlWrQHk4BXqLZ3EWIVcPDXpxZj2uJeykb5fxQhAFOFc10Ma
         4skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405449; x=1786010249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5bFJTdkqLSzO7fDbden/wf/7NBWQ+U5kH4/1k85+Bs=;
        b=cpHU7EpYUHQEo11UCVQ/CiuwI8xUdPteCFEJ7kzFnywgxe1/CqLF1qffgA9DWjk2uZ
         7+etW47tzbC1RpRTRzFTjjOeDv2YzzDuFKfVxsVgm3FZSdMaYnwaStyvtXT5Qxl8iRNQ
         eM+e/1GVsPShL69vy8Q0qWvBlrFeMz8YP2YkviWXyXngXuNKUSVE5wunv4sguvUMb/FU
         VzH+07RMZIvUOMoUSZ2z0useu4oa7vor159NtGcbeQLqDcFQ04cSOTQD4+v+BlI0G20+
         Biw7BZCDOPOj1YO3zb6sZ4eG8v15X4grQUgFR4lRYrPwJvUsftty6I3ztd8ohBoLmgcJ
         o6Rg==
X-Forwarded-Encrypted: i=1; AHgh+RqjX1O7Au7vHp2d0LoC9N//+aPVhhUn+751B6pg3lj6pLJgyRTDl/1hMaLapxNANmciZsbA72SmIkxvLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OneOiTLunGGlCKu10b0Mo7Fr1jXhcz+BCGCqfjgU61nMORux
	EP3f5PNueag0gv1wu5ZIiHg9gUHqJ5PVn471eTndFT8+YIbhMw70PTFRZydls1TbP5hxFf+TY+i
	lfHOxcCLz+DgyioR5sbeOXD/RiteaTI1L5XMG
X-Gm-Gg: AR+sD12FFxwt5mDAvIg31nWe4FqZ2IyHJacqGV31ybRbsw5ERuC7X/wTg/PAR0wenJt
	ox+LsRgWy/UA6IZRcmAXjWlyQrzvOY075P3UOxKqdJtkBvkagd/rTw1Vl7o8lnef3nY0kjWdOpg
	dWpdIZDgyuwNFOc1GCnzSeg+sV9ZhZFpbZFWrcKLMWuubBcT15dfAWw4OJtUiBijfOxFBym+CV6
	YagcIwZ4MXGa9vg4lwPjIBi8+CwKvNXDCvWluUnAlH+0h9TIoyJr11XfTKMxbacPNZf+nBpVtjm
	b0Hnhoo2Gn5Iyzj2vDZ+us49JoE5YOFyhTi+5oidTGVMK2KRP0R0xItiMw52Ao29g2dHMc1jU9D
	G2Gbjqz1z4s37uVbKVqFf3hCovnDIaP2u8/LBDifXh6KS0qpguWok0Yx+ph2eDE8rE8pKgPYYuh
	w+spocMgB4KlTksFI=
X-Received: by 2002:a05:6102:f8a:b0:74d:ceb4:5efd with SMTP id
 ada2fe7eead31-7577214d7d7mr444004137.8.1785405449026; Thu, 30 Jul 2026
 02:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722114845.156183-1-krishgulati7@gmail.com> <amsG5_kTFWequgRP@beelink>
In-Reply-To: <amsG5_kTFWequgRP@beelink>
From: Krish Gulati <krishgulati7@gmail.com>
Date: Thu, 30 Jul 2026 15:27:16 +0530
X-Gm-Features: AUfX_myftKw2nbYy698NpwjEbp7eud0gHYBdKmEdDUEXNPIyqTYPpGBQB5j9kHc
Message-ID: <CAOzTEaUZO36gi+kYk+ms1yortYxBx6VsPhXqw-y4YxDecGGDvw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 RESEND] HID: BPF: add keyboard behavioral anomaly detection
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> These files are part of udev-hid-bpf, not the kernel. They will
> eventually make it to the kernel, but the development happens on
> gitlab.freedesktop.org.
>
> Also, that patch makes changes to
> "src/bpf/testing/0010-Generic__keyboard.bpf.c" which is not known to any
> upstream, so we can't do much.

Thanks for the pointer -- I'll move this over to gitlab.freedesktop.org
and open a merge request against udev-hid-bpf directly.

Regards,
Krish

On Thu, Jul 30, 2026 at 1:42=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> Hi,
>
> On Jul 22 2026, Krish Gulati wrote:
> > This patch implements a HID-BPF struct_ops program that detects automat=
ed
> > HID injection attacks. It does this by measuring post-enumeration delay
> > and tracking inter-keystroke timing using Welford's online variance alg=
orithm.
> > State is stored in a hash map keyed by the HID ID.
> >
> > Detection results are currently surfaced via bpf_printk(). A
> > BPF_MAP_TYPE_RINGBUF interface with configurable userspace daemon
> > is planned; deferred pending validation of detection heuristics.
> >
> > Signal design is grounded in: Neuner et al., "USBlock: Blocking
> > USB-based Keylogger Attacks", DBSec 2018.
> >
> > Link: https://lore.kernel.org/linux-input/adSxXidgeWF0-Ewn@beelink/
> >
> > Signed-off-by: Krish Gulati <krishgulati7@gmail.com>
> > Suggested-by: Sashiko-bot <sashiko-bot@kernel.org>
> > ---
> > Changes since v1:
> > - Added bpf_spin_lock/unlock around the Welford compound update in
> >   kbd_hook() to close a data race on concurrent execution (was
> >   lockless read-modify-write).
> > - Switched dev_details from LRU_HASH to plain HASH so eviction
> >   under map pressure fails the insert instead of silently
> >   displacing an existing tracked device.
> > - Store report_id in dev_info and gate kbd_hook() on it, so
> >   composite devices no longer misattribute other report types'
> >   bytes as keystrokes.
> > - Zero dev_info with __builtin_memset before populating in probe()
> >   to satisfy the verifier's stack-init tracking (was relying on a
> >   partial designated initializer).
> > - Replaced active-byte-count heuristic with bytewise diff/mask
> >   (standard_boot_keypress/nkro_keypress) so consecutive keystrokes
> >   without an intervening empty report are still detected.
> > - Verified bucket-size rounding (8/16/32/64) does not drop events
> >   or read out-of-bounds, tested via hid-replay with synthetic
> >   report sizes (9, 14 bytes, etc.).
> >
> > Known limitations, not addressed in this version:
> > - No cleanup on device disconnect: hid_bpf_ops has no disconnect
> >   hook, so dev_details entries persist until the map fills.
> >   Deferred pending maintainer guidance on the right approach.
> > - find_keyboard_field() returns on the first Keyboard-typed
> >   (GenericDesktop/Keyboard) Application Collection found; a device
> >   with multiple such collections within a single report descriptor
> >   (as opposed to multiple HID interfaces, which are already handled
> >   correctly and verified on real composite hardware) will only have
> >   the first one tracked. Untested; the only hardware available for
> >   testing exhibits the multiple-interface pattern rather than the
> >   single-descriptor multi-collection pattern, so this path has not
> >   been exercised.
> >
> > Resending as a top-level thread (v2 was sent as a reply to v1 on July 9=
).
> > Original thread: https://lore.kernel.org/linux-input/20260709104958.383=
03-1-krishgulati7@gmail.com
> >
> >  src/bpf/testing/0010-Generic__keyboard.bpf.c | 311 +++++++++++++------
> >  src/bpf/testing/meson.build                  |   1 +
>
> These files are part of udev-hid-bpf, not the kernel. They will
> eventually make it to the kernel, but the development happens on
> gitlab.freedesktop.org.
>
> Also, that patch makes changes to
> "src/bpf/testing/0010-Generic__keyboard.bpf.c" which is not known to any
> upstream, so we can't do much.
>
> Cheers,
> Benjamin
>
> >  2 files changed, 217 insertions(+), 95 deletions(-)
> >
> > diff --git a/src/bpf/testing/0010-Generic__keyboard.bpf.c b/src/bpf/tes=
ting/0010-Generic__keyboard.bpf.c
> > index 9114587..c3f2364 100644
> > --- a/src/bpf/testing/0010-Generic__keyboard.bpf.c
> > +++ b/src/bpf/testing/0010-Generic__keyboard.bpf.c
> > @@ -24,11 +24,11 @@
> >  #define HID_GUARD_PED_SUSPICIOUS_THRESH (50 * HID_GUARD_NSEC_PER_MSEC)
> >  #define HID_GUARD_PED_WARNING_THRESH (300 * HID_GUARD_NSEC_PER_MSEC)
> >
> > -/*not derived from real typing data yet*/
> > +/*not derived from real typing raw_buffer yet*/
> >  #define HID_GUARD_MIN_SAMPLES 5
> >
> >  /*
> > - * Variance is "too metronomic
> > + * Variance is "too metronomic"
> >   * to be a human," expressed in ms^2 so we never need sqrt().
> >   */
> >  #define HID_GUARD_VARIANCE_THRESH_MS2 (40ULL * 40ULL)
> > @@ -57,9 +57,17 @@ enum hid_guard_ped_flag {
> >  };
> >
> >  struct dev_info {
> > -     __u64 connection_time;
> > +     struct bpf_spin_lock lock;
> > +     __u8 report_id;
> > +     __u8 field_type;
> > +     __u8 prev_report[64];
> > +     __u16 bits_start;
> > +     __u16 bits_end;
> > +     __u16 usage_id;
> >       __u32 report_size;
> > -     __u64 prev_report[32];
> > +     __u32 keyboard_offset;
> > +     __u64 connection_time;
> > +     __u64 raw_buffer_length;
> >       /*welford's variables*/
> >       __u64 prev_keydown_ts;
> >       __u64 count;
> > @@ -71,22 +79,8 @@ struct dev_info {
> >        */
> >  };
> >
> > -/*
> > - * BPF_MAP_TYPE_LRU_HASH:
> > - * Using an LRU map automatically prevents exhaustion by silently evic=
ting
> > - * the oldest idle devices. It requires no syntax changes to the rest =
of the
> > - * code (lookup/update helpers work identically), but introduces behav=
ioral
> > - * trade-offs:
> > - *
> > - * 1. Eviction wipes Welford variance history. An attacker
> > - *    could theoretically flood the map to flush their device and rese=
t their
> > - *    score.
> > - * 2. PED Blindspot: Eviction deletes the 'connection_time' set during=
 probe().
> > - *    If an evicted device wakes up, it will bypass post-enumeration d=
elay
> > - *    checks.
> > - */
> >  struct {
> > -     __uint(type, BPF_MAP_TYPE_LRU_HASH);
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> >       __type(key, __u32);
> >       __type(value, struct dev_info);
> >       __uint(max_entries, 128);
> > @@ -138,11 +132,29 @@ static __always_inline void welford(struct dev_in=
fo *dev_state,
> >       delta2 =3D x - dev_state->mean;
> >
> >       dev_state->M2 +=3D (__u64)(delta * delta2);
> > +}
> >
> > -     bpf_printk("W[Count:%llu] Int:%llu ms, scaled_x:%lld\n",
> > -                dev_state->count, interval_ms, x);
> > -     bpf_printk("  -> delta1:%lld, mean:%lld\n", delta, dev_state->mea=
n);
> > -     bpf_printk("  -> delta2:%lld, M2:%llu\n", delta2, dev_state->M2);
> > +static __always_inline bool standard_boot_keypress(__u8 *current_repor=
t,
> > +                                                __u8 *prev_report)
> > +{
> > +     for (int i =3D 2; i < 8; i++) {
> > +             if (current_report[i] !=3D prev_report[i])
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static __always_inline bool
> > +nkro_keypress(__u8 *current_report, __u8 *prev_report, __u64 buffer_le=
ngth)
> > +{
> > +     for (int i =3D 0; i < 64; i++) {
> > +             if (i >=3D buffer_length)
> > +                     break;
> > +
> > +             if (current_report[i] & ~prev_report[i])
> > +                     return 1;
> > +     }
> > +     return 0;
> >  }
> >
> >  HID_BPF_CONFIG(HID_DEVICE(BUS_USB, HID_GROUP_ANY, HID_VID_ANY, HID_PID=
_ANY),
> > @@ -150,7 +162,7 @@ HID_BPF_CONFIG(HID_DEVICE(BUS_USB, HID_GROUP_ANY, H=
ID_VID_ANY, HID_PID_ANY),
> >                         HID_PID_ANY));
> >
> >  SEC(HID_BPF_DEVICE_EVENT)
> > -int BPF_PROG(kdb_hook, struct hid_bpf_ctx *hctx)
> > +int BPF_PROG(kbd_hook, struct hid_bpf_ctx *hctx)
> >  {
> >       __u32 hid_id =3D hctx->hid->id;
> >
> > @@ -161,124 +173,233 @@ int BPF_PROG(kdb_hook, struct hid_bpf_ctx *hctx=
)
> >       if (!info)
> >               return 0;
> >
> > -     __u32 size =3D info->report_size;
> > -     __u32 fetch_size;
> > -     __u8 *data;
> > +     __u8 *raw_buffer;
> >
> > -     if (size <=3D 8)
> > -             fetch_size =3D 8;
> > -     else if (size <=3D 16)
> > -             fetch_size =3D 16;
> > -     else
> > -             fetch_size =3D 32;
> > +     __u8 *report_id_data =3D hid_bpf_get_data(hctx, 0, 1);
> >
> > -     data =3D hid_bpf_get_data(hctx, 0, fetch_size);
> > +     if (!report_id_data)
> > +             return 0;
> >
> > -     if (!data)
> > +     if (info->report_id !=3D 0 && report_id_data[0] !=3D info->report=
_id)
> >               return 0;
> > -     int now_active_ks =3D 0, was_active_ks =3D 0;
> > -#pragma unroll
> > -     for (int i =3D 0; i < 32; i++) {
> > -             if (i >=3D fetch_size)
> > -                     break;
> > -             now_active_ks +=3D ((__u8)data[i] + 255) >> 8;
> > -             was_active_ks +=3D ((__u8)info->prev_report[i] + 255) >> =
8;
> >
> > -             info->prev_report[i] =3D data[i];
> > +     __u32 offset =3D info->keyboard_offset + (info->report_id !=3D 0 =
? 1 : 0);
> > +
> > +     __u64 buffer_length =3D info->raw_buffer_length;
> > +
> > +     if (buffer_length <=3D 8)
> > +             raw_buffer =3D hid_bpf_get_data(hctx, offset, 8);
> > +     else if (buffer_length <=3D 16)
> > +             raw_buffer =3D hid_bpf_get_data(hctx, offset, 16);
> > +     else if (buffer_length <=3D 32)
> > +             raw_buffer =3D hid_bpf_get_data(hctx, offset, 32);
> > +     else
> > +             raw_buffer =3D hid_bpf_get_data(hctx, offset, 64);
> > +
> > +     if (!raw_buffer)
> > +             return 0;
> > +
> > +     bool new_key_pressed =3D false;
> > +
> > +     if (info->report_id =3D=3D 0) {
> > +             new_key_pressed =3D
> > +                     standard_boot_keypress(raw_buffer, info->prev_rep=
ort);
> > +     } else {
> > +             new_key_pressed =3D nkro_keypress(raw_buffer, info->prev_=
report,
> > +                                             buffer_length);
> >       }
> >
> > -     __u64 current_ms =3D bpf_ktime_get_ns() / HID_GUARD_NSEC_PER_MSEC=
;
> > +     __u64 now =3D bpf_ktime_get_ns();
> >
> > -     if (now_active_ks > was_active_ks) {
> > +     __u64 interval_ms =3D 0;
> > +     __u64 variance_m2 =3D 0;
> > +     bool is_idle_gap =3D false;
> > +     bool is_suspicious =3D false;
> > +     enum hid_guard_ped_flag ped_flag =3D HID_GUARD_PED_NO_ENTRY;
> > +     bool run_ped =3D false;
> > +
> > +     bpf_spin_lock(&info->lock);
> > +
> > +     if (new_key_pressed) {
> >               if (info->prev_keydown_ts !=3D 0) {
> > -                     __u64 interval_ms =3D current_ms - info->prev_key=
down_ts;
> > +                     interval_ms =3D (now - info->prev_keydown_ts) /
> > +                                   HID_GUARD_NSEC_PER_MSEC;
> >
> > -                     if (interval_ms < HID_GUARD_IDLE_GAP_THRESH_MS) {
> > +                     if (interval_ms < HID_GUARD_IDLE_GAP_THRESH_MS)
> >                               welford(info, interval_ms);
> > -                     } else {
> > -                             bpf_printk(
> > -                                     "hid %d: idle gap %llu ms exclude=
d from sample\n",
> > -                                     hid_id, interval_ms);
> > -                     }
> > +                     else
> > +                             is_idle_gap =3D true;
> >               }
> >
> > +             /*
> > +              * Variance check runs after welford() so the current
> > +              * sample is already folded in before we decide.
> > +              * Guard on MIN_SAMPLES: Welford's unbiased estimator
> > +              * (M2 / (count - 1)) is undefined for count < 2, and
> > +              * unreliable until a few samples have accumulated.
> > +              */
> >               if (info->count >=3D HID_GUARD_MIN_SAMPLES) {
> > -                     __u64 variance_m2 =3D
> > +                     variance_m2 =3D
> >                               info->M2 /
> >                               ((__u64)HID_GUARD_WELFORD_SCALE *
> >                                HID_GUARD_WELFORD_SCALE * (info->count -=
 1));
> > -                     /*
> > -                      * the initial interval x was multiplied by HID_G=
UARD_WELFORD_SCALE, both
> > -                      * delta and delta2 are also scaled by that facto=
r,
> > -                      * thus scale^2 in the denominator
> > -                      */
> > -                     if (variance_m2 < HID_GUARD_VARIANCE_THRESH_MS2) =
{
> > -                             bpf_printk(
> > -                                     "hid %d: Suspeciously regular typ=
ing, variance=3D%llu ms^2\n",
> > -                                     hid_id, variance_m2);
> > -                     }
> > +                     if (variance_m2 < HID_GUARD_VARIANCE_THRESH_MS2)
> > +                             is_suspicious =3D true;
> >               }
> >
> > -             info->prev_keydown_ts =3D current_ms;
> > +             info->prev_keydown_ts =3D now;
> >       }
> >
> > -     if (info->connection_time !=3D 0) {
> > -             enum hid_guard_ped_flag ped_flag =3D
> > -                     post_enumeration_delay(info, bpf_ktime_get_ns());
> > -
> > -             bpf_printk("PED flag for hid %d: %d\n", hid_id, ped_flag)=
;
> > +     for (int i =3D 0; i < 64; i++) {
> > +             if (i >=3D buffer_length)
> > +                     break;
> > +             info->prev_report[i] =3D raw_buffer[i];
> > +     }
> >
> > -             /*
> > -              * Prevent re-evaluation on subsequent packets for this d=
evice
> > -              */
> > +     /*
> > +      * PED: fires exactly once per device lifetime. connection_time
> > +      * is set at probe() time; we clear it here so subsequent events
> > +      * skip this branch entirely.
> > +      */
> > +     if (info->connection_time !=3D 0) {
> > +             ped_flag =3D post_enumeration_delay(info, now);
> >               info->connection_time =3D 0;
> > +             run_ped =3D true;
> >       }
> > +
> > +     bpf_spin_unlock(&info->lock);
> > +
> > +     if (new_key_pressed) {
> > +             if (is_idle_gap)
> > +                     bpf_printk(
> > +                             "hid %d: idle gap %llu ms excluded from s=
ample\n",
> > +                             hid_id, interval_ms);
> > +             if (is_suspicious)
> > +                     bpf_printk(
> > +                             "hid %d: suspiciously regular typing, var=
iance=3D%llu ms^2\n",
> > +                             hid_id, variance_m2);
> > +     }
> > +
> > +     if (run_ped)
> > +             bpf_printk("hid %d: PED flag=3D%d\n", hid_id, ped_flag);
> > +
> >       return 0;
> >  }
> >
> >  HID_BPF_OPS(hook_keyboard) =3D {
> > -     .hid_device_event =3D (void *)kdb_hook,
> > +     .hid_device_event =3D (void *)kbd_hook,
> >  };
> >
> >  struct hid_rdesc_descriptor HID_REPORT_DESCRIPTOR;
> >
> > -SEC("syscall")
> > -int probe(struct hid_bpf_probe_args *ctx)
> > +static __always_inline bool find_keyboard_field(__u16 *bits_start,
> > +                                             __u16 *bits_end,
> > +                                             __u8 *report_id,
> > +                                             __u32 *size_in_bytes)
> >  {
> >       struct hid_rdesc_report *input;
> >       struct hid_rdesc_field *field;
> >       struct hid_rdesc_collection *col;
> >
> >       hid_bpf_for_each_input_report(&HID_REPORT_DESCRIPTOR, input) {
> > -             __u32 size_in_bytes =3D (input->size_in_bits + 7) / 8;
> > -
> > -             bpf_printk("Report size: %d\n", size_in_bytes);
> > -             if (input->report_id !=3D 0)
> > -                     size_in_bytes +=3D 1;
> > -
> > -             bpf_printk("Report size after report_id: %d\n", size_in_b=
ytes);
> > -
> >               hid_bpf_for_each_field(input, field) {
> >                       hid_bpf_for_each_collection(field, col) {
> >                               if (col->usage_page =3D=3D
> >                                           HidUsagePage_GenericDesktop &=
&
> >                                   col->usage_id =3D=3D HidUsage_GD_Keyb=
oard) {
> > -                                     __u32 key =3D ctx->hid;
> > -                                     struct dev_info info =3D {
> > -                                             .connection_time =3D
> > -                                                     bpf_ktime_get_ns(=
),
> > -                                             .count =3D 0,
> > -                                             .report_size =3D size_in_=
bytes
> > -                                     };
> > -                                     bpf_map_update_elem(&dev_details,=
 &key,
> > -                                                         &info, BPF_AN=
Y);
> > -                                     ctx->retval =3D 0;
> > -                                     return 0;
> > +                                     *size_in_bytes =3D
> > +                                             input->size_in_bits / 8;
> > +
> > +                                     if (input->report_id !=3D 0)
> > +                                             *size_in_bytes +=3D 1;
> > +
> > +                                     *bits_start =3D field->bits_start=
;
> > +                                     *bits_end =3D field->bits_end;
> > +                                     *report_id =3D input->report_id;
> > +                                     return true;
> >                               }
> >                       }
> >               }
> >       }
> > -     ctx->retval =3D -EINVAL;
> > +     return false;
> > +}
> > +
> > +SEC("syscall")
> > +int probe(struct hid_bpf_probe_args *ctx)
> > +{
> > +     __u8 report_id;
> > +     __u16 bits_start, bits_end;
> > +     __u32 size_in_bytes;
> > +     __u32 hid_id =3D ctx->hid;
> > +
> > +     struct dev_info *existing_info =3D
> > +             bpf_map_lookup_elem(&dev_details, &hid_id);
> > +
> > +     struct dev_info info;
> > +
> > +     __builtin_memset(&info, 0, sizeof(info));
> > +
> > +     if (!find_keyboard_field(&bits_start, &bits_end, &report_id,
> > +                              &size_in_bytes)) {
> > +             ctx->retval =3D -EINVAL;
> > +             return 0;
> > +     }
> > +
> > +     if (existing_info !=3D NULL) {
> > +             __u64 now =3D bpf_ktime_get_ns();
> > +
> > +             bpf_spin_lock(&existing_info->lock);
> > +
> > +             existing_info->connection_time =3D now;
> > +
> > +             existing_info->bits_start =3D bits_start;
> > +             existing_info->bits_end =3D bits_end;
> > +             existing_info->keyboard_offset =3D bits_start / 8;
> > +             existing_info->report_size =3D size_in_bytes;
> > +
> > +             if (existing_info->keyboard_offset >
> > +                 existing_info->report_size) {
> > +                     bpf_spin_unlock(&existing_info->lock);
> > +                     ctx->retval =3D -EINVAL;
> > +                     return 0;
> > +             }
> > +
> > +             existing_info->report_id =3D report_id;
> > +             existing_info->raw_buffer_length =3D
> > +                     existing_info->report_size -
> > +                     (existing_info->keyboard_offset -
> > +                      (report_id !=3D 0 ? 1 : 0));
> > +
> > +             existing_info->count =3D 0;
> > +             existing_info->mean =3D 0;
> > +             existing_info->M2 =3D 0;
> > +             existing_info->prev_keydown_ts =3D 0;
> > +
> > +             __builtin_memset(existing_info->prev_report, 0,
> > +                              sizeof(existing_info->prev_report));
> > +
> > +             bpf_spin_unlock(&existing_info->lock);
> > +             ctx->retval =3D 0;
> > +             return 0;
> > +     }
> > +
> > +     info.connection_time =3D bpf_ktime_get_ns();
> > +     info.bits_start =3D bits_start;
> > +     info.bits_end =3D bits_end;
> > +     info.keyboard_offset =3D bits_start / 8;
> > +     info.report_size =3D size_in_bytes;
> > +
> > +     if (info.keyboard_offset > info.report_size) {
> > +             ctx->retval =3D -EINVAL;
> > +             return 0;
> > +     }
> > +
> > +     info.report_id =3D report_id;
> > +     info.raw_buffer_length =3D info.report_size - (info.keyboard_offs=
et -
> > +                                                  (report_id !=3D 0 ? =
1 : 0));
> > +
> > +     bpf_map_update_elem(&dev_details, &hid_id, &info, BPF_NOEXIST);
> > +     ctx->retval =3D 0;
> >       return 0;
> >  }
> >
> > diff --git a/src/bpf/testing/meson.build b/src/bpf/testing/meson.build
> > index 9d1b5d3..2586aea 100644
> > --- a/src/bpf/testing/meson.build
> > +++ b/src/bpf/testing/meson.build
> > @@ -11,6 +11,7 @@ tracing_sources =3D [
> >  # 'sources' are BPF programs only compatible with
> >  # struct_ops (kernel v6.11+)
> >  sources =3D [
> > +    '0010-Generic__keyboard.bpf.c',
> >  ]
> >
> >  foreach bpf: tracing_sources
> > --
> > 2.55.0
> >
> >
