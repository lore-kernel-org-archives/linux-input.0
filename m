From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] input: mouse/hgpk.c needs module.h
Date: Sat, 30 Jul 2011 12:02:40 -0700
Message-ID: <20110730190240.GB5686@core.coreip.homeip.net>
References: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
 <20110729211441.5de62eca.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54525 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab1G3TCp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 15:02:45 -0400
Content-Disposition: inline
In-Reply-To: <20110729211441.5de62eca.rdunlap@xenotime.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, akpm <akpm@linux-foundation.org>

On Fri, Jul 29, 2011 at 09:14:41PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> hgpk.c uses interfaces from linux/module.h, so it should
> include that file.  This fixes build errors.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Applied, thanks Randy.

-- 
Dmitry
