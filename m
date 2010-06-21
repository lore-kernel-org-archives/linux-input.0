From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: removing obsolete kone_abi_version sysfs attr for
 roccat kone
Date: Mon, 21 Jun 2010 14:06:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006211405110.13809@pobox.suse.cz>
References: <1276872145.2358.1.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43050 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab0FUMGH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 08:06:07 -0400
In-Reply-To: <1276872145.2358.1.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, 18 Jun 2010, Stefan Achatz wrote:

> The newest version of the accompanying userland tools cuts backward
> compatibility and uses libudev to find its devices superseding the
> quirky kone_abi_version sysfs attribute. Therefore it should be removed.

How backwards incompatible this change actually is?

What happens if you run old userspace tool (the one which looks for 
kone_abi_version) on a kernel with this patch applied?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
