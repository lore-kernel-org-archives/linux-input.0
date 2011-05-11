From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: ads7846: fix gpio_pendown configuration
Date: Wed, 11 May 2011 15:44:29 -0700
Message-ID: <20110511224429.GG11178@core.coreip.homeip.net>
References: <20110505161356.GF27251@core.coreip.homeip.net>
 <1304844290-31233-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39827 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265Ab1EKWog (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 18:44:36 -0400
Received: by pvg12 with SMTP id 12so448146pvg.19
        for <linux-input@vger.kernel.org>; Wed, 11 May 2011 15:44:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304844290-31233-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-input@vger.kernel.org

On Sun, May 08, 2011 at 11:44:50AM +0300, Igor Grinberg wrote:
> The pendown gpio was requested but not configured for input.
> Configure it for input.
> 

Applied, thanks Igor.

-- 
Dmitry
