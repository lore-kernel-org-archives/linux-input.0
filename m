Return-Path: <SRS0=bjBO=ZK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77491C432C0
	for <linux-input@archiver.kernel.org>; Mon, 18 Nov 2019 23:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F06A22303
	for <linux-input@archiver.kernel.org>; Mon, 18 Nov 2019 23:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=airpost.net header.i=@airpost.net header.b="ibBEB80h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3LRAlZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRXe4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:34:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46113 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfKRXe4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Nov 2019 18:34:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0644E21B10
        for <linux-input@vger.kernel.org>; Mon, 18 Nov 2019 18:34:55 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Mon, 18 Nov 2019 18:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=VCmNtQjjZ7ffsrA9HgUhc1z1D4PnbybLBu5xH0klM90=; b=ibBEB80h
        Ij5imcNR/LyPY9Zoc6CSDHGN0vtvuKhqU/51+hmGkZeaTgLhZDm65j9t7z03NUWp
        SWsRPSHyRij8LssWQmpe+J3O3pxFvqJ0dnZhcpZNTMB+/a5NaD4fna58w+02TwVB
        Yq+LcF5GxEj16+q3DX5ivwEVDwpZXO419kn3k5ozxIT+JHBte+KiNPPYYLs4I/6Q
        7IpS8hki8rzKmOtBDE0IpQ0YvoD5UeaXFPyccnN6x/Yy7aTBIFo5HDwpAUEs3NhO
        YpUP/40WRucvq/9JLoCm6RcKAe/Y1nc2fwUErDlp4ix2lCCLDfkPuJFu1uLDFbl9
        qNMUjqquTNU13Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=VCmNtQjjZ7ffsrA9HgUhc1z1D4Pnb
        ybLBu5xH0klM90=; b=F3LRAlZ2lCU2a35BNPJLFZUAIkNuHIg8qxN0EVEAq/w1b
        f0HnbPCTBkUzSK49hfYrZKqfAdYMFSsvyiOvNr4sOY7MFAyceSr1pJgKRuIEJVzm
        /fovCeHJVK650wmchGD/GKAWQua/dlUo28KnCAbT/xr/TGcGwExunPwcqUYpiDCo
        dO/2RZH+m80dwDrS/uMaiIig2FedgCredmbkRj6sxbAVZPu8D0logb0n+MlVwW5Y
        utXYn61WqmO6XqucEY9pbe38tc3AgqL/svW89dyuunb/TqZ2/hxLu+fo96wYSYMB
        +QIORKCZtdwo9DzJTQ3jriutqFz2eXZibtI/pgofQ==
X-ME-Sender: <xms:nirTXQGgZE12JFnA0yKArVj4t0KmOMxkfMgwqVCAATjSjCS5FeDMJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfuehruhhnohcuffgrnhhtrghsfdcuoegurghnthgrshesrghi
    rhhpohhsthdrnhgvtheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurghnthgrshesrg
    hirhhpohhsthdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:nirTXcziCUsINd-z1cd1VidbaBynTMY7ppvaG-KNJdNU_PzOtzK1rg>
    <xmx:nirTXW7yoxzDSnZM16PmzW7o9tdznx3inna_hLCkxG0z8Wrk05aEaA>
    <xmx:nirTXVf6QtPszqluVNBZEHJxDw6dnH3dy2Iws8RSc-WguWwSpbBjzg>
    <xmx:nyrTXa6MPD72-Znk651yQpbFS6v5T6_X6agVMqJmAOWsrM3E2W4mug>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C2B79E00AA; Mon, 18 Nov 2019 18:34:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <110a1d5c-5556-4343-9662-2284426a19f4@www.fastmail.com>
Date:   Mon, 18 Nov 2019 18:34:34 -0500
From:   "Bruno Dantas" <dantas@airpost.net>
To:     linux-input@vger.kernel.org
Subject: how do unbind ThinkPad touchpad without unbinding trackpoint?
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

I have a T400 laptop running Devuan ASCII with linux 4.16.2

Please, this laptop's touchpad generates input "noise" while the lid is shut, which causes applications that should run while system is idle (e.g., xscreensaver) not to run.

I've tried to disable the touchpad via xinput or synaptics, but it does not remedy the issue. The only remedy I've found is to unbind the touchpad with this command:

# echo serio1 /sys/bus/serio/drivers/psmouse/unbind

Unfortunately, the above command also disables my trackpoint ("nipple mouse") which I need to remain functional.

Please, how do I unbind the touchpad without unbinding the trackpoint?

Thanks,
Bruno "GNUser"

P.S. This may be useful:

bruno@thinkpad:~$ cat /proc/bus/input/devices
---snip---
I: Bus=0011 Vendor=0002 Product=0007 Version=01b1
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input6
U: Uniq=
H: Handlers=mouse0 event5 
B: PROP=1
B: EV=b
B: KEY=420 30000 0 0 0 0
B: ABS=11000003

I: Bus=0011 Vendor=0002 Product=000a Version=0000
N: Name="TPPS/2 IBM TrackPoint"
P: Phys=synaptics-pt/serio0/input0
S: Sysfs=/devices/platform/i8042/serio1/serio2/input/input7
U: Uniq=
H: Handlers=mouse1 event6 
B: PROP=21
B: EV=7
B: KEY=70000 0 0 0 0
B: REL=3
