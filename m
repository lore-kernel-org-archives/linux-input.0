Return-Path: <SRS0=GsZw=3Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF74C2D0B1
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1788521744
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 09:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgBDJ1c (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:27:32 -0500
Received: from mta-out1.inet.fi ([62.71.2.202]:51026 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBDJ1c (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Feb 2020 04:27:32 -0500
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeelgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepnfgruhhrihculfgrkhhkuhcuoehlrghurhhirdhjrghkkhhusehpphdrihhnvghtrdhfiheqnecukfhppeekgedrvdegkedrfedtrdduleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddufeegngdpihhnvghtpeekgedrvdegkedrfedtrdduleehpdhmrghilhhfrhhomhepoehlrghujhgrkhdqfeesmhgsohigrdhinhgvthdrfhhiqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeosggvnhhjrghmihhnrdhtihhsshhoihhrvghssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehjihhkohhssehkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeolhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehonhgvuhhkuhhmsehsuhhsvgdrtghomheq
Received: from [192.168.1.134] (84.248.30.195) by julia1.inet.fi (9.0.019.26-1) (authenticated as laujak-3)
        id 5E37D3E200048C87; Tue, 4 Feb 2020 11:27:29 +0200
Subject: Re: USB HID fix: Retry sending timedout device commands 20 times
To:     Oliver Neukum <oneukum@suse.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
References: <9cf20b6f-5bfa-2346-ca9f-5ca81245bfff@pp.inet.fi>
 <CAO-hwJJDkFh+ZS7pCZLhfuoXeAByFLzKbPW8mHtF=N_e-hn+Dg@mail.gmail.com>
 <1580807154.11089.0.camel@suse.com>
From:   Lauri Jakku <lauri.jakku@pp.inet.fi>
Message-ID: <11338553-09e7-5201-d829-4c52eb86f50e@pp.inet.fi>
Date:   Tue, 4 Feb 2020 11:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1580807154.11089.0.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


On 4.2.2020 11.05, Oliver Neukum wrote:
> Am Dienstag, den 04.02.2020, 09:17 +0100 schrieb Benjamin Tissoires:
>> Ouch, very much ouch. Resending 20 times on a generic path when the
>> timeout can be several seconds is pretty much a bad thing. Again, this
>> should be limited to the device you are talking to, and not be
>> generic. Or maybe you are encountering a usb controller issue.
> Yes. You need a least to consider teh unplug case.
>
> 	Regards
> 		Oliver

The patch does not loop in normal case, only if there are timeouts, and

even then not more than 400ms .. 20ms sleep while retry.


-- 
Br,
Lauri J.

