From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: The way for disabling input device?
Date: Tue, 15 Mar 2011 15:17:29 +0000
Message-ID: <20110315151728.GD17277@sirena.org.uk>
References: <4D7F2C12.5020509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37533 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1COPRb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 11:17:31 -0400
Content-Disposition: inline
In-Reply-To: <4D7F2C12.5020509@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Mar 15, 2011 at 06:06:26PM +0900, Joonyoung Shim wrote:

> The framebuffer device driver of kernel supplies sysfs interface to
> control blanking level of framebuffer and  we can turn off LCD panel
> using this sysfs at the above case.

> Currently i know there isn't the generic way for disabling input device
> via user interface, so i am looking for the way for disabling
> input device on kernel side for above case.

Isn't the expectation here that userspace closes the input device when
it blanks the screen?
