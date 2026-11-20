Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171854;
	b=UM+4EGOwcMt2OrAbnpDKNI/1/GaIrczq8lEVgTJ1TG3KYD80h656Lm7Jd+Np0wPWTxSV
	 ED21dHP7+QPo1yQl3GEgpmkLU9lgucxzL/ZoDnJGgxh7ZgtXo+eG5Urxje4YQ9nljyaOs
	 yajoArmMFNKjvup/NilAGL7t8vJRbhHhe73rR5LNydq7eFyB3oq8TYlCFc31V4MvnX0Pe
	 AlYNn3UsnXLRcajUxLIN0gwE8EKtLHjTZ8OLogFbM+kVkVl5fcJ5lQtZ7qi6t4vHiAW1X
	 zmZQcxFVgzSAilcuzbKFqq2yc97OgFSWMA6WO2qp/DBTjR2s1XOfF76ge810Ewef2pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171854;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=RuCBGxW4k+nLAhcDYdOOEYmXXtboFDr5QBxJOONXv6U=;
	b=xP/Ypt/2s46ukS32+OfRAZGtFZ5IpzBYvO2/6AsvCaOlLzd+YrZJ38KQgDppSQCv85Mn
	 dPTPPVsLiCQX5NZWwnnIbniI0/j780L6mkKaWlIkgDoUxlEs9lEz9meo6oLnfHZQLthv2
	 iSpSQcEEhzeNNeMurCO7Ki4MbZZr7mykhFr110SqjUQwr4ppKj1VigHymb9jDZf/JA6Yc
	 vbldvxBmtILj7jqLLI/+bOPpE0k7DnbAJvDB3E+WHfjqDOqNTTRKTIM+JuwgP0Ha7Bqs7
	 DuuR8pdtjt6Mfm0V9jsALX1JIESaayAKypsDVqrcIM2sWhanwNSDCB61N6d3r7cBDKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44960A260A
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 10:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F44960A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c734afb8deso967172b6e.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 02:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171852; x=1795776652;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RuCBGxW4k+nLAhcDYdOOEYmXXtboFDr5QBxJOONXv6U=;
        b=EnH5mx5B6GRYXxj4dJIXEnLiN9qs69LEuQcP7MaPProMe/pWVIBnA+c8HitzCQ+Q2x
         biLwK2EW1IfxclwtrJlpaaIhT+G0FR37+Nyj7wVyIScZn1dJmismZLQfb3hZsEGyWcco
         ZlSiw53xZkmlAlZWa/qCar8BUBd93XJh4ridiAngQxccs5gyXv+hTNntyMZMkImm8Py4
         DsjtHf8pI53nwkQQxK+uTN/hklMjc93V5THQcNO0NA1POxv9udanhWHVBUn3nVx2gl6P
         Iunrg7NzeSxHxuRc9H2KAG/h2xdyce8RPcGFDl42wLIy4ntSIvVTQgXpQ+0dXmd6W0lQ
         E5Ng==
X-Forwarded-Encrypted: i=1; AL+hErGXlA9dQF3KuYF2CR2+CawMufYdpNkop3hCECXG2c6klrQRxjCfSmDcu3AlWgO/Wm0VXkVDs8+CaagdTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+o/1QCYqGRBHEn0rdgWMQWCCo3ORIDBTSmt3EeSnpgMzz8HR5Y
	B3+hEXmiyqcnLqxiflZjkBkSFDcK3YuJzzX6Lnj9UT7jmRduWnecc98iigfseRRDXx1rmWmuaJa
	yWy3uovRqdnhe6f4j3d2+EDV4kB7cXoOJf5E3DFLnYOPES2D0A3LdB1UpoJ8=
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1783:b0:571:76cb:b4c5 with SMTP id
 5614622812f47-57a06b25c93mr3051987b6e.2.1795171852750; Fri, 20 Nov 2026
 02:50:52 -0800 (PST)
Date: Fri, 20 Nov 2026 02:50:52 -0800
In-Reply-To: <0428126d-684f-4b4c-a805-7dc3e2d56897@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b00260c.c48d0c14.ca62.000b.GAE@google.com>
Subject: Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: crofts@kernel.org
Cc: bentiss@kernel.org, crofts@kernel.org, jic23@kernel.org, jikos@kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, 
	viennaoffh@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On 20/11/2026 08:56, Zheng Shuhao wrote:
>> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
>> sensor hub removal.
>> 
>> sensor_hub_remove() currently holds sensor_data->lock while calling
>> device_for_each_child(). The child iteration enters the device core and may
>> acquire the klist lock. Since sensor_data->lock is also acquired with
>> interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
>> lock-order inversion.
>> 
>> The callback only needs sensor_data->lock while checking pending.status and
>> completing pending.ready. Pass sensor_data to the callback and take the lock
>> only around that short critical section instead of holding it across
>> device_for_each_child().
>> 
>> This preserves synchronization of pending.status while avoiding the lock-order
>> dependency between sensor_data->lock and the device core's klist lock.
>> 
>> The syzbot report is available at:
>> https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>> 
>> Testing:
>> - Reproduced the target lockdep warning with the unmodified kernel in 3/3
>>   two-CPU QEMU runs.
>> - The warning was absent with this patch in 3/3 equivalent runs.
>> - Ran the HID selftests against both baseline and patched kernels:
>>   hid_bpf: 45 passed, 1 skipped, 0 failed
>>   hidraw: 27 passed, 0 failed
>>   hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
>>   hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
>> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=2 in both
>>   kernels because no executable test cases were collected in this minimal
>>   QEMU environment.
>> - No KASAN report, use-after-free, Oops, BUG, panic, or general protection
>>   fault was observed.
>> - checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.
>> 
>> Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
>> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
> You cannot add a Tested-by tag with your name.  This is reserved for when
> someone independent of you tests your patch. Looking at the syzbot report
> there is a reproducer, so syzbot should test it. You can make syzbot test
> a patch by sending the following (note, this will trigger a test):
>
> #syz test

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

>
> -- 
> Kind regards,
> Joshua Crofts
>
