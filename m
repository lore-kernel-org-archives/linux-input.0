Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B95396B9D
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935693; cv=none; b=N8Vk93ayMCiOYxYCrES5CkyMTKz2R3U88JqKuYPcICp/WOAwqg48hdOVajUOkcdkB/K4jJYYqFXiTBCwTz9347url+ejrNnCk90AXDgxkUF53zJNGiv3FLDdFUQANUJWT5pJ6kden3e5zivyWWySWXkzOXAZGBKzbWmDF5wOz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935693; c=relaxed/simple;
	bh=+mdxWA7ZTB71/MaGBGas7+QPK60V2E5tzRBizCTuNjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OXUxQMQwqMpk3Zl/yFfuWp7t2pOls18HiucZ/AgQqdQ8Z45qw1WdAadBSBQTyu3HVeov3lzMj++ib5HHa7QEnGhOsIJcchFM97lmVhv++wMw49hp1J2jf2lKubQ1HYCQRz0arHT+DaAAYkhS82v8RgVY8Y8r1Qjpz0h4WwFGK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2rc6P46; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2rc6P46"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6a5c57e01so481925785a.2
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 11:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768935690; x=1769540490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8qh6vJanosuQZR9ha4djD8gyY7F2kO7sGM9tek3dC4=;
        b=Z2rc6P46k64u55Dfn0n5ZhmYd0A5LizWBe2QN8sBxJdKDi37h1yhZ9vJpCesEe3sAV
         TSdwZib9X32jiEIrhQwaYz4TSZoA6UTdzEUKxMW1cw5eErkvLUkVggSFCsSL658YhH35
         64C1GBCf0VS/yUGMm/uMiORLfkYF1FTPpyYbV66qQoyzBKEK9UbgGJxL9kg+AqV8dZaT
         1iE+ZpdXrqam5iMznJIBc5EQ5y0C+HZkvQ7weDp6UlmFDRVD1KwlkhQ07vMsx//2CM8S
         bWl38SKzC6aOGStOkWPaab/eR7vIfTH+K1ERZfPyYLkuxrWdL2kd94ZKQ9g9o31Bq3wi
         mhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935690; x=1769540490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8qh6vJanosuQZR9ha4djD8gyY7F2kO7sGM9tek3dC4=;
        b=jqMC8Yw1Il/eT+eQTLcGDWKbUSueQz8rTCS+8dQq6EBKe+ymcXciS841BHAnxodu8w
         jNaML51BISXoBqL9C1QaC7kxvPncTMKIkSTe4ZMbD31VDlakP2K4M2NKu4LuDbV5lyj3
         st0gVPPscKdI59rykrKKTlsLALZGlLJmyCCL+S33SPkbzgbmmXrx3+QQDJAOKV16TaIy
         fMxgRGI86GKjCqCCGRWq85MquCtl72SkhTz1enoVD1cTyHz814OEzrfbPtQ87Co/4h/N
         CWVb5NaIgF+MgFuwUx6YMmUV9SYFP6IuRBdI1hfo3rTx3Chz8FCeW+CAEknL2GIaU9Am
         DkBw==
X-Forwarded-Encrypted: i=1; AJvYcCUAolrM6zAZz9il2lztbQaZXygHSl2QkCZDOvivp9eAP7yw0I2VtAtNvO7GwJojTHl+O7T6I97+ru8KUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzshSsgpc6P7huiJWC1bam5XPEsAhdT7EAs0yAaDQny8VrlV9Rr
	SBKNL6Lffar7elRq3L376wvGu6K5jw1MVje44Vr1t1FocRJ1jFAicQl9HAj7Rg==
X-Gm-Gg: AY/fxX4ec8lDdJZtUS5ncdDn+5KEQF2zCY2Mnd0lwknwXBDS2sXnBROVhu3ikuk9iIl
	Ht4HwbTpRcQihRjZw7lEK2Ef3ZczMWw/SW/mu/FuSVtxvFxqjJT/H+vz/tfM1CmUasZ608iy7HF
	BTePGZpN15/US6f14VjuvlpRThAUU6Uvuq/zGp9J0EXA86e70shQJZL4yQHLEvDHjsR17N0TbvJ
	3y3rQQnH3ATFNToMmgSN8EIEIo2zqBS41mv0CpbmDhyDfeVSl+CIIzjksZnwxNz1yyfZb/pBlzj
	YEOWdYH+fzUs/MmFKX/miu0C6EFDk17ADlWnatPByQEl4qmeeM/wig6VHOSL2AkI7YN7VODANfn
	tVUB1W7BZJwL6HkX1WNRlsy1UqCOP2lg4a4bH4s/XqnELuW+K93OCxLcbNAu1u6UDJJgSW7LCc0
	weT+8j5ZkVx4+biZWnrlv/60JxrjFRfg==
X-Received: by 2002:a05:620a:710c:b0:8b1:2fab:30a8 with SMTP id af79cd13be357-8c6a677c02amr1931785285a.74.1768935688432;
        Tue, 20 Jan 2026 11:01:28 -0800 (PST)
Received: from [192.168.1.151] ([141.154.77.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72602fesm1086932085a.41.2026.01.20.11.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:01:28 -0800 (PST)
Message-ID: <564ac92e-2049-4c9c-a701-f0e1c6d33f24@gmail.com>
Date: Tue, 20 Jan 2026 14:01:26 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 0/4] HID: steelseries: Add support for Arctis headset
 lineup
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260112041941.40531-1-srimanachanta@gmail.com>
Content-Language: en-US
From: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
In-Reply-To: <20260112041941.40531-1-srimanachanta@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm Benjamin, and I coincidentally have also been looking into this 
driver. Sriman, if you would like, I'd be happy to work together on this 
driver with you! In reviewing your patches, I have found and fixed a bug 
in my local tree regarding battery requests.

The Steelseries Arctis 7 and Arctis 7 (2019 ed.) are not implemented in 
the battery request logic, and simply report 100% (the default value 
during battery registration). I discovered this bug while testing your 
driver with my Arctis 7 :-)

Would you like me to send a formal patch for this? I also have some 
patches I can send that clean up the battery logic in general that make 
the code less complex.

I am also happy to look into creating ALSA mixers/switches as well. 
Please let me know how I can help! Excellent work so far, and smart 
choice in using HeadsetControl, they've done most of the heavy lifting 
for us.


Sincerely,

Benjamin Wheeler


On 1/11/26 11:19 PM, Sriman Achanta wrote:
> This patch series adds comprehensive support for the SteelSeries Arctis
> wireless gaming headset lineup to the hid-steelseries driver.
>
> The current driver provides only basic battery monitoring for Arctis 1
> and Arctis 9. This series extends support to 25+ Arctis models with
> full feature control including sidetone, auto-sleep, microphone
> controls, volume limiting, and Bluetooth settings.
>
> The driver restructure uses a capability-based device info system to
> cleanly handle the varying feature sets across different Arctis
> generations while maintaining support for the legacy SRW-S1 racing
> wheel.
>
> Patch 1: Add 27 new device IDs to hid-ids.h
> Patch 2: Add HID quirks for proper device initialization
> Patch 3: Update ABI documentation for new sysfs attributes
> Patch 4: Complete driver implementation with all features
>
> Tested on Arctis Nova 7 (0x2202). All other implementation details are
> based on the reverse engineering done in the HeadsetControl library
> (abe3ac8).
>
> V2:
> - Fix Documentation formatting issues
>
> Sriman Achanta (4):
>    HID: hid-ids: Add SteelSeries Arctis headset device IDs
>    HID: quirks: Add INPUT_CONFIGURED quirk for SteelSeries Arctis
>      headsets
>    Documentation: ABI: Document SteelSeries headset sysfs attributes
>    HID: steelseries: Add support for Arctis headset lineup
>
>   .../ABI/testing/sysfs-driver-hid-srws1        |   21 -
>   .../ABI/testing/sysfs-driver-hid-steelseries  |  131 ++
>   drivers/hid/hid-ids.h                         |   33 +-
>   drivers/hid/hid-quirks.c                      |   25 +
>   drivers/hid/hid-steelseries.c                 | 2061 ++++++++++++++---
>   5 files changed, 1925 insertions(+), 346 deletions(-)
>   delete mode 100644 Documentation/ABI/testing/sysfs-driver-hid-srws1
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-steelseries
>
