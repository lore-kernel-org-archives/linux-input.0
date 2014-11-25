From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom - PAD is independent with pen/touch
Date: Tue, 25 Nov 2014 14:33:12 -0800
Message-ID: <CAF8JNhLoEHz9KOyMhOQoL9dECWZaGRJ3iUqWFM8UCc+UTw2rmw@mail.gmail.com>
References: <1416529872-3128-1-git-send-email-pingc@wacom.com>
	<CAF8JNh+MrEPKLQ9-KPW3T25zT_AFs9jh2F1+d9ba=xWFxwsF6Q@mail.gmail.com>
	<alpine.LNX.2.00.1411252056130.23174@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:57913 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbaKYWdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 17:33:14 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so1443649lab.38
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 14:33:12 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1411252056130.23174@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Nov 25, 2014 at 11:56 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 25 Nov 2014, Ping Cheng wrote:
>
>> Please don't forget to merge this patch. It fixes a bad pointer issue...
>
> Hi Ping,
>
> yes, it's in my queue for this evening or tomorrow.

Thank you.

> I will also add Cc: stable, ok?

If you Cc this one to stable, please also include my other three
patches, dated Nov. 18, 2014, under your wacom-3.19 branch. Those four
patches go together to fix a system freeze issue caused by Bamboo Pen
only device.

Cheers,

Ping
