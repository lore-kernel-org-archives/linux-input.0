Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313964;
	b=QuDUjhf/ftfeGomOo3tsEvAnC+zeYzbFFl1F0Cxx/O9AgsqycXswhPZjGcUrLykVnQAE
	 0rdUg4DRUP9H+EDQXVVPbIfLDMtVpqo1WM2mdNJuIYve+B93hlm2fzSUjj0c2+xyS2Efj
	 zv9I1H82pimuOrEXaTj/z5H+rJA3z1qFFjPpiZpq+TwpLsNzYcRfOprPKzINsKMLCOeOY
	 iA31fSmlivaxQLVL9dzLmp0FcRcXNIjaAk9SjlLR3eROdFf7AHuaBTqvEnn/ARLz+GZ7I
	 IaX4BD0nSchbuOwsVI55WlpXoRv2LmRfKaCuTy775qV6CwVm3NwYdUt8zl0Pe0Lox9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313964;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5379CRQJx8I15aivicNrF0oYqHlT2w74jNzhiFSUHZA=;
	b=gH1HWuFhkJSMOHgDwWa6r+rmL5C/s2Tn3sb3k56xuGlojCjIJpUmSeVsPPhgv3mmSapJ
	 mRHIMR4IFX34CMUY2SVVE88mbwMqQ9k+2DzlE5WBZYfA1CBu87DbUj0bRvQGQ1Cwe/miB
	 JLDSW5WJzgJ4IbxQPv4AjQyrZL7fYrZcxv6KdMYe9lr0HmvRaS+2HAmthQEFRwEASr4Q+
	 xcOu2/TyfnP167YBWFF9b9+0o1iuo9VG1hktmFV+Br4Xf5VQCEeIZUrora4l6US6ktOGf
	 XwmzqGHuWR5MvMcEsvrAU9x3p/mj21+2RUmsdiHf15gqDJxJqoxuKqf8bXVI0HpEC7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o49NzHcI;
	arc=none smtp.remote-ip=95.215.58.127
Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781060A2610
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 02:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D781060A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o49NzHcI
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PzuoZhu6Eoqymm75/Wmyv8NSmRksFQncwoKiOhcjjSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795313962; v=1; x=1795918762;
 b=o49NzHcIuYrHBiqUa6MPObB/lrTows3AchSB1TpnRURF+R5m9FeY+KaVWJtrNVkhhIAi4F+6
 0JC9m1N0ttL3h0tGQ/yv0RrrpAl3V8cwCg9XpF4HaSTiwGyNL57KrIcLtLlDdLIyjwn5zsMffl2
 H9p3T/9lGB4XW+xaQW2+GSFo=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 44227067b1cb5981;
	Sun, 22 Nov 2026 02:19:18 +0000
X-Mizu-Trace-ID: 44227067b1cb5981
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
Subject: [PATCH v16 16/19] HID: asus: document ROG XG Mobile sysfs attributes
Date: Sun, 22 Nov 2026 02:18:45 +0000
Message-ID: <20261122021849.57863-17-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122021849.57863-1-denis.benato@linux.dev>
References: <20261122021849.57863-1-denis.benato@linux.dev>
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

