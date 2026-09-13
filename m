Received: from mail.k7h.de (mail.k7h.de [49.12.72.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5583AD50D
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325979; cv=none; b=meUg5IVqIQDKhlmhzdj46chdBG0tS1pLueJgAjOxOz8Me9nlO6oT/NC/vZlfESlbfqQnHBPD1DdFmq+5AnVsCbKP6jlfc7bnE5e5SSPX1w41WBJZwCmrv5xFduCrymLGwYWs7c08r9mn2buXI5nGvXNXa/JSe7WB8qIWzTw9NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325979; c=relaxed/simple;
	bh=8mHz0Xe2/H/ZYUXkVzqB9niefRhM6qoXJpIoypyaBqk=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=FgHNxrNmsWo9G/U2dA/qNj7p98L38nhiJxaRZzgGpZce+JI40HxiKWIuLkKgCWYu7CPAtk4M7srkMEl6Rsx+49I+ggjPg8NAa5CRtDsADrrcd5QuZYNmWlWPaukuQaGrG2+obg+97aVOtvzsgsJJuSWT8COHtihMCm1uDq4X5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=k7h.de; spf=pass smtp.mailfrom=k7h.de; dkim=pass (2048-bit key) header.d=k7h.de header.i=@k7h.de header.b=UK4qsh7t; arc=none smtp.client-ip=49.12.72.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=k7h.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=k7h.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=k7h.de header.i=@k7h.de header.b="UK4qsh7t"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0C4C61317;
	Sun, 13 Sep 2026 20:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=k7h.de; s=dkim;
	t=1789325469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=8mHz0Xe2/H/ZYUXkVzqB9niefRhM6qoXJpIoypyaBqk=;
	b=UK4qsh7tNLPw5VsiyaIXjM2wU6TBEtx8Pj8IIuq0w5dWJAg2C/EW1mgzNFsVcLJNKJq3Pj
	Bj6Iq/csj56fZ8rxMBHgevucfuKttLhQMkbgYZS3jDR61IKmC7yXM4/un0vXaKK1n9lcgb
	nw6O0HFB/+7X/0P7O2/V0Ar7xwMAxvswrSSES7P7SHvf1Kk6NQ8AjdYy3yX8TeOf2m55E/
	f0ZAh4RFV3SVKF0sL9GSeL4FVBgdDrjVqIVc61zb1Dq8Xus3L8BA3772jFWaLP1dOSqTOu
	mOr1AIafz0pHJkUyTF/gL0z8VWbrd4sqSYwVFWJfaAJJ1x8VIh8vHGi34wv7Ow==
Message-ID: <22c06460-9760-4879-8c24-2106cd0efd5e@k7h.de>
Date: Sun, 13 Sep 2026 20:51:06 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Holger_K=C3=B6nig?= <holger@k7h.de>
Content-Language: en-US
To: linux-input@vger.kernel.org
Cc: lains@riseup.net, hadess@hadess.net
Subject: [BUG] HID: logitech-hidpp: capacity_level stays UNKNOWN after
 charging ends on 0x1000-only devices (MX Master 3)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I am seeing a persistently stale POWER_SUPPLY_PROP_CAPACITY_LEVEL on an
MX Master 3 after a charge cycle ends. The device keeps reporting
capacity_level=Unknown while status is already Discharging, which makes
upower publish battery-level=unknown; desktops render that as an empty
battery and raise a low-battery warning. The state persists indefinitely
until the device reconnects.

Environment
-----------
Kernel:   7.2.5 (CachyOS build), x86_64
upower:   1.91.4
Desktop:  KDE Plasma 6.7.5 / powerdevil 6.7.5 (Wayland)

Device
------
Logitech MX Master 3 via Unifying receiver (046d:c52b), WPID 4082,
HID++ 4.5, FW MPM 19.01.B0015 / BOT 95.01.B0015.

Battery features present (from `solaar show`): only 0x1000 BATTERY STATUS
(V1). No 0x1001 (voltage), no 0x1004 (unified), no 0x1f20 (ADC). The
capability query selects HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS, so sysfs
exposes capacity_level but no capacity attribute.

Symptom
-------
While charging (expected, see analysis):

   /sys/class/power_supply/hidpp_battery_0/status         = Charging
   /sys/class/power_supply/hidpp_battery_0/capacity_level = Unknown
   /sys/class/power_supply/hidpp_battery_0/online         = 0

   HID++ 0x1000 raw (via Solaar): 50%, RECHARGING, next level 0%

After the charger was removed and the mouse was in use again -- this is
the actual bug:

   status         = Discharging
   capacity_level = Unknown          <-- stale
   online         = 1

   HID++ 0x1000 raw (via Solaar): 100%, DISCHARGING, next level 50%

   upower: state: discharging / battery-level: unknown /
           percentage: 50% (should be ignored)

So the device itself reports a perfectly usable (100, 50, discharging)
triple, the driver's status field tracked the transition, but
battery.level was never refreshed and stayed at the UNKNOWN value left
over from the charging phase.

Power-cycling the mouse (switch on the base off/on) triggers
hidpp_connect_event() -> hidpp20_query_battery_info_1000(), which writes
all fields together, and the state becomes correct immediately:

   status = Discharging / capacity_level = Full
   upower: state: fully-charged / battery-level: full / percentage: 100%

Analysis
--------
hidpp20_batterylevel_map_status_capacity() deliberately reports no level
for every state except discharging, which is documented in the comment
and is fine in itself:

     *level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;

     /* When discharging, we can rely on the device reported capacity.
      * For all other states the device reports 0 (unknown).
      */
     switch (data[2]) {
         case 0: /* discharging (in use) */
             status = POWER_SUPPLY_STATUS_DISCHARGING;
             *level = hidpp_map_battery_level(*capacity);
             break;
         case 1: /* recharging */
             status = POWER_SUPPLY_STATUS_CHARGING;
             break;
     ...

For a device with only 0x1000, the only writers of battery.level are
hidpp20_query_battery_info_1000() and hidpp20_battery_event_1000(), and
both assign status, capacity and level together. I therefore cannot
explain the observed Discharging + UNKNOWN pair from reading the code
alone -- it looks like either an update that is only partially applied,
or another writer touching battery.status without battery.level. I did
not manage to pin down the exact path and would rather report the
observation than guess.

One thing that did turn up while grepping for writers, and that looks
like the same class of problem: two event handlers update
battery.status/.capacity (and .voltage) but never battery.level, so
capacity_level can go stale there as well:

   - hidpp20_adc_measurement_event_1f20()
   - hidpp_solar_battery_event()

Neither applies to this device, but both would leave whatever level was
last written in place across a status change.

Impact
------
For userspace this is not cosmetic: upower maps battery-level=unknown to
an unusable value (it publishes 50% flagged "should be ignored"), and
powerdevil turns that into a permanent "battery empty" state plus a
low-battery notification, on a mouse that is at 100%. In the upower
history file the bogus state shows up as repeated

   <timestamp>    0,000    unknown

entries, each correlating with a boot or reconnect.

Reproducer
----------
1. MX Master 3 connected via Unifying receiver, discharging,
    capacity_level sane (e.g. Full).
2. Charge the mouse (USB-C, charger is enough -- it does not have to be
    the same machine). status goes to Charging, capacity_level to Unknown.
3. Unplug and use the mouse.
4. Read status and capacity_level: status returns to Discharging,
    capacity_level stays Unknown indefinitely.
5. Power-cycle the mouse -> capacity_level correct again.

I can reproduce this on demand and am happy to test patches or to
collect hid_dbg/dynamic-debug output from logitech-hidpp-device across
the charge/discharge transition if that would help narrow down which
write path is involved.

Thanks,
Holger

