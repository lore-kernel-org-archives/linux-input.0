From: Dima Zavin <dima@android.com>
Subject: Re: [PATCH 1/4] Revert to anonymous 'type A' MT protocol for touch
Date: Thu, 7 Jul 2011 14:52:51 -0700
Message-ID: <CAPz4a6Cf+rM17qKVDf7mZrYYv4Dzse4w1wVZaWgrSzb8yppk4A@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
	<20110707213506.GA20310@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:48213 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab1GGVwy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 17:52:54 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p67LqqSn027392
	for <linux-input@vger.kernel.org>; Thu, 7 Jul 2011 14:52:52 -0700
Received: from yxk38 (yxk38.prod.google.com [10.190.3.166])
	by hpaq1.eem.corp.google.com with ESMTP id p67LqYnB009360
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 7 Jul 2011 14:52:51 -0700
Received: by yxk38 with SMTP id 38so820084yxk.16
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 14:52:51 -0700 (PDT)
In-Reply-To: <20110707213506.GA20310@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>

Agreed. The next version will correctly use protocol B. When I briefly
(too briefly clearly :-( ) looked at the original patches, I thought
they were driver bug fixes. If it's just workarounds for stuff android
doesn't do, then we should fix our framework.

Jason, do any of these patches fix actual driver bugs or make the
driver more robust?

--Dima

On Thu, Jul 7, 2011 at 2:35 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jul 07, 2011 at 02:04:57PM -0700, Jason Gerecke wrote:
>> Android (at least up to Gingerbread) does not understand the 'B' protocol
>> first made available in 2.6.36. As a workaround until this is fixed, we
>> drop back to using the 'A' protocol.
>>
>
> Well, fix Android then. Same goes for patches 2 & 3.
>
> Thanks.
>
> --
> Dmitry
>
