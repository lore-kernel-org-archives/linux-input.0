Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C978331ED4;
	Mon, 27 Jul 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165010; cv=none; b=jqqE7+6isobLUgheZajD7MBJzUXQrn2XB0vWVNvjXH8j7Qfxd6gC9lFKBrZxdUc5sfgwDCZhfHuMeJ15OOcTcy8S9Y31Ola5qMBROLkGCQ0ebxcls7kndKeVWOoXNRQyWnJZCrYluJD7lN9FwLYjAhiLjasVfFsqiH13XHnwur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165010; c=relaxed/simple;
	bh=0TNxTC62a96PY6L5EFPjqn/7L08TLW7Y/0cP71aGJN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfluWETvpsX//Ufkm3exENV9eaHmZsXchb2YYiImmj2UJLhyipcX93ilOEpbjiCfU2CLWognfpf/nDtvxw8pf+y52diG520NqpWJy46mWGHVx4KxgXusqyxLUoo5MXGpKOYYITwIhy8EZNnpR8Lp/9mlJ6g5khLyuqsegZsdXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvJq5fIq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvJq5fIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785165009; x=1816701009;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0TNxTC62a96PY6L5EFPjqn/7L08TLW7Y/0cP71aGJN0=;
  b=ZvJq5fIqmDIOx9XJ6ML55SbLg1skVJBTF+WzM+mIWNoQPogNn/mPWF7u
   ZUV4XXTUcKnAKLHxnaugb+6e9NM2ikvq6EjtUwYjYaOmjDFp/3IiOppMo
   CkOqdFyb02fbj2uRsebssztlFHPvipCM8faTakdbbZelARxwhD5NB4cnF
   F+z8lqKuoPhvQ8NNP5Iul9WkRzTLAwa9u+fsBb+RqaBGHbEDhhJDskLk7
   n+ckcXstxyXI5NglvS784E96QArrA6r1GHC/9rnndfggaQg5QapVZqWYy
   nnTSYIcG58qvMg9kkbgzdg6VW9Q6/6v5vUHpyDhFp/NLyxEBmZMT5qP/G
   Q==;
X-CSE-ConnectionGUID: Tgz1iWmVQa66CefP4drF4w==
X-CSE-MsgGUID: 9ndeT4KrQPGYXkhZ0OuDWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96888618"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96888618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:10:07 -0700
X-CSE-ConnectionGUID: AVGkj5OMTFq2p2oVMFZEqw==
X-CSE-MsgGUID: 4Gcx0k0PSmmE2m5+OV3Mlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="263221845"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:09:56 -0700
Message-ID: <ec3395f45c07ae8afee181768828eb1c5f43c6f9.camel@linux.intel.com>
Subject: Re: hid-sensor-custom: async notification for input-report sysfs
 attributes? (human presence / attention sensors)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Daniel Paul Perinchery <danielpaulperinchery07012005@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Benjamin Tissoires	 <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 27 Jul 2026 08:09:55 -0700
In-Reply-To: <CA+8Hp=Pv_zsYiPOhxTQ4NtQ-rMSyPKbWrGyU0d+d--BHpT87YQ@mail.gmail.com>
References: 
	<CA+8Hp=M3ynUHzcDshLup5G+HDs0XoWkav0R5k-00m+O7LbOv1w@mail.gmail.com>
	 <7df349cbcccc8004d9aef37f95be5c8e0e51f713.camel@linux.intel.com>
	 <CA+8Hp=Pv_zsYiPOhxTQ4NtQ-rMSyPKbWrGyU0d+d--BHpT87YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-27 at 11:38 +0530, Daniel Paul Perinchery wrote:
> Apologies =E2=80=94 my last message went to Srinivas directly instead of =
the
> whole thread. Reposting here so it's visible to everyone and gets
> archived properly:
>=20
Hi,

> Hi,
>=20
> Thanks, this does help. I got it running and poll()/read() on
> /dev/HID-SENSOR-2000e1.3.auto does work. Two things I wasn't
> expecting, and wanted to check with you before going further:
>=20
> 1. The reports arrive continuously, roughly every 100ms, whether or
> not anything actually changed (matches property-report-interval on
> this device, which reads 100). property-reporting-state reads 2
> ("Threshold Events" per the HID sensor usage table), which I'd
> assumed
> meant the async path would only push on a real threshold crossing --
> but empirically it's a steady ~10Hz stream throughout, including long
> stretches where the sensor value isn't changing. Is that expected for
> this reporting-state value on the async report path specifically, or
> is there a separate control I'm missing to actually get
> sparse/event-only pushes out of the misc device (vs. it just always
> streaming at the configured report interval regardless of
> reporting-state)?
>=20

That is up to the hub. The reporting interval just tells that it should
not report less that that interval.
There is a sensitivity usage IDs 0x20030F , 0x200310 or  0x200310.
But they are optional, but if hub provides then, you can try that.


> 2. Every sample's usage_id field comes back as 0x002000e1, i.e. the
> collection's own usage (hsdev->usage), not the usage of whichever
> individual input field the report is carrying. This instance
> (2000e1.3.auto) has five input fields under it in sysfs
> (input-0-200201 through input-4-2004b1), so I think each 11-byte
> payload is a packed report containing some/all of those fields
> together, keyed by byte offset rather than by usage_id per sample. Is
> there a way to get the per-field usage or offset table from userspace
> (something under sysfs or a report-descriptor dump via hidraw) so I
> don't have to reverse-engineer the byte layout empirically by
> correlating against the -value sysfs files field by field?
>=20

There is no individual field reporting by the hub.

Thanks,
Srinivas

> My use case is specifically the human-presence input (2004b1) for a
> walk-away lock/dim daemon, so what I actually want is: wake up only
> when *that* field changes, ideally without also waking up for the
> other four fields' updates every 100ms if they're unrelated to
> presence. Let me know if that's realistically achievable with this
> interface as-is, or if it'd need something added on the kernel side
> after all (which circles back to my original question -- happy to go
> either direction depending on what you'd recommend).
>=20
> Thanks again for the pointer, this is a big step forward from polling
> sysfs.
>=20
> Daniel Paul
>=20
> On Fri, Jul 24, 2026 at 9:00=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Hi,
> >=20
> > On Fri, 2026-07-24 at 12:42 +0530, Daniel Paul Perinchery wrote:
> > > Hi,
> > >=20
> > > I've been investigating why userspace can't efficiently watch a
> > > hid-sensor-custom input-report value (specifically a human-
> > > presence
> > > sensor, HID usage 2000e1, on an AMD Sensor Fusion Hub / amd_sfh
> > > platform) for changes without polling, and wanted to check
> > > whether
> > > there's interest in closing this gap before I try to write
> > > anything.
> > >=20
> > > Setup: Lenovo IdeaPad Pro 5 14AKP10, AMD Ryzen AI 7 350, kernel
> > > 7.0.13
> > > (Debian/Parrot, but this is stock hid-sensor-custom.c). Presence
> > > and
> > > gaze/attention are exposed as separate logical sensors under the
> > > same
> > > physical hub (HID-SENSOR-2000e1.x.auto), each with the usual
> > > auto-generated input-N-<usage>-value sysfs attribute.
> > >=20
> > > What I found tracing show_value() in hid-sensor-custom.c: for
> > > input
> > > reports, it calls sensor_hub_input_attr_get_raw_value(...,
> > > report_id,
> > > SENSOR_HUB_SYNC, false) -- i.e. every read of the -value file
> > > issues
> > > a
> > > synchronous GET_REPORT to the hub and returns the live answer.
> > > There's
> > > no cached field backing that attribute, so there's nothing for a
> > > notify-on-change mechanism to attach to on that path.
> > >=20
> > > Separately, hid_sensor_capture_sample() *is* a genuine async
> > > callback
> > > fired on hub-pushed input reports, but as far as I can tell it
> > > only
> > > feeds the raw kfifo behind the driver's misc-device streaming
> > > interface (custom_dev), gated on test_bit(0,
> > > &sensor_inst->misc_opened). It doesn't appear to update any per-
> > > field
> > > cached value, so it isn't reachable from the sysfs show_value()
> > > path
> > > either.
> > >=20
> > > Net effect: there's no way for a userspace consumer to poll()/
> > > select() on the -value file and be woken only on real hardware
> > > events.
> >=20
> >=20
> > I have a test program for poll(). Attached poll part.
> >=20
> > #define DEVICE_PATH "/dev/HID-SENSOR-2000e1.2.auto"
> > #define BUFFER_SIZE 256
> >=20
> > int main(int argc, char *argv[])
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fd;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pollfd pfd;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buffer[BUFFER_SIZE];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sigaction sa;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (argc < 2) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 printf("syntax %s sample_interval\n", argv[0]);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exit(0);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // 1. Set up Ctrl+C signal h=
andler
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sa.sa_handler =3D handle_sig=
int;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sigemptyset(&sa.sa_mask);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sa.sa_flags =3D 0; // Don't =
use SA_RESTART so poll() unblocks
> > on
> > signal
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sigaction(SIGINT, &sa, N=
ULL) < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 perror("Error setting up signal handler");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_sensor(1);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // 2. Open the misc device
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open(DEVICE_PATH, O_R=
DONLY | O_NONBLOCK);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 perror("Failed to open device");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // 3. Configure poll structu=
re
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pfd.fd =3D fd;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pfd.events =3D POLLIN;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Polling loop started=
. Press Ctrl+C to exit
> > safely.\n");
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // 4. Main event loop
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (keep_running) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 printf("Waiting for data...\n");
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D poll(&pfd, 1, -1);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Si=
gnal interrupted poll, loop will exit
> > if
> > it was SIGINT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Ti=
meout reached with no data
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 // 5. Handle readable data event
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (pfd.revents & POLLIN) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rx_ts=
c =3D read_rdtsc();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssize=
_t bytes_read =3D read(fd, buffer,
> > sizeof(buffer) - 1);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (b=
ytes_read > 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_t tm;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buffer[bytes_read] =3D '\0'; // =
Null-
> > terminate string
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("tm:%ld Received %ld byte=
s:
> > %s\n", time(&tm), (long)bytes_read, buffer);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_time_stamp(buffer,
> > bytes_read);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e if (bytes_read < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("Read error");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // 6. Cleanup
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\nExiting program cl=
eanly...\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fd);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_sensor(0);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > }
> >=20
> > Does it help.
> >=20
> > Thanks,
> > Srinivas
> >=20
> >=20
> > > The hub itself is already configured for threshold-based
> > > reporting
> > > (property-reporting-state =3D 2, i.e. "Threshold Events") in my
> > > case,
> > > so
> > > the inefficiency is entirely on the kernel/sysfs side --
> > > userspace
> > > has
> > > to fall back to timed re-reads of a synchronous, firmware-round-
> > > trip
> > > attribute, which is more expensive per-read than a typical cached
> > > sysfs value and awkward to size a safe polling interval for.
> > >=20
> > > This seems like a real gap for the presence/proximity use case
> > > specifically (walk-away lock, auto-dim, etc.), which is
> > > inherently
> > > event-oriented and is exactly the kind of feature vendors
> > > implement
> > > natively on Windows via push notifications from the same class of
> > > sensor.
> > >=20
> > > Before I put together a patch I wanted to ask: is there interest
> > > in
> > > adding async caching + sysfs_notify() (or sysfs_notify_dirent(),
> > > if
> > > attrs end up carrying a stored kernfs_node) for input-report
> > > values
> > > specifically, sourced from hid_sensor_capture_sample()'s existing
> > > async path? Rough shape as I see it:
> > >=20
> > > =C2=A0 - add a cached "last input value" (+ a bool "valid") per
> > > relevant
> > > field in struct hid_sensor_custom_field
> > > =C2=A0 - in hid_sensor_capture_sample(), in addition to (or instead
> > > of,
> > > behind a config/attr) feeding the misc-device fifo, decode and
> > > store
> > > the value for the matching field, then sysfs_notify() its -value
> > > attribute
> > > =C2=A0 - leave show_value()'s SENSOR_HUB_SYNC path untouched for
> > > feature
> > > reports and for any input attrs that never get an async report,
> > > so
> > > nothing regresses for existing consumers
> > >=20
> > > Happy to be told this already exists via a different interface
> > > I've
> > > missed (I did look at whether this should just go through the IIO
> > > buffered/trigger interface instead, given some other hid-sensor-*
> > > drivers are IIO-backed -- but hid-sensor-custom exposes
> > > vendor/custom
> > > usages directly via this sysfs shape rather than IIO channels, so
> > > I
> > > wasn't sure that's the right layer to add it at). Also open to
> > > being
> > > told the misc-device/fifo interface is meant to be the async
> > > consumption path already and userspace tools should be using that
> > > instead of polling -value -- if so, is there existing
> > > tooling/docs
> > > for
> > > that path I should be pointing presence-detection use cases at?
> > >=20
> > > Not attaching a patch yet since I'd rather get a read on the
> > > right
> > > approach (and whether it's wanted at all) before writing one.
> > >=20
> > > Thanks,
> > > Daniel Paul
