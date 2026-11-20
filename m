Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164080;
	b=pP54hq4BfY9Uk9wklLue49mFb+p1gT7q2qovQoJ9YL0TtzKxlBoX0/9zcWStHM1PQdME
	 HibC59fxsbTO5s/TLkmXuHwh1Ks/3XT1Ys4sp4AqOehEZZPZr3hJT2F9LiW5frphq4xtr
	 EE/KIrkkfFIO/8giki+NAzEK/+aD1ucThc+53k8kSw1RdR+GFAOh/TDsS0Wc8ID40ouuF
	 OFZiXGDtBzl0OWY/ndi8a4maadiIFEdsBZF1PN+x04v+JOPx5vcvNotv1OrhhmuANcJON
	 reCuSRYFNTNU0BSnO1oiEArJ26Vk49/2dn4PQXxmMqd2+D37hAcoptocDDoy/gFvv7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=B3S7G7b9bye8TH3pDQ6FGxRtNzK8TEwIHow/DDgOdOU=;
	b=mliiWcc8MbiKPsc1aYnG3nWGqF5asZYH6ArbhwR0NC8LHHoFJxVT3/Ho6ibNdvV5bizL
	 CQs/Ts+UCuPDo+qttUC9QO3uxmY8EmNrGQ+BCxgAMGrhd8ZE8EbrAr1aj0zEkcoKbS7Zb
	 udcVL0QLz41joAbED+usSBf6pzaO0ok2Da82nV4j6NAYIVTTfBl1bNVF86QnHj4f3SzoC
	 GsKBTUIZu+h5E5lLfBU+o2jRG9aekTvKx8RYsTYdqcOlVm0aTRUY0upiyAxrJSW+D374y
	 XYpmp7+DrPl4QyIqjDcs5LXqFdIoj4gehfW4oq9GE1or4CRlI5/4+fG+aN9C+tFrj3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okn6srFl;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949A60A2629
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B949A60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okn6srFl
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38587f3de36so709807eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164079; x=1795768879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3S7G7b9bye8TH3pDQ6FGxRtNzK8TEwIHow/DDgOdOU=;
        b=okn6srFlkBXzTrb8uFg8Vx6Xl4YtwxPNpldaWNYmjndNTscTMmdlFfzchYc7kU5ms4
         DgGqbDtgYS+D3Wvp8sYZ088ENqY1DRJ8ummDicwi5+SQQlVUQYwqZA3dcRnHNAfi21iF
         X0Dtd3kwKZHPltw2BZlD+sOoHR5Mpo8EfhK45EWoYxRzxR9/YCdpR4ZrEaeQKQhOKuxC
         4j4gH/37z6fo5eConjfUkbMa4W37bjUwmjc3wLlSmmtq8/7hpZ/+Vfe9ICBg8o0XOwbp
         TqHfiS1X/oIM5hZpV4eYW7g+6D9NMIfYqIYNdr6iQ+LZbCGqWST18TGjIslO48oKTzpl
         d9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164079; x=1795768879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3S7G7b9bye8TH3pDQ6FGxRtNzK8TEwIHow/DDgOdOU=;
        b=wHzvlGl1hl4YdhAZw38aISLTGsw/jPvwnAYesWtPoSs8eZ7rCa38oSUBzxtf/Q9iT/
         yfB4oM/+P7AWFSkfyOecohlCMV6M0bBP1D6N0nDB0qy+Xfo5m9zP6X40JM9FnCw43XjN
         JF6xUfhVav+juYdsikPob9l/FO+O/hRATsFyyERoLe0Ha9KrhKDwQwYb60AJmm092qne
         OuZ0hphQY1K75ElxFj3occfai9s2Cah4DBE1zRo/HCS7cpjo2374eGSomicVaTmoilL0
         PuBgPh/4xYskKqUhu4MxOvOk6hZiThLbrn4t5cdhYi1OWlYGLM0+e+7of7hzfvfuGUVU
         2Fsw==
X-Forwarded-Encrypted: i=1; AL+hErHDEbwD3aKP8h0G3XMgPuR78u5b9Dx1Hz7Xd6lVaJyLr9kKmXUonSfyHrHVlN89lnNMyeM+/AFp7vQ8Fg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9aNoih0J47hS1KAkVaueiKo96OuQf4AfE9IBJCEVnQiDownwTh
	LSLnjJQ2dcvJpL1h43WD2IyGm4i5j51Vf5m77SjfQHyJcipzD9jmA0uB
X-Gm-Gg: AZFdTZddTYXMztB304CN3AAvu0d/+PI/mFV4v7qxHl26VKlpokGbvmndCz6wpl7ZelB
	bUuxsjvCt3ckFW7Us+WH7osJ86Uy6d8gcDP3m5fww2OctIVtsB7MaspSV3sI5Sno6lgKwa7Kw3F
	Ot10NA999895B+RyT140jwb/Bqy0TkNmAIXLTS2Jw+M2EhJNaE5gxxCYzH75Y5ipn4RY2+5HvaQ
	pD/nlyAKEsr2kRCLhiOISRXvfe+avPFjOCQ0UKQpot0cgWrdWApaTzcH9RE8i3WAcQRJzTYWJRF
	rWPeGfzGFJMn78bvFgnPCzPbHpL7SvyZdq07HT3dFEw7Ew3HnHW9EFPE5Pwg51j6IYd9f5y+ORc
	Hp+mjs3Q+8A/zoqyxTgTXyZclJsSNjbNhakZknn6a+j/HrB1QSie0Q6mLoBhJybkSyWNW6gIRf4
	D3ww3CWf45LkkECYPmt8wqYVf+eNgQ0Kw/cCO0Jo1X5jCA1HcXuXTfjssXyxO5z7M+zaj2i/0ob
	4c27nGNNdAiThkP9AXJYIwhViCTevsQEYugxnt+rTdov3l6gj/irMqOJu+czw/E42jyHZHneFBJ
	zW2aljhEY3EEUMvYjkfr3nt2Ii0qmoTrl+jrnMlEZy5b8+AjWIB0iW6w5ywNEJVRXIh+RL/qmxv
	oTo0dXMBvhEVo/JdI3A==
X-Received: by 2002:a05:7301:6285:b0:369:f182:8e99 with SMTP id 5a478bee46e88-38570554684mr2335097eec.35.1795164078916;
        Fri, 20 Nov 2026 00:41:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:18 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:41:02 -0800
Subject: [PATCH v3 14/14] HID: logitech-hidpp: expose charge_type property
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
Message-Id: <20261120-hid-logitech-hidpp-v3-14-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Commit be281368f297 ("hid-logitech-hidpp: read battery voltage from
newer devices") added support for the 0x1001 battery voltage feature,
populated battery->charge_type, and handled POWER_SUPPLY_PROP_CHARGE_TYPE
in hidpp_battery_get_property(). However, it did not add a placeholder
slot in hidpp_battery_props[] or register POWER_SUPPLY_PROP_CHARGE_TYPE
in hidpp_initialize_battery() when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set. Consequently, the charge_type attribute was never exposed via
sysfs. Furthermore, hidpp20_battery_voltage_event() only checked
whether voltage or status changed before updating cached battery values
and notifying user space, ignoring changes in level and charge_type.

Additionally, hidpp20_battery_map_status_voltage() unconditionally set
charge_type to standard (or fast/trickle) charging even when the device
was discharging, full, not charging, or in an unknown status, and
hidpp_connect_event() left charge_type stale on wireless disconnect.

Add a placeholder slot to hidpp_battery_props[], update the fixed
property count in hidpp_initialize_battery(), append
POWER_SUPPLY_PROP_CHARGE_TYPE when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set, and include level and charge_type in the change detection condition
in hidpp20_battery_voltage_event(). In
hidpp20_battery_map_status_voltage(), map charge_type to unknown when
status is unknown, to none when discharging, full, or not charging, and
to standard, fast, or trickle only when charging. Reset charge_type to
unknown on wireless disconnect in hidpp_connect_event().

Fixes: be281368f297 ("hid-logitech-hidpp: read battery voltage from newer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index dbf8f15f5a5b..966c5932528d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1428,12 +1428,17 @@ static int hidpp20_battery_map_status_voltage(u8 data[3], int *voltage,
 	else
 		status = POWER_SUPPLY_STATUS_DISCHARGING;
 
-	*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
-	if (test_bit(3, &flags)) {
-		*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
-	}
-	if (test_bit(4, &flags)) {
-		*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+	if (status == POWER_SUPPLY_STATUS_CHARGING) {
+		if (test_bit(4, &flags))
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		else if (test_bit(3, &flags))
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		else
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+	} else if (status == POWER_SUPPLY_STATUS_UNKNOWN) {
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	} else {
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_NONE;
 	}
 	if (test_bit(5, &flags)) {
 		*level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
@@ -1553,7 +1558,10 @@ static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
 
 	hidpp->battery.online = status != POWER_SUPPLY_STATUS_NOT_CHARGING;
 
-	if (voltage != hidpp->battery.voltage || status != hidpp->battery.status) {
+	if (voltage != hidpp->battery.voltage ||
+	    status != hidpp->battery.status ||
+	    level != hidpp->battery.level ||
+	    charge_type != hidpp->battery.charge_type) {
 		hidpp->battery.voltage = voltage;
 		hidpp->battery.capacity = hidpp20_map_battery_capacity(hidpp->hid_dev,
 								       voltage);
@@ -1795,6 +1803,7 @@ static enum power_supply_property hidpp_battery_props[] = {
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
 	0, /* placeholder for POWER_SUPPLY_PROP_VOLTAGE_NOW, */
+	0, /* placeholder for POWER_SUPPLY_PROP_CHARGE_TYPE, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -4398,7 +4407,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (!battery_props)
 		return -ENOMEM;
 
-	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 3;
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 4;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE ||
 	    hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE ||
@@ -4416,6 +4425,10 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 			POWER_SUPPLY_PROP_VOLTAGE_NOW;
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		battery_props[num_battery_props++] =
+				POWER_SUPPLY_PROP_CHARGE_TYPE;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;
@@ -4511,6 +4524,7 @@ static void hidpp_connect_event(struct work_struct *work)
 			hidpp->battery.online = false;
 			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;
 			hidpp->battery.level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+			hidpp->battery.charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
 			power_supply_changed(hidpp->battery.ps);
 		}
 		return;

-- 
2.56.1.750.gf70dc682cf-goog

