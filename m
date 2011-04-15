From: Sadrul Chowdhury <sadrul@chromium.org>
Subject: Re: [PATCH] input-mt: Allow -1 for tracking id
Date: Fri, 15 Apr 2011 09:09:58 -0400
Message-ID: <BANLkTinPVJU49g+L_Qu-uFW-1b2CJJ0LuQ@mail.gmail.com>
References: <BANLkTimcCh7MbmxtuzTCEFyT28FHZU+ijw@mail.gmail.com> <20110415070000.GA7135@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:9479 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1DONKV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Apr 2011 09:10:21 -0400
Received: from kpbe12.cbf.corp.google.com (kpbe12.cbf.corp.google.com [172.25.105.76])
	by smtp-out.google.com with ESMTP id p3FDAJPY028940
	for <linux-input@vger.kernel.org>; Fri, 15 Apr 2011 06:10:19 -0700
Received: from iye19 (iye19.prod.google.com [10.241.50.19])
	by kpbe12.cbf.corp.google.com with ESMTP id p3FDAIt1028181
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 15 Apr 2011 06:10:18 -0700
Received: by iye19 with SMTP id 19so2901465iye.31
        for <linux-input@vger.kernel.org>; Fri, 15 Apr 2011 06:10:18 -0700 (PDT)
In-Reply-To: <20110415070000.GA7135@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Fri, Apr 15, 2011 at 3:00 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Sadrul,
>
> On Thu, Apr 14, 2011 at 06:13:17PM -0400, Sadrul Chowdhury wrote:
>> In protocol B, the tracking ID can be set to -1. But since the min
>> value is set to 0, the clients don't receive a -1 when a contact is
>> lifted. The attached patch sets the min to -1 to fix this issue.
>
> All ABS_MT_TRACKING_ID values outside the valid value range denote an
> invalid touch. To simplify implementation in userland, where the valid
> range may not always be known, the documentation was changed to say
> "-1" instead. Apparently the original explanation was unintentionally
> dropped with it.
>
> Because the change goes against the semantics of the tracking id, this
> patch constitues an interface breakage, with malfunctions in userspace
> as a result. Therefore, this patch will not be applied.

Ah, that makes sense. Thanks for the explanation. I will fix things on
the client end.

Thanks.
Sadrul
