Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED235674C
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132536; cv=pass; b=RnTkMt4i4p50l5QsB6ZiikKkq+7xW3cknSlOLG/kUqGN3tepLyLYkVzdBQK7GgVHnVcB6O3MLauPmJ/5CRkzq9Xg22JCRKHRfOSaCU3PPwYcpP+r1Yka8IGBNnkZWbtZaQb2MnCozAEZV8DdYWBxp0vx4/5V9FtFkMgHxcvTicg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132536; c=relaxed/simple;
	bh=I8nZMzbkZAznY6mHohPSZv/fO0E0qqzemqUWFmAp4NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0o4jn6z/5X9qF+iDEOi1XMhlJIPy9c7s3PipNO5Fv920xcIDRPgXOUf7fr2io8/ICh42cI/VGZj4MNGb+1j6O29aPR9NdCSczUABjlXyuL0UQoKEjWGEDLoBtFBtA+h8YwntoK+751ZXWuzpZ7Eb8fhkD33aVxerLUkA1rabMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPPtz8GV; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPPtz8GV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51ca5143268so3258791cf.0
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 23:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785132533; cv=none;
        d=google.com; s=arc-20260327;
        b=lUZaG91hc5ST1kTh0Zfb2/k9T/dOUC+oo6mSn8U8Ac3FCTL59Y33iGBSlANDZNdm6I
         eiVU4O9Nstvft+1e9jYMTsyl+toUksLo8l8Y+47tD2gTK9yDaqLPasjngct576Jpid6V
         d7+6lEfomvusgTMGdCD9XzPL8UVcUnYfdGRKUNtdZ3q4Q5U5QDWvjRP+rqRmDZG3+ZMU
         9g6iZz920k22ZFfGje/Gt3dvHjCQrYMXyRiPelH+Eiy8kGBcm9uTC33r+UfVorlWSwbq
         OH5vu31Z0M+fKN35PmE6Q5lB/7flmeD/S1HLpfBHZQ1f3ayJaaBN4nbLjgAZuOB4VzaA
         Tryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mO2yEgmy0uLYubiS6bMWaivQtv2wiYD2udY7mlP9ld4=;
        fh=H/kt7JzISQjFJ9+x3QX2hixi6Xcmk5v+IpWdfv1x20Q=;
        b=iP+z3wfHXuKkXigyyMG1mUME9C4QAtMI506hYCB+BfQKSwpwHfjPSaw5Jg+z9I9aw3
         d+Y9tktkjLvnW6zBrFuW47dqcWGV4Qr/5W+j6S0q904MF6U3hWKu7nhXAGi+OR8n+NN6
         6SQI4g/RsRI+uyHmzo4BfI9Lb77/xViW2hkQKjxOh+hmiSofoW2zURP+CA/fM2iDy0hw
         jKG4K0ElSPbUu62jhz7kG1HcS5IuI+EQb0Baw5EYOUKktAQowOLqfSnFt1z3FLm1JGy4
         65h2mMjITUntAxJ8YLpucBljJ1DjgevDhqgOHErqlxu52Fr7paePZyg/y1E5GodtsaBq
         PZ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785132533; x=1785737333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mO2yEgmy0uLYubiS6bMWaivQtv2wiYD2udY7mlP9ld4=;
        b=XPPtz8GVMTUoJtG0P9qRCYouSRyoYEHz/R3H8tCVx2ZRgPJi7dlxHKVTBNWau8emjy
         WSixw6yy14oytS+bXZbZUnQsCoVGMB85mLtmHiJ0awrTyfbkm0uyzv7RpeYqVHvPpwEc
         uB9IXZAYN2l571ZrX24sOt6hn1z/EcxaNXjo2F29ndHitLqJ2tMXWQz5KNrWXHIiu6/K
         zUv0kpdU2AuzkpUj/xk9lwDXicRArZgw+J74UCrIQG4bYTd8Uex5eIVPh4fpn3XYhVo7
         dChlW0dJCM6+8z8ZMuM0HFTHIu43yNEo69XHpRbVUDaFLdrpvqSHsDfpUIJkwFqRIeB0
         iRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785132533; x=1785737333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mO2yEgmy0uLYubiS6bMWaivQtv2wiYD2udY7mlP9ld4=;
        b=qTYu34l7gEoF4UzLnSom6zgQYOgCO2rDiBK7Kqzhg5DyYPVXWBAuPbMv6C7fPEhlpo
         iT9fJaIxeXZxYe2O7y4lkxkzUSyVFR4SBw6iUskiHSzRSMu3DT9emNExW82HUVXJ3mwI
         g8Dx2ppxtXjjFpy3i946oUV+ocsjeWswp54EH8QtlJwHNTMLl0jq1L3uQSh0QVoNA8+w
         tIFgAvlJLJ6ALi3aWi5zhwDIun0XAFiBXr8Ut+YH7U31PkF2eRXIedZWLPv5O8U/u7IK
         k8FcIpYaFfpIP2LML2a+yTOhDnSNBBch4BmGzpP2OkcmkU44B+rGyiZi9UV2X10Ay4bf
         N7kA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5QhMH+jhv4CVG/lDu2UwRb52V/4xQCbz6+BC0zOs3XaUZIjRi8jn1pqxAFLGifjkD8axplvT//xygxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TwGdzMFPqI3Kz2AKt8FF2WBvUDTDphk4tpe1aHS6TUrsyhcl
	AD3XOiPTTyvWAAZ20ZnjYht18EzIjBBvquRqwvnON/gzdQT+SDNxFFIoBO6kH/ATrmdy9XZllPH
	0fARrlz2OD7vsFrW1YF8M4aarRMv4vww=
X-Gm-Gg: AR+sD11+N8MIYC4Yb++Y2KBLAUBOO6MeaZifgyGE3l3NHD9MVkPkVHeUSy49/g8JDPu
	2QMZ+9Djc9BTquDdYJe2rCD6fqpHglE1Q6YXMftY8ad7fPVwIE6OitMXTcpE05gGCPRMigU24qe
	cxVTza2EzMrIWQMaDv+VFFDez2+CPN5O8poMrzYaVqpHXmJ9cPTTsBkpYkThl5JICiw5s5dOwAb
	qsr0p3dUvHpxRfONSlweQZlccN265VRj3PnSROdEf61i3PabEkWRSZnSSFUDosvbOsepujXFLaw
	rBlXGH0Zuj+dNsp9sCF4yobYBk0yS/rlCTbBQN/9vCyQ+mFQ3fBgTXg5MvgWD33EgLQJ0HJdCD6
	OBcn/
X-Received: by 2002:a05:622a:aa4d:10b0:528:3722:a372 with SMTP id
 d75a77b69052e-529a84dec8dmr48090321cf.4.1785132533145; Sun, 26 Jul 2026
 23:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+8Hp=M3ynUHzcDshLup5G+HDs0XoWkav0R5k-00m+O7LbOv1w@mail.gmail.com>
 <7df349cbcccc8004d9aef37f95be5c8e0e51f713.camel@linux.intel.com>
In-Reply-To: <7df349cbcccc8004d9aef37f95be5c8e0e51f713.camel@linux.intel.com>
From: Daniel Paul Perinchery <danielpaulperinchery07012005@gmail.com>
Date: Mon, 27 Jul 2026 11:38:42 +0530
X-Gm-Features: AUfX_mwVuK7N8Tdvd-3xis3OaVDKSpEC98dcBi8NzfS7udTnPE0Kw7MI8pFRQlQ
Message-ID: <CA+8Hp=Pv_zsYiPOhxTQ4NtQ-rMSyPKbWrGyU0d+d--BHpT87YQ@mail.gmail.com>
Subject: Re: hid-sensor-custom: async notification for input-report sysfs
 attributes? (human presence / attention sensors)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies =E2=80=94 my last message went to Srinivas directly instead of th=
e
whole thread. Reposting here so it's visible to everyone and gets
archived properly:

Hi,

Thanks, this does help. I got it running and poll()/read() on
/dev/HID-SENSOR-2000e1.3.auto does work. Two things I wasn't
expecting, and wanted to check with you before going further:

1. The reports arrive continuously, roughly every 100ms, whether or
not anything actually changed (matches property-report-interval on
this device, which reads 100). property-reporting-state reads 2
("Threshold Events" per the HID sensor usage table), which I'd assumed
meant the async path would only push on a real threshold crossing --
but empirically it's a steady ~10Hz stream throughout, including long
stretches where the sensor value isn't changing. Is that expected for
this reporting-state value on the async report path specifically, or
is there a separate control I'm missing to actually get
sparse/event-only pushes out of the misc device (vs. it just always
streaming at the configured report interval regardless of
reporting-state)?

2. Every sample's usage_id field comes back as 0x002000e1, i.e. the
collection's own usage (hsdev->usage), not the usage of whichever
individual input field the report is carrying. This instance
(2000e1.3.auto) has five input fields under it in sysfs
(input-0-200201 through input-4-2004b1), so I think each 11-byte
payload is a packed report containing some/all of those fields
together, keyed by byte offset rather than by usage_id per sample. Is
there a way to get the per-field usage or offset table from userspace
(something under sysfs or a report-descriptor dump via hidraw) so I
don't have to reverse-engineer the byte layout empirically by
correlating against the -value sysfs files field by field?

My use case is specifically the human-presence input (2004b1) for a
walk-away lock/dim daemon, so what I actually want is: wake up only
when *that* field changes, ideally without also waking up for the
other four fields' updates every 100ms if they're unrelated to
presence. Let me know if that's realistically achievable with this
interface as-is, or if it'd need something added on the kernel side
after all (which circles back to my original question -- happy to go
either direction depending on what you'd recommend).

Thanks again for the pointer, this is a big step forward from polling sysfs=
.

Daniel Paul

On Fri, Jul 24, 2026 at 9:00=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, 2026-07-24 at 12:42 +0530, Daniel Paul Perinchery wrote:
> > Hi,
> >
> > I've been investigating why userspace can't efficiently watch a
> > hid-sensor-custom input-report value (specifically a human-presence
> > sensor, HID usage 2000e1, on an AMD Sensor Fusion Hub / amd_sfh
> > platform) for changes without polling, and wanted to check whether
> > there's interest in closing this gap before I try to write anything.
> >
> > Setup: Lenovo IdeaPad Pro 5 14AKP10, AMD Ryzen AI 7 350, kernel
> > 7.0.13
> > (Debian/Parrot, but this is stock hid-sensor-custom.c). Presence and
> > gaze/attention are exposed as separate logical sensors under the same
> > physical hub (HID-SENSOR-2000e1.x.auto), each with the usual
> > auto-generated input-N-<usage>-value sysfs attribute.
> >
> > What I found tracing show_value() in hid-sensor-custom.c: for input
> > reports, it calls sensor_hub_input_attr_get_raw_value(..., report_id,
> > SENSOR_HUB_SYNC, false) -- i.e. every read of the -value file issues
> > a
> > synchronous GET_REPORT to the hub and returns the live answer.
> > There's
> > no cached field backing that attribute, so there's nothing for a
> > notify-on-change mechanism to attach to on that path.
> >
> > Separately, hid_sensor_capture_sample() *is* a genuine async callback
> > fired on hub-pushed input reports, but as far as I can tell it only
> > feeds the raw kfifo behind the driver's misc-device streaming
> > interface (custom_dev), gated on test_bit(0,
> > &sensor_inst->misc_opened). It doesn't appear to update any per-field
> > cached value, so it isn't reachable from the sysfs show_value() path
> > either.
> >
> > Net effect: there's no way for a userspace consumer to poll()/
> > select() on the -value file and be woken only on real hardware
> > events.
>
>
> I have a test program for poll(). Attached poll part.
>
> #define DEVICE_PATH "/dev/HID-SENSOR-2000e1.2.auto"
> #define BUFFER_SIZE 256
>
> int main(int argc, char *argv[])
> {
>         int fd;
>         struct pollfd pfd;
>         char buffer[BUFFER_SIZE];
>         int ret;
>         struct sigaction sa;
>
>         if (argc < 2) {
>                 printf("syntax %s sample_interval\n", argv[0]);
>                 exit(0);
>         }
>
>
>         // 1. Set up Ctrl+C signal handler
>         sa.sa_handler =3D handle_sigint;
>         sigemptyset(&sa.sa_mask);
>         sa.sa_flags =3D 0; // Don't use SA_RESTART so poll() unblocks on
> signal
>         if (sigaction(SIGINT, &sa, NULL) < 0) {
>                 perror("Error setting up signal handler");
>                 return -1;
>         }
>
>         enable_sensor(1);
>
>         // 2. Open the misc device
>         fd =3D open(DEVICE_PATH, O_RDONLY | O_NONBLOCK);
>         if (fd < 0) {
>                 perror("Failed to open device");
>                 return -1;
>         }
>
>         // 3. Configure poll structure
>         pfd.fd =3D fd;
>         pfd.events =3D POLLIN;
>
>         printf("Polling loop started. Press Ctrl+C to exit
> safely.\n");
>
>         // 4. Main event loop
>         while (keep_running) {
>                 printf("Waiting for data...\n");
>
>                 ret =3D poll(&pfd, 1, -1);
>
>                 if (ret < 0) {
>                         // Signal interrupted poll, loop will exit if
> it was SIGINT
>                         continue;
>                 }
>
>                 if (ret =3D=3D 0) {
>                         // Timeout reached with no data
>                         continue;
>                 }
>
>                 // 5. Handle readable data event
>                 if (pfd.revents & POLLIN) {
>                         rx_tsc =3D read_rdtsc();
>                         ssize_t bytes_read =3D read(fd, buffer,
> sizeof(buffer) - 1);
>                         if (bytes_read > 0) {
>                                 time_t tm;
>
>                                 buffer[bytes_read] =3D '\0'; // Null-
> terminate string
>                                 printf("tm:%ld Received %ld bytes:
> %s\n", time(&tm), (long)bytes_read, buffer);
>                                 read_time_stamp(buffer, bytes_read);
>                         } else if (bytes_read < 0) {
>                                 perror("Read error");
>                         }
>                 }
>         }
>
>         // 6. Cleanup
>         printf("\nExiting program cleanly...\n");
>         close(fd);
>
>         enable_sensor(0);
>
>         return 0;
> }
>
> Does it help.
>
> Thanks,
> Srinivas
>
>
> > The hub itself is already configured for threshold-based reporting
> > (property-reporting-state =3D 2, i.e. "Threshold Events") in my case,
> > so
> > the inefficiency is entirely on the kernel/sysfs side -- userspace
> > has
> > to fall back to timed re-reads of a synchronous, firmware-round-trip
> > attribute, which is more expensive per-read than a typical cached
> > sysfs value and awkward to size a safe polling interval for.
> >
> > This seems like a real gap for the presence/proximity use case
> > specifically (walk-away lock, auto-dim, etc.), which is inherently
> > event-oriented and is exactly the kind of feature vendors implement
> > natively on Windows via push notifications from the same class of
> > sensor.
> >
> > Before I put together a patch I wanted to ask: is there interest in
> > adding async caching + sysfs_notify() (or sysfs_notify_dirent(), if
> > attrs end up carrying a stored kernfs_node) for input-report values
> > specifically, sourced from hid_sensor_capture_sample()'s existing
> > async path? Rough shape as I see it:
> >
> >   - add a cached "last input value" (+ a bool "valid") per relevant
> > field in struct hid_sensor_custom_field
> >   - in hid_sensor_capture_sample(), in addition to (or instead of,
> > behind a config/attr) feeding the misc-device fifo, decode and store
> > the value for the matching field, then sysfs_notify() its -value
> > attribute
> >   - leave show_value()'s SENSOR_HUB_SYNC path untouched for feature
> > reports and for any input attrs that never get an async report, so
> > nothing regresses for existing consumers
> >
> > Happy to be told this already exists via a different interface I've
> > missed (I did look at whether this should just go through the IIO
> > buffered/trigger interface instead, given some other hid-sensor-*
> > drivers are IIO-backed -- but hid-sensor-custom exposes vendor/custom
> > usages directly via this sysfs shape rather than IIO channels, so I
> > wasn't sure that's the right layer to add it at). Also open to being
> > told the misc-device/fifo interface is meant to be the async
> > consumption path already and userspace tools should be using that
> > instead of polling -value -- if so, is there existing tooling/docs
> > for
> > that path I should be pointing presence-detection use cases at?
> >
> > Not attaching a patch yet since I'd rather get a read on the right
> > approach (and whether it's wanted at all) before writing one.
> >
> > Thanks,
> > Daniel Paul
