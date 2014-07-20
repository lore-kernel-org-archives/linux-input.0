From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] Input: Add driver for Microchip's CAP1106
Date: Sun, 20 Jul 2014 13:42:21 -0700
Message-ID: <20140720204221.GC18347@core.coreip.homeip.net>
References: <1405423859-16121-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35400 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbaGTUmZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 16:42:25 -0400
Content-Disposition: inline
In-Reply-To: <1405423859-16121-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, dh.herrmann@gmail.com, devicetree@vger.kernel.org, mark.rutland@arm.com

On Tue, Jul 15, 2014 at 01:30:59PM +0200, Daniel Mack wrote:
> This patch adds a driver for Microchips CAP1106, an I2C driven, 6-channel
> capacitive touch sensor.
> 
> For now, only the capacitive buttons are supported, and no specific
> settings that can be tweaked for individual channels, except for the
> device-wide sensitivity gain. The defaults seem to work just fine out of
> the box, so I'll leave configurable parameters for someone who's in need
> of them and who can actually measure the impact. All registers are
> prepared, however. Many of them are just not used for now.
> 
> The implementation does not make any attempt to be compatible to platform
> data driven boards, but fully depends on CONFIG_OF.
> 
> Power management functions are also left for volounteers with the ability
> to actually test them.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Applied, thank you.

-- 
Dmitry
