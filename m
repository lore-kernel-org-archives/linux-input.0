From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - Add force relese key quirk for HP ProBook
Date: Tue, 28 Feb 2012 22:17:15 -0800
Message-ID: <20120229061715.GA13131@core.coreip.homeip.net>
References: <1330475770-4153-1-git-send-email-manoj.iyer@canonical.com>
 <1330475770-4153-2-git-send-email-manoj.iyer@canonical.com>
 <20120229004604.GB21093@kroah.com>
 <20120229010311.GA11492@core.coreip.homeip.net>
 <alpine.DEB.2.02.1202282351510.5366@happy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58182 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab2B2GRT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 01:17:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1202282351510.5366@happy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Hi Manoj,

On Tue, Feb 28, 2012 at 11:56:22PM -0600, Manoj Iyer wrote:
> Dimitry,
> 
> This quirk helps a few HP ProBooks to make brightness keys
> typematic. Can you please tell me why you think its better handling
> this in user space?

Because there are too many broken laptops to quirk them all in kernel as
every quirk takes non-swappable kernel memory whereas userspace solution
only takes disk space.

> I see other quirks similar to this in atkbd,
> just trying to understand.

These were added before I implemented support for allowing marking some
of the keys as "force release" via sysfs attribute.

> Yes, we did quirk this in udev rules to
> make brightness keys works as expected. But thought it might help
> others who see this issue with HP ProBooks by quirking it in kernel.
> 

If you submit your quirk to udev maintainers you will help others
exactly the same as with kernel patch.

Thanks.

-- 
Dmitry

P.S. Please do not top post.
