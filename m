From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] Input: touchscreen: ads7846: keep copy of
 pdata in private struct
Date: Mon, 1 Jul 2013 00:21:48 -0700
Message-ID: <20130701072148.GA9861@core.coreip.homeip.net>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com>
 <20130701013324.GA10755@core.coreip.homeip.net>
 <51D12652.3090804@gmail.com>
 <20130701070916.GC8047@core.coreip.homeip.net>
 <51D12C3C.1090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36951 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3GAHVv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jul 2013 03:21:51 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so4690974pab.22
        for <linux-input@vger.kernel.org>; Mon, 01 Jul 2013 00:21:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D12C3C.1090002@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

On Mon, Jul 01, 2013 at 09:14:04AM +0200, Daniel Mack wrote:
> On 01.07.2013 09:09, Dmitry Torokhov wrote:
> > Hi Daniel,
> > 
> > On Mon, Jul 01, 2013 at 08:48:50AM +0200, Daniel Mack wrote:
> >> Hi Dmitry,
> >>
> >> On 01.07.2013 03:33, Dmitry Torokhov wrote:
> >>> On Sun, Jun 30, 2013 at 11:09:14PM +0200, Daniel Mack wrote:
> >>>> +
> >>>> +	if (!pdata->model)
> >>>> +		pdata->model = 7846;
> >>>> +
> >>>> +	if (!pdata->vref_delay_usecs)
> >>>> +		pdata->vref_delay_usecs = 100;
> >>>> +
> >>>> +	if (!pdata->x_plate_ohms)
> >>>> +		pdata->x_plate_ohms = 400;
> >>>> +
> >>>> +	if (!pdata->pressure_max)
> >>>> +		pdata->pressure_max = ~0;
> >>>
> >>> We should not be changing the platform data as the device does not own
> >>> it and it may well be declared as a constant structure.
> >>
> >> We don't change the platform data that is passed in via the driver core.
> >> We keep a copy of it in our private strucz (that's what the subject
> >> says) and in case of DT, we modify that copy. The passed pdata is left
> >> untouched.
> >>
> > 
> > That might have been the intent but the patch only stores a _pointer_ to
> > the platform data in the main structure, so in non-DT case you end up
> > modifying the original structure.
> 
> Eh, ok. I'll change that to always make a copy. Somehow though, I like
> the first approach (v1 of the set) better, which stored all data that is
> modified inside the private struct directly.
> 
> Anyway, I'll submit v3 later.

No, there is no need, the other patch (adding DT bindings) should work
just fine without this one.

Thanks.

-- 
Dmitry
