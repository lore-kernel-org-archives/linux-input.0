Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BF182D0;
	Mon, 26 Jan 2026 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769388843; cv=none; b=fgv8G8aEsKCU8xB7lqCt9QCZ8fJMa/i/hgB9Q7HqACOU72TnYB4dpj8wMPvaYlcgERVwuBa6o7uxuvfpCJLHhOraCPVXprL3EUBW5FqV+LV5s2IvIIpMzz9BwgEeMYXAqGqISMoRTYq44M/nUkfFzl6kNYlw3G2PYRbsdMgitzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769388843; c=relaxed/simple;
	bh=4yrNsxakZLTJmcroe94KZKgeBTSSJm4VLVKOqUj4Mnw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bKDXbam6KKHlQE4h62+AmnB9wS30UhcbNM/rB9KpDi5UltTfGwHoui/UpDrvySTDr8OMEVTs+d+PHuN13GqWnuerSzMuKhXwIsRLhqT2Z+/6YhvdWe9VkBJW2Tq/2hccaiIrkQuOgq3lZyBFbAoRxU2TR2qxsZ+Elh9szMYUQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=QWx7j2+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrwDb+AO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="QWx7j2+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrwDb+AO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7E291400102;
	Sun, 25 Jan 2026 19:53:59 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sun, 25 Jan 2026 19:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769388839;
	 x=1769475239; bh=BFJ6Zn7DLwNKVMODnPj8XRWiPzMllQ7V6/0qZdgdcE8=; b=
	QWx7j2+Pqtx/i+dIvKV/bSkC/nZLnLbr+rrMyUaSYpH8wdzp4nbtI8wnWdYhwGQX
	LlaqZyqhiZUfxxhxmpy699WKXflpG21dZPgn2FM/WrONI8YTc6HLEKDbrH0eD5Cg
	c1kK7IxBswsCfhvP+z3PWhW/yOEXWzG0ATXCyWT/BtcbSdUyC3JCO86IhKCTqwOt
	83Xl2yjoaV/sTHatCEl/fwuVPeZIjF8n2dNTRy3i2wzK/kWDVbLPbE0ElADuThpt
	VNATKwmFOVN8ua8rA6LetgAbFqwjCcQQTxD7Uu110OlaEBFSYb+g/4gdpKUYt5ia
	v3ycBmtuE4NXHwllj+bwKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769388839; x=
	1769475239; bh=BFJ6Zn7DLwNKVMODnPj8XRWiPzMllQ7V6/0qZdgdcE8=; b=Q
	rwDb+AODyMjUT4c+5dMG/rZprVqtbcXMkwrvHwHZHVVCLUCJyjPKSvPHHvXOiIk6
	Wwhw8u39YmfzaM0jRUjA7Qxr+QsfWn5w1rKlpGUnspO0thfBiJdWSkVUr388S0E8
	/EugnuNHRReeEdlhz91xWgDHZHnyrvpp5fn1lLBkFGVgiWYinSKz0Y+4Qx3n4t8/
	TXxk6lgyCr++Mi5RT8rpJqN0GElSE9mCUi/ACwVM1YG2wyMxC5ZnBZZAX06ezWFo
	XzXDcOKX3jOihNKJWP9b7b8F8FiOAZW9dKAMkFPmEj0+nAm4PSgH/RdFEJhRvZNA
	6255nqajCiBs6/U9G1Z8g==
X-ME-Sender: <xms:J7t2afgf28U_YJ5KGAm8pJsI0yBVWu7a5v0neFdRd-zisFXvmPhhBg>
    <xme:J7t2aW1ANIEPUOxgHBPCmqz03y2CQq0HWChhO8A8ABTWIxUFaMvlDg4PJXUoEUeW4
    YnXmKeCZYChUH1rGrFo5JR7DIP2nUC6JsN25iycgAjefWhU86BYB2qf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpeelvedviefhffegleeiueegtdeigfegleeltdehkedt
    uddugeegfeehueeluddvheenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtph
    htthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhiohdrlhhi
    mhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeguvghrvghkjhhohhhnrd
    gtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhhrghohhiiudeslhgvnhhovhhordgtohhmpdhrtghpthhtohepiihhrghnghii
    giefieeslhgvnhhovhhordgtohhmpdhrtghpthhtohepphhgrhhifhhfrghishesvhgrlh
    hvvghsohhfthifrghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J7t2abEfr_eK3xZ7sz85GL8FVIdExIIheXq_LizSEVt8X5t1x8zJ-A>
    <xmx:J7t2aQiVp0OcePtkPr2EOrrEtPmbc29lbho8I6t0xCkf_vXDiYzjAw>
    <xmx:J7t2aYtmGjsZ_b_MXBahmgIAgaap4IqyIHc7XnF4C-5FHrLmX-R9hQ>
    <xmx:J7t2aTsR-1bjMgY2qYKU8gOqyS_JGEFx9LIobaPPMKWpHn_lF-VTpQ>
    <xmx:J7t2aV6i4AIfVLazlNIDB3WZewIF-jsn5WygUeXHKr2oa0Xwf8BfGRLn>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 389472CE0072; Sun, 25 Jan 2026 19:53:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AieL9ZmtN4OB
Date: Sun, 25 Jan 2026 19:53:38 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Zhixin Zhang" <zhangzx36@lenovo.com>, "Mia Shao" <shaohz1@lenovo.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <9c470f55-2f53-4669-b976-9a81d8bfe856@app.fastmail.com>
In-Reply-To: <20260124014907.991265-1-derekjohn.clark@gmail.com>
References: <20260124014907.991265-1-derekjohn.clark@gmail.com>
Subject: Re: [PATCH v3 00/16] HID: Add Legion Go and Go S Drivers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jan 23, 2026, at 8:48 PM, Derek J. Clark wrote:
> This series adds configuration driver support for the Legion Go S,
> Legion Go, and Legion Go 2 built-in controller HID interfaces. This
> allows for configuring hardware specific attributes such as the auso
> sleep timeout, rumble intensity, etc. non-configuration reports are
> forwarded to the HID subsystem to ensure no loss of functionality in
> userspace. Basic gamepad functionality is provided through xpad, while
> advanced features are currently only implemented in userspace daemons
> such as InputPlumber[1]. I plan to move this functionality into the
> kernel in a later patch series.
>
> Three new device.h macros are added that solve a fairly specific
> problem. Many of the attributes need to have the same name as other
> attributes when they are in separate attribute subdirectories. The
> previous version of this series, along with the upcoming his-asus-ally
> driver[2] use this macro to simplify the sysfs by removing redundancy.
> An upcoming out of tree driver for the Zotac Zone [3] also found this
> macro to be useful. This greatly reduces the path length and term
> redundancy of file paths in the sysfs, while also allowing for cleaner
> subdirectories that are grouped by functionality. Rather than carry the
> same macro in four drivers, it seems beneficial to me that we include the
> macro with the other device macros.
>
> A new HID uevent property is also added, HID_FIRMWARE_VERSION, so as to
> permit fwupd to read the firmware version of the Go S HID interface without
> detaching the kernel driver.
>
> Finally, there are some checkpatch warnings that will need to be supressed:
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> 1292: FILE: drivers/hid/lenovo-legos-hid/lenovo-legos-hid-config.c:1085:
> +       case -ENOSYS: /* during rmmod -ENOSYS is expected */
>
> This error handling case was added as it is experienced in the real world
> when the driver is rmmod. The LED subsystem produces this error code in
> its legacy code and this is not a new novel use of -ENOSYS, we are simply
> catching the case to avoid spurious errors in dmesg when the drivers are
> removed.
>
> [1]: 
> https://github.com/ShadowBlip/InputPlumber/tree/main/src/drivers/lego
> [2]: https://lore.kernel.org/all/20240806081212.56860-1-luke@ljones.dev/
> [3]: 
> https://github.com/flukejones/linux/tree/wip/zotac-zone-6.15/drivers/hid/zotac-zone-hid
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> Change Log
> V3:
>   - Fix Documentation formatting by removing extra + characters
>   - Fix bugs in hid-lenovo-go-s IMU & TP RO attributes being tied to the
>     wrong _show function.
>   - Rename enume os_mode_index to os_mode_types_index to fix collision
>     with os_mode_index attribute.
>   - Remove accidental rename for enabled->enable attributes in patch 4
>   - Add SOB for Mario in patch 10 as Co-Developer
> V2: 
> https://lore.kernel.org/linux-input/20251229031753.581664-1-derekjohn.clark@gmail.com/
>   - Break up adding the Go S driver into feature specific patches
>   - Rename Go S driver from lenovo-legos-hid to hid-lenovo-go-s
>   - Drop the arbitrary uevent properties patch
>   - Add Go serires driver
>   - Move DEVICE_ATTR_NAMED macros to device.h
> V1: 
> https://lore.kernel.org/linux-input/20250703004943.515919-1-derekjohn.clark@gmail.com/
>
>
> Derek J. Clark (15):
>   include: device.h: Add named device attributes
>   HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver
>   HID: hid-lenovo-go: Add Feature Status Attributes
>   HID: hid-lenovo-go: Add Rumble and Haptic Settings
>   HID: hid-lenovo-go: Add FPS Mode DPI settings
>   HID: hid-lenovo-go: Add RGB LED control interface
>   HID: hid-lenovo-go: Add Calibration Settings
>   HID: hid-lenovo-go: Add OS Mode Toggle
>   HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver
>   HID: hid-lenovo-go-s: Add MCU ID Attribute
>   HID: hid-lenovo-go-s: Add Feature Status Attributes
>   HID: hid-lenovo-go-s: Add Touchpad Mode Attributes
>   HID: hid-lenovo-go-s: Add RGB LED control interface
>   HID: hid-lenovo-go-s: Add IMU and Touchpad RO Attributes
>   HID: Add documentation for Lenovo Legion Go drivers
>
> Mario Limonciello (1):
>   HID: Include firmware version in the uevent
>
>  .../ABI/testing/sysfs-driver-hid-lenovo-go    |  724 +++++
>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s  |  304 +++
>  MAINTAINERS                                   |   11 +
>  drivers/hid/Kconfig                           |   24 +
>  drivers/hid/Makefile                          |    2 +
>  drivers/hid/hid-core.c                        |    5 +
>  drivers/hid/hid-ids.h                         |    7 +
>  drivers/hid/hid-lenovo-go-s.c                 | 1577 +++++++++++
>  drivers/hid/hid-lenovo-go.c                   | 2399 +++++++++++++++++
>  include/linux/device.h                        |   46 +
>  include/linux/hid.h                           |    1 +
>  11 files changed, 5100 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>  create mode 100644 drivers/hid/hid-lenovo-go-s.c
>  create mode 100644 drivers/hid/hid-lenovo-go.c
>
> -- 
> 2.52.0

For the series - all looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
