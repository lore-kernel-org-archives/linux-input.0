From: Martin Herkt <lachs0r@srsfckn.biz>
Subject: Re: PROBLEM: [Asus Zenbook Pro UX501JW] Backlight control via hotkeys does not work
Date: Mon, 01 Jun 2015 23:50:50 +0200
Message-ID: <3398135.BGeJMlpYrp@sakuya>
References: <CAGo33vX_m_nTrDJ+20XTH-qwjHrDgH+w=Uu89ztC10t8-kYrHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srsfckn.biz ([148.251.137.227]:40723 "EHLO srsfckn.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbbFAVuw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Jun 2015 17:50:52 -0400
Received: from sakuya.localnet (dslb-088-068-164-236.088.068.pools.vodafone-ip.de [88.68.164.236])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by srsfckn.biz (Postfix) with ESMTPSA id 922311917612
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2015 23:50:34 +0200 (CEST)
In-Reply-To: <CAGo33vX_m_nTrDJ+20XTH-qwjHrDgH+w=Uu89ztC10t8-kYrHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Monday 01 June 2015 23:19:09 Philip Tibom wrote:
> [1.] One line summary of the problem:
> [Asus Zenbook Pro UX501JW] Backlight control via hotkeys does not work
> 
> 
> 
> [2.] Full description of the problem/report:
> When using the default open source drivers, backlight control does not
> work via keyboard hotkeys on Asus Zenbook Pro UX501JW.
> 
> WORKAROUND: The backlight can be manually set while running on the
> integrated intel graphics (not with hotkeys).

Setting acpi_osi= on the kernel command line is a workaround for many ASUS 
laptops running UEFI firmware (I have one of those too). Although I did not 
observe any obvious unwanted side effects with this option, I have no idea 
which other ACPI functions are influenced by it.

See also:
https://bugzilla.kernel.org/show_bug.cgi?id=89401
https://bugzilla.kernel.org/show_bug.cgi?id=70241
