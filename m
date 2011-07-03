From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/3] Updates to the wm97xx-drivers
Date: Sun, 3 Jul 2011 13:37:22 -0700
Message-ID: <20110703203721.GA13701@opensource.wolfsonmicro.com>
References: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35235 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753071Ab1GCUh0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 3 Jul 2011 16:37:26 -0400
Content-Disposition: inline
In-Reply-To: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-input@vger.kernel.org, dp@opensource.wolfsonmicro.com

On Sun, Jul 03, 2011 at 07:09:27PM +0200, Wolfram Sang wrote:
> I noticed a problem that reading battery status was dependent on the pen_down
> status. While trying to solve the problem, I came up with the first two cleanup
> patches. The third one then fixes the original itch. The series been tested
> with Linux 3.0-rc5 on a Jaytech PID7901 having a WM9715. The code for WM9705
> and WM9713 has only been compile tested. Testers are very welcome :)

All

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
