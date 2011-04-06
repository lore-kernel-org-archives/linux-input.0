From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: h3600_ts - fix error handling at connect
Date: Wed, 6 Apr 2011 15:35:25 -0700
Message-ID: <20110406223525.GD11611@core.coreip.homeip.net>
References: <1301957832.3352.8.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33791 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab1DFWfa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 18:35:30 -0400
Received: by iyb14 with SMTP id 14so1881759iyb.19
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2011 15:35:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301957832.3352.8.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-input <linux-input@vger.kernel.org>, jsimmons@transvirtual.com

On Tue, Apr 05, 2011 at 12:57:12AM +0200, Christoph Fritz wrote:
> In case of an error in h3600ts_connect(), deconstruct by correct order
> and with the right calls.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

Applied, thanks Christoph.

-- 
Dmitry
