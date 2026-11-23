Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396941;
	b=MmW1rMg+ukmlot14ImjVxVipUonO4elIlP/2X9PNiEfn+xTHpp5TbHbXo9qbqxnjKba3
	 9MNJ2qmu9i6Y8Sqsor+cpj75wOdSDo12HpnWxhMboLniQMPp/BFzoAdnN2c10xLmBq8q+
	 YHHpOiHHuCePl8lLOS0BjedAZAc7AEiIDnOmfYC4msE11iNaLNOs6ClWzbMZp6eXGoMD8
	 QNc3X109jYnwHGgPWJAP1mnPPOT/jAEMrjakQDw7QP1/Oqctm4secQzR3us9ewcTAxD9I
	 yAeakwsVzMHrPli8mM4ajo5j5kbwf3QNfAe81YH4Ramqdwg1p4KXiljM22+7gvjh3mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2Q8qQWgKcP+xT57roRgQ8IJ3xXja0pQGrqCS2TbAAfE=;
	b=zYl0kj1gaLZoLFPTfRnfwUSBgSBqONhQKXp/8UpsctHL2NmqTwJ5SISJUwskj5EMQGfZ
	 whYGjSQF55Dk2DCwgHznmCH6heA4oGjmT0Wjam2zH78c4YfDyUuT+6MSuqVChZWywquAj
	 a5uLl34prOCOvi4ta2GFRIuJF0+ec2C64Z2P53NoXcwQqUGi5zPncG3QO3NI0A5au2ZVH
	 X+/C9CKxTwEA+dFSO1JfrefPK3yWXxHBVONNrifhdqsY79zHUtn5P7/okKAYbQPUctt/E
	 e3qfTNJVdxIwoY1oiVqeGUdHvpiEnY4yqWdd5kbiU8eXRBthjwVv+6WFYbXs2nkpqww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcnD80S6;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECF606A327
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66ECF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcnD80S6
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3acec6677so3909679c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795396940; x=1796001740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Q8qQWgKcP+xT57roRgQ8IJ3xXja0pQGrqCS2TbAAfE=;
        b=rcnD80S6RHlSfFU8FCgfOc0ABV95p4Il5Ah/CGuObNMNDoi/6q+Szy1oe0iVWlIMoL
         Y/Rbloz1sA1ibz7cbUzYlxer4QwSEaU/Tbdzzq5M+1S/1I5jDzcyw3hmxyTqXJ306W61
         L048QyV6ekg3eBAbQ6i322m6qMqFIgtFb9Qlw4oVGC/FL8BeAWtG49fyAdFRvDWVeRJd
         uuaPN6YzRDDZ4+wOBgkh1W9gZYI4AtnucAMEh1TM+QZKabFMnJk94bTuPsfrN27Vp+rV
         KVC5KxLp2ILW4CluX3r5RTzj9fukwcR9HaTsu6ACUYQZENPCfO3iRFAo/38PeXP6GU3B
         HLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795396940; x=1796001740;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Q8qQWgKcP+xT57roRgQ8IJ3xXja0pQGrqCS2TbAAfE=;
        b=wiNK+1s+SSxCZd+49fAoAZwauFAdAvtygFgFXbKv5qDKzu3fR4tzdJYN+BQl7EJn/r
         LJJD74290d8S5Ci5Lvxwiu4K0IIWKaYpKDFgpppzbfIF0GTWvi4dnij0VZDPXtyWOqgQ
         BoQH/ZW3bbKFvwATTjKZtPLPtygj8caHNZPgRzJMsrdOdxlG0WFpBcT9xOw6wmUhzY5Q
         8C+Yo5Yq+TDAyghrByPnr7ThesvCuU4JtEp9Iy39842yUNmY0GiYe/kr8sl5Hkp/vk95
         SnL9KUzpyGvMzPiWHM2HTcl6CVTF/5Ml+HDyPUkUqfNJNpKPaZwW6phJ+sK6QzpmcspH
         L8zw==
X-Forwarded-Encrypted: i=1; AL+hErG1WOVn0IvH1yBu1VCU5eyL5QGDk9VYtb+/WGTfU9C2oMDgpub/IXTb7jstWzY24TdV3rMNUCaQoLE7/g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+b7OugQDxTHZBkmi+3G11a7lriaCSMIxtRC8XtNeR7Q9rpJFma
	xakeX4xWuskbW1swl1vkLVJuP29crob7DNLTMU5a8WqBC02HYS8rPGt0
X-Gm-Gg: AZFdTZdcvg6ayr8+7MAjhxRjZYiPCO2XOz1zqTtETciXfbEpvZSwbkhkqfvK1oRs6gx
	S9ZsXiHvoaeoT2/fW4mijCz82FUXiuS3AdvKAiVDBWsiNmvLFqry19K5Iwp7TP8S1pzKFdFt08O
	M8elTCMQXY/beap++n7GUDpuIvp1ZzeJjMvJbzFYdn/iNUyQqL69PdTrWu8cmjDvwlg8gB+NTbH
	4npjFGT+UKp/hqLJDNbBMDiaVCM3CfvuVLYon3gqdgHjFYuxSryD8qtFvIBStqKyGKGBu06JeYc
	Zd3epPRjIHXJOiAr7dzOT3OWXlSxJi1CQpQ0zxkL9Qzdv/CTY2y6mU8aZ9rRlKSfo0s/Xl/nasO
	i4lS993OYq3b8q18+VzG87GH0fozMzeYgCjOmhQH5ENDjpbN/jnw2RHHrsL//9ADyX8QRLXHwCU
	hI4Y5TQXG62awJH06C6IGMgPqjKmABf5UZps3gh7VUNvENX5lu7kByN9eYao8H+FhYTjklZGAad
	qkCAAn2oLOP9407HZxQkNgwoFA/CK8xc5RF4cVm3cR5LMD8TQq616yNyXlm0Nfu8wB+yliO10iN
	hzcgDI+ib12OownTfdveVSh7KqvvZcc2on+pE/heBGDvtSmrefDUuDTUFJXohNLkK19RAfI=
X-Received: by 2002:a05:701a:ccca:20b0:1b5:71bb:6800 with SMTP id a92af1059eb24-1b571bb698bmr1863335c88.3.1795396940552;
        Sun, 22 Nov 2026 17:22:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm22955681c88.2.2026.11.22.17.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:22:19 -0800 (PST)
Date: Sun, 22 Nov 2026 17:22:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, 
	Thomas Reitmayr <treitmayr@devbase.at>, Shaun Jackman <sjackman@gmail.com>, 
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Florian Euchner <florian.euchner@gmail.com>, 
	Johan Hovold <johan@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Xue Lei <Xue.Lei@windriver.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: remove obsolete cm109 USB phone driver
Message-ID: <awOVNaQM8_Hb5E3H@google.com>
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112001642.243554-1-dmitry.torokhov@gmail.com>

On Wed, Nov 11, 2026 at 04:16:40PM -0800, Dmitry Torokhov wrote:
> This short series removes the obsolete cm109 driver for mid-2000s USB
> VoIP/Skype handsets based on the C-Media CM109 USB audio and HID
> controller (0x0d8c:0x000e) and drops its module selection from
> ppc6xx_defconfig.
> 
> The driver was written in 2007-2008 (modeled after yealink) to poll a
> 4x4 phone keypad matrix and toggle a buzzer wired to the chip's GPIO
> pins across four phone models (Komunikate KIP1000, Genius G-talk,
> Allied-Telesis Corega USBPH01, and ATCom AU-100), relying on a module
> parameter (phone=...) to choose the keymap. The mid-2000s userspace
> VoIP/Skype bridge ecosystem for these handsets is long defunct, and the
> driver has seen no new hardware support since 2008 while continuing to
> attract syzbot crashes in its custom URB state machine.
> 
> Furthermore, because 0x0d8c:0x000e is the generic default C-Media CM109
> VID:PID and was added to hid_ignore_list[] so cm109 could claim the USB
> interface, cm109 actively interferes with non-phone CM109 devices still
> in use today: amateur radio interfaces (Direwolf, AllStarLink, SVXLink,
> UniPager, Hamlib) have to blacklist cm109 so usbhid can expose
> /dev/hidraw* and so opening the input device does not pulse the GPIO
> pins and key the radio transmitter's PTT line, while standard USB
> headsets with 0x0d8c:0x000e can bind to usbhid directly via the chip's
> standard HID Consumer Page volume and mute descriptors once the
> hid_ignore_list[] entry is dropped.
> 
> Thanks.
> 
> Dmitry Torokhov (2):
>   powerpc/configs: drop CONFIG_INPUT_CM109 from ppc6xx_defconfig
>   Input: cm109 - remove driver

Applied the lot.

-- 
Dmitry
