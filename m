From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/keyboard: Remove obsolete cleanup for clientdata
Date: Tue, 21 Jun 2011 03:40:10 -0700
Message-ID: <20110621104008.GA8468@core.coreip.homeip.net>
References: <1308603674-19264-1-git-send-email-w.sang@pengutronix.de>
 <20110621105532.540dbf7b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54161 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab1FUKkS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 06:40:18 -0400
Content-Disposition: inline
In-Reply-To: <20110621105532.540dbf7b@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Axel Lin <axel.lin@gmail.com>, linux-input@vger.kernel.org

On Tue, Jun 21, 2011 at 10:55:32AM +0200, Jean Delvare wrote:
> On Mon, 20 Jun 2011 23:01:12 +0200, Wolfram Sang wrote:
> > A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> > on exit or error. This is obsolete meanwhile, the core will do it.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Bo Shen <voice.shen@atmel.com>
> > Cc: Axel Lin <axel.lin@gmail.com>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 

Applied, thanks Wolfram.

-- 
Dmitry
