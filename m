From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] input: sh_keysc suspend can use to_platform_device()
Date: Wed, 11 Mar 2009 17:29:14 +0900
Message-ID: <20090311082914.GD6281@linux-sh.org>
References: <20090311080423.2006.22858.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:51712 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbZCKIdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2009 04:33:16 -0400
Content-Disposition: inline
In-Reply-To: <20090311080423.2006.22858.sendpatchset@rx1.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, soni.trilok@gmail.com, linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 05:04:23PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch changes sh_keysc to use to_platform_device()
> for suspend. Thanks to Trilok Soni for this suggestion.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied on top of the earlier patch, with Trilok's Reviewed-by, thanks.
