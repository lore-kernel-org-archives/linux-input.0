Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E93E1D09;
	Wed, 25 Mar 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450019; cv=none; b=eASCPonrDCIszlwkoRWifPoIdvCKL/g4qNoJrpE1eLdzJm6W0X/jpaFDRwSMAs9Uoo3aLLv8D2KKcdOC0a6reTHpd7UxCx+vQDq6QY/ksOLD7i2+RV30WChfKIY5wcdLsdCT3Ii2W8HWfv2RmZunDhuTYPeG+mhsSRwZscpOJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450019; c=relaxed/simple;
	bh=iEtWqnaNHDK+HKROoZFAFhlgb9sMKAraf5fE2xdLZAo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ud1pikD3nuokq6w5GS9d9VJy3gG4oMF9dOvfWBnbbkJ9/EeVU4yAzwbeyAA1KqENfukZ08/F0WXtKAnSP+YBewAlvSjM5jSRSXzuHHaA9bIQ4oMvQkpuRD6Bms4DuWt643hZdjYAUXHhCwqKm/thk/0N31m8LPfEQG7uoysbESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=vvpAAVHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dFv4xJT/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="vvpAAVHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFv4xJT/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B5A01400218;
	Wed, 25 Mar 2026 10:46:54 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 10:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774450014;
	 x=1774536414; bh=z7qXp1yIZCNMXld9KFgoV7znI1zKPo766t3TOhqje+A=; b=
	vvpAAVHHB8NgSvrv1BIYfYLIXmXiJl07oaJV/rwX98dKU9QjHg3bim2oVausI3Na
	A6A5/0HIXO0X4gmkwDJDbzFXWLBGTSDyK5r5LU0TBuGJl5LgOJE+LpG0GuKyVPfb
	qw+297/9XiPh1QPtMKObGr/Rzcgyyx2b3rV3U6Dm27XQfycroqxNTfPuNrHquFfP
	iqN4Wu9LymcaIq57VPRlew32GNkHyY/AfcdTJkAG+BkkCc37SF97oLqMMgIBbLML
	vE1KvftkoMs/cf2bzJaVXAC4pGDMI7n1ElEu/JsZKi9SsP65ZUZBNRikRbXpxWXI
	o+nbq7OeUnDJ7ijAUCXXzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774450014; x=
	1774536414; bh=z7qXp1yIZCNMXld9KFgoV7znI1zKPo766t3TOhqje+A=; b=d
	Fv4xJT/d5h2g6E6QYuVRspsenLhfu08TDPn1ZxcKT93hqzqChOM/Fs6ahE2vyY3e
	jY/tyK855gYAI409ABeaA7rXQeqfsUwbjxYyymVrrFvia0hBNev64trbMXT/P5/V
	zb1izl1t4dghcxUyKFsSVmfPOhRuBIsgSPCx0+WKZxew73arFq1Hp/KUM9S27CbA
	AcRpEJ4O5U+VJBxbZ9571fN1a8Qw9MA2/9Yx5Et1aMYkgzKF52D9aXcsSeBY11P+
	1VfljKcINLb6CBVyG24toQCugiOZZ+zbb1do5hMLQimhdsxr1RdlwO/aI9R0femT
	7hwaodH5pYEASAnA+JNwg==
X-ME-Sender: <xms:XvXDaZot0d6Sl4mj01RxZrqAUaEaTBQ9_y2VeBGj7PCnvfpy6MQyXw>
    <xme:XvXDaWeajz83Izy53V63dIN1f7qDGxRj8IsN8ibAKJ8A9tjP3g8KLhkgA2mnDord_
    HJwwDJ5td2-wvLLiu227c2701vmiUGrDDld8WDpSfNhGf56TtuiOEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
    hiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopegrrhhnuges
    rghrnhgusgdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvg
    hrrdgsvgdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvghthhgrnhhtihgumhhorhgvtdeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhguvghnohhsvgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghr
    nhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XvXDaegdMOXhD_Fk34ZTrgw2cgdrlQkErJ29d5QMp2LCyGBQj5EXMQ>
    <xmx:XvXDaXL9Ob3GgwiG_l5EB8YF6VTBHL_UbqyFOfqYEWuc2ss9He8hqw>
    <xmx:XvXDaVljFva7nA6OD-2hLzq1N9zSwJo39pxU0Z6o9b-NnF8Hw55wSw>
    <xmx:XvXDaXPBQPt8EL4-7s1bhfnm7qq_I4MRfLsjxy_Y14Tz6s1wb-YBNQ>
    <xmx:XvXDaToIwoYmba0B2kECkrp6_kb8DQSG4kO7y5XMxfMR6PWrqVPGCfNO>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F10DD2CE0083; Wed, 25 Mar 2026 10:46:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApD5rVnmxPON
Date: Wed, 25 Mar 2026 10:46:33 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Arnd Bergmann" <arnd@kernel.org>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Ethan Tidmore" <ethantidmore06@gmail.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Aditya Garg" <gargaditya08@live.com>,
 "Jonathan Denose" <jdenose@google.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <eabb24a2-6703-4613-bc3e-62e3fdd6155c@app.fastmail.com>
In-Reply-To: <20260324192045.2895560-1-arnd@kernel.org>
References: <20260324192045.2895560-1-arnd@kernel.org>
Subject: Re: [PATCH] HID: hid-lenovo-go: fix LEDS dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, Mar 24, 2026, at 3:20 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added hid-lenovo-go and hid-lenovo-go-s drivers attempt to
> 'select LEDS_CLASS', which has a dependency on NEW_LEDS, causing a build
> failure when NEW_LEDS itself it disabled:
>
> WARNING: unmet direct dependencies detected for LEDS_CLASS
>   Depends on [n]: NEW_LEDS [=n]
>   Selected by [m]:
>   - HID_LENOVO_GO [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
>   - HID_LENOVO_GO_S [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
>
> WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
>   Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=m]
>   Selected by [m]:
>   - HID_LENOVO_GO [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
>   - HID_LENOVO_GO_S [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
> ERROR: modpost: "led_set_brightness_nopm" [drivers/leds/led-class.ko] 
> undefined!
> ERROR: modpost: "led_set_brightness" [drivers/leds/led-class.ko] 
> undefined!
> ERROR: modpost: "led_get_color_name" 
> [drivers/leds/led-class-multicolor.ko] undefined!
> ERROR: modpost: "led_set_brightness" 
> [drivers/leds/led-class-multicolor.ko] undefined!
>
> Device drivers generally should not select other subsystems like this, as
> that tends to cause dependency problems including loops in the dependency
> graph.
>
> Change these two and the older hid-lenovo driver to behave the same way 
> as all
> other HID drivers and use 'depends on LEDS_CLASS' or 'depends on 
> LEDS_CLASS_MULTICOLOR'
> instead, which itself has NEW_LEDS and LEDS_CLASS as dependencies.
>
> Fixes: a23f3497bf20 ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S 
> Series HID Driver")
> Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series 
> HID Driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hid/Kconfig | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 10c12d8e6557..f658ed0168ea 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -610,8 +610,7 @@ config HID_LED
> 
>  config HID_LENOVO
>  	tristate "Lenovo / Thinkpad devices"
> -	select NEW_LEDS
> -	select LEDS_CLASS
> +	depends on LEDS_CLASS
>  	help
>  	Support for IBM/Lenovo devices that are not fully compliant with HID standard.
> 
> @@ -626,8 +625,7 @@ config HID_LENOVO
>  config HID_LENOVO_GO
>  	tristate "HID Driver for Lenovo Legion Go Series Controllers"
>  	depends on USB_HID
> -	select LEDS_CLASS
> -	select LEDS_CLASS_MULTICOLOR
> +	depends on LEDS_CLASS_MULTICOLOR
>  	help
>  	Support for Lenovo Legion Go devices with detachable controllers.
> 
> @@ -638,8 +636,7 @@ config HID_LENOVO_GO
>  config HID_LENOVO_GO_S
>  	tristate "HID Driver for Lenovo Legion Go S Controller"
>  	depends on USB_HID
> -	select LEDS_CLASS
> -	select LEDS_CLASS_MULTICOLOR
> +	depends on LEDS_CLASS_MULTICOLOR
>  	help
>  	Support for Lenovo Legion Go S Handheld Console Controller.
> 
> -- 
> 2.39.5

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
