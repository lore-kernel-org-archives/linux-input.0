Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DF32E69A
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396733; cv=none; b=SFXyRsAfGf3mpwyCXQIiSpnXHPjkg9aIwhdMbU39JGyVfkuKgDMoN+5ib6Ebs+j1qKu3NsnPZZclLnbP9Z0Pkp/xeOpeV8jCSfl9HSErLTWOTG9cEzo1VyGQdOl21QOKSOTcS3GKpdA4p3qz2gR3yDjwTJWJTLgAsJMbzb5BBtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396733; c=relaxed/simple;
	bh=w79EgFPobXc1fNLX0IdgEikal4mapMbUm9s85WHfqNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPVRRl2xsJTlnkcghYeL/OadSZ2UbQqRnn86vQ5BguJdv0eOGYZipoAfUSI4qThDnT9CiiufZTdRXld0avRsnBoNLKustO5j+irlsqx05iMFfIAu8c8oTjLdhtwwUk5Utl0NE22Bv29YO/VU4N8neZ4/+0GPBdFzfIqxOB5Ug/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3IlvLajq; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3IlvLajq"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-662efd1bdd4so2806577eaf.0
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772396731; x=1773001531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4MOiR5mzBPo/Mx0DatRw9g2Ut/kzE5VHrbIV+pfL+0=;
        b=3IlvLajqAWppR3CK817paDIe65qdnkci0kq8svTYpJtK/c7YF5CcGR0QeoYT4n12oz
         VVOR0/XzqT2nK14APEjper/bC5LvqTpYdr9uyiKPpMTHuQQqMXIaOcx2K27GZ7E5WQvz
         /I7eZeeY51JtTkg3z65DRuI8frrfz5n65Omc0q7fwSeBfWCGb2PfFo0opiKOEX/eZhM2
         GhJmTXQvayH0T33Cv8Pim1CAUkVAjGN1bRsRgdmzJpSWJS143JxGTSe95oWhYOzEis7A
         J3OUSChAPgEwNV254+7nsjpcz89sqDYK8cnvhN1Qhch7x245fnJ81vO53qyxHjEEXxGk
         x/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396731; x=1773001531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4MOiR5mzBPo/Mx0DatRw9g2Ut/kzE5VHrbIV+pfL+0=;
        b=TXUo4y1dYsaUlwXNSlhTUzzihwMj7pZWS7bsYSUJeG0gbExUXhwyDXPSYbIifbYpZ9
         p/V7ZeCwMj+ekvbVSDiRhAMOBae6PH14qQ36H1AeU100vUZNSNF2AgKZZjcRQNtSTcWf
         vDyWWWnDzNY4giRUe3fSkwB3IG7azc58RkKWjLvSqMhofxwaaOaQ7VN4JgjxD5PuVNUQ
         2x5vD8+P1zN2kf/ZjAhAd+hJjSfbxePgwsMTsotLZ+8iYU8z36wCLZxAsCBkw1YVVpVb
         LuzEnTQQbRDuJl5ZvMaHy/P/Ivpgb0QkrEEadg1p/yaiUQrIa092b1P3ptNOM/5IB4sf
         YHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUhq4nbQEyUlHciOh0C5H5GWNWylCtk2gH4CpCy/RTAUsuP/syA9VwQUr/L/rpCf7/I73hzeo1UjFfuxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaA8AHE0jUcO09CA0jqU56C9Y8o9y4zTSz6haxH6HcHBy7i3R
	SRKpChzpoK2r7ZCG5dqI83qqlPVpv5hSd4/UhiARTgBClCOE7VEAFk2MxSaD7KGIqq4=
X-Gm-Gg: ATEYQzzf3Uy/MleZGvXqJr+bJe5F4nIA7dtZPjd1LA/Wu0qBO4aIiI6GyWQvRB6gJX1
	I9kwfGCsD+OSK8TflMKhLg+FaIku28PWOVb/hEkKMnPN04VdQEsfjMlO1NFl2HSshR3JxXi5FZl
	RZzcchgWqtAU/JMFgWH0zyPG54b4XdmZpFOUuxWXeC2mAqCTlh5dzIR7C6hyLCr66DhhnprAvfM
	pbvLtG9hSIdXzejTp3ZwAn4I15EW74DF9P69Pmkd3oGbmd7B9aMOMtgHmVy7dCagS3aSA2kUHg2
	G8ozeMP8Uemw9XqNwGCUM0WKvlQGrFAG2OqkSVjgddVf+qRZjVynIhcWSoKnHUcFayc7yL6XR93
	BhqmzVzy+JhG+fNmo1qzMyWvl0MDzZVQd81xy67sm7H6Al4IGs1vTyGrDDxMqwVlz5NwmtZybS+
	ukMSeaJjl+nliMwlvrJAi6NIvmgefU
X-Received: by 2002:a05:6820:4b08:b0:679:a41d:2d29 with SMTP id 006d021491bc7-679fb4394abmr5183163eaf.2.1772396731107;
        Sun, 01 Mar 2026 12:25:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm10063025fac.17.2026.03.01.12.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:25:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 01 Mar 2026 14:24:50 -0600
Subject: [PATCH 1/4] iio: orientation: hid-sensor-rotation: add timestamp
 hack to not break userspace
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10742;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=w79EgFPobXc1fNLX0IdgEikal4mapMbUm9s85WHfqNg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBppKCc4+PtND/C7HPEVljZkQuAOkl8nLVneSj2k
 A6fg4oEkZ2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaSgnAAKCRDCzCAB/wGP
 wJFWCACNu0gJJ1bM8mp4u/nzubTieDtO+AXElboTgLhRUfkzhGoPv6Y7OHjQ3FvDXZlNiT6z9v2
 IODRFHAPi2GefAmywSMCPxZXN9oA5wV/pE9rwSXb0LsoZPqq2rE9Jzvldt8X0D8tl1Qh67E5GfE
 rx9le4WnjBwtLlm/5fQQfj66ed4nPs+EV0ecDXb5OjtvsOqVaAh1mz/7E5Ft8+yH74Negu4KU3k
 SOQ4e43rLqkISyIbds3WC/JbsitELWlNKitReFio0x/vBfARvf7Sx6d2FsW+zHd0FYubG6IpTqv
 OAlDpwJPz3wXNRljR7yNAuMjh1Jc64Sj6CKYBG4zCZPJticc
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a hack to push two timestamps in the hid-sensor-rotation scan data
to avoid breaking userspace applications that depend on the timestamp
being at the incorrect location in the scan data due to unintentional
misalignment in older kernels.

When this driver was written, the timestamp was in the correct location
because of the way iio_compute_scan_bytes() was implemented at the time.
(Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
align the size of scan bytes to size of the largest element") changed
the computed scan_bytes to be a different size (32 bytes), which caused
iio_push_to_buffers_with_timestamp() to place the timestamp at an
incorrect offset.

There have been long periods of time (6 years each) where the timestamp
was in either location, so to not break either case, we open-code the
timestamps to be pushed to both locations in the scan data.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huawei/
Fixes: 883f61653069 ("iio: buffer: align the size of scan bytes to size of the largest element")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

I found that I could emulate this thanks to /dev/uhid. And thanks to AI
code generators, I was able to reasonably quickly make a script that
worked for emulating "HID-SENSOR-20008a". I'll include the script at the
end.

I set up the buffer like this:

cd /sys/bus/iio/devices/iio:device1/buffer0
echo 1 > in_rot_quaternion_en
echo 1 > in_timestamp_en
echo 1 > enable

Before this series is applied, we can see that the timestamp (group of 8
ending in "98 18") is at offset of 24 in the 32-byte data.

hd /dev/iio\:device1

00000000  6a 18 00 00 ac f3 ff ff  83 2d 00 00 02 d3 ff ff  |j........-......|
00000010  00 00 00 00 00 00 00 00  5a 17 a0 2a 73 cb 98 18  |........Z..*s...|

00000020  ad 17 00 00 6a f4 ff ff  35 2b 00 00 ca d0 ff ff  |....j...5+......|
00000030  00 00 00 00 00 00 00 00  2a a6 bb 30 73 cb 98 18  |........*..0s...|

00000040  92 1e 00 00 50 ec ff ff  ea c1 ff ff 78 f0 ff ff  |....P.......x...|
00000050  00 00 00 00 00 00 00 00  8f 3b a7 39 77 cb 98 18  |.........;.9w...|

After the first patch, we can see that the timestamp is now repeated at
both the correct and previous incorrect offsets (24 and 32). (Normally,
the last 8 bytes would be all 00 for padding.)

00000000  dd e0 ff ff 0e e0 ff ff  75 07 00 00 90 3f 00 00  |........u....?..|
00000010  f4 38 82 d0 3a cc 98 18  f4 38 82 d0 3a cc 98 18  |.8..:....8..:...|

00000020  a0 e0 ff ff 1d e0 ff ff  a0 0a 00 00 1c 3f 00 00  |.............?..|
00000030  3a 29 9f d6 3a cc 98 18  3a 29 9f d6 3a cc 98 18  |:)..:...:)..:...|

00000040  a9 e1 ff ff 1e 14 00 00  6c c1 ff ff 98 f2 ff ff  |........l.......|
00000050  39 21 77 11 55 cc 98 18  39 21 77 11 55 cc 98 18  |9!w.U...9!w.U...|

Test script:

import math
import os
import struct
import time

UHID_DESTROY = 1
UHID_CREATE2 = 11
UHID_INPUT2 = 12

UHID_DATA_MAX = 4096
BUS_USB = 0x03

class UHIDRotationSensor:
    def __init__(self, device_path: str = "/dev/uhid") -> None:
        """Initialize the virtual UHID rotation sensor.

        Args:
            device_path: Path to the UHID character device.
        """
        self.device_path = device_path
        self.fd = -1

    def open_device(self) -> None:
        """Open the UHID device."""
        self.fd = os.open(self.device_path, os.O_RDWR)

    def close_device(self) -> None:
        """Close the UHID device."""
        if self.fd >= 0:
            os.close(self.fd)
            self.fd = -1

    def create_device(self) -> None:
        """Create and register a virtual HID rotation sensor."""
        # HID descriptor for Sensor Device Orientation (HID-SENSOR-20008a)
        report_desc = bytes(
            [
                0x05,
                0x20,  # Usage Page: Sensor
                0x09,
                0x8A,  # Usage: Device Orientation (0x20008A)
                0xA1,
                0x01,  # Collection: Application

                # Input report (Report ID 1): quaternion x, y, z, w (s16)
                0x85,
                0x01,  # Report ID 1
                0x0A,
                0x83,
                0x04,  # Usage: Orientation Quaternion (0x200483)
                0x16,
                0x00,
                0x80,  # Logical Minimum: -32768
                0x26,
                0xFF,
                0x7F,  # Logical Maximum: 32767
                0x75,
                0x10,  # Report Size: 16
                0x95,
                0x04,  # Report Count: 4
                0x81,
                0x02,  # Input: Data, Variable, Absolute

                # Feature report (Report ID 2): report state, power state,
                # and report interval
                0x85,
                0x02,  # Report ID 2
                0x0A,
                0x16,
                0x03,  # Usage: Property Report State (0x200316)
                0x15,
                0x01,  # Logical Minimum: 1
                0x25,
                0x05,  # Logical Maximum: 5
                0x75,
                0x08,
                0x95,
                0x01,
                0xB1,
                0x02,  # Feature: Data, Variable, Absolute

                0x0A,
                0x19,
                0x03,  # Usage: Property Power State (0x200319)
                0x15,
                0x01,
                0x25,
                0x05,
                0x75,
                0x08,
                0x95,
                0x01,
                0xB1,
                0x02,  # Feature: Data, Variable, Absolute

                0x0A,
                0x0E,
                0x03,  # Usage: Property Report Interval (0x20030E)
                0x15,
                0x00,  # Logical Minimum: 0
                0x27,
                0xFF,
                0xFF,
                0xFF,
                0x7F,  # Logical Maximum: 2147483647
                0x75,
                0x20,  # Report Size: 32
                0x95,
                0x01,  # Report Count: 1
                0xB1,
                0x02,  # Feature: Data, Variable, Absolute

                0xC0,  # End Collection
            ]
        )

        # Build struct uhid_create2_req payload
        create_req_header = struct.pack(
            "<128s64s64sHHIIII",
            b"HID-SENSOR-20008a",  # name
            b"AD Inc",  # phys
            b"",  # uniq
            len(report_desc),  # rd_size
            BUS_USB,  # bus
            0x0001,  # vendor
            0x0001,  # product
            0,  # version
            0,  # country
        )

        create_req = (
            create_req_header
            + report_desc
            + b"\x00" * (UHID_DATA_MAX - len(report_desc))
        )
        event = struct.pack("<I", UHID_CREATE2) + create_req

        if self.fd < 0:
            raise RuntimeError("UHID device is not open")

        os.write(self.fd, event)

    def send_rotation_data(self, qx: int, qy: int, qz: int, qw: int) -> None:
        """Send one quaternion sample report.

        Args:
            qx: Quaternion X component (signed 16-bit).
            qy: Quaternion Y component (signed 16-bit).
            qz: Quaternion Z component (signed 16-bit).
            qw: Quaternion W component (signed 16-bit).
        """
        report_id = 1
        report = struct.pack(
            "<Bhhhh",
            report_id,
            max(-32768, min(32767, qx)),
            max(-32768, min(32767, qy)),
            max(-32768, min(32767, qz)),
            max(-32768, min(32767, qw)),
        )

        input_req = (
            struct.pack("<H", len(report))
            + report
            + b"\x00" * (UHID_DATA_MAX - len(report))
        )
        event = struct.pack("<I", UHID_INPUT2) + input_req

        if self.fd < 0:
            raise RuntimeError("UHID device is not open")

        os.write(self.fd, event)

    def run(self) -> None:
        """Run the virtual sensor simulation loop."""
        try:
            self.open_device()
            self.create_device()
            time.sleep(0.5)

            angle = 0.0
            while True:
                # Simulate changing orientation in quaternion form.
                half_angle = angle * 0.5
                qx = int(8192 * math.sin(half_angle * 0.7))
                qy = int(8192 * math.cos(half_angle * 0.5))
                qz = int(16384 * math.sin(half_angle))
                qw = int(16384 * math.cos(half_angle))

                self.send_rotation_data(qx, qy, qz, qw)
                angle += 0.1
                time.sleep(0.1)

        except KeyboardInterrupt:
            print("\nStopping...")
        finally:
            self.close_device()

if __name__ == "__main__":
    sensor = UHIDRotationSensor()
    sensor.run()
---
 drivers/iio/orientation/hid-sensor-rotation.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e759f91a710a..a8bce5151dcb 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -20,7 +20,11 @@ struct dev_rot_state {
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
 		s32 sampled_vals[4];
-		aligned_s64 timestamp;
+		/*
+		 * HACK: There are two copies of the same timestamp in case of
+		 * userspace depending on broken alignment from older kernels.
+		 */
+		aligned_s64 timestamp[2];
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
@@ -154,8 +158,18 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!rot_state->timestamp)
 			rot_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &rot_state->scan,
-						   rot_state->timestamp);
+		/*
+		 * HACK: IIO previously had an incorrect implementation of
+		 * iio_push_to_buffers_with_timestamp() that put the timestamp
+		 * in the last 8 bytes of the buffer, which was incorrect
+		 * according to the IIO ABI. To avoid breaking userspace that
+		 * depended on this broken behavior, we put the timestamp in
+		 * both the correct place and the old incorrect place.
+		 */
+		rot_state->scan.timestamp[0] = rot_state->timestamp;
+		rot_state->scan.timestamp[1] = rot_state->timestamp;
+
+		iio_push_to_buffers(indio_dev, &rot_state->scan);
 
 		rot_state->timestamp = 0;
 	}

-- 
2.43.0

