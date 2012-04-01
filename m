From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 01 Apr 2012 23:11:23 +0300
Message-ID: <4F78B66B.4050302@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com> <CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com> <4F78B036.8070207@gmail.com> <alpine.LNX.2.00.1204012147270.16928@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44279 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab2DAUL0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 16:11:26 -0400
Received: by wgbdr13 with SMTP id dr13so2085582wgb.1
        for <linux-input@vger.kernel.org>; Sun, 01 Apr 2012 13:11:25 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1204012147270.16928@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input <linux-input@vger.kernel.org>

Hi Jiri,

On 04/01/2012 10:49 PM, Jiri Kosina wrote:
> On Sun, 1 Apr 2012, Nikolai Kondrashov wrote:
>> However, I plan to make a non-HID driver for Waltop tablets, using their
>> proprietary, HID-incompatible protocol and there I will probably use
>> that.
>
> is this for new tablets only, or are you planning to move the support from
> hid-waltop away into this new driver?

For now, this is for higher-end tablets, which have reduced functionality in
the default mode. There are three such tablets among currently supported and
probably more among the ones I haven't seen yet.

> The ones currently supported by hid-waltop seem to be covered pretty
> nicely with only report descriptors fixups being necessary; is this still
> a limited support not covering the full device capabilities?

Yes. The higher-end tablets report in half or even less the resolution
available in proprietary mode. Then, not all the frame controls are
supported properly.

I have contacted Waltop in the beginning of the year and they agreed to help
and already sent me two samples. However, I'm trying to use their help
sparingly. Then, I can't say when I will find the time to do this driver.

Sincerely,
Nick
