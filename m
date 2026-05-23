Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042022D1F44
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538328; cv=pass; b=HYBDTC1CT3WBVnKjGqW5yRyIDCwGtmrHkbvUdxs1MM8m7xERQ+ac/nZXdOLtjjeK7278xxnh2po+vBrlWxRAhP4u3npahXRR1neVpzpuJyA+rf8iKDWCHaEo0XaqQOkCCzX2hLs99+ZwrA7cbLZ5OXxalCT3tvE0qZNkiPsdaNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538328; c=relaxed/simple;
	bh=2VtsKi4WeoXlo/h5B8OP4CG1PkMFpiBngeVHvJw83SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buDBKlHxAZEnRq+IbU0+NXbnDktfKm4kNr7CescN39UnH+TgqegFlQflnPs63pj0bynfhfMSePvSfMXspac5dWhBiZio4Cz0Ceq7Fj+JqSmcQJerbvsD3xqqpv39iDJfGalan+uj/l5/6zivZLfXS3lQ7iQcoukNinW76rcUKt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+ucAJWX; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+ucAJWX"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd8faef2e18so914201066b.3
        for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779538325; cv=none;
        d=google.com; s=arc-20240605;
        b=OZ9qAlR8FfPn7ATWWiYZ+EE6YEhyn8TqG4MqD4ubc5HNSCuM5/UcUY1nURHhYFuZ7h
         vKdp+wH7Re0zffVGN6HSEEgV/AQWZ41FCQLpe98TxzQEXNMQE2mRCpm1Ck8Ie63h5tGW
         gZuPkBHMBPIfg7DolbMWOAkdOrEtouTC/5Zk8sWv0ioI+NwwOf/RUsp2Vprb6Xd8iBmX
         KQ/nBC6lglG8MzuPlbpyFi1/TLr7rVCg7MPRIPo4QB1U31E4A0Vzt/1wMe7rY6ui535U
         yajYfs3VvRXFGOVD2/rXg9RkBNJe5sTv5O7Wl6bdag6BZDlPRckPUOe3iyK+t/k1Q6uK
         gYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZxKLv419Kh3ldC+z3qNJwvfzNG/QDZIqGAP5yoc8fK8=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=SFtyuJYIOvchZ/xXYK5r634il22WjYhNdEf6WRSRfBi9LHErJvWkgSHYqHslnX2u2e
         pYTBr9NJG/1L4r02LYztprxXJOX7x+gQXJhW9UJZ0Q3RjsKRqk5mAhTpBQcke9vKVlkR
         3/yk+yOzOKlRkxtwjcxIZIPWvwTMjWaGbd1fNUfmPAFsEkrwUTX51/5CBYIJNFL7aDVl
         3Ti0qUY1gvpbTqonvA2C5oJZD8N8lMGJcduMVH8C6sz28ZNGhSb3OtABWQyU5/nYPRhI
         zy5SAXOzphlOWV6ZiVsxiCalvwekcqGBwEVUQGMoRZvrUG7ymmq3/feDJ+OAiILLOJXQ
         0Vog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779538325; x=1780143125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxKLv419Kh3ldC+z3qNJwvfzNG/QDZIqGAP5yoc8fK8=;
        b=k+ucAJWXbah4NLPhVX5NBYeaHOqxCF5a1iQu1C7yhxtIQ5Tl16kkqMKHR21ID5qhbY
         l7VstV7iSgmUUuDOaby48JQxl9JUzphuXw0m4U09KbyFDTkYzkhntuda3X7yvmxOK0DK
         eqU4cr9TLI1Igxndv/mTGhES63trxdEXgnrr6TQiAZ1lL+GbFdlybgabrY0Fv7OIbwK9
         hOglh7w09o11P1hugLXl7opYHTWJ0Lkoqe0qHHNZafG/KNvihkoUVwB3qa1Br8G7ZLIn
         QM+SX+nlwYUWQUaPHDXU1JNPdBW85hQnJfm0m7wr/m90qW9hYNhMBRQDlUFCO4fNIw1x
         1mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779538325; x=1780143125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxKLv419Kh3ldC+z3qNJwvfzNG/QDZIqGAP5yoc8fK8=;
        b=lNTxiwMqNATFuJuw0WZmQyoGy4QsHH81Hj9Kebw1aN2qpMP2ENR9C9nQEyKaaySXt9
         sGpLXAwkTWLLN72uqyqM/pBAXfxgWAXy2OO/RAWBDmccQkzjKhxEYbmHIV88fZhEfHlg
         vr77aJZ0mJN6HIalpw1/XikcAAKyYWa+x1QFmjG1QwJRF0smyrb7JAnfKq3k5ClI9qoG
         zPoLV2jLZ5g3ImV//jUkJr0Z2LDVn4nrKuusSA7v357losTp3PQYDuxR9Fjwm3l63XoM
         WCYqN8Osk8CqZsqHQw16WnJmnaV48kjFu7E88+pdm15efXT97jiDc+Og6b//hw077v3E
         Kt1w==
X-Gm-Message-State: AOJu0YwEfP0ZRIWfY6XSR+kL2mqhXV01KYduMgJX3qKG8a85e/cn8qM4
	9bS86PrSDQDFzDPOeVF9FSp6m93F+5ZvSdRBFH6Y1QruT/uGDOJUrtpxkAfIYufz09urzDanDyS
	eK1YxEUVPoD/+8Su/QFXXbae2jaKMbuvfa0XJVd4=
X-Gm-Gg: Acq92OEzEEw5aC9+MTgm8G/hzqrGfSdYcJU74BQK8a3AuQXImfTy+P6/rcH5wEndD2l
	Bnxi8Qa2HsIuhyO1VxfEbYU6HG1uAlI+AMgI4jPyUs4lQdDH8f5ihzt2AlBCT7SK4PNh9SICxaH
	vOyAfWVM/rAn13Y6RGc/Zg50KrPDBieqbD5RvyltVy4Hk4HrnWdhX902kflglMhAaX+AvXje6CY
	EmHRvFCyP1LB3zArcaXH5ZzIGvJj0U+BPmxTwGm+H87HbVHdlsOGJE6JaDVw6nFQNA9zRZqdaET
	UicI4JNypg==
X-Received: by 2002:a17:906:6a0b:b0:bd4:99f5:52f6 with SMTP id
 a640c23a62f3a-bdd264bf66bmr447447766b.34.1779538325204; Sat, 23 May 2026
 05:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523105545.68079-1-technoboy85@gmail.com> <20260523110447.F10D41F000E9@smtp.kernel.org>
In-Reply-To: <20260523110447.F10D41F000E9@smtp.kernel.org>
From: Matteo Croce <technoboy85@gmail.com>
Date: Sat, 23 May 2026 14:11:29 +0200
X-Gm-Features: AVHnY4JU8ub18CMgxZqpIp0auOGoQ3iX31iiMjKkFJEK94iD4Jh5k0bpEIXZY20
Message-ID: <CAFnufp1cM4FXky3xGconcOZpyPueaRQY-VaD9yGMtxP_8ZckAA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno sab 23 mag 2026 alle ore 13:04 <sashiko-bot@kernel.org> ha scritt=
o:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Demoting the `bsize < rsize` warning to debug level masks legacy=
 API misuse and silently drops valid short reports.
> --
>
> commit c89b6cb8fc074729ec292f2ffe95d958722d1447
> Author: Matteo Croce <teknoraver@meta.com>
>
> HID: core: demote warning to debug level
>
> This commit demotes the "Event data for report was too short" message fro=
m
> a warning to a debug log to prevent syslog flooding from devices that
> regularly send short reports.
>
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 41a79e43c82b3..503b9bfa5d379 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2072,8 +2072,8 @@ int hid_report_raw_event(struct hid_device *hid, =
enum hid_report_type type, u8 *
> >               rsize =3D max_buffer_size;
> >
> >       if (bsize < rsize) {
> > -             hid_warn_ratelimited(hid, "Event data for report %d was t=
oo short (%d vs %zu)\n",
> > -                                  report->id, rsize, bsize);
> > +             hid_dbg_ratelimited(hid, "Event data for report %d was to=
o short (%d vs %zu)\n",
> > +                                 report->id, rsize, bsize);
> >               return -EINVAL;
> >       }
>
> [Severity: High]
> Does demoting this warning to debug level mask legacy API misuse and sile=
ntly
> drop valid short reports?
>
> The bsize < rsize check correctly returns -EINVAL to reject events where =
the
> allocated buffer is too small, preventing out-of-bounds memory accesses.
>
> If the UPS device triggers this warning because a core API or legacy driv=
er
> incorrectly uses the old hid_input_report() function, the legacy API
> implicitly sets the allocated buffer size (bsize) equal to the received
> payload size (csize). When the device sends a valid short report
> (csize < rsize), bsize also becomes less than rsize, causing the HID core
> to incorrectly conclude the buffer is too small, drop the report, and pri=
nt
> the warning.
>
> Silencing this warning fails to fix the root cause. The valid short repor=
ts
> are still incorrectly dropped, but now they are dropped silently, potenti=
ally
> leaving the device broken. Furthermore, demoting this warning hides genui=
ne
> buffer under-allocation vulnerabilities in other HID drivers.
>
> Should the caller be updated to use hid_safe_input_report() with the actu=
al
> allocated buffer length, so the short reports can be successfully process=
ed
> via zero-padding instead of returning -EINVAL?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523105545.68=
079-1-technoboy85@gmail.com?part=3D1

Commit 0a3fe972a7cb changed the level from debug to warning.
This is too noisy, I'm just reverting to the original behaviour.

--=20
Matteo Croce

perl -e 'for($t=3D0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
