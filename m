From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] input: remove at32psif
Date: Fri, 19 Jan 2018 08:25:44 +0100
Message-ID: <20180119072544.j2wcvbtls7vzufzo@samfundet.no>
References: <20180118185811.12856-1-clabbe.montjoie@gmail.com>
 <20180118192017.k3gqrbqcwp53cc7z@dtor-ws>
 <20180118194824.GA1276@Red>
 <20180118195543.wn6tl57zd2jg3on4@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:46361 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeASITc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 03:19:32 -0500
Content-Disposition: inline
In-Reply-To: <20180118195543.wn6tl57zd2jg3on4@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Around Thu 18 Jan 2018 11:55:43 -0800 or thereabout, Dmitry Torokhov wrote:
> On Thu, Jan 18, 2018 at 08:48:24PM +0100, Corentin Labbe wrote:
>> On Thu, Jan 18, 2018 at 11:20:17AM -0800, Dmitry Torokhov wrote:
>> > On Thu, Jan 18, 2018 at 07:58:11PM +0100, Corentin Labbe wrote:
>> > > Since AVR32 arch is gone, at32psif driver is useless.
>> > > This patch remove it.
>> > > 
>> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>> > 
>> > Applied, thank you.
>> > 
>> > What about:
>> > 
>> > config TOUCHSCREEN_WM97XX_ATMEL
>> > 	tristate "WM97xx Atmel accelerated touch"
>> > 	depends on TOUCHSCREEN_WM97XX && AVR32 
>> > 
>> > ?
>> > 
>> 
>> It was my second target BUT the code content reference to AT91 (wm97xx continuous touch driver for Atmel AT91 and AVR32) so perhaps it could be keeped.
>> 
>> But someone need to test it.
> 
> "&& AVR32" means that nobody ever ran it on AT91 though...
> Hans-Christian, any ideas?

I never tested accelerating WM97xx codecs on AT91, hence it is AVR32 only. It
can be removed.

Thanks for cleaning (-:

-- 
Best regards,
Hans-Christian Noren Egtvedt
