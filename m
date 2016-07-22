From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Thu, 21 Jul 2016 17:57:55 -0700
Message-ID: <CAKdAkRSYxM0_JOD-fR_n49PFxPUbZbVZ4nDqhgzm=HzCb8FQHg@mail.gmail.com>
References: <20160717185134.GA20462@deathstar> <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar> <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd> <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly> <20160721063234.GA14200@amd>
 <20160721064241.GA31008@jelly> <20160721085421.GA15485@amd> <20160722001012.GA11426@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35681 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbcGVA55 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 20:57:57 -0400
In-Reply-To: <20160722001012.GA11426@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com

On Thu, Jul 21, 2016 at 5:10 PM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Thu, Jul 21, 2016 at 10:54:21AM +0200, Pavel Machek wrote:
>> Should we have calibration info in the device tree, with kernel
>> passing it to the x?
>>
>> Should kernel somehow do the calibration itself?
>
> if the kernel knows about the calibration it would make more sense to just
> do it in the kernel directly.

Historically we relied on userspace to perform
calibration/transformation. Lately we've been introducing trivial
transformations (inversion and axes swapping) and we allow plumbing
this though DT; the rest I think is still better done in userspace
(where you can do floating point, if desired).

> but for anything even remotely run-time or
> user-configured the xorg.conf snippet is the best solution.

Thanks.

-- 
Dmitry
