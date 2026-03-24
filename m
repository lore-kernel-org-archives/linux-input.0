Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A98366DA4
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346241; cv=none; b=GP+YyjQUiewBGX8EFFHtZWSR6BriPKqeUM04hPok1oGwGM102evIK9fvnzPuK14djhkzSzupTrST7hZDhaRWmn4dgYtc+u5tlHrQRSfXIe6yVBl4YVGDAOSMHsL9960SI4fBhk69JveIxvZLhFCjHl3uhYTeof+QvxdITHHb/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346241; c=relaxed/simple;
	bh=cSSRqdl3bRjI2qTVJyh+oxlQnsH6b6ppDKYP2gx347M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dvz456mjBULhQ1Yl5IAeIwSzzE6zfMHmTUI9t0mXS7maMiyd/54BDXhkpKo9lkg81vwJE1EGCpokUhu/y1m5uSXqBPu557nzUneWb4B2rpzk8eTyjUEW6+retUTUNZIqYJVmiqutIvlojugC/LuOSwxyYM8qTDHUbMgWbc3g05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bp9rD6z3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bp9rD6z3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b40003d13so3199656f8f.2
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774346238; x=1774951038; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWjO/xgvn1SjtSt3LipRq2Pbv7MghLZ9edNo1IpvDhc=;
        b=Bp9rD6z3rqlIGN18U7jtBZ+TTZmhgFZ/W6ESP+tQuR+IG45FtAShCtWUfTIn3TUzYR
         P3NPLsmlsVitwNaUznQ8xByLXA4TOAZ06rct5hXfM1vRk5h52Qm05ef3opRWBp/mIlMG
         e3hvEddGivNXgnaO5TTyjwo05wCER69keCIzLOhUVlNj2hWKNI45Yj4rIHV4roydL065
         XqPS2J+SgoGpgzpNNePTyVgbx/YA1xPfsGmnWFnFoB+LMiLOjRFBBzydtW4q4PYVnvj/
         PmgZahINL5ROIW1ZJMjj4I8xfTrlPONxpFFpjjFzeKaJF59TkwdvzaNgRBc6uvxlfiM9
         S4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774346238; x=1774951038;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWjO/xgvn1SjtSt3LipRq2Pbv7MghLZ9edNo1IpvDhc=;
        b=QQIOkofR6u0g4ZR272n5G6qTgwXBq6uOb8jdlE9aV1UkVeq9XaCVTvMZr+BzxKqAwp
         2UKvA6NjxknWEogNnDRY31fyoMbmsNUdEifq4Ge+312SfvEp/n2SM61hcVSTdSjiB04H
         gxtvZHX2m6PYPH84+j8o32roWNuX5p6M1UH4RAhEE1Iou/gGDOIcQ1vjtw8ewIVJ6xch
         0HnNtKoDGnwr15gJfQQHaXyqNGLLFwocrGo4cJMi2pgq4zXX8Pn9+mrCsYyzZH8BEKQz
         UhKeUxAochsaxCj+ADHLfEP2qV95lTzxV+4I4cFCurt0OINsJQ8zQBWBx4gEBVstb0dt
         COvw==
X-Forwarded-Encrypted: i=1; AJvYcCUJZPDPd6xOw44Lv3PQ5i5szErfHxiqnt7PJiMFr2vQcLEO7IKDJpK6IJbPiXNVu2VUnhYNPCNN5G/I4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2FLoUK3scU5jLLLkGLxfvRizELnzuTk7eO/xsBQGXoxoB/fE
	z3DtLg7/1KmmpzQmPa6NTGnaJyCMFjZofjuTYMJntExaL0wivOvjlEkO6htgRm0P6Zv0CwIvl3I
	4OcuA
X-Gm-Gg: ATEYQzxwZb1nXtyiiB2o3fumASXEbx8F7x0IWikOFQD7we2yMGJjkUYKYATa4HKxkC1
	buH8ym69bKBBvSrd3sb22LrB34WhJ44mWE4hya/F5E0ZhMp+Ga7gLU3KvYyWwy/pizN/RJNQUJD
	28citrJ7v66J6GHvAWuvXLbjUYyBIkAGC11ijnO0BhX0rWCCwf4txAjYoWjsV3onXARSWNjS8AV
	Bfv+MWkZu0WDs6VfyWZuI7OA4fDh7tj9xKFSvdN48udbUdZJ1OYciPnK4vkcWe/bieQsdAz/HnT
	Y1nQcUZYN65PYQGAT6pX3gG7Cyr/uOE5iiv/R2n/ndestJ7Pi+1HSWHQ+cFDWURRrcGywV75fAq
	oiSqeNeZfqCDW+1XND5tlcGndA039G/yH+iQvtcqnLaKh8BYTHWdcxayLuvAuasAVisqvGJFQcd
	kGv8CpxxVhVdeUa1NIJ5+DVTiva1ahzyDeI0dc3HJmyi/q8/hvH4d7Odmrm6SjCwjY
X-Received: by 2002:a5d:5f86:0:b0:43b:4921:8743 with SMTP id ffacd0b85a97d-43b6428168dmr23971363f8f.42.1774346238045;
        Tue, 24 Mar 2026 02:57:18 -0700 (PDT)
Received: from ?IPV6:2001:a61:1332:2a01:88e9:6e6:b5b2:fd40? ([2001:a61:1332:2a01:88e9:6e6:b5b2:fd40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae619sm37731853f8f.5.2026.03.24.02.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 02:57:17 -0700 (PDT)
Message-ID: <8d665258-6dd6-404a-85e0-a2f3420cd992@suse.com>
Date: Tue, 24 Mar 2026 10:57:16 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB list <linux-usb@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: Question regarding error handling in usbhid
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

hid_io_error(), in case it decides that a reset is necessary,
schedules reset_work(). reset_work() in turn calls usb_queue_reset_device().
Why? Is there a reason usb_queue_reset_device() is not used directly
in hid_io_error()?

	Regards
		Oliver

