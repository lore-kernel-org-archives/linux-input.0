From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: eeti_ts: allow active high irq lines
Date: Wed, 12 Aug 2009 23:50:34 -0700
Message-ID: <20090813072116.BF622526EC9@mailhub.coreip.homeip.net>
References: <1250005972-27095-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:5791 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbZHMGuh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 02:50:37 -0400
Received: by rv-out-0506.google.com with SMTP id f6so187518rvb.1
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2009 23:50:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1250005972-27095-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Tue, Aug 11, 2009 at 05:52:52PM +0200, Daniel Mack wrote:
> This adds a struct eeti_ts_platform_data which currently holds only one
> value to specify the interrupt polarity.
> 
> The driver has a fallback if no platform data is passed in via the
> i2c_board_info, so no regression is caused.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>


Applied to next, thanks Daniel.

-- 
Dmitry
