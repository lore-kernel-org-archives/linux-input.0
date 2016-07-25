From: Mark Laws <mdl@60hz.org>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Tue, 26 Jul 2016 07:15:58 +0900
Message-ID: <CADemMPO4YY_sFZAseMD=d0SOZeeeNj7f35Q9h=AeHwVU5-1jGA@mail.gmail.com>
References: <CADemMPNEv+kq21rXQMmB_BjgTsnEjscOCS5A02VAapOOM-ryMA@mail.gmail.com>
 <20160725210108.GK27415@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35298 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbcGYWQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 18:16:00 -0400
Received: by mail-io0-f176.google.com with SMTP id m101so178941800ioi.2
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 15:16:00 -0700 (PDT)
In-Reply-To: <20160725210108.GK27415@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KY Srinivasan <kys@microsoft.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Linux Input <linux-input@vger.kernel.org>

On Tue, Jul 26, 2016 at 6:01 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> [ resending to inlude the list ]
>
> Hi Mark,
>
> (snip)
>
> Can you please tell me if the patch below solves the issue for you?
>
> Thanks!

Hi Dmitry,

No worries about the delay! I tested your patch just now and I can
confirm it solves the issue.

Regards,
Mark Laws

-- 
|v\ /\ |\ |< |_ /\ \^| //
