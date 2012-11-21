From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Input: tca8418_keypad - use a temporary variable for
 parent device
Date: Tue, 20 Nov 2012 23:04:12 -0800
Message-ID: <20121121070412.GD16772@core.coreip.homeip.net>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55651 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2KUHEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 02:04:16 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1862400pad.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 23:04:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

On Wed, Nov 14, 2012 at 08:48:04AM -0800, Dmitry Torokhov wrote:
> Use a temporary variable for our parent device (coming from I2C client
> structure); we'll be also using it during conversion to managed resources.
> 

Alban, if you could test the patches that would be great as 3.8 merge
window is approaching.

Thanks!

-- 
Dmitry
