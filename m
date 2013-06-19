From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Added hovering capability
Date: Tue, 18 Jun 2013 23:13:54 -0700
Message-ID: <20130619061354.GB26181@core.coreip.homeip.net>
References: <1371200199-17718-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50852 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab3FSGN6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 02:13:58 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so4853703pad.16
        for <linux-input@vger.kernel.org>; Tue, 18 Jun 2013 23:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371200199-17718-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

On Fri, Jun 14, 2013 at 05:56:39PM +0900, Tatsunosuke Tobita wrote:
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> 
> Although BTN_TOOL_PEN and BTN_TOOL_RUBBER function properly, the driver didn't
> have hover functionality, so it's been added.
> Also, I noticed that "WACOM_RETRY_CNT" was not used, so it was removed.
> 
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Applied, thanks.

-- 
Dmitry
