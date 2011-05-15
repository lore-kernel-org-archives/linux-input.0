From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] pwm: Add __weak attributed functions for pwm
	operations
Date: Sun, 15 May 2011 11:58:50 +0100
Message-ID: <20110515105850.GH30539@n2100.arm.linux.org.uk>
References: <1305290602-29859-1-git-send-email-mpallaka@codeaurora.org> <1305290602-29859-2-git-send-email-mpallaka@codeaurora.org> <20110515080031.GA12911@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36925 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab1EOK7L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 May 2011 06:59:11 -0400
Content-Disposition: inline
In-Reply-To: <20110515080031.GA12911@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mohan Pallaka <mpallaka@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.intradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Sun, May 15, 2011 at 01:00:31AM -0700, Dmitry Torokhov wrote:
> On Fri, May 13, 2011 at 06:13:21PM +0530, Mohan Pallaka wrote:
> > For chip drivers that support both pwm and non-pwm modes
> > would encounter compilation errors if the platform doesn't
> > have support for pwm though the chip is programmed to work
> > in non-pwm mode. Add __weak attributed pwm functions to avoid
> > compilation issues in these scenarios.
> > 
> 
> Russell,
> 
> You seem to have authored pwm.h, do you have any objections to this
> change?

This seems to be a recipe for an oops.  Have a look at how
linux/regulator/consumer.h deals with this kind of problem, and notice
that we have CONFIG_HAVE_PWM to indicate whether this interface is
supported or not.
