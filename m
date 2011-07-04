From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input: wacom - Wacom Bamboo Pen D4 has 1024 pressure
 level
Date: Mon, 4 Jul 2011 03:20:59 -0700
Message-ID: <20110704102058.GD3723@core.coreip.homeip.net>
References: <1309535991-1960-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33860 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab1GDKVF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 06:21:05 -0400
Received: by iwn6 with SMTP id 6so4337242iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 03:21:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309535991-1960-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: rydberg@euromail.se, linux-input@vger.kernel.org

On Fri, Jul 01, 2011 at 08:59:51AM -0700, Ping Cheng wrote:
> On Thu, Jun 30, 2011 at 10:18 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> 
>     > Hi Ping,
> 
>     > On Fri, Jun 24, 2011 at 05:14:58PM -0700, Ping Cheng wrote:
>     >> Instead of 512.
>     >>
>     >> Reported-by: David Foley <favux.is@gmail.com>
>     >> Signed-off-by: Ping Cheng <pingc@wacom.com>
>     >> ---
> 
>     > Perhaps one could elaborate the commit message a bit - in particular
>     > since the text mentions 512, whereas the patch seems to change from
>     > 256?
> 
> Nice catch, Henrik. 512 was a typo. Does this commit message work:
> 
> It is reported by Ubuntu users that Wacom Bamboo Pen D4 has 1024
> pressure level instead of 256.

Unfortunately I already pushed out the patch to we'll have to live with
bad log message. Oh well...

Thanks.

-- 
Dmitry
