Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380202;
	b=ZUi00fNDtvz6hZ3qbf/GAh1H1D3JIuBlajz9qCFtV2OKsBZBW5tDX9jvezy77Qd0M+1E
	 ujeydZxjsZHMWUCFol88nVTSl+NtGMqMMDUjI3m6sxqznLy1XluV6BaueXP0g/rhLFFsz
	 ZAUJNJJkvc8rIgqxk7g2IMaqPqWe7YafHgIIIUuk8WPoDmTJKT+hFEtOqD6ZJqShVxtQo
	 CTnecODvxu4VSiPcyrPjq7Za3sYQrnE06LhPOBYSgKh9fN51/JwqYL9vPD5Ulfg1RjoyL
	 wc2SQuNDuoQpmU9+MVyJOjkBOxN3V5ug6iYiYR+bD9R87Fyaq9lCmFZIRaVZPH4fKWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1Yt98aftbzappM4NZjAdKvDjSZighEgA8WJl219P+eE=;
	b=UWGM9gvATuUO4WNf+6Puv3j0HvSynSm7SELXQP+E5I5/JhIhorTe2A4TTWjOSvlJJ8Wi
	 SpDm+Z38VXw2V0tWIcAWyI0JGoi+WulKHaThKkmDC7tdPKa6wC4dJOmuka6v3eOhmzyWv
	 Xe4MeFgt5oCWQ0erdOIFatnVnPGoSzSafaoi/3zpz25ruLVRcUb2jryqiTPwpXoOkxlnm
	 9ZBJzo0D+hpeh7hyFaN3U6UYlcbw0SHAhw+KVzG/QbTac0x5B8QefjwHFtJRqn2/AjMvD
	 MVxWhs4qBfGjjhU55Kqg0LaDytemOxrrq5mcxqsE1pCCgewEFh5PvhKAj2Cmd8Ybq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPl5TzAq;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17660A261F
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED17660A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPl5TzAq
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f8cdd30beso4812174eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380201; x=1794985001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Yt98aftbzappM4NZjAdKvDjSZighEgA8WJl219P+eE=;
        b=zPl5TzAqaAandcmyf93fMP/SKnmJFwqHEkWQEndip5DNWbt/eDobWVihWYuECbfMxA
         oR1/YK5tWXzWXDZMBqOsQ+F6VpVljf0ycYIC0hHiJPc9xGsyQCSmD8JBM9eaHfAKfWyP
         G1/ia4qD8Vjn6iogDMfSMOtalQjXpsW+Nmu+cfVaxey5h3y3cC2oKgfk8UYMArcSDIgE
         zEsPsfhBEfrrB/jKQQU/DmPDsVKkigtr+Irbw+jVJ1jDa4Y09dFhNzN/rbFC3wQ1ouX2
         eeHEikZkG4N6kebZuq7LFrMMmgyPVIslYG1xvjgK2xLlvgbGRJr0gyx6KgvFkz8tXxtB
         4LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380201; x=1794985001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Yt98aftbzappM4NZjAdKvDjSZighEgA8WJl219P+eE=;
        b=T2WPhtC+mseS5xsQHsMOBdCkD6TUMUnAwuwhp3ehaZY3FpXRi+aYmU3n9PJcpeJIbS
         YlhFuDBDDJJAdsGpWLwBGNVLXPdwAm/RUzDWswmG5rmjN7m0npP3YZXVi5iJOVl+OILU
         FYcLvVJrkXzmHDrMLwEbQVS9VA+zhzYvXhw4wjFd5lt4Arg1NPbXfh3wxpzDC0qDKRx4
         tRIVYpgVU8Qa1Op0hc1BTL9WmpLvLnUsipUVzYmWWWItrH7owC6j6deJ5WzAX/aLVQ3t
         hdvehjak/T8/3DiwLXHWBipcOtu4bR5DkE+Zv5d8jaGSmYHu7dtHbw7+DMSU4Tb/D/z2
         /3aA==
X-Forwarded-Encrypted: i=1; AL+hErFS9mNfHJ4+u7GvTxb7k/PxL/NSL34ObLCRL18HGyZO9R2qqxyEeMWh3vkY7OEOQHipaSOy43I8X+YKVQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zmftaaMoL0pv40V2zJsQjK7zHXfy3D0r17qAFqRh3E3riQIbL
	H391Ld5Dx0fapVnS2G48HurCNUeZxQ9SPOawt3xYD8y/CYYc6MDHAdRo
X-Gm-Gg: AYBFou043BupoobJjcEjhd2lD2sYlJPcsiMu4NrOiqyaXQ6Q5VUGLoD3jbmkFIckBs8
	NGguPRLd46F4mLoLjVYHcdguQ7YtLZ8fYynzz/N8JstBENcwtoPjdgIAm33MPqpVWjzcl608ppP
	3Lg6sjWtPc6QGMUpXh5jg8jhLBqv1GLHQmMiy9E1/Sl2ProeK+IiySTiLOM5Zd33tL1V2xFzfdv
	dfR5HPtgGd1Gz3lMCTXg2Y8nbz9CN1vsUfrEUHrFAmGN4Yjm3D31zDxI2SUnIoh+aasvuY3EH6z
	6adcRC5IetKIjxB0pP8T6dYsyp+r/IGhNb3E6SKp3qZ1NBoIypcRmzElzoVt5Zq5i3SSgkDfdUQ
	1wEVMJIUi+u3i5HBDL+SgGu2i33+MZ0xolSrw3x5GwXOp2hlx+frg3tmMotBMChexX2N+OZOxs1
	j5uvefnosGute7Q1xREHRZvAObbMFzn2HJFCmQknf7uwLGDkwqcS8Dc2GSC6TIWy3h3femG6HH/
	rIY+7NhEW2JZRFA56JD/a3KkTf9CIGX/b277siQGqiLJ9sSZIpHNuEIR30NLqd1WUpVoO7fpt6P
	Ny+u/MqQCt0yM+EKSzdZR4kfRll6eBKHJgs089yYbKyTmyqGOPFHzQLT9fFuInaQtVEkCR0ig1t
	mna9q6f8KJQYC2ZWoJ6ZdPAo2/E2l0WPYCzYeeE0=
X-Received: by 2002:a05:7022:1e08:b0:1ab:aaf3:389d with SMTP id a92af1059eb24-1b3c023c0d1mr1325386c88.1.1794380201027;
        Tue, 10 Nov 2026 22:56:41 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:40 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:10 -0800
Subject: [PATCH v2 12/33] HID: logitech-hidpp: mark device online on
 unified battery 0x1004 events
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
Message-Id: <20261110-hid-logitech-hidpp-v2-12-30743e91d83b@gmail.com>
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

When a wireless device disconnects, its battery state is marked offline.
However, when the device reconnects and sends an unsolicited unified
battery status event (feature 0x1004), hidpp20_battery_event_1004()
never updated hidpp->battery.online to true and did not include the
online state in the changed check.

As a result, sysfs POWER_SUPPLY_PROP_ONLINE stayed 0, power supply
listeners were not notified of the online transition, and the 0 to 1
online transition check in hidpp_raw_hidpp_event() failed to schedule
reset_hi_res_work to reconfigure high-resolution scrolling on reconnect.

Include !hidpp->battery.online in the changed check and mark
hidpp->battery.online true when receiving a 0x1004 status event.

Fixes: e037acf0b1ae ("HID: logitech-hidpp: add support for Unified Battery (1004) feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 28402baf04fb..f717f0308454 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1761,12 +1761,15 @@ static int hidpp20_battery_event_1004(struct hidpp_device *hidpp,
 	status = hidpp20_unifiedbattery_map_status(hidpp, params[2], params[3]);
 	level = hidpp20_unifiedbattery_map_level(hidpp, params[1]);
 
-	changed = status != hidpp->battery.status ||
+	changed = !hidpp->battery.online ||
+		  status != hidpp->battery.status ||
 		  (state_of_charge != hidpp->battery.capacity &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE) ||
 		  (level != hidpp->battery.level &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS);
 
+	hidpp->battery.online = true;
+
 	if (changed) {
 		hidpp->battery.capacity = state_of_charge;
 		hidpp->battery.status = status;

-- 
2.56.0.542.g3ef89b7020-goog

