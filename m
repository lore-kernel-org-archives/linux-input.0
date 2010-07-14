From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add pwm beeper driver
Date: Wed, 14 Jul 2010 01:20:57 -0700
Message-ID: <20100714082057.GA2786@core.coreip.homeip.net>
References: <1279041459-5585-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51147 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab0GNI0J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 04:26:09 -0400
Content-Disposition: inline
In-Reply-To: <1279041459-5585-1-git-send-email-lars@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 13, 2010 at 07:17:39PM +0200, Lars-Peter Clausen wrote:
> This patch adds a simple driver which allows to use pwm based beepers (for
> example piezo elements) as a pcspkr-like device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

The driver looks reasonable, applied to 'next' branch, thanks
Lars-Peter.

-- 
Dmitry
