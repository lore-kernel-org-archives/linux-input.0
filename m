From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] Input: tegra-kbc - assume CONFIG_OF, remove platform
 data
Date: Fri, 15 Feb 2013 18:53:49 -0800
Message-ID: <20130216025349.GB25913@core.coreip.homeip.net>
References: <1360968585-25674-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:38352 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3BPCxw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 21:53:52 -0500
Content-Disposition: inline
In-Reply-To: <1360968585-25674-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On Fri, Feb 15, 2013 at 03:49:45PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra only supports, and always enables, device tree. Remove all ifdefs
> and runtime checks for DT support from the driver. Platform data is
> therefore no longer required. Delete the header that defines it, and
> rework the driver to parse the device tree directly into struct
> tegra_kbc.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2:
> * Change struct tegra_kbc.irq to signed int so error-checking works.
> * Rebased directly onto input's next branch.

Applied, thank you Stephen.

-- 
Dmitry
