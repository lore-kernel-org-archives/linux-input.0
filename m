From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input - wacom: Not all multi-interface devices
 support touch
Date: Tue, 15 Oct 2013 23:48:47 -0700
Message-ID: <20131016064847.GB24554@core.coreip.homeip.net>
References: <1381439833-1116-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35754 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3JPGsu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 02:48:50 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so351124pdj.35
        for <linux-input@vger.kernel.org>; Tue, 15 Oct 2013 23:48:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381439833-1116-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, peter.hutterer@who-t.net, chris@cnpbagwell.com, Ping Cheng <pingc@wacom.com>

On Thu, Oct 10, 2013 at 02:17:13PM -0700, Ping Cheng wrote:
> Some multi-interface devices support expresskeys on a separate interface,
> such as Bamboo; some multi-interface devices do not support touch at all,
> such as Pen only Intuos5. Make sure we report the right device names.
> 
> Tested-by: Jason Gerecke <killertofu@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied, thank you.

-- 
Dmitry
