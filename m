From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] apm-power.c: Fix crash when unloading modules
Date: Mon, 24 Mar 2008 11:03:29 -0400
Message-ID: <20080324150329.GA20402@anvil.corenet.prv>
References: <200803241443.19164.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:58354 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758425AbYCXPDe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2008 11:03:34 -0400
Received: by py-out-1112.google.com with SMTP id u52so4206765pyb.10
        for <linux-input@vger.kernel.org>; Mon, 24 Mar 2008 08:03:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803241443.19164.deller@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Mon, Mar 24, 2008 at 02:43:18PM +0100, Helge Deller wrote:
> This patch fixes a crash in the apm-power driver when a input-device
> (e.g. a keyboard driver module) is unloaded.
> Fix is the same as it's used in the evbug driver.
> I assume this patch went unnoticed, since most keyboard drivers
> in PDAs are not compiled as modules.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> CC: Richard Purdie <rpurdie@rpsys.net>
> 

Applied to the "for-linus" branch of my tree, thank you Helge.

-- 
Dmitry
