From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input : wacom - add a few new styli for Cintiq series
Date: Sun, 5 May 2013 20:22:23 -0700
Message-ID: <20130506032223.GC25084@core.coreip.homeip.net>
References: <1367360537-30215-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47319 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab3EFDWZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 23:22:25 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq8so1745025pbb.33
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 20:22:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367360537-30215-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, Apr 30, 2013 at 03:22:17PM -0700, Ping Cheng wrote:
> Add new styli for Cintiq 13HD and 22HD. Update comments for
> for tools. Check whole 10 nibbles of tool ID for tool
> types. Remove unuecessary tool type for Intuos series PAD.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  3.7/wacom_wac.c |   36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/3.7/wacom_wac.c b/3.7/wacom_wac.c
> index afe4fe0..3b6998a 100644
> --- a/3.7/wacom_wac.c
> +++ b/3.7/wacom_wac.c

Applied both, but next time can I please get diff with ptoper path
(drvers/input/tablet/...)?

Thanks.

-- 
Dmitry
