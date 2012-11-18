From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: 3.7-rc3: mouses stopped working
Date: Sun, 18 Nov 2012 14:34:33 +0100
Message-ID: <20121118133432.GA13224@shrek.podlesie.net>
References: <20121115132849.GA4062@elf.ucw.cz>
 <alpine.LNX.2.00.1211151429240.15877@pobox.suse.cz>
 <20121115140736.GA2651@elf.ucw.cz>
 <alpine.LNX.2.00.1211151508350.15877@pobox.suse.cz>
 <20121116013405.GA2002@elf.ucw.cz>
 <alpine.LNX.2.00.1211161153290.20577@pobox.suse.cz>
 <20121116122400.GA10994@elf.ucw.cz>
 <alpine.LNX.2.00.1211161335180.20577@pobox.suse.cz>
 <20121118085638.GA2331@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [93.179.225.50] ([93.179.225.50]:55100 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab2KRNeg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Nov 2012 08:34:36 -0500
Content-Disposition: inline
In-Reply-To: <20121118085638.GA2331@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org

On Sun, Nov 18, 2012 at 12:56:38AM -0800, Dmitry Torokhov wrote:
> 
> Input: mousedev - move /deb/input/mice to teh correct minor

s/teh/the/ ??

> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> When doing conversion to dynamic input numbers I inadvertently moved
> /dev/input/mice form c,13,63 to c,13,31. We need to fix this so that
> setups with statically populated /dev continue working.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I had the same problem and this patch fixes it (I even concurrently fixed
that in similar way).

If you need that:
Tested-by: Krzysztof Mazur <krzysiek@podlesie.net>

Thanks,

Krzysiek
