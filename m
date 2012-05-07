From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sentelic - including production serial number in
 driver information string
Date: Mon, 7 May 2012 08:47:23 -0700
Message-ID: <20120507154723.GA10222@core.coreip.homeip.net>
References: <1336398566-28669-1-git-send-email-avatar@sentelic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55659 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab2EGPra (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 May 2012 11:47:30 -0400
Received: by dady13 with SMTP id y13so1407075dad.19
        for <linux-input@vger.kernel.org>; Mon, 07 May 2012 08:47:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336398566-28669-1-git-send-email-avatar@sentelic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: linux-input@vger.kernel.org

On Mon, May 07, 2012 at 09:49:26PM +0800, Tai-hwa Liang wrote:
> Hardware since Cx supports an unique identity(used to identify OEM vendors
> and released lot number) which is very helpful for diagnostic purpose.
> This revision tries to make it as a part of driver boot up message.
> 
> Whilst here, also bumping fsp_drv_ver to acknowledge recent addition of
> absolute coordinates output.
> 

Applied, thanks Tai-hwa.

-- 
Dmitry
