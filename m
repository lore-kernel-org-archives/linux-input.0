From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] input: wacom: Add fuzz and scale features
Date: Thu, 02 Sep 2010 22:58:36 +0200
Message-ID: <4C800FFC.70303@euromail.se>
References: <1283451517-1711-1-git-send-email-rydberg@euromail.se> <1283451517-1711-2-git-send-email-rydberg@euromail.se> <20100902202655.GB22482@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:38990 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752737Ab0IBU67 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 16:58:59 -0400
In-Reply-To: <20100902202655.GB22482@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

On 09/02/2010 10:26 PM, Dmitry Torokhov wrote:

> Hi Henrik,
> 
> On Thu, Sep 02, 2010 at 08:18:35PM +0200, Henrik Rydberg wrote:
>> The signal-to-noise ratio varies between devices, but currently all
>> devices are treated the same way. In addition, some devices report
>> very low resolution, which makes the fuzz algorithm ineffective.
>> Add fuzz and scale parameters to the feature struct, allowing for
>> tailored treatment of devices.
>>
> 
> While we may adjust fuzz depending on the resolution scaling of the
> data is not kernel's task and should be left to userspace.


The scaling introduced here is for round-off errors in the EWMA filter. Maybe
the Bamboo Touch is a one-in-a-million case, but any device reporting a
resolution lower than the screen will exhibit very jerky motion without such a
scaling. I put the scaling among the features in an attempt to reduce special
code across the driver.

Henrik
