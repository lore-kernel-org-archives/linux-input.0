Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468564;
	b=41HPABJUUNWj+UQULxNLPBp4Hd/iJOdc9EVT5ZbBCCWS25qbpkEhs3tnNP9pVcUs9w9W
	 FGUxtV+zSCZ6xvv23t9OsJYXxtrnZxL9PHssgRnmEX9fhYVpyBRANaaZMMWCj3oO9Z5/w
	 vVt0a346yFOl8CPApgIunQqSH/yrLzdhhyMlThIU+GDAoH5BX1ssPtKgmGQJ+GLTawpMG
	 1jt9RQcFvY30In4HOBKc8Y+ueS7uThpTZs4M4V0g/uP9lS20fyiPP5wys5RVYJBkbcpR8
	 9Wn5+V/hQhfz4gPlu4JJztAFkiACbTNwnjdnToouCdXZdaImUdJ51kxPfa29+URmqmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468564;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5379CRQJx8I15aivicNrF0oYqHlT2w74jNzhiFSUHZA=;
	b=c9F0VZGSTULUfAn24dSvmeoA84nLXDHQKn5shrJjzFykVQnIHFLVuPYkmN9XrNDWpxZf
	 9VTfBaHHhha3pREX5sc+iCQV3zHjpGRRnJeiAnGqrm1ZlkH8MvRW8uz5L2OOoYowEgOhp
	 k2dT/czDJAsunLrRG/6xr0b3TltNRmJxJgk0yR44DSbbKba35ZlNSv7e2f7Du/RrwPcIZ
	 +bhTQ3e/0LV1qM7cOc7dVdKT0e48UiT6y5kat9TRqX33tEJDikOhXBt9wZgOZHs++9l+r
	 9oc/gBmKomkv+aJZp13oquF2YVKeGH6R4LcOOJ2SVHYnPs9WtSekT5biqtBuhX2WVog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pVQak5Fb;
	arc=none smtp.remote-ip=91.218.175.29
Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D80606A31D
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D80606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pVQak5Fb
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PzuoZhu6Eoqymm75/Wmyv8NSmRksFQncwoKiOhcjjSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468562; v=1; x=1794073362;
 b=pVQak5Fbyjefv79EB6j07HuCLP50POkBl6h2dTgxcnuywlbF7n3mC1UVTMow9Hcc/3dHbE2s
 efbKDxZlAga0s5h2dmoSE+eOOqbtNO+Aq8hh+JrnSk1M3bb7XI28BXhC4QuiE4KIGl0ETtP6A3u
 vE5WpnWd8zksifACxeGUWHDE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 42bf4bbfbda7191e;
	Sat, 31 Oct 2026 17:42:42 +0000
X-Mizu-Trace-ID: 42bf4bbfbda7191e
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v12 15/17] HID: asus: document ROG XG Mobile sysfs attributes
Date: Sat, 31 Oct 2026 17:41:28 +0000
Message-ID: <20261031174130.208240-16-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031174130.208240-1-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver publishes the station's model, serial, mainboard identifier,
part number, firmware version and hardware generation as read-only
sysfs files. Document each file: when it is created, what a read
returns, and when that read is an empty line.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 .../ABI/testing/sysfs-driver-hid-asus         | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-asus

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-asus b/Documentation/ABI/testing/sysfs-driver-hid-asus
new file mode 100644
index 000000000000..30e0d17d4cec
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-asus
@@ -0,0 +1,95 @@
+What:		/sys/bus/hid/drivers/asus/<dev>/xgm_model
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Model of the connected ASUS ROG XG Mobile station, as
+		reported by the station. An example is "GC33Y".
+
+		The file is created only for a supported station, one whose
+		model name starts with GC31, GC32 or GC33, and only while that
+		station is bound.
+		The value is one line and is never empty while the file
+		exists.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/xgm_serial
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Serial number of the connected ASUS ROG XG Mobile station,
+		as reported by the station.
+
+		The file is created only for a supported station, one whose
+		model name starts with GC31, GC32 or GC33, and only while that
+		station is bound.
+		The read is an empty line when the station did not report a
+		serial number.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/xgm_mainboard
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Mainboard identifier of the connected ASUS ROG XG Mobile
+		station, as reported by the station.
+
+		The file is created only for a supported station, one whose
+		model name starts with GC31, GC32 or GC33, and only while that
+		station is bound.
+		The read is an empty line when the station did not report a
+		mainboard identifier.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/xgm_part_number
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Part number of the connected ASUS ROG XG Mobile station, as
+		reported by the station.
+
+		The file is created only for a supported station, one whose
+		model name starts with GC31, GC32 or GC33, and only while that
+		station is bound.
+		The read is an empty line when the station did not report a
+		part number.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/xgm_firmware_version
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Firmware version of the connected ASUS ROG XG Mobile
+		station, as reported by the station.
+
+		The file is created only for a supported station, one whose
+		model name starts with GC31, GC32 or GC33, and only while that
+		station is bound.
+		The read is an empty line when the version query failed or
+		the station did not report a firmware version.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/xgm_generation
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Hardware generation of the connected ASUS ROG XG Mobile
+		station, as reported by the station.
+
+		The file is created only for a supported station, one whose
+		model name starts with GC31, GC32 or GC33, and only while that
+		station is bound.
+		The read is an empty line when the version query failed or
+		the station did not report a generation.
+
+		Access: Read only
+		Valid values: a single line of text
-- 
2.47.3

