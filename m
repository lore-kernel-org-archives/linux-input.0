Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C319375AB5
	for <linux-input@vger.kernel.org>; Fri, 20 Mar 2026 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998995; cv=pass; b=m8r/lyodF6Vp2KQnxBLcrGXtkElQ1wkTUYTEvD/q9V9dxeSjIx2WcH1I01aYXQ3d0QGSZzo8rtsF6CbdjbTNmM1ZE6phesQJCOyjBFAbGXTi8Roax2MDxhpg7GaKNzCTU2hrAvMeqVMj07pUiPvqvFElTc3e0PuZyXhEqZeJkpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998995; c=relaxed/simple;
	bh=XHu8Gli3d1+YiRI/Nl90fgAcMoVGQ+QlR3AKrBYLpvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dImT/HPsgWNOO4dLNBJsNLNpP02JInAAQMrJ54o9sZXWdCLs8jmXNTvrAwKNPfnTycy/5ZOiuDN33dhascMGDnAGfh29igvRpKuq96VfDUx1qxlhr8KYKGU/i05sIAqnC9JPWQJE1VMDKa/tYTFvPOqT8TIPE0NguI1FUm4c5ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPhR4IhX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EejXO1Yx; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPhR4IhX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EejXO1Yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773998992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMwmfckkkZiXaCizavt9UqN5ZSTTd02KJ+dZZmOZMOE=;
	b=RPhR4IhXWXVnscHs6PKtWK/yStA4+v2e2Gzs/uUT62O9EZjpIQZyZaqedJIvgYtnCLHNX5
	+DfkR1YEIxnXjGccwzipp0VSpgreeKt9F58vJV4XEQpREchln832doqSsQw4tqp2W7qzVX
	w7dqZlOHy4DObfUvBeRDzuIrd+sTkvw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-nwHgi2VBMW2OTHIYyN1OJw-1; Fri, 20 Mar 2026 05:29:51 -0400
X-MC-Unique: nwHgi2VBMW2OTHIYyN1OJw-1
X-Mimecast-MFC-AGG-ID: nwHgi2VBMW2OTHIYyN1OJw_1773998990
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b97fd48d0faso137352666b.0
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2026 02:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998989; cv=none;
        d=google.com; s=arc-20240605;
        b=dqEQEriUP7ohrMjW3Z8V47QLMkY/EflnyFil9vM9dYh+ZL2uY1qb02SLzq91Ms0L8u
         4YKAxqgz71vwG1N5QkGpwRHhdqQVz49mx/QicrjrDbd2P/BQm2qHTp37NO34wun3/NYh
         bAQ763N4p+pO0CRR3QL0w6p0DHbJxxqIBoy4sL08yywryveH1mkV8Tu6KWG2MVs6aOKv
         2txxHSj1BQh6ERSRVJ63PciqEqpaA3V1BuAmYm34+VpQTZl3yMr9cTJq+W/F+vAGIMp1
         jTsI911EOknhLSi1dzLsE7YBQDgwoQGC3v8xj2U8Dud7cykuXJ6pDJQT1fuL55RukM5N
         trTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMwmfckkkZiXaCizavt9UqN5ZSTTd02KJ+dZZmOZMOE=;
        fh=BCixdRE3sBEAEggCR6KK7wpyY56ZAq4R14jZIRhjoc4=;
        b=EBpDnqtTdkBDTindi3Let5l+37cWR+8Lbk86nXtxelB1K9+U62IfDKluWcN2Gep0GI
         XTXpPsjE/iGAamtI2hEYjHiVM+IoUtF4Xw+I/8AuEfvIK8w/j8zZ+1UXlZwXbr/Als2e
         Tv1VGytdXZtU/+bdEvHCB1/DUt3DRhlIm4jqNpGuC5YYdO0gNr0g5YbqkrzRZBq/YxjE
         C3j7haBaNIkiPzqFWoIaGCHP8vXF9k/5bPnQpEo6KRXGTrRlq7SbLxE8ozX8kumPKqtu
         quQS2nwc1HZNlkk94+wcr8u0Uadbl/STWEckFfGl1n1Pur79aAdu2W5HysSoWXyFcqLx
         /q6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773998989; x=1774603789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMwmfckkkZiXaCizavt9UqN5ZSTTd02KJ+dZZmOZMOE=;
        b=EejXO1Yx6kn93ndtDBtY3RMN8vPkkWpV82jx2jRue8hIntGcvaeLd3V5zu4HDbsY7l
         aven/hGdLVSC7L2FaujUa9Mjbn7dADN3exyIWaE7tb8K5jwlHbVieVcs6kjnZ7O4iFyV
         KO8mLwNo9cCe7y7SuZhoAffSn1l57V6vzL2oSZB4uADY2wasE3+580pZ5tXe6u+T1jRp
         4Hlwq8lMmrSnkis+tlbtXDkoPxveR/PF0SgO91Fg/n0F25qmNE4TpZXYTOFvpRtkdVMW
         Ax5qhGCeP4fuBf+W7kpHCTm0VsboJzlMiUWf1Mguz0OoiHmJjt3thyLLw2tG/czsamUB
         drRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998989; x=1774603789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMwmfckkkZiXaCizavt9UqN5ZSTTd02KJ+dZZmOZMOE=;
        b=Nl5umTvkPPaM+s9URWFpomWwx3v/N9JWYY/PdJvtfxQsBLrFIV+Zvkfvh8Nz0S3q9P
         iInRme+72bpe9LS3jqkHW2n+rUyx307ILIDWc7hpC1+X9YdZCgr0tlbNqmjyLVh1Zfb+
         ezChASl0hbvIqZ3ouQQuY1zWVII1/W/ViayHFN0IJoT13HpUGt7+806YpjQrR7QmVnRN
         J4Go77dxc4h5PBFv5flJvGqD0Z449Fav6tryywBdrv6/Tde/WBGbwchkShV+83uG/u/H
         Rx78NQbaoTfTrjdv5323Gsfa4NvbmqTqeMY4Q713htlEBHvmyl45P0mZohbIV3rLQbn2
         ua5w==
X-Gm-Message-State: AOJu0Yw5xU+cqiKtgv+HWmjsrvbfrsziwm9rrRaDC58lxB+TdyTJ8FnT
	uqCKYTb/LI+RzZA1TmEJPW+Hxm491kH/1IkJdPP6XY0I3KlooLroagnF57/euw8jqpM4xM5C/0S
	3DAl8sNke1lXF+cRHTMk4zq4oxF/m+cTz10+eNARfSwQ7plg0XgAH47edVeqD8J9H+dcy/PIwuE
	8/XUKcBB68ERxyhjWm3jU7UtFfvnXsfrcpx3CBiPtJLPAZb8Apnw==
X-Gm-Gg: ATEYQzyonkwEi/3Ty30fSETTRjnWUKvJZk9UnIYU4yHAVMW+Je/rvDgKqDgJKCRZ9sP
	mTcf2M9g0dkVLEpfwcBBl6Us0g6t2K0a+A4MNk9SKVOmZNCGWYibpYwnVSITVjy2DJbItvYhy70
	5Hwut91nTYxPj/OYUBTqW9sbxa+QpcjRSAw0G2m/HbXTTniFX5WxFcJ1QOjSfSZ0J+S2BoT205q
	zqbAjjztvFdCnMK
X-Received: by 2002:a17:906:240e:b0:b97:f12a:3f8c with SMTP id a640c23a62f3a-b982f1ffa96mr110600866b.20.1773998989342;
        Fri, 20 Mar 2026 02:29:49 -0700 (PDT)
X-Received: by 2002:a17:906:240e:b0:b97:f12a:3f8c with SMTP id
 a640c23a62f3a-b982f1ffa96mr110599166b.20.1773998988793; Fri, 20 Mar 2026
 02:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWzDrqH8Z5qEjCHOAb5f68DUiTLUTjj-sdav7Y7+1+tFvnc4w@mail.gmail.com>
In-Reply-To: <CABWzDrqH8Z5qEjCHOAb5f68DUiTLUTjj-sdav7Y7+1+tFvnc4w@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 20 Mar 2026 10:29:14 +0100
X-Gm-Features: AaiRm53CQSXjUdJ2vQB2yCME9_2qkdeVzWdQakD7fl6xRiKGlQJOEn_W-QIBJHY
Message-ID: <CAO-hwJLU964rOqfGMHZgg71LmU48Ok_EXNjo2JKaKgCMwGLSGA@mail.gmail.com>
Subject: Re: [BUG] HID: Apple Magic Mouse 2 (BT 0x004C:0x0323) reports wrong
 battery percentage -- hidinput_query_battery_capacity() reads buf[1] (status
 byte) instead of buf[2] (AbsoluteStateOfCharge) ---
To: William MacKinnon <wh6cyy@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi William,

On Fri, Mar 20, 2026 at 12:04=E2=80=AFAM William MacKinnon <wh6cyy@gmail.co=
m> wrote:
>
>  Hi,
>
>  I am reporting a confirmed bug in the HID battery subsystem that causes =
the
>  Apple Magic Mouse 2 to permanently show 4% battery at boot when connecte=
d via
>  Bluetooth.  The root cause has been isolated to a hardcoded byte-index
>  assumption in hidinput_query_battery_capacity() (drivers/hid/hid-input.c=
)
>  that is incompatible with the Magic Mouse 2's multi-field report 0x90 st=
ructure.

Good finding. Indeed, hidinput_query_battery_capacity() makes overly
strong assumptions about the report's content (like why a report of
size 4 only?). :(

Good thing is that I was planning today to write HID battery tests and
then improve that code slightly (I want it to be aware of new HID
usages).

Anyway, I'll work on that over the next days/weeks if I'm not
preempted by something else.

Cheers,
Benjamin

>
>
>  --- System information ---
>
>    Kernel:   6.18.15-400.asahi.fc43.aarch64+16k (Asahi Linux on Apple Sil=
icon)
>    Device:   Apple Magic Mouse 2, "William's Magic Mouse #2"
>    BT MAC:   D0:C0:50:CF:DF:F1
>    HID IDs:  Bus=3D0x0005 (Bluetooth), Vendor=3D0x004C (Apple BT),
>              Product=3D0x0323
>    Driver:   hid-magicmouse (BT path)
>
>
>  --- Observed vs. expected behaviour ---
>
>    /sys/class/power_supply/hid-d0:c0:50:cf:df:f1-battery/capacity
>    reports: 4
>
>    macOS reports 94% for the same mouse simultaneously (confirmed ground =
truth).
>    Occasional spontaneous correct readings (~95%) are observed at boot be=
fore
>    the first sysfs read (see Race Condition section below), confirming th=
e
>    device transmits the correct value.
>
>    UPower sysfs snapshot:
>
>      POWER_SUPPLY_NAME=3Dhid-d0:c0:50:cf:df:f1-battery
>      POWER_SUPPLY_TYPE=3DBattery
>      POWER_SUPPLY_STATUS=3DDischarging
>      POWER_SUPPLY_CAPACITY=3D4
>      POWER_SUPPLY_SCOPE=3DDevice
>      POWER_SUPPLY_MODEL_NAME=3DWilliam's Magic Mouse #2
>
>
>  --- HID Report Descriptor (battery collection) ---
>
>  Full raw descriptor (from hid-recorder):
>    R: 135 05 01 09 02 a1 01 85 12 05 09 19 01 29 02 15 00 25 01 95 02 75 =
01
>    81 02 95 01 75 06 81 03 05 01 09 01 a1 00 16 01 f8 26 ff 07 36 01 fb 4=
6
>    ff 04 65 13 55 0d 09 30 09 31 75 10 95 02 81 06 75 08 95 02 81 01 c0 0=
6
>    02 ff 09 55 85 55 15 00 26 ff 00 75 08 95 40 b1 a2 c0 06 00 ff 09 14 a=
1
>    01 85 90 05 84 75 01 95 03 15 00 25 01 09 61 05 85 09 44 09 46 81 02 9=
5
>    05 81 01 75 08 95 01 15 00 26 ff 00 09 65 81 02 c0
>
>  Battery Application Collection (report 0x90):
>
>    85 90          -- Report ID 0x90
>    05 84          -- Usage Page: Power Device (0x84)
>    75 01 95 03    -- Report Size 1, Count 3
>    15 00 25 01    -- Logical Min 0, Max 1
>    09 61          -- Usage: PresentStatus (0x61)          [bit 0]
>    05 85          -- Usage Page: Battery System (0x85)
>    09 44          -- Usage: Charging (0x44)               [bit 1]
>    09 46          -- Usage: Discharging (0x46)            [bit 2]
>    81 02          -- Input (FIELD 0: 3 x 1-bit status)
>    95 05 81 01    -- 5-bit padding
>    75 08 95 01    -- Report Size 8, Count 1
>    15 00 26 ff 00 -- Logical Min 0, Max 255
>    09 65          -- Usage: AbsoluteStateOfCharge (0x65)
>    81 02          -- Input (FIELD 1: 8-bit charge)
>    c0             -- End Collection
>
>  Raw buffer layout for report 0x90 (as seen by the kernel):
>
>    buf[0] =3D 0x90  -- report ID
>    buf[1] =3D 0x04  -- FIELD 0: status byte (bit2=3DDischarging=3D1, rest=
=3D0)
>    buf[2] =3D 0x5F  -- FIELD 1: AbsoluteStateOfCharge =3D 95 decimal
>
>
>  --- Bluetooth traffic capture (btmon) ---
>
>  The kernel queries:  41 90  (GET_REPORT, INPUT type, report ID 0x90)
>
>  The mouse consistently responds:  a1 90 04 5f
>
>    a1 =3D BT HID DATA INPUT header
>    90 =3D report ID
>    04 =3D status byte =3D 0b00000100 (bit2=3DDischarging)
>    5f =3D AbsoluteStateOfCharge =3D 95 decimal  =E2=86=90 matches macOS 9=
4%
>
>  The value 0x5f=3D95 is stable across every captured report.
>
>
>  --- Root cause ---
>
>  hidinput_query_battery_capacity() in drivers/hid/hid-input.c:
>
>    ret =3D hidinput_scale_battery_capacity(dev, buf[1]);   /* BUG */
>
>  It hardcodes buf[1] as the battery byte.  For reports where the battery
>  field is the first (and only) data field, buf[1] is correct.  For report
>  0x90 on the Magic Mouse 2, buf[1] is the status byte (0x04 =3D 4) and th=
e
>  AbsoluteStateOfCharge is at buf[2] (0x5F =3D 95).
>
>  Arithmetic confirming the bug:
>
>    Observed: buf[1] =3D 0x04 =3D 4 =E2=86=92 scale(4, 0, 100) =3D 4%  =E2=
=9C=93 matches sysfs
>    Correct:  buf[2] =3D 0x5F =3D 95 =E2=86=92 scale(95, 0, 100) =3D 95%  =
=E2=9C=93 matches macOS
>
>  The correct byte offset is deterministic from the descriptor:
>    1 + (field->report_offset / 8) =3D 1 + (8/8) =3D 2  =E2=86=92  buf[2]
>
>  The leading 1 accounts for the report-ID byte prepended by hid_hw_raw_re=
quest().
>
>
>  --- Race condition / intermittent correct readings ---
>
>  hidinput_get_battery_property() has two paths:
>
>    A. Query path (buggy): when battery_status !=3D HID_BATTERY_REPORTED, =
calls
>       hidinput_query_battery_capacity() =E2=86=92 reads buf[1] =3D 4 =E2=
=86=92 returns 4%.
>
>    B. Event-driven path (correct): after the first spontaneous HID INPUT
>       event for report 0x90 processes the AbsoluteStateOfCharge usage via
>       hid_input_var_field() (which correctly bit-extracts each usage's va=
lue
>       per the descriptor), hidinput_update_battery() caches 95 in
>       dev->battery_capacity and sets battery_status =3D HID_BATTERY_REPOR=
TED.
>       Subsequent sysfs reads return 95%.
>
>  The race: if UPower reads sysfs before the first mouse input event (whic=
h is
>  typical at boot), path A fires =E2=86=92 4%.  If the user moves the mous=
e before
>  UPower reads =E2=86=92 path B fires first =E2=86=92 95%.
>
>  This explains the "sometimes correct at boot" behaviour: it is a genuine
>  race between UPower's enumeration and the first spontaneous HID report.
>
>
>  --- Why magicmouse_fetch_battery() does not apply ---
>
>  magicmouse_fetch_battery() checks is_usb_magicmouse2() which tests:
>    vendor =3D=3D USB_VENDOR_ID_APPLE  /* 0x05AC */
>
>  A BT-connected Magic Mouse 2 presents vendor=3D0x004C (Apple BT vendor I=
D),
>  not 0x05AC.  is_usb_magicmouse2() returns false; the battery timer is ne=
ver
>  armed; all battery handling falls through to hid-input.c where the bug l=
ives.
>
>
>  --- Proposed fix direction ---
>
>  Option A (general fix): Store the AbsoluteStateOfCharge field's byte off=
set
>  at hidinput_configure_usage() time (e.g., in a new hdev->battery_field_o=
ffset
>  member) and use it in hidinput_query_battery_capacity() instead of the
>  hardcoded 1.
>
>  Option B (device-specific): Extend is_usb_magicmouse2() to also accept
>  BT_VENDOR_ID_APPLE (0x004C), arming the existing battery timer for BT-pa=
th
>  devices so magicmouse_fetch_battery() runs and primes battery_status bef=
ore
>  the first sysfs read, bypassing the hid-input.c query path entirely.
>
>  I do not have a tested patch yet.  I am happy to test patches.
>
>  Regards,
>  Will
>
>  --
>  Kernel: 6.18.15-400.asahi.fc43.aarch64+16k
>  Platform: Apple Silicon (Asahi Linux / Fedora 43)
>
>

