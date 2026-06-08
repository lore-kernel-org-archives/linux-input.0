Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A9332EDE;
	Mon,  8 Jun 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938695; cv=none; b=N2yBDJsE9FhlBES3pvrOdhhiPwInZzyheUy5nr9dToc7MVNhAtMFvGOUiMjGNI5O/iYrDCfhvce1ch7l1EQInXRX+1M1ua9sflaEEU/tqSY9UbTuar3LyAAdqmonUarx5AljjSPKbo+1ORQpmB+taQWLnaZtEtlwZcmcuMUeTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938695; c=relaxed/simple;
	bh=8X6SDfa2uqXlyseGv/Uo104fxHt5iKmpLarOU63qQAE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BAl3pxlWKT2348iHhBjODI/Y4EZb+BOJe+TR+2wjSh/eG7QFZNbB26J0lyE0LxyxIU/e5WaUPGNyuV6G2/JN3m89SuvL2rsja4sbYhe3dBj8BDLS4PmJwo1JcKh6u4yUmCYer3C183fjxc01EObjO6kdcHEEk6Dx9VSkMP0mi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aI75Wbub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQqipefS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aI75Wbub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQqipefS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6946814000C1;
	Mon,  8 Jun 2026 13:11:33 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 13:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780938693;
	 x=1781025093; bh=5N06FHSWHmtGiizyMQkYX82C/GPOmNfgl/ROy/Znpbw=; b=
	aI75Wbubs/t9s2AdcK6asF7TCjmopVoC8xjMA8Sf/cSitk/r7/PS3GC1ztR7z+J+
	yZbgA70Dfu2puARZf6v1trh4hyh/58BKCAtpLUBA10/hpee6XtFqmIUiPREc6mOr
	Wd/SDjc7Am6c68uNXel38E16+jaS2QfXWIu98ZPPje8DZegQh6DdseZAvw8JygIC
	REfUZhQBL09AXW3tF1znMjyWEXhDu8wFZCKDi6qqz5rrQpQGALrK39lJ5D8bOBGG
	1zB/SKwnyB/r5u5OBGRI1Q/39V1LI4OaNXTwc1Rygv4Jpi+oSkbKrSrOPRaNIiVq
	LUflBjFvmLe3hLOslUHjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780938693; x=
	1781025093; bh=5N06FHSWHmtGiizyMQkYX82C/GPOmNfgl/ROy/Znpbw=; b=H
	QqipefS9diXmQkaH2EHQKT+LF8KIU9eXmE/nwY8Un3e1WPZTgTs+PcOI5M9jlrfN
	QRCfIGp5Nch70KP/ti+Lwkl9L24kO/VSUZL0EpBuxEybTXi40CzZFpPCAz66JDoW
	gpc0Fo/QyRSn4KOD8cJU67+Net0WAAcfCtZo/5Vu5AkiP3YqrnuyW7/BtHOs8tPW
	49eiSTgZODBVZ169X7/4f4PrCM1dP63Fh8CBk0IopE5SQRHYNSyv/ZkNG2dwZ5Cj
	/03niV0dyqUfKpx3C1kvmPeJVsLqENYO/TxfiTkF2XSyCr+q2FvOopIPlrGAebwy
	gqqrVFAJ9clZ9wcF+yKiA==
X-ME-Sender: <xms:xPcmave1SFA6qKsFWEN3Ln0ThxoEia1q08W1Zgwl5025NBXqmtJb9g>
    <xme:xPcmagA4tE9vCrNDvEwqKqcIDcI-AtZwNYKJlHE4o80GlZo5oPowCl2eQJ_QU6MA1
    LXlR6lOOthaXdkeDfpSwLBqRQ-mVq0qUsd8e-rGnEdXYsfS48hAUzRk>
X-ME-Proxy-Cause: dmFkZTEBJyaMAP3TDAJtRLMda8+Z1sANpdvgvrXLebNvBI1V1vjsIUCXpuKEnBdpFw6Rl+
    1eK5B74o4h8LLEE+hXdlrYzTTB47NVLAkf8RfkJJ5AfviL7PUNJ+M9W5Xm0RZ0n7Hus6oq
    /fQakMcirP4bqswRgTm+cssfJ66RfKI/2109NMoyaHCYQXv4QSEPwJ0uCWNM+yHBPuiI9K
    S4GZwDQmk9N8WQWz0oN+sfehL/smmk2MoHWgsSqlvLro/BDQO0f+M6Xcq/gsQNReg/dHHE
    Nl7tC00fRXsBQOW2N+wd0+kE+PmTzE2LyePiW3g7xPQkNgoL1t7NM1J6OYN9oo8XqqhEeM
    /1cD7/AqTTnpNs4bvb61dYR3IAuD07hVUTGo9JNB+Ade4Uqn87zLxxoqf+9YwSa748We2J
    DcZGNV0TPtE3dDv1J59JcxaDFD8KgBPodPR8jpJr0l76oCl9V2RzMaRNSZc8fJoFyHrawN
    x8yi6RilGh3X+/F9QxyGKVcqStGsPf9H0KRFu/7696fGFpZKke8u2I7ZpKyBW3A6+28A2E
    L3fc792rp92yKghWWIJ1UFJoThhuu4nqwYQg3Rf+14lR/FthHM/iHg3qY7zuzrEbcbJafv
    K4+fByARvDHgPXPrqbCcEw19PeWU5JHnTA8/s3yQB+TEnOnJIj1QoB7KFZ2A
X-ME-Proxy: <xmx:xPcmainHjZnU5zbipIZxKeIK2negpBIzAM2jffNMAGvKZHHcDBU7SQ>
    <xmx:xPcmaqwgUSYXzpNqshmMNTLu1V8aA9f0phgmvS2j8DBD09WMBv1sxQ>
    <xmx:xPcmag93IlnIpp85IbJ38QU0v48k4uFIPelEJVjWPbAHJ0zyAcweTg>
    <xmx:xPcmalD1-VsZSLQSynhZp2Dy6KNO-AWSDE2qvh09frXROQyYzjHUsg>
    <xmx:xfcmarwUHGkcMFDWkIl6p5Y4UDy3KRtrr0hoGJD9QHFJe8wD8hoLPG6W>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 10A951820082; Mon,  8 Jun 2026 13:11:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO-lxqPu-pZJ
Date: Mon, 08 Jun 2026 19:11:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
 linux-serial@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Linus Walleij" <linusw@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>
Message-Id: <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
In-Reply-To: <aibz3auoiq4CFa9l@google.com>
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
 <aibz3auoiq4CFa9l@google.com>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 8, 2026, at 18:56, Dmitry Torokhov wrote:
> On Sat, May 09, 2026 at 10:20:49PM -0700, Ethan Nelson-Moore wrote:
>> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
>> index a8f4b2d70e59..cea72bd888af 100644
>>  
>> -#if defined(__arm__)
>> -/* defined in include/asm-arm/arch-xxx/irqs.h */
>> -#include <asm/irq.h>
>> +#ifdef CONFIG_ARCH_FOOTBRIDGE
>> +/* defined in arch/arm/mach-footbridge/include/mach/irqs.h */
>> +#include <mach/irqs.h>
>>  #elif defined(CONFIG_PPC)
>>  extern int of_i8042_kbd_irq;
>>  extern int of_i8042_aux_irq;
>
> This does not look right. Did you mean to drop inclusion of asm/irq.h
> for all other arms?

I think this is correct, as footbridge is the only one that selects
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and defines I8042_KBD_IRQ on arm.

       Arnd
