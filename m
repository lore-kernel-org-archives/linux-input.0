Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F24360751;
	Fri, 24 Jul 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907033; cv=none; b=qAFXn9M5MgCRQTT2yljA3A+kLVZOv/8WiOxOee9RgxUI3604k8T4Lf/+1ejrsTwmHVJVZURyY9NdNDuCCNR7f1BsQnWI0wCI6J3K99XW2Yi5HIMyKo7MBQz5jv9cweq0cE2lTvE7Dj9cX/PQjzsVT+AlpSUvbyo4IXy+f2cRom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907033; c=relaxed/simple;
	bh=O9piygf4mclTLSx4e3UlgjLQXNtkVuA++5iO9IxjET8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BqtbaTB+G87H99p1VE9hG8WhV/XbamdXt2axY4Jeen3W4ho7KHqbcTJRRcgnTAUHOTxI/ETOAVwIqIpDTc43ifLQrJkNUDKR9K+i/v02sKsCNlytEY6oPI8gbqSR42GUZrW/9Jakjqe8QCF8rv1qrx/XBdN9o06Ryrp+Yu7nki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1AdiOqo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1AdiOqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784907031; x=1816443031;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O9piygf4mclTLSx4e3UlgjLQXNtkVuA++5iO9IxjET8=;
  b=B1AdiOqoVwn1sZAn4ObrASY0f3fCH0UKmK/urvACr2VLdJ+sxs1DT7a7
   yki35sIPk+S6l2Lq6tw9h7MMzHyLeFX++mc8+E+L73m4SSiZWUw457JBZ
   JboMW6MoSXGFbDyjZDWOYZYzAi0qSFekACKzOTTJi9o++mo0PJk1hMZwv
   MPk9Ut4irlvvirCSV/cOai8tmBSiZipSSxWU5ILSGdwSPCeLg2HYbDOTZ
   sF6uBfoTqJER/22amz1saoLtYuEWgdfLRtXCrHPMJuROJpzKMOWH+pyJR
   Y7MTZoAEWOu00IH1MqdeReDiYYDmmz324yi1IYqyPftGCxwDCK2B9ZZsv
   Q==;
X-CSE-ConnectionGUID: vl1iv66NRKWTu9IPqLkBHA==
X-CSE-MsgGUID: jykp7n0MRYS3v9XNMXbB4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85621717"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85621717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:30:30 -0700
X-CSE-ConnectionGUID: HCrolK7iSO2wmuEtPkBZxA==
X-CSE-MsgGUID: Tq4z16YQTx2NOg1ptwyHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="262256353"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:30:31 -0700
Message-ID: <7df349cbcccc8004d9aef37f95be5c8e0e51f713.camel@linux.intel.com>
Subject: Re: hid-sensor-custom: async notification for input-report sysfs
 attributes? (human presence / attention sensors)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Daniel Paul Perinchery <danielpaulperinchery07012005@gmail.com>, Jiri
 Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Benjamin
 Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 08:30:15 -0700
In-Reply-To: <CA+8Hp=M3ynUHzcDshLup5G+HDs0XoWkav0R5k-00m+O7LbOv1w@mail.gmail.com>
References: 
	<CA+8Hp=M3ynUHzcDshLup5G+HDs0XoWkav0R5k-00m+O7LbOv1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2026-07-24 at 12:42 +0530, Daniel Paul Perinchery wrote:
> Hi,
>=20
> I've been investigating why userspace can't efficiently watch a
> hid-sensor-custom input-report value (specifically a human-presence
> sensor, HID usage 2000e1, on an AMD Sensor Fusion Hub / amd_sfh
> platform) for changes without polling, and wanted to check whether
> there's interest in closing this gap before I try to write anything.
>=20
> Setup: Lenovo IdeaPad Pro 5 14AKP10, AMD Ryzen AI 7 350, kernel
> 7.0.13
> (Debian/Parrot, but this is stock hid-sensor-custom.c). Presence and
> gaze/attention are exposed as separate logical sensors under the same
> physical hub (HID-SENSOR-2000e1.x.auto), each with the usual
> auto-generated input-N-<usage>-value sysfs attribute.
>=20
> What I found tracing show_value() in hid-sensor-custom.c: for input
> reports, it calls sensor_hub_input_attr_get_raw_value(..., report_id,
> SENSOR_HUB_SYNC, false) -- i.e. every read of the -value file issues
> a
> synchronous GET_REPORT to the hub and returns the live answer.
> There's
> no cached field backing that attribute, so there's nothing for a
> notify-on-change mechanism to attach to on that path.
>=20
> Separately, hid_sensor_capture_sample() *is* a genuine async callback
> fired on hub-pushed input reports, but as far as I can tell it only
> feeds the raw kfifo behind the driver's misc-device streaming
> interface (custom_dev), gated on test_bit(0,
> &sensor_inst->misc_opened). It doesn't appear to update any per-field
> cached value, so it isn't reachable from the sysfs show_value() path
> either.
>=20
> Net effect: there's no way for a userspace consumer to poll()/
> select() on the -value file and be woken only on real hardware
> events.


I have a test program for poll(). Attached poll part.

#define DEVICE_PATH "/dev/HID-SENSOR-2000e1.2.auto"
#define BUFFER_SIZE 256

int main(int argc, char *argv[])
{
	int fd;
	struct pollfd pfd;
	char buffer[BUFFER_SIZE];
	int ret;
	struct sigaction sa;

	if (argc < 2) {
		printf("syntax %s sample_interval\n", argv[0]);
		exit(0);
	}
=09

	// 1. Set up Ctrl+C signal handler
	sa.sa_handler =3D handle_sigint;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags =3D 0; // Don't use SA_RESTART so poll() unblocks on
signal
	if (sigaction(SIGINT, &sa, NULL) < 0) {
		perror("Error setting up signal handler");
		return -1;
	}

	enable_sensor(1);

	// 2. Open the misc device
	fd =3D open(DEVICE_PATH, O_RDONLY | O_NONBLOCK);
	if (fd < 0) {
		perror("Failed to open device");
		return -1;
	}

	// 3. Configure poll structure
	pfd.fd =3D fd;
	pfd.events =3D POLLIN;

	printf("Polling loop started. Press Ctrl+C to exit
safely.\n");

	// 4. Main event loop
	while (keep_running) {
		printf("Waiting for data...\n");
=09
		ret =3D poll(&pfd, 1, -1);=20

		if (ret < 0) {
			// Signal interrupted poll, loop will exit if
it was SIGINT
			continue;=20
		}

		if (ret =3D=3D 0) {
			// Timeout reached with no data
			continue;=20
		}

		// 5. Handle readable data event
		if (pfd.revents & POLLIN) {
			rx_tsc =3D read_rdtsc();
			ssize_t bytes_read =3D read(fd, buffer,
sizeof(buffer) - 1);
			if (bytes_read > 0) {
				time_t tm;

				buffer[bytes_read] =3D '\0'; // Null-
terminate string
				printf("tm:%ld Received %ld bytes:
%s\n", time(&tm), (long)bytes_read, buffer);
				read_time_stamp(buffer, bytes_read);
			} else if (bytes_read < 0) {
				perror("Read error");
			}
		}
	}

	// 6. Cleanup
	printf("\nExiting program cleanly...\n");
	close(fd);

	enable_sensor(0);

	return 0;
}

Does it help.

Thanks,
Srinivas


> The hub itself is already configured for threshold-based reporting
> (property-reporting-state =3D 2, i.e. "Threshold Events") in my case,
> so
> the inefficiency is entirely on the kernel/sysfs side -- userspace
> has
> to fall back to timed re-reads of a synchronous, firmware-round-trip
> attribute, which is more expensive per-read than a typical cached
> sysfs value and awkward to size a safe polling interval for.
>=20
> This seems like a real gap for the presence/proximity use case
> specifically (walk-away lock, auto-dim, etc.), which is inherently
> event-oriented and is exactly the kind of feature vendors implement
> natively on Windows via push notifications from the same class of
> sensor.
>=20
> Before I put together a patch I wanted to ask: is there interest in
> adding async caching + sysfs_notify() (or sysfs_notify_dirent(), if
> attrs end up carrying a stored kernfs_node) for input-report values
> specifically, sourced from hid_sensor_capture_sample()'s existing
> async path? Rough shape as I see it:
>=20
> =C2=A0 - add a cached "last input value" (+ a bool "valid") per relevant
> field in struct hid_sensor_custom_field
> =C2=A0 - in hid_sensor_capture_sample(), in addition to (or instead of,
> behind a config/attr) feeding the misc-device fifo, decode and store
> the value for the matching field, then sysfs_notify() its -value
> attribute
> =C2=A0 - leave show_value()'s SENSOR_HUB_SYNC path untouched for feature
> reports and for any input attrs that never get an async report, so
> nothing regresses for existing consumers
>=20
> Happy to be told this already exists via a different interface I've
> missed (I did look at whether this should just go through the IIO
> buffered/trigger interface instead, given some other hid-sensor-*
> drivers are IIO-backed -- but hid-sensor-custom exposes vendor/custom
> usages directly via this sysfs shape rather than IIO channels, so I
> wasn't sure that's the right layer to add it at). Also open to being
> told the misc-device/fifo interface is meant to be the async
> consumption path already and userspace tools should be using that
> instead of polling -value -- if so, is there existing tooling/docs
> for
> that path I should be pointing presence-detection use cases at?
>=20
> Not attaching a patch yet since I'd rather get a read on the right
> approach (and whether it's wanted at all) before writing one.
>=20
> Thanks,
> Daniel Paul
