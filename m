Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380206;
	b=bzWUQUzL2xVXet/yFM62iIsbL1za+5ZgZTNVfu7KA3pdHc7ea1mQ/+BuU1sJAA+03obG
	 kg7bREp1B4Os9vnLNPI5+gwjr2VTb7G1rOQ7WGwBdENb9ImeyfHg15q87Fr20yeSwywq6
	 k4js0xjh6LFbH4WJibdBhIX4ba9Z02pokVU4gL4/qYukd/L8rtRKJ8ZsVzpEW0kmgmfAU
	 e1/1H+vOl5BfIg0qed1P5Lrj8yY4E/l9eH6E+j1P1SSToqpfkdvSwhTnUe5kFRLVVi/wC
	 3TMrDHrR/ov6y7Hn9AMoMGECyIVTBs6Tj3A0P+0Oqdv2ZVk1wKtz8HRBARPIwSzxxXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tRiGUdZDbUH6e6UAZLEy4irsPtafHp9cuwISJdPL7/4=;
	b=dA2X79iThOtVIniOvaw57IKJTSQDlWIIQfU4WuWTe1W5RwROK6E0NILbtvO5+mE9xPn6
	 oyr/bNSSgWmS0bMW9v4qdSqDGPvMRUonJEz6ZD4bSqKWkxwKWK7qyIQxLsQlc0dNJoA4H
	 +4z2N21UxZg4loXws47Epr4695MZkFAP2e1NRGjh2VIYp4C6ynUR/3J8gxmnayf5Rrdn3
	 w9QtBgKakHTkl34Ptk+uzjc4vaiAxTPVghKpT8j7GbeOjIAeftIahFYty5ujGlUYw+urO
	 NC/3yC2WwJpldyUwkTmcUjfqRkdmxnmpuvxEhYITfW1hTEbo99DvcnH5fWzPBDp18yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzCsqm0O;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DCB60A6F76
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DCB60A6F76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzCsqm0O
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5872662eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380205; x=1794985005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRiGUdZDbUH6e6UAZLEy4irsPtafHp9cuwISJdPL7/4=;
        b=qzCsqm0Ov4zq78nTlrvSlkNvKa1AjVMSX2+8EyVkC9mifpb7lSSzD3zuTciPyYlYQT
         Up2WEpjuwqCeFQ2dGCRM1bD9/f+vyN50TbAebx6MZOgoxMR0EZNy33Xqz8tSow3BLza0
         NLgsIcPrviyQTei0d0br81aMWiM9i15C2LAaSXj2cnBksbeualEO4CHE+k8eEr/rsDpt
         8LqO7tSwGeTtIz1Ele+GAxDTmKwjs956NgzZCXBQFuKieKiWjowMJyE4Ds7zFLhUnjhf
         8RMhhfAyXNVeoSq+Jt1xWNeT/Hoa5qAQMyMDsEjRkLhjZG3eG0dlvJs6QIzwqPZSUWcg
         LbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380205; x=1794985005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRiGUdZDbUH6e6UAZLEy4irsPtafHp9cuwISJdPL7/4=;
        b=uoT5UuWFF2IZ7I7xlRAdh+OvFv51EFMEKbSOZz87Nl0vgIzGE3m2oTDMguLFzqo+Te
         M2z015lG8PDR9/NV86E3WgkR2oE2ZODrgQrisHcW5OebMTU/c9TzqNibUdgNZ/YVsEDu
         arESPqaN7qdNz0at+Zk7RAUokCru0YmbOb2MakV78Ng/ez/VjT2198MT8AhdEy8fgE+8
         VkFC6Ws/qZxxQFjzc8qkvh8OP4LHXeczFnHkNwsyVTS+WHiig4BrU0rvK6VGAzs0eepZ
         se7vz93/Q2pB1vVeOkln/KxvRY7nxPc/rClVzjMoeMe35UnIpF4mIo2ygU+7brJAPSvP
         Qwow==
X-Forwarded-Encrypted: i=1; AL+hErHrIPxlmvQWu63AHKrWZFkMJLZBQEWX+2TWHWKGqjAoxrJskQAQqUxq8SAOh50xJwAXn4gNgG9YScHTaQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8fJDotRGIRknLco8JtT/0sTbe4edSadZMp9Yndu1ozPgv6Vhd0
	cEmWHQWChAmp2cP5rfdIe1zovuhVeHvDQBy3pH7EqWZ6KaMsiImtbonB
X-Gm-Gg: AYBFou2R6ymVo/Iqb8towzHceu13/FeOe1K3tIbpWogzq6L0qlOGipFju5vKAfkDi4E
	iP++GW/TI5BLaCkEo8MyCtAxYfLaTwyzpiv6VE4YS0dSgpwTZllAriooJLhqMlQwgdPy+wGVYwS
	TMwH2I4RQjJl642NvQ6lHo8fEP7SbhARtgUUOt6HVPll5tqMJlY9b0mhTNyP0GH2mbPiQ/IE0Tp
	PN9eeKIOUz8qUuyedEKZeOBKDiYYXyoISYZUWvgSTpjXHzypkIrHm3C3qWufQJJlE69DJJBqHBE
	+iR2y75OFiBG3b2jPGtWPn46mes5+MVqn19RBcwd9wfxKVf9m7oE9VQBt+irLAA4i4+yufu0NWK
	w00UKmPQtS5AxmM9TNHAmE946kns6wzpDlC7E9utPLoCMUZ42oxq/JDDdjWZMJtURR5W1XS6cTX
	J34/rrbHxiVXFBSw0HItf50TxYLrtYEWZ3S6G1kbWRG+4PT/A+zZVZIFnOpXTK4P1oAIk6WHi0O
	KxBpXn7gXG5aQobx3hS3Ocra0vZm9NJ61XoW6V+LxhjwpTvmJQx9NWH2Zyc3lfpLkYNNCkR+Frp
	mFGZPOA1SbvDImLib08di1Y/bKKXbYx8AJSiNU8CxL5mmj/u8+bc0LG72cLALWpC7gRAa4EGcr3
	dkw/OGoAt7LS7HB8Ahg==
X-Received: by 2002:a05:7023:a47:10b0:1b3:b67e:9fcf with SMTP id a92af1059eb24-1b3c03108bcmr1532997c88.17.1794380204475;
        Tue, 10 Nov 2026 22:56:44 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:43 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:12 -0800
Subject: [PATCH v2 14/33] HID: logitech-hidpp: expose charge_type property
 for battery voltage feature
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-14-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Commit be281368f297 ("hid-logitech-hidpp: read battery voltage from newer
devices") added support for the 0x1001 battery voltage feature, populated
battery->charge_type, and handled POWER_SUPPLY_PROP_CHARGE_TYPE in
hidpp_battery_get_property(). However, it did not add a placeholder slot
in hidpp_battery_props[] or register POWER_SUPPLY_PROP_CHARGE_TYPE in
hidpp_initialize_battery() when HIDPP_CAPABILITY_BATTERY_VOLTAGE is set.
Consequently, the charge_type attribute was never exposed via sysfs.
Furthermore, hidpp20_battery_voltage_event() only checked whether voltage
or status changed before updating cached battery values and notifying
user space, ignoring changes in level and charge_type.

Add a placeholder slot to hidpp_battery_props[], update the fixed
property count in hidpp_initialize_battery(), append
POWER_SUPPLY_PROP_CHARGE_TYPE when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set, and include level and charge_type in the change detection condition
in hidpp20_battery_voltage_event().

Fixes: be281368f297 ("hid-logitech-hidpp: read battery voltage from newer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index cdeb1b3c2f21..fb9ad4cfc583 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1553,7 +1553,10 @@ static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
 
 	hidpp->battery.online = status != POWER_SUPPLY_STATUS_NOT_CHARGING;
 
-	if (voltage != hidpp->battery.voltage || status != hidpp->battery.status) {
+	if (voltage != hidpp->battery.voltage ||
+	    status != hidpp->battery.status ||
+	    level != hidpp->battery.level ||
+	    charge_type != hidpp->battery.charge_type) {
 		hidpp->battery.voltage = voltage;
 		hidpp->battery.capacity = hidpp20_map_battery_capacity(hidpp->hid_dev,
 								       voltage);
@@ -1795,6 +1798,7 @@ static enum power_supply_property hidpp_battery_props[] = {
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
 	0, /* placeholder for POWER_SUPPLY_PROP_VOLTAGE_NOW, */
+	0, /* placeholder for POWER_SUPPLY_PROP_CHARGE_TYPE, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -4398,7 +4402,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (!battery_props)
 		return -ENOMEM;
 
-	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 3;
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 4;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE ||
 	    hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE ||
@@ -4416,6 +4420,10 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 			POWER_SUPPLY_PROP_VOLTAGE_NOW;
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		battery_props[num_battery_props++] =
+				POWER_SUPPLY_PROP_CHARGE_TYPE;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;

-- 
2.56.0.542.g3ef89b7020-goog

