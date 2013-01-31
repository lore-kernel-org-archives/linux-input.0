From: simon@mungewell.org
Subject: Re: [PATCH 1/5] USB: HID: SRW-S1 Gaming Wheel Driver
Date: Thu, 31 Jan 2013 11:15:57 -0500
Message-ID: <24729db4d06b0a7e8192fc7a137dabc2.squirrel@mungewell.org>
References: <alpine.LNX.2.00.1301291057170.23853@pobox.suse.cz>
    <1359644830-3274-1-git-send-email-simon@mungewell.org>
    <alpine.LNX.2.00.1301311622430.23853@pobox.suse.cz>
    <16fadf665c1103c5f3184d9f4471d415.squirrel@mungewell.org>
    <alpine.LNX.2.00.1301311653090.23853@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:52688 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3AaQP6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 11:15:58 -0500
In-Reply-To: <alpine.LNX.2.00.1301311653090.23853@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rosegardener@freeode.co.uk

> On Thu, 31 Jan 2013, simon@mungewell.org wrote:
>
>> > I thought we converged to hid-steelseries name in the end originally?
>> >
>> > If you agree, I'll change it and apply.
>>
>> I'd be OK with that,
>
> Thanks. I will also apply this patch on top, otherwise we'll be corrupting
> memory in steelseries_srws1_probe() here:
>
> 	drv_data->led[SRWS1_NUMBER_LEDS] = led;
>


You are correct.

Bugger! I had that in the original patch, but must have missed it when
copying over to new file name.

Thanks,
Simon.

