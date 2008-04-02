From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] locomokbd.c: Add "Off"-button functionality for Sharp
	Collie/Poodle
Date: Wed, 2 Apr 2008 02:16:09 -0400
Message-ID: <20080402061609.GC14189@anvil.corenet.prv>
References: <200803241419.38374.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:9330 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422AbYDBGQP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2008 02:16:15 -0400
Received: by an-out-0708.google.com with SMTP id d31so651648and.103
        for <linux-input@vger.kernel.org>; Tue, 01 Apr 2008 23:16:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803241419.38374.deller@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-input@vger.kernel.org, thommycheck@gmx.de, rpurdie@rpsys.net, hvontres@gmail.com

On Mon, Mar 24, 2008 at 02:19:37PM +0100, Helge Deller wrote:
> This patch enables the Sharp Zaurus Collie and Poodle devices to be turned
> off by pressing the "Cancel" button for a few seconds (as designed by Sharp).
> 
> Additional small cleanups:
> - removal of unused #defines and variables
> - add missing __devinit/__devexit/__devinitconst annotations
> - reorganized copyright notice
> 
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Applied to the input tree, thank you Helge.

-- 
Dmitry
