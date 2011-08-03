From: Yufeng Shen <miletus@chromium.org>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Report pressure information from
 the driver
Date: Wed, 3 Aug 2011 12:22:19 -0400
Message-ID: <CAPDwgkOpBg911PjoAb1ywv769nC63QDAJgUSES+3PmRsMENMHg@mail.gmail.com>
References: <1311787695-28147-1-git-send-email-miletus@chromium.org>
	<20110730191206.GF5686@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:29607 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab1HCQWX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 12:22:23 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p73GMMAR030666
	for <linux-input@vger.kernel.org>; Wed, 3 Aug 2011 09:22:22 -0700
Received: from yxn22 (yxn22.prod.google.com [10.190.4.86])
	by hpaq14.eem.corp.google.com with ESMTP id p73GMKCs011493
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 3 Aug 2011 09:22:21 -0700
Received: by yxn22 with SMTP id 22so659640yxn.0
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 09:22:20 -0700 (PDT)
In-Reply-To: <20110730191206.GF5686@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Iiro Valkonen <iiro.valkonen@atmel.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Chris Leech <christopher.leech@linux.intel.com>, linux-kernel@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, "Gong, Michael" <Michael.Gong@atmel.com>

Re-sent this email due to linux-input@veger.kernel.org rejecting last
reply for containing HTML subpart

-----------------------------------------------------------------------------------------------------------------------------------------------

Hi Dmitry,

Currently the driver atmel_mxt_ts.c supports 3 different models of
atmel touch controller:

1. qt602240_ts
2. atmel_mxt_ts   (which is for mxt1386)
3. mXT224

Confirmed with atmel side that qt602240_ts is actually an alias for
mxt224, and mxt224
follows the same protocol guide with mxt1386, which means it will
report the pressure
information the same way as mxt1386.

--- Yufeng Shen

On Sat, Jul 30, 2011 at 3:12 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Yufeng,
>
> On Wed, Jul 27, 2011 at 01:28:15PM -0400, Yufeng Shen wrote:
>> Atmel mxt1386 touch controller has the touch pressure information but
>> the current driver atmel_mxt_ts does not expose it to the user space.
>> This patch makes the driver report the touch pressure information to
>> user space.
>>
>
> What about other controllers supported by this driver? Do all of them
> report pressure? Do all have the same reporting range?
>
> Thanks.
>
> --
> Dmitry
>
