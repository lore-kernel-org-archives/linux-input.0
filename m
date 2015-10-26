From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/19] input: tegra-kbc: enable support for the standard
 "wakeup-source" property
Date: Mon, 26 Oct 2015 01:33:54 -0700
Message-ID: <20151026083354.GA13056@localhost>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
 <20151023063946.GA38047@dtor-ws>
 <562A0AB7.3080607@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34593 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbJZIeE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 04:34:04 -0400
Content-Disposition: inline
In-Reply-To: <562A0AB7.3080607@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org

On Fri, Oct 23, 2015 at 11:23:51AM +0100, Sudeep Holla wrote:
> 
> 
> On 23/10/15 07:39, Dmitry Torokhov wrote:
> >On Wed, Oct 21, 2015 at 11:10:03AM +0100, Sudeep Holla wrote:
> >>Though the mmc core driver should/will continue to support the legacy
> >>"nvidia,wakeup-source" property to enable SDIO as the wakeup source, we
> >>need to add support for the new standard property "wakeup-source".
> >>
> >>This patch adds support for "wakeup-source" property in addition to the
> >>existing "nvidia,wakeup-source" property.
> >>
> >>Cc: Laxman Dewangan <ldewangan@nvidia.com>
> >>Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>Cc: Thierry Reding <thierry.reding@gmail.com>
> >>Cc: linux-input@vger.kernel.org
> >>Cc: linux-tegra@vger.kernel.org
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> >Applied, thank you.
> >
> 
> Thanks, but I think I sent out a old copy which had unrelated commit
> message because of copy-paste. *Sorry for that*. Can you update it
> something like:
> 
> "
> Though the tegra-kbc driver should/will continue to support the legacy
> "nvidia,wakeup-source" property to enable keyboard as the wakeup source,
> we need to add support for the new standard property "wakeup-source".
> 
> This patch adds support for "wakeup-source" property in addition to the
> existing "nvidia,wakeup-source" property.
> "

Thanks, I replaced the description with what you supplied.

-- 
Dmitry
