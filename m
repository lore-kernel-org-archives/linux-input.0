From: "Shaobo" <shaobo@cs.utah.edu>
Subject: RE: Help with confirming an error trace in drivers/input/touchscreen/ad7879-spi.c
Date: Thu, 16 Feb 2017 20:25:37 -0700
Message-ID: <005801d288cd$82ac2a40$88047ec0$@cs.utah.edu>
References: <7a8799eb4ddca5b4b52991158f8ddc87@cs.utah.edu> <20170216233136.GA6708@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:53350 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754684AbdBQDZk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 22:25:40 -0500
In-Reply-To: <20170216233136.GA6708@dtor-ws>
Content-Language: zh-cn
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Thanks a lot for your reply. It makes sense to me. It seems that the only
caller of ` ad7879_spi_multi_read` is ` ad7879_multi_read ` via a function
pointer. ` ad7879_multi_read ` only has one call site with the argument
`count` being non-one. Am I right?

Moreover, I would like to point out a minor issue that you may have known. `
input_alloc_absinfo ` does not return an error status when OOM occurs. So a
lot of drivers may get a null pointer of `absinfo` field after
initialization. I'm not sure if the case where OOM results to a null
`absinfo` field and it gets dereferenced afterwards can happen.

Best,
Shaobo
-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: 2017Äê2ÔÂ16ÈÕ 16:32
To: Shaobo <shaobo@cs.utah.edu>
Cc: linux-input@vger.kernel.org
Subject: Re: Help with confirming an error trace in
drivers/input/touchscreen/ad7879-spi.c

Hi Shaobo,

On Thu, Feb 16, 2017 at 04:27:00PM -0700, Shaobo wrote:
> Hi there,
> 
> My name is Shaobo He and I am a graduate student at University of 
> Utah. I am applying a static analysis tool to the Linux device drivers 
> and got an error trace of null pointer dereference in 
> drivers/input/touchscreen/ad7879-spi.c staring from
> `ad7879_spi_multi_read`: it calls `ad7879_spi_xfer` with the argument 
> `tx_buf` being NULL, which gets dereferenced at line 52 given the 
> argument `count` being 1. As you can see, the error trace is only 
> plausible since it depends on certain conditions. To be more specific, 
> is it possible for the count argument to be 1. Therefore, I was 
> wondering if you could help me confirm it since you are one of the 
> authors of this driver.
> 
> Thanks for your time. I am looking forward to your reply.

We never call ad7879_spi_multi_read() with count == 1, so this scenario is
not going to happen. Given that this is driiver-private code and not a
public API I think it is OK-ish.

Thanks.

--
Dmitry

