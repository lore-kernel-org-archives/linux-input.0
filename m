From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Drivers: hid: Makefile: Cleaned up Makefile
Date: Tue, 16 Nov 2010 23:21:17 -0800
Message-ID: <20101117072117.GC7046@core.coreip.homeip.net>
References: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
 <alpine.LNX.2.00.1011151557510.7420@pobox.suse.cz>
 <AANLkTikKTLpzafaE9oxRz1f_ZE9zv1eL6K8aAkYmR+TB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53081 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab0KQHV0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 02:21:26 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikKTLpzafaE9oxRz1f_ZE9zv1eL6K8aAkYmR+TB@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tracey Dent <tdent48227@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, spbnick@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 16, 2010 at 10:28:19PM -0500, Tracey Dent wrote:
> On 11/15/10, Jiri Kosina <jkosina@suse.cz> wrote:
> > On Sun, 7 Nov 2010, Tracey Dent wrote:
> >
> >> Changed Makefile to use <modules>-y instead of <modules>-objs because
> >> -objs is deprecated and should now be switched. According to
> >> (documentation/kbuild/makefiles.txt).
> >
> > Actually, where exactly does this file document it?
> >
> 
> It documents how it should be done in the section entitled --- 3.7
> Compilation flags (which starts on line 284).
> 

Actually the only reference I could find is in 3.3:

        If a kernel module is built from several source files, you specify
        that you want to build a module in the same way as above; however,
        kbuild needs to know which object files you want to build your
        module from, so you have to tell it by setting a $(<module_name>-y)
        variable.

See commit 4f8272802739f5c6ce6b0a548810a181d2f1b652 for reasoning behind
the change.

Thanks.

-- 
Dmitry
