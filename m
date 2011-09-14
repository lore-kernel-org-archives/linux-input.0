From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH 2/3] TSC-40: fix checkstyle issues
Date: Wed, 14 Sep 2011 14:04:32 +0200
Message-ID: <CAH9NwWczg_+he0UKPVE0POGidghAs_-3a8RXsG4ULB3=p1U4PA@mail.gmail.com>
References: <CAH9NwWfEAag2+d_s3tbNyLV_oi23fTaeXtWvCm8-W+E69fxDcA@mail.gmail.com>
 <20110913084720.GB27776@linutronix.de> <20110913163722.GB2915@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40581 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab1INMEx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 08:04:53 -0400
Received: by gwb15 with SMTP id 15so1477422gwb.19
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2011 05:04:52 -0700 (PDT)
In-Reply-To: <20110913163722.GB2915@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-input@vger.kernel.org

2011/9/13 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, Sep 13, 2011 at 10:47:20AM +0200, Sebastian Andrzej Siewior wrote:
>> * Christian Gmeiner | 2011-09-13 10:18:35 [+0200]:
>>
>> >Subject: [PATCH 2/3] TSC40: fix checkstyle issues
>> >
>> >This patch fixes all found problems.
>>
>> Besides the checkpatch fixes you also increased the msleep delay. For
>> the checkpatch part it is probably better in include it in the previous
>> patch unless Dmitry prefers something different. The same goes probably
>> for the msleep part but pleae denote why this was required.
>
> Yes, please fold the cleanup patches into the original patch.
>

Okay - will send a v2 in a few days

--
Christian Gmeiner, MSc
