Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795268314;
	b=GEi9KZ4VKCmEVAMAAB3zKOaqGT8dlcii108jHDBFa08cqflTlvHevUUMr5Ozp1INlYXd
	 t+P3WeCAHxYSLhHPSSGta5D8MLORm2+4bcG18NFwNvEHjFEyuPaqBhKl2R4wqLALbA0oi
	 P7dTEPqHprS9LP9c0y4MUCrn6mkzHYunnr/+F3nooxIl69kbxJSTt0MU+MLAXI53I/Gmd
	 NgXbW47EjR5JUddkmb/ewHHvBmo7kTtBa1krtptsx0EzIJT/wS2cFUgLAz3pq7CYWHcgi
	 gvZMhZzZEAhnqFjTG+DlXmEV3M+rIpDmvrw+mICiIknfnAczsMm+p0uLGiE+uv/ulWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795268314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=2JcSkgOAc70yUl0xOGsAkRmn2yrqWyaYEB22eRFKz4Q=;
	b=xvIVgjDTRo4Xw0Jr3om1lfcWgswPVeHsWg6qRmwl0nnV14kuYYAfNxfB9k76JjTeezkK
	 M5S7btmT3fX+dsvD24pAt/ZE+e/Nrf14UG5nGG5QLxoIY+ZP9uNQRvAatjpKkK78Ceo3p
	 jpeuQ9hrx7WmnSDt5Xz0WZF0b2En+qLlqqEn8fumpD3MpZVA1B2FUDkh240CG07ouugVg
	 Wm7j4TXDxe3wwRsTEKFYpg0ljz9VqonlVP3Vme8AUcXY3plcrlMx2KMpNgGFWdDIAJBJB
	 zajMtMgwXPE6PeN7Q0aRQb6fwP34AX+w84rRj+UB1oab0ULUNsUHlr8U4+V0WRVDvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NiI8guW9;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D0606A320
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 13:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27D0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NiI8guW9
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2efddf749e5so13001125ad.1
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795268313; x=1795873113; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2JcSkgOAc70yUl0xOGsAkRmn2yrqWyaYEB22eRFKz4Q=;
        b=NiI8guW97trs2YALHBUQx5HwUu1q8e+xkO4IqLHlA4TYdHvu7rzrplXh+EWPxIKrd7
         z9pXZcroA89w541dMTytKW0zYAAHKhG2OQG79hskyNXx9Ops5jcgk48JQUCJjk8zfQ5/
         rG2dSVnCXgjNygIlV7c8yByNBjP6yj4vyKtWFGCG5VUlvRZI8Ee8H7rF9Q7BYZZCRU7S
         VE05mPAu0L6B/mejL7DpatGB2CpMceBiI+5ohCWORZ9wLBvpVugXnNIOI119HfeK4pG7
         9QmZNgHPcUEE0pf6cCpXVyoEhO0zjI5MD3Jpb9m+PYqHS3x+fJ0cERtzroQmpFsQxNv9
         geTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795268313; x=1795873113;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2JcSkgOAc70yUl0xOGsAkRmn2yrqWyaYEB22eRFKz4Q=;
        b=JP55qwkkTbyw1px6lIeLTJseVzp8kSdkYBaztTIc5Gn0oMuAsYKJPp/SnldFd3wBbW
         7Vt4fiCX0+hN8O6RUcPbd2Ar8E9ndu8zViyIj6GT3r+qp+T1fUyL6GxneqEB3lPBqaDy
         +Nb4nYe2QUhAaW7+TOPQFcKPrbhG7etH/Og7icZRXETU8zfCmZjAYvOosYRHEIgQXslX
         worQsj2Ug0hJFxlinzhQ7ggTcVtVvPiQnx9ceNA0v6WREZRC0zwnfU7nRCUZPHJPOgjy
         xuYj98WehZKvREvoa5u9BjfupcGywg4R5nN83NawuajFubZl77N7NUa+HfRFWpWAxGjY
         +rSA==
X-Forwarded-Encrypted: i=1; AL+hErFAQ9BdVQlkgpAUMjkoI/zsLJZXqCFzZcAI+zqr8Ki/i7y9J6DXubIzFOADRyg0t/11M2T9H8ObNHACSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+o1ydHoUHO+aSPRj2xCQwnVBpMzb3Rxc7tl/E/jWDx0Fjlre6u
	Z9x6SfOcxFgb4t4d6BGi5N2VthyiGGhxyqP0JUalGyB4SZxr52vUfXfw
X-Gm-Gg: AZFdTZcCfaHQRbil6p/E4q2daJ9paUdlaKejj4A3+QZ6/fUDY0JVBbbsjKT2o9fJTx3
	LkrL38qYZy0eSelQG8jVX6Kz5xb4XoONvdcjw37+tXh0XUpNpvRcvOjtTRMH7mFEwwQnhACbhiK
	OZ1WmUAsmskAYrJBdPx9SewFWBb/fpHdfSoWJOA9Ty5FKK+2XY2vV6sIbAtTEDig/+5LzdpxM8h
	PahveTYLXdo7tJP9I6kUDpYC3/3pitgMKl9v2udQbUwcBunC6kzsod7CNrPN1kHTEOVIJmG5Jev
	W2gmyXI+ZvO4Ac3/RF7gjYjpMMzNRkLpz4/nSLo94/DDrrmeutSOBHmmt9iwZR03+c8airQ9+wi
	8HjdH2dTCYyp2BWsgBgXWIFjjQC5VMCDxFM505J4+20wfnrBvdiy0b8fdNW4b0nTT7M716ZRSct
	5y5qdbP8VDN3XPCsD+tecYJLdfKUOgea2P71TIdIk+K+75nwQnx7h8lH9EFRTVIVsC+EETrSQVg
	d2K8Sza9tNfoofGutP3JrfGXlppyo5NplmjDluKEey8XQ/57nQxfNgvWOvf3wqOhA5kVkjpeyF6
	0Bh+J19jp1nXApGo3ZtFMFZvuh6b87Ad5jbYOp1vMTzILKX2gZJSJYwkA6xH/2EEiT+dTS9iKFU
	=
X-Received: by 2002:a17:90b:2f8f:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3b41c938926mr3785656a91.25.1795268312893;
        Sat, 21 Nov 2026 05:38:32 -0800 (PST)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7f4899sm2032844a91.4.2026.11.21.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:38:32 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Lee Jones <lee@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
In-Reply-To: <20261120210317.184756-1-kapoorarnav43@gmail.com>
References: <20261120210317.184756-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 21:38:25 +0800
Message-ID: <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Hi Ayaan,

Hmm, I overlooked the latest discussion, which caused some overlap between our patches. Sorry for the confusion.

We can merge the fixes into a single version or find another compromise. Either way works for me.

Thanks,
Zheng
