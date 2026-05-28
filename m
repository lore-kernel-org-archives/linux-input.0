Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871B1F5847
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929393; cv=none; b=lBvQln0FdKUXBYaSzEs8Sgyd2wS0Pgd3X6ip/t7Hv0X30l/PFZZahMAlx6aPtqD6N833o3z017vvqQRWBvMbNfimVVvQjut+9MafIKpuN9bb0O1wl9UtGNEYMdm3PTgUFTiRAQN3KOs4WVxXNC3OLvjdV13Zi5MfEyOlMWvgjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929393; c=relaxed/simple;
	bh=QRfVt/hYHCLqbSkeXW+CuJI83At8XX+vSUVvVNuyeFc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ABSNG2/nkpDvlDvZZ+FShlqR/II2z8udMOQxNJyp0SGmRrP7eCug+BMtZZ3oKGJHr3UhzgP6bqcp00+XpQvrP8S5IgXGqLtwdc9RUxdq4h4p+w4bjR6CWum0lynPCI+r5Zon39FwNo4dXkapkwKQo8NFnDh9Tx2BM8ISpBVmEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9AhVvvm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9AhVvvm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bcd3ac3307so72151975ad.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929390; x=1780534190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9aRo1QYU538O5SIsAWbjFU2Nq0lYt45JSxAzbDD8aZI=;
        b=k9AhVvvmAh2uxdBIvKSx2jjpDcv1IIGncKw2msvCFdWx6UE8RCHo/CGnRQnkGVoNXx
         7dJY1ZDZ4rIIsW5DLBR/7ph8ijVWwhbwGZk224rmjtPyv4gMj9XKv0mr3bGp7fHOI3p7
         i9ICQqeUUMJ65qw1r+ML5HNHC4B9bM3UZKgsBfOtRufmHYnx/JgaLQlalACl0cpGft+j
         siwyrTQnfik5UA94AKSS2WPJ+t1XAXMC77bomAqAJNTLUOrHZW4cGuxcLVbLsyYn8CPy
         d7ijR0sv1r1pgMy/7KKYF5+GEbovEqBTQcfctqH0wysecYX6u7dl5GPuqJOoCNJRs8wK
         5IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929390; x=1780534190;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aRo1QYU538O5SIsAWbjFU2Nq0lYt45JSxAzbDD8aZI=;
        b=lisGi5hbGf5cQ7IHpK+qbDej8ywKZqx1gHk9a0EoUCl9MW/H0h8jjz8ItphfoncYxq
         bzznFIkhBFh2d6Y9EdIaVKXFJFFSDIqY3DcUS1q2zGtIQ2vaPP95p0SxKl/JkLrDl7gH
         PEZptLH60izCxMlxiC0E49XeVewabbZ9rZBR7Vzkx82qZ1N429IkDyqn4Dyg+RQE203Z
         B0aWea279N3O2NtOL0PIy0oujQfydipLEwmjUuAsuBZhHEjcl0rRKkNGfAZiKb4oQ3XH
         2WRq26LvKqHtgLHSHRJzdvjSQi5apiBzEaoWdzsZeVtxxDO7jNdZY2Vl4kSA8I97zrTJ
         x2yg==
X-Forwarded-Encrypted: i=1; AFNElJ/6Uo1C7xtuGI7Trzz9nkthAE4BQz2fGuyR/mgNQXmfbDipUgj0w5Jk0xY/3RdUF0MC68AmMRUjiqFGNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRh39KwidHABqJn0sXODwBcHfdu11LTPmB+uesrPzXEu1DWDUC
	PEOtZB1IiUnFhPom5qfsviOdLBpJvhb2IFcmI9gZjh5ACoNcpcVLYYfr
X-Gm-Gg: Acq92OFp6sr5UjAiz4VIzhoY8GqIxryMzMp092Ck4HUwS4Bb82dJ+ls5wKL7EV6UfhK
	gWAUX1AA7mCfEUfLIDCmwqN6c6iPqFaP1/QvYbYTstmhPYdcNapjec1TqnnTdCW1XoyZuql2rPE
	78z+lOEwnHQdN8l2ju1cxDNI8NNQfJtfKyYGQCc9bT1RAKhzXUy2VYvXSUlTzIU3Os2NyEkaAg2
	z8FlEFr2uYXZOSqRkNtiWez3xJrgP4nB3AYh/0+pr5qSFcyRnsN1VZWRetHVI1LxbNqQgIxCEDb
	Cju78yrkQSmklJGmx61PQj4iTNTQ4F6QPVyjm67I775CPRI1L06BXck8lMY+TpKEbJBfbRMCZEx
	aP7NoT5Q73NXoXWccPV/ycgn468ohnHeGtMn7xZFujE73ECO4NH/ftFt+D0z9zzBVRuWEVMa0dV
	l+6NIDKhnvANvGXjKO9vIwuFeuLnhR2V+s221/9d+UsFThxOYEWBj8OEMfxzQzfqFma7Gc4abg
X-Received: by 2002:a17:903:2348:b0:2bd:3bff:432 with SMTP id d9443c01a7336-2beb074f535mr277723275ad.25.1779929390377;
        Wed, 27 May 2026 17:49:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([203.105.74.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2cd6sm170100275ad.52.2026.05.27.17.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 17:49:49 -0700 (PDT)
Date: Thu, 28 May 2026 09:49:49 +0900
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v10 4/4] HID: hid-msi: Add Rumble Intensity Attributes
User-Agent: Thunderbird for Android
In-Reply-To: <20260528004340.2C3D91F00A3A@smtp.kernel.org>
References: <20260527222122.10620-5-derekjohn.clark@gmail.com> <20260528004340.2C3D91F00A3A@smtp.kernel.org>
Message-ID: <8DE0A307-A10C-47DE-864C-19CE8B73F7B1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 28, 2026 9:43:39 AM GMT+09:00, sashiko-bot@kernel=2Eorg wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
>New issues:
>- [Medium] Missing functional implementation for rumble intensity feature=
=2E
>
>Pre-existing issues:
>- [High] Race condition during device teardown leading to Use-After-Free =
of drvdata=2E
>--
>
>commit 902919289c1cf51c111590532df6640b717c3236
>Author: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>
>HID: hid-msi: Add Rumble Intensity Attributes
>
>Adds intensity adjustment for the left and right rumble motors=2E The pat=
ch=20
>introduces the data structures and driver variables for this feature=2E
>
>>     Claude was used during the reverse-engineering data gathering for t=
his
>>     feature done by Zhouwang Huang=2E As the code had already been affe=
cted,
>>     I used Claude to create the initial framing for the feature, then d=
id
>>     manual cleanup of the _show and _store functions afterwards to fix =
bugs
>>     and keep the coding style consistent=2E Claude was also used as an =
initial
>>     reviewer of this patch=2E
>
>[Severity: Medium]
>Are the _show and _store functions missing from this patch?
>
>The commit message mentions manual cleanup of these functions, but the di=
ff
>only introduces the data structures (like struct claw_rumble_report and
>rumble_addr) without any sysfs attributes or functional implementation=2E
>

=2E=2E=2E What the heck=2E=20

This must have somehow dropped during rebase and I didn't notice=2E=20

I suppose I'll send a v11 tomorrow=2E Sorry for all the noise=2E

- Derek

>> diff --git a/drivers/hid/hid-msi=2Ec b/drivers/hid/hid-msi=2Ec
>> index 96710d80543d4=2E=2E17b0707ecd46d 100644
>> --- a/drivers/hid/hid-msi=2Ec
>> +++ b/drivers/hid/hid-msi=2Ec
>[ =2E=2E=2E ]
>> @@ -332,8 +343,12 @@ struct claw_drvdata {
>>  	enum claw_gamepad_mode_index gamepad_mode;
>>  	u8 m1_codes[CLAW_KEYS_MAX];
>>  	u8 m2_codes[CLAW_KEYS_MAX];
>> -	spinlock_t mode_lock; /* Lock for mode data read/write */
>> +	u8 rumble_intensity_right;
>> +	u8 rumble_intensity_left;
>>  	const u16 *bmap_addr;
>> +	spinlock_t rumble_lock; /* lock for rumble_intensity read/write */
>> +	spinlock_t mode_lock; /* Lock for mode data read/write */
>
>[Severity: High]
>This is a pre-existing issue, but can the device teardown in claw_remove(=
)
>cause a use-after-free of this drvdata structure?
>
>In claw_remove(), cancel_delayed_work_sync(&drvdata->rgb_queue) is called
>before led_classdev_multicolor_unregister(&drvdata->led_mc)=2E
>
>If a concurrent sysfs write triggers claw_led_brightness_set(), it checks
>rgb_registered under a lock but calls mod_delayed_work() after unlocking=
=2E
>
>If preempted between these steps, claw_remove() could set the flag to fal=
se,
>cancel the workqueue, and then block in led_classdev_multicolor_unregiste=
r()
>waiting for the sysfs operation to finish:
>
>CPU1                                CPU2
>claw_led_brightness_set()
>  scoped_guard(=2E=2E=2E) {
>    if (!smp_load_acquire(=2E=2E=2E))
>      return;
>  }
>  // preempted
>
>                                    claw_remove()
>                                      smp_store_release(=2E=2E=2E, false)=
;
>                                      cancel_delayed_work_sync(=2E=2E=2E)=
;
>                                      led_classdev_multicolor_unregister(=
=2E=2E=2E);
>                                      // blocks waiting for CPU1
>
>  mod_delayed_work(=2E=2E=2E);
>  // finishes, CPU2 unblocks
>
>                                      hid_hw_close(hdev);
>                                      // drvdata is freed
>
>When the sysfs thread resumes, it schedules the delayed work on the freed
>drvdata=2E
>
>Should the LED subsystem be unregistered before cancelling the associated
>workqueues to flush active sysfs writes?
>
>> +	bool rumble_support;
>>  	bool gp_registered;
>>  	bool bmap_support;
>>
>

