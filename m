From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: [RFC][PATCH] POSKeyboard driver for exclusive keyboard access
Date: Tue, 26 Aug 2008 08:11:29 +0000 (UTC)
Message-ID: <loom.20080826T080624-638@post.gmane.org>
References: <1b51b6f80808220917t20fdb09el78b117c5ba5b7f7c@mail.gmail.com> <20080822111924.d0713931.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60574 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbYHZIPF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2008 04:15:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KXthf-0004Ib-5F
	for linux-input@vger.kernel.org; Tue, 26 Aug 2008 08:15:03 +0000
Received: from prpdbx1e.wincor-nixdorf.com ([prpdbx1e.wincor-nixdorf.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2008 08:15:03 +0000
Received: from niels.devos by prpdbx1e.wincor-nixdorf.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2008 08:15:03 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Andrew Morton <akpm <at> linux-foundation.org> writes:

> 
> On Fri, 22 Aug 2008 18:17:28 +0200
> "Niels de Vos" <niels.devos <at> wincor-nixdorf.com> wrote:
> 
> > This new driver makes it possible for middleware like JavaPOS to use
> > a POSKeyboard (connected to PS/2) with exclusive access. This is
> > required by the UnifiedPOS Specification which is available from
> > http://www.nrf-arts.org/UnifiedPOS. Any middleware using this driver
> > should implement the full exception-handling in user-space. Therefor
> > it is possible to use specific POS-extensions of POSKeyboards, without
> > abusing other keyboard-drivers.

Hello Andrew,

thanks for your review. However I will look into the suggestions of Dmitry which
could include little changes to serio_raw instead of this new poskbd driver.

Thanks again,
Niels


