From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 22:38:53 +0100
Message-ID: <4CDC626D.9050205@euromail.se>
References: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>	<AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>	<20101110050219.GB29110@barra.bne.redhat.com>	<4CDA6D25.4070501@euromail.se>	<20101110235355.GB4473@barra.bne.redhat.com>	<4CDB3D6C.2000507@euromail.se>	<20101111012251.GC2121@core.coreip.homeip.net>	<AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>	<20101111082653.GC24415@core.coreip.homeip.net>	<AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>	<20101111192434.GA13163@core.coreip.homeip.net>	<4CDC46E5.8040703@euromail.se> <AANLkTi=TVm1xUeM8nfnGFhyrjW9+3NL0AO9iCvVFTriZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:53448 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464Ab0KKVkH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 16:40:07 -0500
In-Reply-To: <AANLkTi=TVm1xUeM8nfnGFhyrjW9+3NL0AO9iCvVFTriZ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

>

> Are we going to do the tocuh and pen aribtration in input-mt.c? I need
> to understand this to make my patches.


If the pen is implemented as just another contact, it will also be treated as
such, and arbitration becomes the same thing as single-pointer emulation.

Cheers,
Henrik
