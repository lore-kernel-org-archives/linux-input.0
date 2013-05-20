From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/2] hid: sort id list for eGalax and remove dups
Date: Mon, 20 May 2013 14:50:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305201450410.1716@pobox.suse.cz>
References: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45691 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab3ETMuv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 May 2013 08:50:51 -0400
In-Reply-To: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, 17 May 2013, Andy Shevchenko wrote:

> Third version of the patches addresses comments I got from Benjamin and Jiri.
> The actual change is the commit message for patch 2/2. Patch itself is remained
> as in the first version.
> 
> Andy Shevchenko (2):
>   hid: sort IDs for D-WAV eGalax multitouch devices
>   hid: remove duplicate ID for D-WAV eGalax 0x7224
> 
>  drivers/hid/hid-ids.h        |  7 +++----
>  drivers/hid/hid-multitouch.c | 29 +++++++++++++----------------
>  2 files changed, 16 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
