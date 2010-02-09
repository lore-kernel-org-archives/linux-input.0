From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: bitmap update for sh_keysc V2
Date: Tue, 9 Feb 2010 01:39:54 -0800
Message-ID: <20100209093954.GC12642@core.coreip.homeip.net>
References: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f202.google.com ([209.85.216.202]:44483 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab0BIJkB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 04:40:01 -0500
Content-Disposition: inline
In-Reply-To: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Tue, Feb 09, 2010 at 06:16:09PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the sh_keysc driver with proper bitmap support V2.
> This instead of using a fixed 32-bit integer to keep track
> for the key states. With this change in place the driver
> supports key pads with more than 32 keys.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Changes since V1:
>  - ditched the wrapping macros
>  - use __set_bit() and __clear_bit()

Thank you for making the change. It indeed is easier to read than the
original since one does not have to go and look up what wrappers are
doing.

-- 
Dmitry
