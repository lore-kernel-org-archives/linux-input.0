From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen: tsc2007.c  x_plat_ohms must be > 0 for
 touch to  work
Date: Tue, 11 Oct 2011 20:55:48 -0700
Message-ID: <20111012035547.GB27569@core.coreip.homeip.net>
References: <37B624E6-712E-4909-988F-62E5526180DA@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56420 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab1JLDzx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 23:55:53 -0400
Received: by iaek3 with SMTP id k3so330298iae.19
        for <linux-input@vger.kernel.org>; Tue, 11 Oct 2011 20:55:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <37B624E6-712E-4909-988F-62E5526180DA@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Oct 11, 2011 at 02:28:05PM -0700, Philip Rakity wrote:
> Touch events are not processed unless pressure > 0.
> x_plat_ohms is used in pressure calculation.  ensure driver
> will not start if zero value and indicate reason why there is
> a failure
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Applied, thanks Philip.

-- 
Dmitry
