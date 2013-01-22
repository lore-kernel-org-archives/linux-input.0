From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PROBLEM: 3.8.0-rc4 keyboard failure at boot
Date: Tue, 22 Jan 2013 11:23:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301221122380.20374@pobox.suse.cz>
References: <20130121213604.GA31225@16s.us> <20130122001346.GD16638@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab3AVKXb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2013 05:23:31 -0500
In-Reply-To: <20130122001346.GD16638@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Brad Tilley <brad@16s.us>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 21 Jan 2013, Dmitry Torokhov wrote:

> > Here is info from a computer where the keyboard works occasionally at
> > boot (about 50% of the time). Users reboot until the keyboard works.
> > 
> 
> Hmm, this is a USB keyboard so let's CC Jiri in addition to
> linux-input...

Thanks for the report.

First question before we start any further analysis -- what is the latest 
known-good version of the kernel, where this problem didn't happen on this 
particular computer?

Thanks,

-- 
Jiri Kosina
SUSE Labs
