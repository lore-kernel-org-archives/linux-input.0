From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: lm8323: add missing device_remove_file for
 dev_attr_time
Date: Sat, 30 Jul 2011 12:07:28 -0700
Message-ID: <20110730190728.GD5686@core.coreip.homeip.net>
References: <1311844021.31725.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35211 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1G3THe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 15:07:34 -0400
Content-Disposition: inline
In-Reply-To: <1311844021.31725.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-input@vger.kernel.org

On Thu, Jul 28, 2011 at 05:07:01PM +0800, Axel Lin wrote:
> Add missing device_remove_file() for dev_attr_time in lm8323_remove().
> Also calling device_remove_file() in lm8323_probe() error path to
> remove sysfs attribute file.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Axel.

-- 
Dmitry
