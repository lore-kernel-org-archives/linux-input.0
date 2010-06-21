From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: removing obsolete kone_abi_version sysfs attr for
 roccat kone
Date: Mon, 21 Jun 2010 15:21:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006211521130.13809@pobox.suse.cz>
References: <1276872145.2358.1.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1276872145.2358.1.camel@localhost>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 18 Jun 2010, Stefan Achatz wrote:

> The newest version of the accompanying userland tools cuts backward
> compatibility and uses libudev to find its devices superseding the
> quirky kone_abi_version sysfs attribute. Therefore it should be removed.

Thanks for explanation of the backwards compatibility (non-)issues with 
userspace tools in the other mail.

I have queued tha patch.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
