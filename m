From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] input: Add Nintendo extension controller driver
Date: Mon, 23 May 2011 22:50:34 +0200
Message-ID: <87fwo5ywdh.fsf@macbook.be.48ers.dk>
References: <20110516214608.17011.3075.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52647 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab1EWUuk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 16:50:40 -0400
In-Reply-To: <20110516214608.17011.3075.stgit@ponder> (Grant Likely's message
	of "Mon, 16 May 2011 15:46:08 -0600")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: simon@mungewell.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, OliverNeukumoliver@neukum.org

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

 Grant> This driver adds support for Nintendo Wiimote extension controllers
 Grant> directly attached to an i2c bus, such as when using an adaptor like
 Grant> the Wiichuck.


 Grant> + * If the device is recognized, then the polling period is bumped up
 Grant> + * to 50ms, and the state machine enters into a loop alternating

<snip>

 Grant> +#else
 Grant> +#define WIICHUCK_CAPTURE_PERIOD (100)	/* 100 milliseconds */

50 or 100ms?

-- 
Bye, Peter Korsgaard
