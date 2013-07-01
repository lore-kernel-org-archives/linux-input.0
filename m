From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] Input: touchscreen: ads7846: keep copy of
 pdata in private struct
Date: Mon, 1 Jul 2013 00:09:16 -0700
Message-ID: <20130701070916.GC8047@core.coreip.homeip.net>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com>
 <20130701013324.GA10755@core.coreip.homeip.net>
 <51D12652.3090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41312 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3GAHJT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jul 2013 03:09:19 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2388525pdj.17
        for <linux-input@vger.kernel.org>; Mon, 01 Jul 2013 00:09:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D12652.3090804@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

Hi Daniel,

On Mon, Jul 01, 2013 at 08:48:50AM +0200, Daniel Mack wrote:
> Hi Dmitry,
> 
> On 01.07.2013 03:33, Dmitry Torokhov wrote:
> > On Sun, Jun 30, 2013 at 11:09:14PM +0200, Daniel Mack wrote:
> >> +
> >> +	if (!pdata->model)
> >> +		pdata->model = 7846;
> >> +
> >> +	if (!pdata->vref_delay_usecs)
> >> +		pdata->vref_delay_usecs = 100;
> >> +
> >> +	if (!pdata->x_plate_ohms)
> >> +		pdata->x_plate_ohms = 400;
> >> +
> >> +	if (!pdata->pressure_max)
> >> +		pdata->pressure_max = ~0;
> > 
> > We should not be changing the platform data as the device does not own
> > it and it may well be declared as a constant structure.
> 
> We don't change the platform data that is passed in via the driver core.
> We keep a copy of it in our private strucz (that's what the subject
> says) and in case of DT, we modify that copy. The passed pdata is left
> untouched.
> 

That might have been the intent but the patch only stores a _pointer_ to
the platform data in the main structure, so in non-DT case you end up
modifying the original structure.

Thanks.

-- 
Dmitry
