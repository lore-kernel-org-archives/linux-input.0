From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: ad7877 - Convert to dev_pm_ops
Date: Thu, 20 Jan 2011 22:56:01 -0800
Message-ID: <20110121065601.GA21842@core.coreip.homeip.net>
References: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49127 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab1AUG4J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 01:56:09 -0500
Received: by iyj18 with SMTP id 18so1378504iyj.19
        for <linux-input@vger.kernel.org>; Thu, 20 Jan 2011 22:56:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

On Thu, Jan 20, 2011 at 09:10:21PM +0000, Mark Brown wrote:
> There is a move to deprecate bus-specific PM operations and move to
> using dev_pm_ops instead in order to reduce the amount of boilerplate
> code in buses and facilitiate updates to the PM core. Do this move for
> the ad7879 SPI driver.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied all 3 to next, thanks Mark.

-- 
Dmitry
