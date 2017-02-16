From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Help with confirming an error trace in
 drivers/input/touchscreen/ad7879-spi.c
Date: Thu, 16 Feb 2017 15:31:36 -0800
Message-ID: <20170216233136.GA6708@dtor-ws>
References: <7a8799eb4ddca5b4b52991158f8ddc87@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32850 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933695AbdBPXbk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 18:31:40 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so2600466pfg.0
        for <linux-input@vger.kernel.org>; Thu, 16 Feb 2017 15:31:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7a8799eb4ddca5b4b52991158f8ddc87@cs.utah.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shaobo <shaobo@cs.utah.edu>
Cc: linux-input@vger.kernel.org

Hi Shaobo,

On Thu, Feb 16, 2017 at 04:27:00PM -0700, Shaobo wrote:
> Hi there,
> 
> My name is Shaobo He and I am a graduate student at University of
> Utah. I am applying a static analysis tool to the Linux device
> drivers and got an error trace of null pointer dereference in
> drivers/input/touchscreen/ad7879-spi.c staring from
> `ad7879_spi_multi_read`: it calls `ad7879_spi_xfer` with the
> argument `tx_buf` being NULL, which gets dereferenced at line 52
> given the argument `count` being 1. As you can see, the error trace
> is only plausible since it depends on certain conditions. To be more
> specific, is it possible for the count argument to be 1. Therefore,
> I was wondering if you could help me confirm it since you are one of
> the authors of this driver.
> 
> Thanks for your time. I am looking forward to your reply.

We never call ad7879_spi_multi_read() with count == 1, so this scenario
is not going to happen. Given that this is driiver-private code and not
a public API I think it is OK-ish.

Thanks.

-- 
Dmitry
