Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793008558;
	b=k0PvhgdouC0MQeQcIC5mUTXl2n+iLy4IRrCNQqWDtoSw2WbjzcaBVGdf05MVkI2WzL2c
	 hSnd0reEiYVaD3uNAh3M8pgAjbBRx0QtxCxWrzDVNJms1VnwzRuJzIbXcFRR5vL8eZ0Pt
	 NxA3Ijg5ZUyfDDznaoUpRErwTtZaryF+w33tvm2LQCNTbVgv7AAOoNJX8V1RaBUw5eqFO
	 4d/wz/iV/C9gaWsJBfCpPYj5LmVsyMmBbkwVZAE+XTVwsSEaKL633v1DbEwmdniTUHOJh
	 5XnhTtXOeNiFIS0U7RyrzDkhsy1+/bzoBzsp0Fll1pq8L9yDI9RCT3q45dAQCV14QzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008558;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SXPNAY8BSpBE8W0KP7BX69lYI7ILVN9z/tYUg7mD3/I=;
	b=cqcf6fblThCHH/I4TBGOL667xvfWtEW0zFZI7jcXDydbg6RQzI5nmkwSXMfYCEp2tNgw
	 DZyQSXmoaoNAOXUgpvn1jgDjWjTUn+qxJzsg2IB2ZQVw7q4G9Zs7hVjrb+ZYkr7xjcFYu
	 r/P7mXCpI8+Jksv8FYpdfaq5ByPyrN2CMYrFXUHew9/u+6Rl+8HNpyAqOK7i5t2seBwAC
	 OapQ7ddVWD6XV3SFrKZIg9rkSLTgAjgMbRHS9NCZ3LC4qo4VdJL/1QMlXXy5gk5hEZuUg
	 Rr5NLOQNYCdBE63dcU4H1dRL06r9OrqU/dIsVkS3wK4+878bXj91lJ/VEE0rpL2hXAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b="a/C2+aNA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F01606A32C;
	Mon, 26 Oct 2026 09:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F01606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=a/C2+aNA
Received: from hillosipuli.retiisi.eu (n18ws8cotq5gnfn8-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:0:19f:4ce7:0:938c:d2f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jCpsT69WPz49PyT;
	Mon, 26 Oct 2026 11:55:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1793008544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXPNAY8BSpBE8W0KP7BX69lYI7ILVN9z/tYUg7mD3/I=;
	b=a/C2+aNAJrW2T5Bs5DLkevetIeUQyTeGae/1pMTnZBJhsw8iAjkRUUxRJmmNvoExvBsSCS
	frJTpwITPW9Q80CUt07/DtkPAVXuNpDQFx6ngk3Sn5zgEEM6gFC1/uYjehoZJFguk2cj53
	4i2hsZXVNJcfmFJx+Qe2OktuL4HRLk1fuOj81fnOFHpYGNH4WxHswVSZYk89EfaBFUcIHG
	6Zl0r32F9BbJ/2gwI3+WhA5egzAADvcFuOQVj5Cf4tvsc2Jk9ke/yNRtb4SWbwznXYh3yr
	DaUOHJL/zsGIZ2kSTo3W/5dt2n0O71jzEkB5rfcxFiQeddM4VTwxAwfYl4FHpw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1793008544;
	b=POIc3HgcX0pvYdu9LaOiyOoZ6JFPzY2sVQDsXQo6eGOJ3jJY+IunoTBsPbnYhjgRAOqJiv
	/dPsWdN1+RE/ZfIr/qaldEtVnVy8Oy4NOv+cZjEXosxlqqrzrTBBUZHDtNaiePxv7pwt87
	vxEqNjWU7gdTW2R9Hua9X7JUvODK6hqbYx1wjFukG6g2t0e5PROw4GbIWQa4o0TLsXGXg3
	k5KDNjASAjmTzOzACVLnORvQtuuuuQfCHPbiGoFhOjxZhvj5AK58lb3HKRXbQLBlBXRUPp
	LAXviSuDb9h/QDovJ9XHXZwnzIwO2BSIC/hqCDq+hWbYDZH7rGUVsuFv+g1cHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1793008544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXPNAY8BSpBE8W0KP7BX69lYI7ILVN9z/tYUg7mD3/I=;
	b=hUU6l60GhOADfQUl0tgp4uxVB5WdVriwf+gVcM+dMtDoy3ZddZSp7/nvBcBQNlBbDLmtE/
	r5IOuzp5ZymkT6atJdYDjpFt/oE7+nJ82kXpEy19p656wO4pT5bciXqnZLGCmDXokzJwSL
	1+o+/djnxsAQEJ5EycPcz70MNk4XIFC3JUyk84iDY4dsQZRQypkYg1j7DxX7Nalo4Pm8zO
	fWoofYCj6vBhORZJX01Q/F5XaAxkfuSMoNQtNTdcLspP9pfpAS1NN+BQIodTyXZdFDz+7e
	Vh+tmnN3YczJXTwBiPVUWz+yTyx/NaqZ2oQbfgPjFDpO4PBBkzGR6nGK4LROLg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 18CAA634C4E;
	Mon, 26 Oct 2026 11:55:41 +0200 (EET)
Date: Mon, 26 Oct 2026 11:55:41 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schyboll <dragonn@op.pl>,
	Denis Benato <benato.denis96@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] hid: asus: always fully initialize devices
Message-ID: <at8jnW4RaMPJItUK@valkosipuli.retiisi.eu>
References: <20260216175539.12415-1-denis.benato@linux.dev>
 <20260216175539.12415-2-denis.benato@linux.dev>
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
In-Reply-To: <20260216175539.12415-2-denis.benato@linux.dev>

Hi Benato,

On Mon, Feb 16, 2026 at 06:55:39PM +0100, Denis Benato wrote:
> ASUS has more devices other than laptop keyboards which needs
> to be initializated: the init sequence is the same as keyboards.
> 
> ID1 and ID2 are USB report IDs that are correctly enumerated:
> send init commands to all devices that supports those reports IDs.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>

This patch appears to break input devices on Asus T100TA. With the patch
applied, I'm getting a steady flow of:

[  256.358075] usb 1-3: USB disconnect, device number 120
[  257.034324] usb 1-3: new full-speed USB device number 121 using xhci_hcd
[  257.175003] usb 1-3: New USB device found, idVendor=0b05, idProduct=17e0, bcdDevice= 2.49
[  257.175050] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  257.175073] usb 1-3: Product: ASUS Base Station(T100)
[  257.175091] usb 1-3: Manufacturer: ASUSTek COMPUTER INC.
[  257.180978] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:0B05:17E0.02DB/input/input749
[  257.266585] asus 0003:0B05:17E0.02DB: input,hidraw1: USB HID v1.11 Keyboard [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input0
[  257.270711] asus 0003:0B05:17E0.02DC: Fixing up Asus T100 keyb report descriptor
[  257.272302] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:0B05:17E0.02DC/input/input750
[  257.327059] asus 0003:0B05:17E0.02DC: input,hiddev0,hidraw2: USB HID v1.11 Device [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input1
[  257.332642] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:0B05:17E0.02DD/input/input751
[  257.334115] asus 0003:0B05:17E0.02DD: input,hiddev1,hidraw3: USB HID v1.11 Mouse [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input2
[  257.336098] asus 0003:0B05:17E0.02DD: Asus handshake 5d failed to send: -71
[  257.336263] asus 0003:0B05:17E0.02DD: Failed to initialize 0x5d: -71.
[  257.336605] asus 0003:0B05:17E0.02DD: Asus failed to start multitouch: -71
[  257.367022] asus 0003:0B05:17E0.02DD: probe with driver asus failed with error -71
[  257.367917] usb 1-3: USB disconnect, device number 121

I haven't tried to debug this yet so just FYI.

-- 
Kind regards,

Sakari Ailus
