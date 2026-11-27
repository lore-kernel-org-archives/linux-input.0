Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.255.86.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779829;
	b=xj8JFGqtGLEzWybAmbCVOfFiTmwvtRvXMzEKfWCQC7WaR07UCReG01zzY9UmjWzp3K8j
	 YHrb6gZraa2yShJQYcNZ2o0837OV7udWVoAddv5i0sahJe5/HtRPahDPu22gRPb3xTj53
	 X367zAxLQCFIBJvmkFzI71Q+8uEtYld+ZrA77NouzhnJZXWqxtg9O+oqi4hn6+hyZBuKi
	 QylIQjctlMyWeJZWXXKWNbm8+O9H6/oZG57JL/e5zFy0h2wRYK1ewm6JP8TnreWYrUP9x
	 79ACvYD54Kp6GNTyMP9Z8pDuU5nZudo3mu5T6au1A7fjQqRlwH9UXA8GCGT0L9k6dQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779829;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=9BDNIK/cbt3ruWqxqJxIqM0/1T2yTZ8ddMmR8eSfwuA=;
	b=wmKMA3JDI6CUmSo0gDv/0/1T+hD/Q6I2nOS9K938wqthTQQ9/kR27L2veqbD1qnNCfV/
	 qYvyl5GxklNzp1zYi2qXmdoyltZ4Xz2Qt58J5OnPshNsCztShNkoJBEJFykQW3tDlB6ug
	 zo0j6lzPVsXdGh06ce41wNeyquxklHAYc5hqtdsHLyzFZvqqZlhwym1z/e6RCR2Pw2LUP
	 KMbASw2yUCLa+a6aA6iYfaFomFhYghvAnZcE1nU6Hr1ztvu7ERBrtH3S3LDoul4kMAw+G
	 BIJmR+zxUdZ8smmfIrGBX1jpg4ci/XghBTtYGr/0G7B4fd+0XTRpm3NgarUcPpL8waA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldred.fr;
	spf=pass smtp.mailfrom=eldred.fr;
	dkim=pass header.d=eldred.fr header.i=@eldred.fr header.a=rsa-sha256 header.s=dkim header.b="j0/62fNi";
	arc=none smtp.remote-ip=51.255.86.93
Received: from mail.celforyon.fr (mail.celforyon.fr [51.255.86.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9C606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 11:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF9C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eldred.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldred.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=eldred.fr header.i=@eldred.fr header.a=rsa-sha256 header.s=dkim header.b=j0/62fNi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F6011783D7E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 12:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldred.fr; s=dkim;
	t=1795779818; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=9BDNIK/cbt3ruWqxqJxIqM0/1T2yTZ8ddMmR8eSfwuA=;
	b=j0/62fNiyA5miq7qDsZYpcmLV0Km6xYh7yon5XlabJmcNhMXIQchZdyT4k7lo8zzQyQ48D
	MFWCH0ZsnbQYIF5QM0FS4l9nOzMdG0cusLs7wr/6JTAQ7FONcvUqWiSZm7fce5zom3xLKf
	fwgtN2qwFbHTt48ytQwPk08lWsJ6QLGgT8ija1hL2DMNZUfDFHnHBCiD5GSMHL2acI6hF+
	VVeSKZYX7+RxfI4eR3SOVsuWvaKFMuClTtEc9W3X+c7uawqPq0eSQkIDF9saEtXddhWD18
	h9Vcwaw1aVJl53rSWHl1pi4lNXTqy32LIZ8G2aEmcJs+YYDzKHPAxSQ+S2NFXQ==
Message-ID: <82edbae6-1338-43d8-8239-de80f098426c@eldred.fr>
Date: Fri, 27 Nov 2026 12:43:37 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-input@vger.kernel.org
From: Eldred HABERT <me@eldred.fr>
Subject: Wacom Graphire2 4x5 unreliable(?) init
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello!

I have this (admittedly old-ass) tablet that I occasionally use on my 
laptop, and I've recently tried again only to be met with failure.

I'm running 7.3.6-zen1-1-zen, but I've done a bit of troubleshooting on 
7.4.0-rc4 as well, with the same symptoms.

Sometimes the tablet works just fine, but most of the time I get these 
errors from Sway:

 > [wlr] [libseat] [libseat/backend/logind.c:121] Could not take device: 
No such device
 > [wlr] [backend/session/session.c:340] Failed to open device: 
'/dev/input/event14': No such device

I've checked and it's not a permission issue, and I can `cat 
/dev/input/event14` just fine, however nothing comes out of it neither 
as my user nor `root`.

No kernel messages hint at anything either, I just get

 > wacom 0003:056A:0011.0009: hidraw4: USB HID v1.00 Mouse [WACOM 
ET-0405A-UV2.0-3] on usb-0000:c1:00.3-1/input0
 > input: Wacom Graphire2 4x5 Pen as 
/devices/pci0000:00/0000:00:08.1/0000:c1:00.3/usb1/1-1/1-1:1.0/0003:056A:0011.0009/input/input40

As far as I can tell, thus, this looks like a driver bug, hence me being 
here. Please let me know if there's anything I can do to help!

Cheers,
~ Eldred

