Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364F78F2F
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711228; cv=pass; b=Mq9gs64utv+ol/kzh7hG0qlpCw+pbEBYfW62dOE9YzmHLBT8+NyczgtgGslrLDywhzAf1lE6m/u+79bzdZRZCQy1ippCyaGz5EEdUlh8buOi0wgFFnPj71lCAjgFT9S15f+Lhw1xvZhfwO2C0/QSHy94EHQI+lZjyqHPbplVF44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711228; c=relaxed/simple;
	bh=zaYm5DCBjt1TyiImXbfTD1s4nCahMfjJ+giPGTzYWjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU5TR/+pTTYQGzzn+fTxWIcq7xs8VlXWEYIm5cOjoop6fWH3T+3jNvZn/5PFU2H1p44yonCkqOLz4WSovXSlpEbzrj6Kwa2XqKdF5EB0GzACuosDIJB9UwcI83yqxMdTQGf1zmpwX+xfC0Y3ljoBWl6TLgh1FxzI8qQwXDhmf3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imjkidjX; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imjkidjX"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso319638585a.3
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2026 09:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788711225; cv=none;
        d=google.com; s=arc-20260327;
        b=GvoCP0TjpLhJuRtH6JF4ApKKqZco+ia41xxxLFcCUq92/YFRKiBn+QkHq4iZ3pNszV
         PZhU0o5601ai2NuYm2UQFmFzpd0c5fJk+GPBMFJF1uMeLygEv77TKT6oKBBb5qVCoKns
         R8TKlmpKfABbnWh3gcFzX3jdmuYBB/GgT4slwvZwi4eQrhNgf+0Sn9ULZs7U24cL3S/b
         +4zvM27XMMABcGd3CWWpHZ0oCp/Pkoel7WGfmhskIHjU6XmClqXkO+OhdvBSf49x3v/g
         XIkNxBc0oaQxv60aYdlR3PzGQU59doelNfd8eP0CLMUPTFH6UzSmrHjvoELkZWwfh0xv
         ndxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8yHrvdEVvU6q5+qJd88ND4hUx7W+Bl65d0SUn+Haq5A=;
        fh=mHJL8z2jEMmVs3VAp45QUu2fZgFr1w4osijvxy30A8s=;
        b=i4zGFlZHhYWP28iAgz8pE0JA34R/t28ekWOI4d5/0qg2Bu/VJM9S1YrIjs7wcjFV/n
         fIhVIoa255Vghb9ipfx788COBfVyXU7rwo4/9DvbsG76OfKO58hAwYo4BBrRxpmFG6JI
         u0p02Tkv3MEayWcySHnaCxTM1FeSWhyGiKrTiVz9yqO8EZ9Vyt3V8eTWePVNo8MEGgg0
         I1U6H63MC4KB9Bb+5Qgixb4t6QW2wnzsnmRaaw62CJ7OQJiu1g8F/RGc88pVfG6WRrzI
         CH6pmPflWh6M3IVwzafiJOkjefK95o6PVqfcvCMMGtK92Hp1o4eDTs4cKi09yqzpPlhu
         gmEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788711225; x=1789316025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8yHrvdEVvU6q5+qJd88ND4hUx7W+Bl65d0SUn+Haq5A=;
        b=imjkidjXORJitO2inPdhSV/jbU3Df+0lkzduDN4FQtk6l0odY59tBTxT1mebfFYBiw
         9ajOEIBSTf1wZvDm4RKGK1nhEKjY1pzVGMqwVk3biYe9pzy4FbNo8Qim6ZJlp+SDGjsQ
         5eTXSj896A6wjn3B/oGxbRS4anCdAadn/rmwosMOEFlKX3mLeQBG+gYeAOJYF4PMMsqi
         reYl1KGX1R6lUtr5aaC1elirbzm4QmnJ3HLc76PI/rV/SJ0L7L7xgVldiKWwjC52Q574
         N7i5bDWm+ee1bY4hkZs7Wj1xerBN0hlenka6NA1Ve6/QHZiYO1AuF6fPqjPIHwmBixBP
         PpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788711225; x=1789316025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yHrvdEVvU6q5+qJd88ND4hUx7W+Bl65d0SUn+Haq5A=;
        b=h88DqO7kLrNrSSRgZBG1h/D+bXPCvrvYtDoNpaWgwlBI5a4x3BELtFaTwWJwTrAWLC
         06UpBRZOEnF9rHpn039KBlb1rNDJ3D2wV9WgoSnX4fvNrPa9b4RJZUVc7TtA37nBHNJx
         hHaGY6leb3jiz+Q1VkrXkTUzvr7Anbx2eFcnG7r4+rQv6rNqFWs09HUfKH73Yxv4qqcp
         EoMyHJrcKoCENpPcv2l4KMIi7cLXqLFytIajQM/jjLe4OlfFjmJcWVZoQ5/mTAs3/hvm
         iKCFh54rk5HVqLuQfUdnvmcVTis86m1Pen5Zk0qz+IjTY3hmJTMhlvoW0JMPe/g6rfHW
         Mk6w==
X-Forwarded-Encrypted: i=1; AKwUvBxfm5lUrM9bz4jmketHqzlWUNEKRYzM58DOE0x0BZxn1yV6Ecdlez56BM7gmteQfkrQzWyYg1zsDenDNA==@vger.kernel.org
X-Gm-Message-State: AFuF++mlMH+Aciy/okCvpwwfx1D2OFXax+Jkc3UwM5KyJ7r4SmgeTxk9
	r3tSB/Hj42FWQebe1soUYqbZMHM6BdQMu3Hm9aV0PDO/nGwEWrbxXUdkTz1iNwPOTXermXAvP7a
	X3cGpZwPY6pSAJQW2njOxV6jkdAt1OZhP2rr+
X-Gm-Gg: AYBFou1d7eUDGwYr0efruuqAZI7NUJK71sYT6EobW9zS5+uudbEr6Dh7BEIvo2uaroh
	7cDDCcfOpJ5EVJjN7tabj7aSu/MiV1u3S9PHYG5CIbnIjfvQR5FeXNBTGGg0TO59q5DXBBdo8S6
	e8h0+0HJWfc9p7jmc6fzmtg3KLfEwW3PB9MWzQzbvsYBmB3q07U5tUoRVmQKj6hOkQnpV7LppSJ
	/1ls2wnv07euF26g9I8VSTIEHVclxwiSgc3cEjwdFUzYjyuBtvJy2elEw6enUB8RqtCsldk0i7u
	tP+wMGVwfB2BSxysxG6GgebYk7kApZvg9DXnBnwY2E5Csd7Dnbxgclfx5B4n6ji4DujKVBLeoP9
	j
X-Received: by 2002:a05:620a:4721:b0:939:a003:7127 with SMTP id
 af79cd13be357-939a0037342mr566132785a.52.1788711225482; Sun, 06 Sep 2026
 09:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
 <aoC-aI_7Dq_nJTHg@eggarch> <CAEru=6K=P_oJfksvRf2BfHZF9AFrQD4=izAwrSsz_Xit_i96xA@mail.gmail.com>
 <CAEru=6+Lnwn+UHcpGA29gcET=ERgiYCOqkR0ijShcfOFR1m-1g@mail.gmail.com>
 <CAEru=6K8gYwNWHFoYmwpQY8GGJ3HrqoJxKyu41nSSGQWOTVOdw@mail.gmail.com>
 <aoyO68JLUeCZbStK@eggarch> <CAEru=6JrUqo34ZtDES+VE3vbLGAFYd5UjnrpLOELKoEVg1Zx=A@mail.gmail.com>
In-Reply-To: <CAEru=6JrUqo34ZtDES+VE3vbLGAFYd5UjnrpLOELKoEVg1Zx=A@mail.gmail.com>
From: Adam <testyiprywatnosc@gmail.com>
Date: Sun, 6 Sep 2026 18:13:33 +0200
X-Gm-Features: AcwNN1V1p9ZMmDrU0gcWFJb97PvUlcYqQL61l4G1SOI_Oic1q0JOP1dA9eChByc
Message-ID: <CAEru=6KD3wxWvmVq2hHnHikYzFcp_hsuCBS0agBm-gpCsXhy0Q@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One more finding, potentially significant: I found that holding/tapping
F9 at boot (HP's boot menu) repeatedly, or alternatively entering the
UEFI Firmware Settings from GRUB and immediately continuing boot, gives
the touchpad a reliable, working boot on my Ubuntu installation
(tested this handful of times, consistently works).

However, the exact same procedure on my Arch installation (same
hardware, same BIOS, back to back on the same day) does NOT make the
touchpad work - I tried this 2-5 times on Arch, no success. So
whatever this trick does (presumably giving the firmware/EC extra time
before OS handoff), it's not sufficient on its own on Arch, even
though it reliably helps on Ubuntu.

I don't have a clean explanation, but this seems like a meaningful
data point: it suggests there may be something about how Arch's boot
path (systemd-boot, initramfs/mkinitcpio, or something else early in
userspace) interacts with this differently than Ubuntu's (GRUB +
initramfs-tools), on top of whatever the F9/firmware-settings trick is
doing at the hardware level. I'm not sure how to narrow this down
further myself - let me know if there's a specific comparison (e.g.
timing between firmware handoff and first i2c probe attempt, or
something in ACPI _PS0/_PS3 execution) that would help pin this down.

Thanks,
Adam


On Thu, Aug 27, 2026 at 11:44=E2=80=AFPM Adam <testyiprywatnosc@gmail.com> =
wrote:
>
> Thanks for the detailed hypothesis - here are the results.
>
> I did 5 warm boots (reboot) and 5 cold boots (shutdown, wait, then
> power on), with dyndbg still enabled, and physically tried moving the
> touchpad after each one. Subjectively, the touchpad did NOT respond to
> touch in any of the 10 boots - I never saw the cursor move.
>
> However, when I went through the logs afterward, I noticed something
> odd: in one of the 5 warm boots (boot #4) and one of the 5 cold boots
> (boot #4), the log shows the device transitioning from repeated
> -121 errors into a long stream of "input: ..." lines with what look
> like changing/plausible HID report data - 1353 such lines over about
> 28 seconds in the warm case, 441 lines in the cold case (that one
> kept going intermittently, mixed with more -121 "failed to set a
> report" errors, for several minutes based on the timestamps - I let
> it sit rather than immediately rebooting).
>
> So the kernel-level input events appear to have been getting
> generated in those two runs, but I did not perceive any cursor
> movement, and I don't have an explanation for that discrepancy - I
> was actively trying to move the touchpad during that window in both
> cases. I don't know if this is meaningful (e.g. some kind of
> noise/garbage data that happens to look like report data) or if
> there's a userspace/libinput layer issue on top of a technically
> "working" kernel driver. Attaching both full logs
> (warm-boots.txt, cold-boots.txt) in case the raw data is useful -
> each file has all 5 boots separated by a blank line.
>
> Overall: no clear cold-vs-warm pattern from this sample (1/5 success
> in each category, by the log's definition of "success" - not by my
> subjective experience of the touchpad working).
>
> I also ran your unbind/bind commands on the platform driver during a
> dead state:
>
> echo AMDI0010:03 | sudo tee /sys/bus/platform/drivers/i2c_designware/unbi=
nd
> echo AMDI0010:03 | sudo tee /sys/bus/platform/drivers/i2c_designware/bind
>
> This did trigger a fresh probe (dmesg shows "HID probe called for i2c
> 0x15" right after, and the HID descriptor was fetched successfully
> this time), but the reset/power-setting sequence right after still
> failed the same way:
>
>   i2c_hid_xfer: cmd=3D05 00 00 01
>   failed to reset device: -121
>   i2c_hid_set_power
>   i2c_hid_xfer: cmd=3D05 00 01 08
>   [repeats a couple more times, same errors]
>
> So as you suspected, it did not recover functionality - the platform
> driver rebind gets further than a cold boot sometimes does (descriptor
> fetched right away) but still fails at the reset/power stage. I also
> physically tried moving the touchpad afterward - still completely
> unresponsive.
>
> Let me know if a larger sample size (more boots) or anything else
> would help narrow down the input-events-without-perceived-movement
> discrepancy.
>
> Thanks,
> Adam
