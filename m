From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: sysrq -- ensure sysrq_enabled and
 __sysrq_enabled are consistent
Date: Mon, 24 Jan 2011 09:04:58 -0800
Message-ID: <20110124170458.GA31066@core.coreip.homeip.net>
References: <1295877972-363-1-git-send-email-apw@canonical.com>
 <1295877972-363-2-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33646 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1AXRFH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 12:05:07 -0500
Content-Disposition: inline
In-Reply-To: <1295877972-363-2-git-send-email-apw@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

On Mon, Jan 24, 2011 at 02:06:12PM +0000, Andy Whitcroft wrote:
> Currently sysrq_enabled and __sysrq_enabled are initialised separatly
> and inconsitantly, leading to sysrq being actually enabled by reported
> as not enabled in sysfs.  The first change to the sysfs configurable
> synchronises these two:
> 
>     static int __read_mostly sysrq_enabled = 1;
>     static int __sysrq_enabled;
> 
> Add a common define to carry the default for these preventing them becoming
> out of sync again.  Default this to 1 to mirror previous behaviour.
> 
> Signed-off-by: Andy Whitcroft <apw@canonical.com>

Applied and will also tag for stable. Thank you Andy.

-- 
Dmitry
