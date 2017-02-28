From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: Help with confirming an error trace in
 drivers/input/touchscreen/ad7879-spi.c
Date: Tue, 28 Feb 2017 10:55:06 -0800
Message-ID: <20170228185506.GI20776@dtor-ws>
References: <7a8799eb4ddca5b4b52991158f8ddc87@cs.utah.edu>
 <20170216233136.GA6708@dtor-ws>
 <005801d288cd$82ac2a40$88047ec0$@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33430 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdB1UAK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 15:00:10 -0500
Received: by mail-pg0-f51.google.com with SMTP id 25so9649557pgy.0
        for <linux-input@vger.kernel.org>; Tue, 28 Feb 2017 11:59:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <005801d288cd$82ac2a40$88047ec0$@cs.utah.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shaobo <shaobo@cs.utah.edu>
Cc: linux-input@vger.kernel.org

Hi Shaobo,

On Thu, Feb 16, 2017 at 08:25:37PM -0700, Shaobo wrote:
> Hi Dmitry,
> 
> Thanks a lot for your reply. It makes sense to me. It seems that the only
> caller of ` ad7879_spi_multi_read` is ` ad7879_multi_read ` via a function
> pointer. ` ad7879_multi_read ` only has one call site with the argument
> `count` being non-one. Am I right?

Right. By the way, I looked at the driver again, and we converted it to
regmap infrastructure, so ad7879_spi_multi_read() is gone now.

> 
> Moreover, I would like to point out a minor issue that you may have known. `
> input_alloc_absinfo ` does not return an error status when OOM occurs. So a
> lot of drivers may get a null pointer of `absinfo` field after
> initialization. I'm not sure if the case where OOM results to a null
> `absinfo` field and it gets dereferenced afterwards can happen.

You are indeed correct that we do not report OOM conditions on
input_alloc_absinfo(), handling errors from each input_set_abs_params()
call was deemed too onerous. But we do refuse registering input device
that claims to use ABS events, but does not have absinfo allocated, so I
think we are OK here.

> 
> Best,
> Shaobo
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: 2017年2月16日 16:32
> To: Shaobo <shaobo@cs.utah.edu>
> Cc: linux-input@vger.kernel.org
> Subject: Re: Help with confirming an error trace in
> drivers/input/touchscreen/ad7879-spi.c
> 
> Hi Shaobo,
> 
> On Thu, Feb 16, 2017 at 04:27:00PM -0700, Shaobo wrote:
> > Hi there,
> > 
> > My name is Shaobo He and I am a graduate student at University of 
> > Utah. I am applying a static analysis tool to the Linux device drivers 
> > and got an error trace of null pointer dereference in 
> > drivers/input/touchscreen/ad7879-spi.c staring from
> > `ad7879_spi_multi_read`: it calls `ad7879_spi_xfer` with the argument 
> > `tx_buf` being NULL, which gets dereferenced at line 52 given the 
> > argument `count` being 1. As you can see, the error trace is only 
> > plausible since it depends on certain conditions. To be more specific, 
> > is it possible for the count argument to be 1. Therefore, I was 
> > wondering if you could help me confirm it since you are one of the 
> > authors of this driver.
> > 
> > Thanks for your time. I am looking forward to your reply.
> 
> We never call ad7879_spi_multi_read() with count == 1, so this scenario is
> not going to happen. Given that this is driiver-private code and not a
> public API I think it is OK-ish.
> 
> Thanks.
> 
> --
> Dmitry
> 

-- 
Dmitry
