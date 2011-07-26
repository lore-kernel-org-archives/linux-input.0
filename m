From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 1/9 v2] Input: synaptics - refactor y inversion
Date: Tue, 26 Jul 2011 10:19:31 +0800
Message-ID: <CAGS+omB1sR88N=yytW7k_O8r4WkCowQwGFN30wzyK0wEEWBUmw@mail.gmail.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
 <1311169146-20066-2-git-send-email-djkurtz@chromium.org> <20110725082752.GB22937@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:1967 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab1GZCTz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 22:19:55 -0400
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com [172.25.105.82])
	by smtp-out.google.com with ESMTP id p6Q2JrRg021986
	for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 19:19:53 -0700
Received: from iyb39 (iyb39.prod.google.com [10.241.49.103])
	by kpbe18.cbf.corp.google.com with ESMTP id p6Q2JpDH026602
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 19:19:51 -0700
Received: by iyb39 with SMTP id 39so25494iyb.18
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 19:19:51 -0700 (PDT)
In-Reply-To: <20110725082752.GB22937@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Mon, Jul 25, 2011 at 4:27 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jul 20, 2011 at 09:38:58PM +0800, djkurtz@chromium.org wrote:
>> From: Daniel Kurtz <djkurtz@chromium.org>
>>
>> Synaptics touchpads report increasing y from bottom to top.
>> This is inverted from normal userspace "top of screen is 0" coordinates.
>> Thus, the kernel driver reports inverted y coordinates to userspace.
>>
>> This patch refactors this inversion.
>>
>
> I really do not see the point...

The point is that this inversion is done in 3 places in the driver.
Refactoring lets us document why this inversion is happening in just a
single place.

>
> Thanks.
>
> --
> Dmitry
>
