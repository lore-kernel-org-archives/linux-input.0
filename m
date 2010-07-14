From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: twl4030-pwrbutton - replace __devinit with __init
Date: Wed, 14 Jul 2010 09:31:49 -0700
Message-ID: <20100714163149.GA9957@core.coreip.homeip.net>
References: <1278509063-30362-1-git-send-email-markus.lehtonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61041 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0GNQbz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 12:31:55 -0400
Received: by pvc7 with SMTP id 7so2810425pvc.19
        for <linux-input@vger.kernel.org>; Wed, 14 Jul 2010 09:31:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278509063-30362-1-git-send-email-markus.lehtonen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Lehtonen <markus.lehtonen@nokia.com>
Cc: linux-input@vger.kernel.org, felipe.balbi@nokia.com

On Wed, Jul 07, 2010 at 04:24:23PM +0300, Markus Lehtonen wrote:
> Power button is not hot-pluggable so we can save some memory by
> using __init.
> 
> Signed-off-by: Markus Lehtonen <markus.lehtonen@nokia.com>

Applied to next, thanks Markus.

-- 
Dmitry
