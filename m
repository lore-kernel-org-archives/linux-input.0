From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V1] input: keyboard: Add interrupt keyboard driver.
Date: Wed, 18 Jan 2012 23:29:41 -0800
Message-ID: <20120119072941.GA9668@core.coreip.homeip.net>
References: <1326778915-2678-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56601 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab2ASH3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jan 2012 02:29:47 -0500
Content-Disposition: inline
In-Reply-To: <1326778915-2678-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: tsoni@codeaurora.org, kyle.manna@fuel7.com, aghayal@codeaurora.org, vapier@gentoo.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Laxman,

On Tue, Jan 17, 2012 at 11:11:55AM +0530, Laxman Dewangan wrote:
> This driver enables the key detection of the keys which
> are connected to interrupt lines.
> Each key is capable of generating an interrupt, and the
> statesi (pressed or released) cannot be found by any
> mechanism.
> A key press event generated when interrupt occurs, and
> based on the debounce time setting, a key release event
> is generated. There is no need to read the state of the
> keys.


Is it possible to modify gpio_keys to skip requesting and settin up
certain gpios and and use it instead of a brand new driver?

-- 
Dmitry
