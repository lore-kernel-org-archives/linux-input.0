From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Wed, 9 Jul 2014 09:54:38 -0700
Message-ID: <20140709165438.GC10364@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59407 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbaGIQym (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 12:54:42 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so9434786pad.41
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2014 09:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, vojtech@suse.cz, hdegoede@redhat.com

On Wed, Jun 25, 2014 at 11:42:43AM +0200, Jiri Kosina wrote:
> Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
> misbehaves rather randomly.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 
> Hi Dmitry,
> 
> I've come across this a few year old patch originating from our internal 
> bugzilla, which was apparently been lost between the cracks somewhere. 
> We've been carrying it in our kernel tree for quite some time ... could 
> you please apply it? Thanks.

I will. I also wonder if by now we should stop defaulting to MUX mode:
all newer desktop/server boxes use USB, only laptops still use PS/2,
and quite a few of them not implement active MUX properly. I also expect
that most of external PS/2 mice are dead by now, so number of cases when
we have users with PS/2 touchpad + external PS/2 mouse + working active
MUX is exceedingly small.

Let's pull Vojtech in ;)

Thanks.

-- 
Dmitry
