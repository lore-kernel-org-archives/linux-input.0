From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm97xx: add BTN_TOUCH event to wm97xx to use it
	with Android
Date: Tue, 17 Feb 2009 10:02:47 +0000
Message-ID: <20090217100246.GB16303@rakim.wolfsonmicro.main>
References: <1234863813-12211-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46929 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751369AbZBQKCt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 05:02:49 -0500
Content-Disposition: inline
In-Reply-To: <1234863813-12211-1-git-send-email-mike@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: lrg@slimlogic.co.uk, linux-input@vger.kernel.org

On Tue, Feb 17, 2009 at 11:43:33AM +0200, Mike Rapoport wrote:
> Please CC me, I'm not subscribed to linux-input

> Android expects BTN_TOUCH events when pen state changes. Add BTN_TOUCH
> event reporting to allow use of wm97xx touchscreen controller wiht
> Android devices.

> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Hrm.  While this is obviously fine from a code point of view it seems
like it'd be better to synthesise the BTN_TOUCH events in the input core
if we want to do this - that way all drivers will behave consistently.
