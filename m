From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 3/3] Input: goodix - use generic touchscreen_properties
Date: Sat, 27 Jan 2018 02:19:00 +0100
Message-ID: <394F8C1E-A963-4AB2-A653-B23A7D07E1AE@hadess.net>
References: <20180125190829.8968-1-m.niestroj@grinn-global.com> <20180125190829.8968-4-m.niestroj@grinn-global.com> <20180126191945.q3sx2pcs7rvpil33@dtor-ws> <1517010494.2592.27.camel@hadess.net> <CAKdAkRTcsTOqj_jT7uu09k5i82wDEB0Fm-sb4TrNviwKbeb9iw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53455 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeA0BTC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jan 2018 20:19:02 -0500
In-Reply-To: <CAKdAkRTcsTOqj_jT7uu09k5i82wDEB0Fm-sb4TrNviwKbeb9iw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>, Antonio Ospite <ao2@ao2.it>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>



> On 27 Jan 2018, at 00:57, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
>> On Fri, Jan 26, 2018 at 3:48 PM, Bastien Nocera <hadess@hadess.net> wrote:
>>> On Fri, 2018-01-26 at 11:19 -0800, Dmitry Torokhov wrote:
>>> Can you please try the version below (note that I sqashed all your 3
>>> patches in one as, as I mentioed, I do not see why they need to be
>>> split
>>> in the first place).
>> 
>> It was easier to read, and backport. Patch 1 and 2 at least are easily
>> backportable, and "easy" fixes on top of the existing code. Breakages
>> would be easier to spot with the 3 separate fixes, and that's how I'd
>> prefer it if it's not too much bother.
> 
> There is nothing to read if you drop the patch 2, as it is something
> that was done and immediately deleted.

It’s easier to backport and understand. Fine if you don’t want it. I’d rather it was still there.

> 
> Thanks.
> 
> -- 
> Dmitry

