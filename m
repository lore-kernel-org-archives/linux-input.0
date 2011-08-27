From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cm109 - fix checking return value of
 usb_control_msg
Date: Fri, 26 Aug 2011 23:29:41 -0700
Message-ID: <20110827062941.GA29434@core.coreip.homeip.net>
References: <1314281210.5915.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44820 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab1H0G3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Aug 2011 02:29:47 -0400
Content-Disposition: inline
In-Reply-To: <1314281210.5915.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Alfred E. Heggestad" <aeh@db.org>, linux-input@vger.kernel.org

On Thu, Aug 25, 2011 at 10:06:50PM +0800, Axel Lin wrote:
> If successful, usb_control_msg returns the number of bytes transferred,
> otherwise a negative error number.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Axel.

-- 
Dmitry
