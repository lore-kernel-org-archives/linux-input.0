Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204691;
	b=tmBKlJBfujiSMkf7xnhmluRchnkPZVjd2mE4S9eEaNS1wnNCpxStgpaE2r4OuKaxZlN/
	 1EPnuorPaec7Dv0ktrzX06QHSHutHYPN3JmEQKUZmfvE44g2VllewtKnGGP3L4RfpPCoF
	 jWwLGXjYep93FvC2onKB4b5idKFsSy3/GfbCf2Q9AnyGRYMX/2ORRlcBrG450FUr8lTpo
	 1end5BOlgrdZZwxbdqtzYpGd9aQMl/45CHaEuJ131CMTT3wcUgBplf4BXB9990W6sY8Wm
	 7DKGwTA4oN6Z8P02XF2f74skpRJJIkfB+0MTupfhEkrlASSejIK38ssk3X0OwFR7fGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qGxoDwXtI5s4aPxzK7UBEGdxPrnksTKaa/8jWSRqto4=;
	b=1kBLJ1KU3jooi467vPT+O+6Pk0vHbc3/HIID3S63DO+ZTMrlWskE0iTR7r/d+Jmf9hh/
	 4UrUpoeYCJ4ZBwPsbbgRMvRihDHuah0OoLZ/73YN5B2WFVwtaWd9wSpzU2nEaenzo24e5
	 MU4Bc8puGzqVpE/oTEEnIuh/kv40v3CG0NspnvOCeCKd/marVfjglk67AJcLRFzRVmhv7
	 ghuP86m5HBiwrUVlS59lD2fjtNWHkqvg7P101sq5KhG9k4XYFLyuWcYlcUPWmb4w6hOGc
	 nKHwlt0vjCRSkKVt4m/LMEpKNkFrzqZxWIeYKnUG+oaQA+/gCW31RnlEB9Vvhgf+CTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l0730psI;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF44606EE91
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF44606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l0730psI
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1297215eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204689; x=1794809489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGxoDwXtI5s4aPxzK7UBEGdxPrnksTKaa/8jWSRqto4=;
        b=l0730psIBA+rgAiCstbBKk7dreIcCR1GNcMtMDZIoxQm79yG6U9FpaDAw+h6UqL1a4
         3+cg5FsgdaFZSUSomr5IUDBrNqBPuOLExu57XiJpqAvYyAS49VATWIQ6ZANsA4bUM61s
         YmD5okjOt+naB1CTuN/3rcvyVMpZMRNyFkd1S5X6Q4Y3Jbsa2Fhhb/11f9aZH66OjfxV
         N1meJKECqRnOGIni7xZ0LFWLswQwV4Z+4jH5kG0VLSiL3xQ3AEjedZ4oG4P8wIol5faX
         PPU8RlLqbqe2pl19f+5vlBdym2n+8CLR6m3miQ/8J/v7q3ZDkI3aqlzo94E7kCEtlIfy
         vBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204689; x=1794809489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGxoDwXtI5s4aPxzK7UBEGdxPrnksTKaa/8jWSRqto4=;
        b=F1YyzLt89sLIlR4uZJYKgxenKLEe+jcery52lOAUqn3RgsGQVeLGUjfVWa3N51ByAH
         u30mqBBbmzCu8Doavr5wLH0rXPg/VaiAYbpnYRUUwBlSAaLVZ/NG8r03bItc8y5+Ng4W
         tZ2ABZS+nxsQCqefyA8JUG9nqUfHi394HCcZsxwChidYz5f8Zp8n6j9QFE2IH2cxKlNI
         VE4hFpj6to5lOHztlN3x9T2JfDeTAQm7tBio+kh9UtMpYv/ZULtPWE9N1QkJWSrHGUk4
         KzxxTrKOk6RYh3+1GktkGWJwcqTSW5tQ017obR4bunGOAcZudY4uO8hy1Cgk9Vl5nmD1
         DfoQ==
X-Forwarded-Encrypted: i=1; AL+hErE9Ipw+IDKnxd6T8iXSajgp2M2wL9HlWSh3hKON8v9i0nqyihsBOt0hpu/govYnhg9GQKp6/2YWlzFmEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/NZeDjTd+IOXt7bNZGVy8ud4vVY3fXFHNltj26BBo76TKb0inM
	AnmpIssrLTI/fAq6GNMGgUkXUFGji5Z3lp9hE6xUTisZEk/P0B0tuUH1
X-Gm-Gg: AYBFou2ZV8I0RzBdgUIz4MnSSBaoxEBf+kzUwQReyyxz4yugQQ30cogHUUPVS/NAasL
	C9IS2w2P/YB/yqkYE7mubtDU2oxkW3qgFkaJVFYdeVz+u134FjHLYlvUobO0ir4L14GYQabKCc6
	XzBa6Ud3MUBxbDb662tXRgS4BfHHpyUmtwVr20BKoLhizY5b3i6773TUVFIC8sDjwUVpx26N1pF
	CQYHOL4PO+mYBBlnwClnxJ5l6+TTq6ezPvELLZvyejBVob6ZZJl/uvMMj8TftC3BlI9rLBIjlaW
	r3N3a/XMMGd/LXrhF0oWvbbm1OOTNKMGnQutlpgKp31CJqLHrCNArNS2r+oS8JqaUwdUPJ63woA
	TrNZfvZxVRjTcK9mVWxQ5RtKqEFmewZGNTNMXbWdwb0TMJ2DCrUMiAcoWRdUEhzmEqn0ipfaLky
	6r2xniU9rww6N/PDnOaj6VcNKQkREeYYQZD5BwW553oMDlszABQ+bQAiJ13jKO9eqXC3e7uADWT
	/+zyE/3Ja7agKNKuhSxc6oqAQdhqU7j0FitCiI+x4xcRIMF4CmUXzuQlvap/kl4D0/GxLCkQJpn
	KxW1cYo/qaJ0txFTuBrriscTG1BqlWNVx406eDvO8VWse6awf1a7ZmYewe4CWw00hLa8RNKTF5q
	kmfV/lvMAluVdCs9P
X-Received: by 2002:a05:7301:1285:b0:343:9eb1:9940 with SMTP id 5a478bee46e88-3725e33de65mr8596467eec.26.1794204689085;
        Sun, 08 Nov 2026 22:11:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:28 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] HID: logitech-hidpp: store device serial as a byte array
Date: Sun,  8 Nov 2026 22:10:57 -0800
Message-ID: <20261109061103.2887636-14-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Device serial numbers are read from 4-byte protocol payloads only to be
formatted as raw byte sequences with %4phD. Storing them as u32 requires
unaligned pointer casts and dereferences that depend on endian-neutral
memory layout, and the FAP-based serial helper reads from the RAP union
member instead of the matching FAP payload.

Represent device serial numbers as 4-byte arrays, copy the payload bytes
with a fixed serial length constant, and read the FAP device information
response from the FAP payload directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c4ebfc4d66fe..3a3baeb9fbb9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -48,6 +48,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_REPORT_SHORT_LENGTH		7
 #define HIDPP_REPORT_LONG_LENGTH		20
 #define HIDPP_REPORT_VERY_LONG_MAX_LENGTH	64
+#define HIDPP_SERIAL_LENGTH			4
 
 #define HIDPP_REPORT_SHORT_SUPPORTED		BIT(0)
 #define HIDPP_REPORT_LONG_SUPPORTED		BIT(1)
@@ -889,7 +890,8 @@ static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev)
 	return name;
 }
 
-static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, u32 *serial)
+static int hidpp_unifying_get_serial(struct hidpp_device *hidpp,
+				     u8 serial[HIDPP_SERIAL_LENGTH])
 {
 	struct hidpp_report response;
 	int ret;
@@ -903,11 +905,7 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, u32 *serial)
 	if (ret)
 		return ret;
 
-	/*
-	 * We don't care about LE or BE, we will output it as a string
-	 * with %4phD, so we need to keep the order.
-	 */
-	*serial = *((u32 *)&response.rap.params[1]);
+	memcpy(serial, &response.rap.params[1], HIDPP_SERIAL_LENGTH);
 	return 0;
 }
 
@@ -915,14 +913,14 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
 	const char *name;
-	u32 serial;
+	u8 serial[HIDPP_SERIAL_LENGTH];
 	int ret;
 
-	ret = hidpp_unifying_get_serial(hidpp, &serial);
+	ret = hidpp_unifying_get_serial(hidpp, serial);
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -1030,7 +1028,8 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 
 #define CMD_GET_DEVICE_INFO				0x00
 
-static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
+static int hidpp_get_serial(struct hidpp_device *hidpp,
+			    u8 serial[HIDPP_SERIAL_LENGTH])
 {
 	struct hidpp_report response;
 	u8 feature_index;
@@ -1047,22 +1046,21 @@ static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
 	if (ret)
 		return ret;
 
-	/* See hidpp_unifying_get_serial() */
-	*serial = *((u32 *)&response.rap.params[1]);
+	memcpy(serial, &response.fap.params[1], HIDPP_SERIAL_LENGTH);
 	return 0;
 }
 
 static int hidpp_serial_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
-	u32 serial;
+	u8 serial[HIDPP_SERIAL_LENGTH];
 	int ret;
 
-	ret = hidpp_get_serial(hidpp, &serial);
+	ret = hidpp_get_serial(hidpp, serial);
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", serial);
 	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
 
 	return 0;
-- 
2.56.0.506.g506a7eabc5-goog

