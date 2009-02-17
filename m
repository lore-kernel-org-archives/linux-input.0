From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm97xx: add BTN_TOUCH event to wm97xx to use it
	with Android
Date: Tue, 17 Feb 2009 13:30:28 +0000
Message-ID: <20090217133028.GD16303@rakim.wolfsonmicro.main>
References: <1234863813-12211-1-git-send-email-mike@compulab.co.il> <20090217100246.GB16303@rakim.wolfsonmicro.main> <499AA29B.8090803@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48787 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752135AbZBQNaa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 08:30:30 -0500
Content-Disposition: inline
In-Reply-To: <499AA29B.8090803@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: lrg@slimlogic.co.uk, linux-input@vger.kernel.org

On Tue, Feb 17, 2009 at 01:42:19PM +0200, Mike Rapoport wrote:

> The difficulty here is to find out when BTN_TOUCH should be generated and what
> should be its value. As far as I can see from different drivers, there's no
> one-to-one correspondence between ABS_PRESSURE and BTN_TOUCH. For instance,
> drivers/input/mouse/synaptics.c has

As a default it should be fine to check for zero/non-zero.  Anything
that wants to override the behaviour could supply their own BTN_TOUCH.
Another option would be to change Android user space to support pressure
only touchscreens.

Like I say, I'm fine with the patch itself so it's got my ack - it just
feels like it fixes the problem at the wrong level.   From that PoV
consider it to have

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
