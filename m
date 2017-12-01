From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: holtekff: move MODULE_* parameters out of #ifdef
 block
Date: Fri, 1 Dec 2017 09:53:15 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1712010952590.11505@cbobk.fhfr.pm>
References: <20171126043404.11621-1-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbdLAIxR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 1 Dec 2017 03:53:17 -0500
In-Reply-To: <20171126043404.11621-1-dja@axtens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Axtens <dja@axtens.net>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, anssi.hannula@iki.fi

On Sun, 26 Nov 2017, Daniel Axtens wrote:

> If you compile with:
> CONFIG_HID_HOLTEK=m
> CONFIG_HOLTEK_FF is not set
> 
> You get the following warning:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/hid/hid-holtekff.o
> see include/linux/module.h for more information
> 
> Fix this by moving the module info out of the #ifdef CONFIG_HOLTEK_FF
> block and into the un-guarded part of the file.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to for-4.15/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

