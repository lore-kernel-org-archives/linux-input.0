From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Question: I2C touchscreen controller
Date: Wed, 24 Aug 2011 12:54:36 -0700
Message-ID: <20110824195436.GA13228@core.coreip.homeip.net>
References: <ADE657CA350FB648AAC2C43247A983F001F3885759E3@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:42888 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab1HXTym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 15:54:42 -0400
Received: by iye16 with SMTP id 16so2643269iye.1
        for <linux-input@vger.kernel.org>; Wed, 24 Aug 2011 12:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3885759E3@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Hartley,

On Wed, Aug 24, 2011 at 01:23:59PM -0500, H Hartley Sweeten wrote:
> Hello all,
> 
> I have a question...
> 
> Are there any I2C touchscreen controllers that do not need irq support?
> 
> I have a system with an I2C bus available to connect to the touchscreen
> controller but I don't have an IRQ pin available.  Right now I'm just
> trying to discover if there is a possible solution or if I will need to
> modify my board somehow to get an IRQ.

Without IRQ you are limited to polling mode which, for touchscreens,
needs to be done at fairly high rate to provide adequate responsiveness.
This, in turn, will put considerable load on the system thus driving up
power requirements... IOW not very suitable for production use, that is
why I've been asking people to submit IRQ-driven drivers, if at all
possible.

If polling is your only option then input-polldev is your friend.

-- 
Dmitry
