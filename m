From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] tsc2007: Debounce pressure measurement.
Date: Mon, 16 May 2011 23:02:41 -0700
Message-ID: <20110517060241.GC20428@core.coreip.homeip.net>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42300 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab1EQGCr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 02:02:47 -0400
Received: by pvg12 with SMTP id 12so90601pvg.19
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 23:02:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwlee@mtekvision.com>

On Mon, May 16, 2011 at 10:32:59AM +0200, Thierry Reding wrote:
> When the controller signals a pen-down event via the platform-specific
> GPIO, while the sample values indicate an invalid measurement, the
> measurement needs to be repeated.
> 

Would not we be interrupted again and take another sample then?

Thanks.

-- 
Dmitry
