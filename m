Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C13DA7E0
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937587; cv=none; b=l4Kby6RktbHnIJhF0toByblLneIxOPxjNnYZY9LaHOlzfeiUaAnDdYLCcOFv1AU4brSfsPetWrTIwRGxTtPVaPJ92G+rWcJ2ZOkYQJra7MATxW+XclqdJboGQ8fkb9e9jZelBbjG/sWgqTfVc+sLCzlRZ9YsaU0X+wlywEnapw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937587; c=relaxed/simple;
	bh=/3QoRAqFj62JENv7kB97NSOUDVLhI2ghJtYPN2Ifqkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auB+x82Gajgl1D18G0rn7Yfu1rMz/8ryHhU7er+7r0p/Krdrn4+XrAKicjRFAKBbAw6yYHnSRFA3DlqWMD/dbBTdgjUx6S2vO3lqmi69N9nAS+wO/queTbFHpqahKrOAUqPVoGC37aXxBCoEX6lwvp7yfYkgTsxh2RNvxo5N7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4n+szIk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4n+szIk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso10814835e9.0
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789937583; x=1790542383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsJjBw/Oa5Zb6NlNapTRqTqtkEMm7b5t0BbF/9DxwDk=;
        b=P4n+szIkIV81SzUCnQmUYaOn+QMlQTHK7oklUZ1D6XvgBqmSUtVXZxmWyVc6PmUsGe
         hMqNHfvsbZP3H9ng8tAA1eu1FhWZbhFCm+dTwljxHx+y5t953T2bNexsH9jxZh1kRNns
         XeVq3ZU5WFLBAkRb3oaEYETvBk/M006aAnia+029zcQ4QYkQvceX3gFn6OfH0SN3Cnng
         lP8FdQFVdC/YQiiaypkUwxjW5ufZNTEPp7ceCo3neIy97Za0CgTs0BMjlkyQbdhniDz5
         jOXaErdLTyqj7W664T6mquPf0pDncOn7LB6DdxEpnr+cWQDPxmSSxN4lyuAsgzRko75I
         V1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789937583; x=1790542383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsJjBw/Oa5Zb6NlNapTRqTqtkEMm7b5t0BbF/9DxwDk=;
        b=yI9jdYmtWFY3y+LinlSp/aDrOggR6Y0dFpDW0FUhN/rMUQ/d3nR6AXreAHOpqmRhM7
         Z0MeHO8QUci4OabHRETuBOfz6z1Ld6wBDmNljK6jtLbb6ERGxuXjRhwyw/MahayVFYzV
         2v+1EGPW6kDt6jeblexffH1AdPPFR8GZA+my3XS1Km3l/9WHjz8vPRCjut05fkwtw/g2
         TfJ4XX/mYIVVSGNzOBLCpTTqaMohwy6vJsqKVIcbwJ4jaRzqX1C9kKRtNysaAEV4b92q
         sn/RHoAf6TpYhkH0RxFTY3EO4iGcr13z8FSEAmXQxGHBQrQ7JRwTEZzAiUtOChLeIz0q
         LxrA==
X-Forwarded-Encrypted: i=1; AKwUvBzc3ime/0MBiN6DRVoCXw3hw0NSC7R7D9WwDMpF1dTib8VXMcbVoY+b/E+Hir99cGSBvdyASSbB175wbw==@vger.kernel.org
X-Gm-Message-State: AFuF++lmB84kKxKwwdNOZZtDVpOiNuLD37b79sYl8MSfGu9xueSpkjP1
	8rbUjsitxgljwqzMUdW8LIyO3cgyypEvQlGvgDM8j0K8P7FLin2uXs1K
X-Gm-Gg: AYBFou2nJoGzTClQsLOFisZYw4OYjSGDJ97CX4FdFud4h20Qv3ZY3UOJEUy7qAR9brm
	HVveyRqkuvf95EwC+YTBG6Hc7mAXCdSF9kyfDU1qdALBmk2gUYmjhONF1iWcB72G+Eg5il5CPhI
	tGnT40RAM2G2ETT2cvNm0LVlTIsBtJjW+1xjJei0dbN8bsO3vBx6JWLwJEosOuSYDOLhsD5+h34
	oGcbz+144FO8ckCk+cY0Uww4YSDFuZY4n2uXlAy6fuVHV19d7wJ1R1w6QHDSW5AjMjhleZVClAH
	0H8GO0fBmZtxtwsOO9v040GcoJMKe2B+4zK34fBjHs//TS4wp0xR0J1h9fJ55KBbOVIdpR69NT3
	WHOWHZc9DUTKhxjr3xlW8B7VQ3HqM0GMEQ6K7W8UaGIJXMmzhpMXzVhm63UyVTP+A3v3Up61fDM
	+UNhtkVcuAvL4S9G7XV1SIFhunIorlrnAQZp7Y2qossGRdTTx1LmqQMMql0uAp+Xwev+BDcplPi
	6VajKhraHEDnLpz/t7TMZb8AG0UhvBPT+9PTLMSL9T2
X-Received: by 2002:a05:600c:4ecb:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49fc5754e06mr120485355e9.26.1789937583225;
        Sun, 20 Sep 2026 13:53:03 -0700 (PDT)
Received: from cachyos-x8664 (213-225-11-125.nat.highway.a1.net. [213.225.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd1f0a061sm86765405e9.12.2026.09.20.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 13:53:02 -0700 (PDT)
From: Roman Stingler <roman.stingler@gmail.com>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: Roman Stingler <roman.stingler@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Erik Hakansson <erikhakan@gmail.com>,
	Filipe Lains <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3-rc1] HID: logitech-hidpp: hi-res scroll mode forcibly re-enabled on every reconnect for Bolt devices, overriding userspace
Date: Sun, 20 Sep 2026 22:50:53 +0200
Message-ID: <20260920205058.11958-1-roman.stingler@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arAe2iRkYh9p98Rf@eggarch>
References: <20260920094508.39682-1-roman.stingler@gmail.com> <arAe2iRkYh9p98Rf@eggarch>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 12:01:03AM +0530, Lovekesh Solanki wrote:
> We could store this info in hidpp_device struct and use in hi_res_scroll_enable().
> I'm pasting a patch below, could you give it a go?

Thanks. Your patch does fix the case I reported:

  Tested-by: Roman Stingler <roman.stingler@gmail.com>

MX Master 4 (WPID B042) on a Bolt receiver, 7.3.0-rc3, patched driver
installed via DKMS so it is the module actually loaded at boot. Set the wheel
to low resolution, suspend (s2idle), resume: still low resolution. Before the
patch that always came back hi-res. It also fixes more than suspend -- on the
unpatched kernel even "solaar config <serial> hires-smooth-resolution false"
read back True within a second, because Solaar's own HID++ ping provokes a
connect event.

(The patch as posted also adds #include "linux/stddef.h" above the pr_fmt
definition, which looks like an editor artifact. I dropped it; the rest I
applied verbatim.)

But while testing I found something that I think makes this the wrong layer
to fix it at.


The wheel mode is persistent state in the device
================================================

I unloaded hid-logitech-hidpp completely, with an install override so udev
could not bring it back, set the wheel to low resolution from userspace,
switched the mouse off at the power switch for ten seconds, and switched it
back on. It came back in low resolution mode.

So 0x2121 wheel mode is not volatile on this hardware. The mouse holds it by
itself, with no driver and no daemon in the picture. That is precisely why
this worked on 7.2: nothing in the kernel ever wrote the setting, so a user
could configure the mouse once and keep that configuration across reboots --
even with the configuration tool uninstalled afterwards.

What 7.3 changed is that the kernel now overwrites that persistent device
state on every probe.


Remembering the mode in hidpp_device cannot close the gap
=========================================================

struct hidpp_device is allocated at probe and freed at unbind, so
hires_wheel_mode_seen is false again on every probe. I hit that three ways
with your patch installed:

- cold boot
- unplugging and replugging the Bolt receiver
- a plain module reload

In each case the driver forces hi-res before userspace has said anything, and
the persistent setting is gone. Gating on connected_once instead -- which I
had considered suggesting -- has the same flaw, since "first connect" also
resets per probe. The problem is not which connect the driver writes on. It
is that it writes at all.

Userspace does not reliably repair it either. Solaar skips its apply here:
for devices exposing WIRELESS_DEVICE_STATUS it goes through a ConfigChange
cookie check, the cookie still matches what it stored (the driver's
SetWheelMode does not bump it), so it concludes nothing needs applying. I
will report that to Solaar separately. But it should not have to be
load-bearing -- the device already holds the setting.


Proposal: read the mode instead of writing it
=============================================

0x2121 exposes getWheelMode (function 1) next to setWheelMode; the driver
currently uses only getWheelCapability and setWheelMode. If
hi_res_scroll_enable() reads the current mode and scales the wheel multiplier
to match, the driver gets what it needs for REL_WHEEL_HI_RES without touching
state it does not own -- and there is no mode to remember across probes.

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1504de32b1c8..ffc7cef49b59 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2044,6 +2044,7 @@ static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
 #define HIDPP_PAGE_HIRES_WHEEL		0x2121
 
 #define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
+#define CMD_HIRES_WHEEL_GET_WHEEL_MODE		0x10
 #define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
 
 static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
@@ -2072,12 +2073,10 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	return ret;
 }
 
-static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
-	bool high_resolution, bool use_hidpp)
+static int hidpp_hrw_get_wheel_mode(struct hidpp_device *hidpp, u8 *mode)
 {
 	u8 feature_index;
 	int ret;
-	u8 params[1];
 	struct hidpp_report response;
 
 	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
@@ -2085,13 +2084,14 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 	if (ret)
 		return ret;
 
-	params[0] = (invert          ? BIT(2) : 0) |
-		    (high_resolution ? BIT(1) : 0) |
-		    (use_hidpp       ? BIT(0) : 0);
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HIRES_WHEEL_GET_WHEEL_MODE,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
 
-	return hidpp_send_fap_command_sync(hidpp, feature_index,
-					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
-					   params, sizeof(params), &response);
+	*mode = response.fap.params[0];
+	return 0;
 }
 
 /* -------------------------------------------------------------------------- */
@@ -3910,8 +3910,16 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	u8 multiplier = 1;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
-		if (ret == 0)
+		u8 mode;
+
+		/*
+		 * The wheel mode is persistent state in the device, so read it
+		 * rather than overwriting it, and scale to match. A device
+		 * left in hi-res still gets the multiplier it needs; one the
+		 * user configured for low resolution is left alone.
+		 */
+		ret = hidpp_hrw_get_wheel_mode(hidpp, &mode);
+		if (ret == 0 && (mode & BIT(1)))
 			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,

Tested on top of 7.3-rc3, installed via DKMS so it is the module loaded at
boot. Results against the same device:

                            stock   your patch   this
  suspend/resume                no        yes       yes
  solaar write sticks           no        yes       yes
  module reload                 no        no        yes
  cold boot                     no        no        yes

The hi-res direction still works: with the mouse left in hi-res, a full
module reload leaves it in hi-res and the driver fetches the multiplier
through the same getWheelCapability call as before. I checked the mode is
honoured; I did not instrument events-per-detent, though that path is
unchanged from the current code.

The deliberate behaviour change is that a device sitting at its factory
default in low resolution will no longer be switched into hi-res by the
kernel. If that is unacceptable, an opt-out, or writing hi-res only on the
very first enumeration of a device the driver has never seen, would both keep
today's default while leaving a configured device alone. I did not want to
guess which of those you would prefer, so the diff above is the simple form.

For the immediate regression I still think your patch should go in -- it is a
clear improvement and it fixes the reported case. I just think the setting
ultimately belongs to the device and the user, not to the driver.

Happy to respin the above as a proper patch with a commit message if it looks
like the right direction, and happy to test anything else.

Thanks,
Roman
