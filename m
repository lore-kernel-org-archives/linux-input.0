From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 01/20] Input: Break out MT data
Date: Wed, 12 Sep 2012 22:15:28 -0700
Message-ID: <20120913051528.GC17105@core.coreip.homeip.net>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45270 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab2IMFPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 01:15:34 -0400
Content-Disposition: inline
In-Reply-To: <1346528835-363-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Sep 01, 2012 at 09:46:56PM +0200, Henrik Rydberg wrote:
> Move all MT-related things to a separate place. This saves some
> bytes for non-mt input devices, and prepares for new MT features.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
...
> @@ -1287,10 +1284,8 @@ struct input_dev {
>  
>  	int rep[REP_CNT];
>  
> -	struct input_mt_slot *mt;
> -	int mtsize;
> +	struct input_mt *mt;
>  	int slot;
> -	int trkid;
>  
>  	struct input_absinfo *absinfo;

Shouldn't 'slot' go into struct input_mt as well?

Thanks.

-- 
Dmitry
