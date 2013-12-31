From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/2] input: mt: Add helper function to send end events
Date: Tue, 31 Dec 2013 10:26:31 +0100
Message-ID: <52C28DC7.9020003@euromail.se>
References: <1388455601-17033-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:41315 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab3LaJXi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Dec 2013 04:23:38 -0500
In-Reply-To: <1388455601-17033-1-git-send-email-eu@felipetonello.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Felipe,

> Adds a helper function to send end touch events for active tracking ids.
> And also implements it in egalax driver.

What problematic scenario is this supposed to solve?

The 'release on suspend' is only an approximation to the 'close laptop' scenario,
it is certainly not correct in the coffee table case, for instance. Instead of
hardcoding this in the kernel, userland can easily detect long intervals
directly using the event time.

Unless there is already a reasonable mechanism in your user application which
deals with cases like this but fails to account for your particular problem
scenario, the patch will not be applied.

Thanks,
Henrik

