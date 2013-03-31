From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: imx_keypad - use devm_ functions
Date: Sun, 31 Mar 2013 00:39:26 -0700
Message-ID: <20130331073926.GF7919@core.coreip.homeip.net>
References: <1363193466-10737-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:55383 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab3CaHj3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Mar 2013 03:39:29 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so697821dak.30
        for <linux-input@vger.kernel.org>; Sun, 31 Mar 2013 00:39:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363193466-10737-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Mar 13, 2013 at 01:51:06PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using devm_ functions can make the code cleaner and simpler. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Remove imx_keypad_remove()

Applied, thank you Fabio.

-- 
Dmitry
