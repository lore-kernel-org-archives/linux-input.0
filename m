From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: build failure after merge of the moduleh tree
Date: Sat, 30 Jul 2011 12:03:04 -0700
Message-ID: <20110730190303.GC5686@core.coreip.homeip.net>
References: <20110729151044.49f8bfdeeadb8edaf583f90d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54525 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab1G3TDJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 15:03:09 -0400
Content-Disposition: inline
In-Reply-To: <20110729151044.49f8bfdeeadb8edaf583f90d@canb.auug.org.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, linux-input@vger.kernel.org

On Fri, Jul 29, 2011 at 03:10:44PM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> After merging the moduleh tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/input/misc/kxtj9.c:644:1: warning: data definition has no type or storage class
> drivers/input/misc/kxtj9.c:644:1: warning: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
> drivers/input/misc/kxtj9.c:644:1: warning: parameter names (without types) in function declaration
> drivers/input/misc/kxtj9.c:649:12: error: 'THIS_MODULE' undeclared here (not in a function)
> drivers/input/misc/kxtj9.c:669:20: error: expected declaration specifiers or '...' before string constant
> drivers/input/misc/kxtj9.c:669:1: warning: data definition has no type or storage class
> drivers/input/misc/kxtj9.c:669:1: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> drivers/input/misc/kxtj9.c:669:20: warning: function declaration isn't a prototype
> drivers/input/misc/kxtj9.c:670:15: error: expected declaration specifiers or '...' before string constant
> drivers/input/misc/kxtj9.c:670:1: warning: data definition has no type or storage class
> drivers/input/misc/kxtj9.c:670:1: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
> drivers/input/misc/kxtj9.c:670:15: warning: function declaration isn't a prototype
> drivers/input/misc/kxtj9.c:671:16: error: expected declaration specifiers or '...' before string constant
> drivers/input/misc/kxtj9.c:671:1: warning: data definition has no type or storage class
> drivers/input/misc/kxtj9.c:671:1: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> drivers/input/misc/kxtj9.c:671:16: warning: function declaration isn't a prototype
> drivers/input/misc/kxtj9.c: In function 'kxtj9_init':
> drivers/input/misc/kxtj9.c:660:1: warning: control reaches end of non-void function
> 
> I have added this patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 29 Jul 2011 15:06:46 +1000
> Subject: [PATCH] kxtj9: explictly include module.h
> 
> since some of its facilities are used.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied, thanks Stephen.

-- 
Dmitry
