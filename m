From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add entry for the Teclast
 X98 Plus II
Date: Tue, 2 Jan 2018 15:40:33 -0800
Message-ID: <20180102234033.GB24794@fury>
References: <20180102134239.3579-1-paul@crapouillou.net>
 <20180102183928.15267-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38391 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeABXkh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 18:40:37 -0500
Content-Disposition: inline
In-Reply-To: <20180102183928.15267-1-paul@crapouillou.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@infradead.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 02, 2018 at 07:39:27PM +0100, Paul Cercueil wrote:
> Add touchscreen platform data for the Teclast X98 Plus II tablet.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/silead_dmi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
>  v2: Rebased on top of http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy

Generally "testing" is the branch you want to base on if linus/master
doesn't work as the review-* branches *will* rebase frequently.
Exceptions exist of course, and this patch is just fine - just for
future reference.

Andy pushed his changes to testing already, so this is no longer
dependent on his review queue. I have applied to review-dvhart, will go
to testing shortly.

Thank you Paul.

-- 
Darren Hart
VMware Open Source Technology Center
