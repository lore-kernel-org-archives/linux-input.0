From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: allow SERIO=m even without EXPERT=y
Date: Tue, 3 Sep 2013 20:35:47 +0100
Message-ID: <20130903193547.GA8150@srcf.ucam.org>
References: <1378147630-12471-1-git-send-email-teg@jklm.no>
 <20130903150226.GA2392@srcf.ucam.org>
 <CAG-2HqVK+nH4+AFrBUmr6wp1zfTeUdLArmXxZxC4TwuPSSkKZg@mail.gmail.com>
 <20130903192421.GA26734@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59404 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3ICTf4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 15:35:56 -0400
Content-Disposition: inline
In-Reply-To: <20130903192421.GA26734@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tom Gundersen <teg@jklm.no>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Sep 03, 2013 at 12:24:21PM -0700, Dmitry Torokhov wrote:

> Presumably such systems would carry over their .config which would have
> these as built-in.

Yeah, but distributions should still be given guidance on their default 
configs.

> i8042 is old-style platform driver, so nothing will load it if it is
> compiled as a module. This one worries me most.

We could add the PNP aliases for it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
