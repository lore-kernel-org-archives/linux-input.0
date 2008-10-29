From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Tue, 28 Oct 2008 23:55:04 -0400
Message-ID: <20081029035504.GC27906@anvil.corenet.prv>
References: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f18.google.com ([209.85.217.18]:44292 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbYJ2DzL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2008 23:55:11 -0400
Received: by gxk11 with SMTP id 11so2307290gxk.13
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2008 20:55:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

Hi Peter,

On Thu, Oct 23, 2008 at 08:51:30AM +0300, Peter Ujfalusi wrote:
> Hello,
> The following two patches provides fixes for the omap-keypad
> driver on OMAP2.
> 
> Peter Ujfalusi (2)
>   OMAP2: omap-keypad: interrupt disable fix
>   OMAP2: omap-keypad: Enable more than 6 rows
> 
>  drivers/input/keyboard/omap-keypad.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 

Looks good, will apply to 'next' branch.

-- 
Dmitry
