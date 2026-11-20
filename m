Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182569;
	b=sknvkNQC7dhaHsimF28j4f1HPzyTJh6bsomIJpr+AQQ/sHn5V+6UJ9BvXlEnw/Et9HqY
	 hWe8Zveaw+Yxs1RWEAKKIO9QVlavS5/poGxdRiIhCJAkOK4LMwC7g4t1yA3tqhPucjc6p
	 tI2KvJUHPa6jOyl8gmyPcjdk3y6J6jQ4M0/M2YhVsgmnSgxryuAHAtxP9AvCnPJ6nyfsf
	 AASPm+hxvXkJLo0yuJgAzPZ8ta1DsGpzf+9qXPAiDMMB91H+fJAXQLATpe0Ew5OLBuKZb
	 HSp0zSoxP4ysCEu4e/f52ByFg4mVi7NAOESShIJLCyePOHlMcOAoH8cbRY2Qw3HBCFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=jRe7KGrlJ8zVa9o/G3HkzBE6A8me3c0geOX4rbgHkF4=;
	b=G3lOQYcyOQjeddIqSKJj/UN1JlOnFsQmzYTH+nc4t/8qu/ZmNtPRIWkIR0R6mmyJEfVS
	 ZIpUaJldH3KfxblXVUv+sE5sO9axZUIZnlY8Q5o2TK2Aj//4hoNGwFVQNeKz3ZKK7AIYA
	 X+g5sfJL/TzRQe+VJ8hGdpGubGYGwlvUEebtfhI1/ypSpco19IcVyn1VsB9VuvX+CYin0
	 mXDFcaxsMwE+XzqJU5dvjJ6Q66HBiUuw5mwnzcLp6BZkCQLJrgU7FQStoA5+0W2mcN6ZH
	 w8QJJ/zF1yOcIaKpns6ccgc8EucYQWRCZSyPa18fkrJ7eZvyilCGPKtSk3RbOrcZtnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrLNMmM9;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350ED60A2602
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 13:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350ED60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrLNMmM9
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso362798a12.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182568; x=1795787368; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRe7KGrlJ8zVa9o/G3HkzBE6A8me3c0geOX4rbgHkF4=;
        b=jrLNMmM9lHGUqE6QnynJ8O2ATi9YDewwhXcStt776MFumhI4uUiEqMm9VR0Yt1cga1
         rls+rMWKqX8h3UpyJOuvi57ydjE7ehpnRKZpnyAbyIrfEuUgeZDIzr4L0+Xr1UQDkfeR
         Y2QgaaFDCLcpDI9kj43G0huL2Ymccn9znNA+8qlukTWd7CocerqfKJuv39ttE1woWSa9
         LIa8UdZmjQ7ai6YdSege2XTpUmS5IVmVGEbGsYDlGcvT7PpBCHX+M/7DUzXJC8YjgB2J
         7XFeRE+HT4TQ3750cvb5cvKOxUEPBrSEZDKHGNfhlrJ2Wj5aveLxig7w9GG1Ys+ZM17U
         rCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182568; x=1795787368;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jRe7KGrlJ8zVa9o/G3HkzBE6A8me3c0geOX4rbgHkF4=;
        b=1CwwivfPgxT+GyEFtt4doxi7etEFvEoeVFOoP0BZjGy6s4GLYZ/ECTZXLpoJT/ZAZf
         4QrLrsgNfeZgsiLEoJb4UaehA5jTiCUPgFbWStJ9FxwBY6KzT90uSaXhjqdFgcyWMUlJ
         Tkgu0gpMIzaPib6TSa0DYkPHiMBKaf79aPXRT7Rr9MP4UiPO79ZNQvVxaL8d2Ew/2fyZ
         Erv3xLTc838jW3mvKvpFln1qMS5zByqlfh2nscH9m5a9UK3UcL7/acL5IKTTEefL/h9L
         vlxMwGi/9ylBuD/+YKL/eOyYWvWd+MYRGkd2KumfVzExYdSMGM/4RbM0X9uzlgaxy4WS
         e/pg==
X-Forwarded-Encrypted: i=1; AL+hErEO4xToBmGCbbYuQNt4ZS7++YIjY/UiEbIMm59RhxQ2ZPTY5DZasW7H+L76/zA7gJZhrTvFsqQtnl/qBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kN59f7GeFQA9Qt+UZWHZYMhZnkPgFj+yRn4/yn9NsDQ5q47lW
	soYKLOJp6Ihska+gpp3T2giZuLv01GczNJT8JBiRhTglVzsiyUAXPDt/
X-Gm-Gg: AZFdTZcsLQwrqGtijXrDIkZi6aauCbSMsVGxFUwPSVzOxDziBVoT12TCUyfXrTneLHN
	LWfHM++zeAFDB3wotAO07RDxfCjIuBw5y4Q6n2/B8KnDQSpqe9e6Rk4BrQ/7nj7kdge2zHm35sR
	cIpfbdEqHruVT1gYuxBFm5qEFxXZhSPaTuX2WMJmVJduUl9SjxiytVMDs0N6dLsOCDtQw10zXoz
	GZaJgyZauEUqEXXZnjIGbRxcMsMENvTcrjN8h6QI1+/EyqLzHzLXp62DxtLeUgEZtgtsjJxjBLD
	cl3XTOcWFh4qmagFi4o2/zZtY0XUhbv1Zp+6oK9mxfSsvS8Mi9yT+yCe9LzqNGt3iflPKbKnBes
	SIlqDnjjg7BvPINSImUjXFQZ1E95ZZhIaNwWHrIhBouKETuwQrDWG6uTjIID5RUvQW+C3AgQ7dX
	TY0ZDYWUJptknRtuN0etv92v2icqU2/UzD4bLObVXmH0yTlV5ZVlB7qjBUEWgG+N3MzHAPuC9kN
	wao4s5NXJ0bDbY/kKJ0y2G2i5bxeZL2bOvnFSKxR0jsJWtozBE1tPrM89Ps4RF4H/Dt32HEsWEO
	vNLNLO2JK+SuVdYOBunDRn4O/jgvx/wZ3MmM89/DQICcYma4
X-Received: by 2002:a17:90b:4d0a:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b41c9cd21fmr2674313a91.24.1795182568459;
        Fri, 20 Nov 2026 05:49:28 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm4530596a91.14.2026.11.20.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:49:28 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jiri Kosina <jikos@kernel.org>, Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
In-Reply-To: <04f2db47461eca6911038bbdb3d8e036dd92776f.camel@linux.intel.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
 <04f2db47461eca6911038bbdb3d8e036dd92776f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 20 Nov 2026 21:49:20 +0800
Message-ID: <1795182560.hid-reply@viennaoffh.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

> Ayaan Mirza Baig posted a similar patch yesterday.

Sorry, I missed Ayaan's earlier patch. I've refined the fix to pass the
callback data and skip children without Sensor Hub platform_data, and am
sending v2 separately. The #syz test request was rejected because syzbot's
automated patch testing is temporarily unavailable.

Thanks,
Zheng
