Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350F175A66;
	Tue, 28 Apr 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356800; cv=none; b=Gj4DzgwF3Sv+4SKYbgwd0OiYBFMAio5lxMlk/kmd0q+r9OSZyv9QsufmLuJ7SgXtGjqYfctoJ0Yp41riKN6TNaC8mDj3kwrSfqIxNJjICCZNnnkuGAkR//x9yR0h+K7QivOSwEDCgibJ3K4gBbILdJxYOQ9FZoV8EPHAS8+RCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356800; c=relaxed/simple;
	bh=ZeynYF64G5AE7okyvFbotmxtDPhhHOdwoQNrsORmlOo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F1lIvlsfB9plpyQfmATFWb8saBRq8IsYTsuvH8kHqAzpsh3YgiTJi0dnaYfUxg88tmYqVb55ZIrSqeILAv9/FvyR5iAy/Lhnr8afiQVedX82Va2sS27tpGOnzpJO1RJIsIj2CrjeUOBW0anoUrc4BEBsYGQe1QFvrDU6bdVzA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=il/84dKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnMBgkEp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="il/84dKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnMBgkEp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 38295EC00C3;
	Tue, 28 Apr 2026 02:13:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 28 Apr 2026 02:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777356797;
	 x=1777443197; bh=AsOgAGNJHq3X7FnUeeXySU9AI8SpiZkaDu+P0QkPXd4=; b=
	il/84dKJlbIGd7TFxdYNfPdlAH4WvSbmTYYdGf892ISblTjX1/5SV+96vwPUZKrS
	elUk4yMY9TJzYWv8eaAASHi7sle+LPKjGse8JOHmUoxgcQTq3qwPR7V6mQNSKn+g
	HYmlVDoU0PJUBU9UeIundK739hJwEb0ZyRd3QK+avtIO1v0wqhfjYTflGg+fn2uC
	YHS1YTablkblXC98D/B0ypqTQwHis/AEPEhyFj0GlKYh4yo3tf/4iLOhMRb7p8c1
	rvc/s1M//j1dQpezuthgvGEYM8GBdVqJ19FAjZG0QbTn5ClF8DnQSU814aQXKU8D
	0OA/c+oHHJifLYas6pE5tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777356797; x=
	1777443197; bh=AsOgAGNJHq3X7FnUeeXySU9AI8SpiZkaDu+P0QkPXd4=; b=X
	nMBgkEpgNb8egEMU+zZM2UxJcjnwOv2droNboHZQ+hOwl9zyUfsaKOIZUo1vProe
	Z0HwhusK1cthpnxzRAlHxD1rKQwpM+15egf7VhshmLqQuNFcsdMQb+9UMlP5CT//
	QCLJc/9M9HRa7xhLZHXKACpov3wsSQlyX5yldbuX7nCCdu7ji242OqlgMQBHzIKA
	IwYfXPPdW/n3w1EhOwziorV82f+B5oz73+ndnOuYxOQdCnHl3WGBOTpzlRMLVJMN
	1CHm+HQ5JJIn9W7zoEWiIvYkhJNjNKrjippn05quKCkl09K9mOrQSiGp5sUkfxtk
	1HHI3RURy6fwbeA/pKPng==
X-ME-Sender: <xms:_E_waZIu7tiZZVtGK-wIAKJU-Dj9LziHYIgP98QmA91n7MJTO4-anw>
    <xme:_E_waf_TZ8F3HpPmqybADNtGqHV78mtEwMOIoxmS7QSb7nV50gRZ6ajmNkkYwDo6o
    Aqf7dJhKUaJ_Do6NG2CFmyUueLXR-VVFrjgtbzbsIf7YFMYAOi8HJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfrggsrhhitggvrd
    hgrghsnhhivghrsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepghgrthhivghnrdgt
    hhgvvhgrlhhlihgvrhesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopegumhhithhrhi
    drthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgriiiiihgvshgr
    tggtohhunhhtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrsheskhgvmh
    hnrgguvgdrihhnfhhopdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghkvggvphgrgiesohhpvghnshhouhhrtggvrdgt
    ihhrrhhushdrtghomh
X-ME-Proxy: <xmx:_E_waZgLc6oNDSlvY-6PeIzyihvg6PagyrXMcPufjKbQZFtWwnZ4Sg>
    <xmx:_E_wadm-pA36UutHMBzWnsWNTaAVfBb4hzN9myTckKIUNMV6LSk7VA>
    <xmx:_E_wadbLI9O8tKP2ZkrJg4KzV23mYAMzXUHlafCGZKteH3xmDbn2oA>
    <xmx:_E_waQyOiM3HCYA9txsJNVYACnTO3gy3wagWlA9DFSKKKAW-Ni3AMg>
    <xmx:_U_waVVlJta6KnJiK5YcinKIb-JJwoXqJuwZwtEmVddTARGDMhWKKsHd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C02D700065; Tue, 28 Apr 2026 02:13:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnQ8bV8uQ6GB
Date: Tue, 28 Apr 2026 08:12:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>,
 "Lee Jones" <lee@kernel.org>,
 "Gatien Chevallier" <gatien.chevallier@foss.st.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Fabrice GASNIER" <fabrice.gasnier@foss.st.com>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7f64a929-c879-4839-a7ee-1da2e423b156@app.fastmail.com>
In-Reply-To: <afAz-UQY0aCaThV3@google.com>
References: <20260427143406.3020992-1-arnd@kernel.org>
 <afAz-UQY0aCaThV3@google.com>
Subject: Re: [PATCH] [v2] input: gpio-keys: make legacy gpiolib optional
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 28, 2026, at 06:14, Dmitry Torokhov wrote:
> On Mon, Apr 27, 2026 at 04:33:49PM +0200, Arnd Bergmann wrote:
>> 
>> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
>> passing an IRQ number instead. In order to keep this working both with
>> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
>> the gpio number if an IRQ is passed.
>> 
>> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: skip the fake GPIO number passing from mfd
>> ---
>>  drivers/input/keyboard/gpio_keys.c        | 7 ++++---
>>  drivers/input/keyboard/gpio_keys_polled.c | 2 ++
>>  drivers/mfd/rohm-bd71828.c                | 1 -
>>  drivers/mfd/rohm-bd718x7.c                | 1 -
>
> Let's see if my patches to rohm drivers will get accepted and then maybe
> we can remove legacy gpio API from gpio-keys altogether.

I think it would be good to still merge the drivers/input
parts of my patch. Since CONFIG_GPIOLIB_LEGACY is still set
unconditionally at the moment, that should work fine as long
as your patches for the rohm drivers get merged before
we turn off CONFIG_GPIOLIB_LEGACY for modern platforms.

In linux-next, I see these users of the legacy gpio-keys platform
data remaining:

arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
arch/arm/mach-orion5x/dns323-setup.c
arch/arm/mach-orion5x/mv2120-setup.c
arch/arm/mach-orion5x/net2big-setup.c
arch/arm/mach-orion5x/ts209-setup.c
arch/arm/mach-orion5x/ts409-setup.c
arch/arm/mach-s3c/mach-crag6410.c
arch/arm/mach-sa1100/assabet.c
arch/arm/mach-sa1100/collie.c
arch/arm/mach-sa1100/h3xxx.c
arch/mips/alchemy/devboards/db1300.c
arch/mips/bcm47xx/buttons.c
arch/sh/boards/mach-rsk/devices-rsk7203.c
arch/sh/boards/mach-x3proto/setup.c
drivers/input/misc/soc_button_array.c
drivers/mfd/ucb1x00-assabet.c

Do you already have patches for more of these? I would like to
kill off mv78xx0, orion5x and sa1100 board files (including
the ucb1x00-assabet mfd driver) soon, but that still leaves s3c,
alchemy, bcm47xx, rsk and x3proto. These platforms are in
varying states of disrepair, maybe a few more of those
can be removed instead of converted. I know that Mark
Brown is still using the s3c board, and Waldemar Brodkorb
was recently working on restoring bcm47xx into a usable
state.

I assume you'll take care of the soc_button_array one.

     Arnd
