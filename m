From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/16] input: tnetv107x-touchscreen: don't treat NULL clk
 as an error
Date: Tue, 11 Jan 2011 21:56:41 -0800
Message-ID: <20110112055640.GC22944@core.coreip.homeip.net>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
 <1294749833-32019-5-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52815 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab1ALF4q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 00:56:46 -0500
Content-Disposition: inline
In-Reply-To: <1294749833-32019-5-git-send-email-jamie@jamieiles.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-kernel@vger.kernel.org, Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org

On Tue, Jan 11, 2011 at 12:43:41PM +0000, Jamie Iles wrote:
> clk_get() returns a struct clk cookie to the driver and some platforms
> may return NULL if they only support a single clock.  clk_get() has only
> failed if it returns a ERR_PTR() encoded pointer.
> 
> Cc: Cyril Chemparathy <cyril@ti.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Applied both, thank you Jamie.

-- 
Dmitry
