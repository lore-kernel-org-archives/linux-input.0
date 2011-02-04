From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] Read whole message instead of just the first byte to
 make CHG low
Date: Fri, 4 Feb 2011 00:54:08 -0800
Message-ID: <20110204085408.GD13046@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB56B.40405@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54815 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab1BDIyQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 03:54:16 -0500
Received: by iyj18 with SMTP id 18so1915599iyj.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 00:54:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4AB56B.40405@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

On Thu, Feb 03, 2011 at 04:02:19PM +0200, Iiro Valkonen wrote:
> Input: qt602240_ts - Read whole message instead of just the first byte to make CHG low
> 
> From: Iiro Valkonen <iiro.valkonen@atmel.com>
> 
> Read the whole message, as reading just the first byte isn't always guaranteed to clear the message.
> 
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>

Applied, thank you Iiro.

-- 
Dmitry
