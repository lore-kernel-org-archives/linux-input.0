From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/02] input: serio: use DEVICE_ATTR_RO()
Date: Tue, 22 Oct 2013 08:51:20 -0700
Message-ID: <20131022155120.GD13473@core.coreip.homeip.net>
References: <20131008010823.GA27012@kroah.com>
 <20131021162531.GC4575@core.coreip.homeip.net>
 <20131022061219.GA15412@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:59425 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab3JVPvY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Oct 2013 11:51:24 -0400
Received: by mail-pb0-f51.google.com with SMTP id wz7so3886241pbc.24
        for <linux-input@vger.kernel.org>; Tue, 22 Oct 2013 08:51:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131022061219.GA15412@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org

On Tue, Oct 22, 2013 at 07:12:19AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 21, 2013 at 09:25:32AM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > On Mon, Oct 07, 2013 at 06:08:23PM -0700, Greg Kroah-Hartman wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Convert the serio sysfs fiels to use the DEVICE_ATTR_RO() macros to make
> > > it easier to audit the correct sysfs file permission usage.
> > 
> > Sorry for the delay. Frankly I am not a fan of DEVICE_ATTR macros as it
> > forces particular naming of the attribute structures and methods and
> > forces us to lose the module prefix in names. I prefer all functions and
> > file-scope variables have module prefix because in the absence of
> > language-supported namespaces this is the one thing that insulates
> > drivers from changes in shared headers.
> 
> No sysfs read/write functions should ever be exported out of the local
> file "scope", so why is this an issue?  I have run into it being a
> problem for some files, where people have device/bus/class sysfs files
> all in the same .c file, but that usage is very limited.

It is not about exporting read/write functions, it is about newly
defined data from common headers stomping on the local module
definitions.

> 
> I'm trying to eventually convert the whole kernel to use the
> DEVICE_ATTR_??() macros to make it so that we can audit the sysfs file
> permissions easier, by making them impossible to get wrong.  We have had
> problems in the past where device files had incorrect permissions and
> unprivilidged users could do things they shouldn't have.  Using these
> macros _should_ prevent almost all of that from even being possible.

Sounds more like task for sparse to ensure we have sane permission bits.

> 
> Now odds are, I'll never be able to remove DEVICE_ATTR() from the tree,
> as there are some strange files that use crazy permissions and we have
> to live with that, but for all of the "simple" files, like are done
> here, I'd really like to use them, especially as it provides a
> kernel-wide uniformity to the naming of attribute function calls, which
> is a huge benifit as well.
> 
> Note, I did apply this patch to my tree already, and it's queued up for
> 3.13-rc1.  If you really object to it, I'll revert it, and fix up the
> 02/02 patch in this series to not need it, but I'd really like you to
> reconsider your objection.

Nah, that is fine.

Thanks.

-- 
Dmitry
