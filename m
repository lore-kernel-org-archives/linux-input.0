From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Tue, 2 Feb 2010 21:07:49 -0800
Message-ID: <20100203050749.GA22110@core.coreip.homeip.net>
References: <201001302257.09354.arnd@arndb.de>
 <520f0cf11001301507k20e3cf8dqa73026e12f3a1767@mail.gmail.com>
 <201001310520.55813.arnd@arndb.de>
 <20100131052942.GA12320@core.coreip.homeip.net>
 <520f0cf11002011222h134dbf06rf1db612da9a9728@mail.gmail.com>
 <520f0cf11002011227s74e57673j3922941f7ee87989@mail.gmail.com>
 <20100201212132.GA7380@core.coreip.homeip.net>
 <520f0cf11002011350u3b541a0cxfb0ed882dca13afe@mail.gmail.com>
 <20100201220856.GB7380@core.coreip.homeip.net>
 <520f0cf11002011518y22c2f097s87872e7b5b1690d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:52122 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab0BCFIA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2010 00:08:00 -0500
Content-Disposition: inline
In-Reply-To: <520f0cf11002011518y22c2f097s87872e7b5b1690d7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Feb 02, 2010 at 12:18:35AM +0100, John Kacur wrote:
> 
> Sorry, maybe I am doing a poor job of explaining myself. My question
> was whether your driver needs to call uinput_release() or not if it
> went through your proposed error path, because that is where you have
> the call to the uinput_destroy_device() function.
> After taking a fresh look at your code I don't believe that it does.
> However, you could still hoist your code that calls nonseekable_open()
> above all that init stuff in uinput_open(), just under the return
> -ENOMEM if you think that it could fail.
> However, I still think that nonseekable_open() is designed from the
> "get-go" to never fail, so I think your code is unnecessarily
> complicated, by just a little bit. It will still work, so you decide
> which to go with. I'm fine with either way.
>

OK, so how about the patch below? If it is accepted I will just switch
to

	nonseekable_open(inode, file);
	return 0;

style. I gonna add Al and akpm to CC to see if the patch will stick...

-- 
Dmitry

VFS: clarify that nonseekable_open() will never fail

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 fs/open.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/fs/open.c b/fs/open.c
index 040cef7..02ceb73 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1200,7 +1200,9 @@ EXPORT_SYMBOL(generic_file_open);
 
 /*
  * This is used by subsystems that don't want seekable
- * file descriptors
+ * file descriptors. The function is not supposed to ever fail, the only
+ * reason it returns an 'int' and not 'void' is so that it can be plugged
+ * directly into file_operations structure.
  */
 int nonseekable_open(struct inode *inode, struct file *filp)
 {
