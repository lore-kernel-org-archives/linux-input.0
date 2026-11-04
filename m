Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756496;
	b=f4xvjQGMU58ucFTFm79z1/XWExlMUw0k2YpglrlDfThtccfCoLZ1g4J4lfoYnJgEA0j+
	 RQ0JCALMV77cmrQDm8yvicXfIbvnT5GJ1Ckcu2+8US5aybLEol8VfA0Lpnuk90sp3HiyC
	 h8wUZVYnbDA3fqhyQdQnZxXEpzZHOEETT+viGPYGUmcV3XbYENwpAm4AUbQVPKT3lZBlu
	 l4ctIf2fHBHBKEsgzqzGjFo6+mwqnOmi8lHHFR6GEF0ksS9n69gw4F6IwhyOumoJBNjmM
	 V8KnW+44bRA9Y8Q7JFY4sLODKPwP6/BGRlmRVe9uEO4ztK0IxVYErKTBzEasa3nqlzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756496;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5379CRQJx8I15aivicNrF0oYqHlT2w74jNzhiFSUHZA=;
	b=me8WStIZ4oiRrPZhQXGrV268COq7NRbbpNy087actknYi8yMTJaLN7ZVupGmUB96GNIk
	 fjcuxluSlLDhQ4A7+9ZrXr8UNmISXsjcmBLnZ4dImTsyCsDRhFNEbqV1BpYYdju6VPieD
	 00SPo1cTYaTWBSo7vBzAACtuohOJ5EMfdqpcUUc7NnxBQtBzPLSobSC6vkLffIhPxptud
	 iq3LmSyG97KDR75XKy8rnJ88Zj5wfQRHeXGfoje3fi4Ri15vQserLSic1JfDbn8fL+jXC
	 t+BqetM646AyJTK67m38duY1aMDtz6jt8z9vWlBHLuZ0s2dOjVJG8l81/ot7zP0jCmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vDXelbPn;
	arc=none smtp.remote-ip=91.218.175.20
Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE253606D81A
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE253606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vDXelbPn
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PzuoZhu6Eoqymm75/Wmyv8NSmRksFQncwoKiOhcjjSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756493; v=1; x=1794361293;
 b=vDXelbPnSoy8ULyAKuUgNl3sS3ZvslOYhUNpIvDRa4tQlERaH7V3pgsc7wpm1ulBOlkez7TK
 UtjDP6UkEh7rB4vLsrPZtc3HksCB4kye9JxiEYV7AS5ld51dWKLnFL+PlxYv/pfyAdh5lD+8bRF
 SCGQVdAApdyORR+GQ4vIYOXI=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da5024db59c4b2f1;
	Wed, 04 Nov 2026 01:41:33 +0000
X-Mizu-Trace-ID: da5024db59c4b2f1
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
Subject: [PATCH v13 15/18] HID: asus: document ROG XG Mobile sysfs attributes
Date: Wed,  4 Nov 2026 01:39:32 +0000
Message-ID: <20261104013935.512713-16-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104013935.512713-1-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
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

