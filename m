From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] Input: synaptics-rmi4 - fix error return code in
 rmi_probe_interrupts()
Date: Tue, 7 Feb 2017 10:00:59 -0800
Message-ID: <20170207180059.GA38092@dtor-ws>
References: <20170207145225.31228-1-weiyj.lk@gmail.com>
 <20170207150037.GB18493@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34941 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753840AbdBGSBC (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2017 13:01:02 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so9760739pfa.2
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2017 10:01:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170207150037.GB18493@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Duggan <aduggan@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Tue, Feb 07, 2017 at 04:00:37PM +0100, Benjamin Tissoires wrote:
> On Feb 07 2017 or thereabouts, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > Fix to return error code -ENOMEM from the devm_kzalloc() error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> > Fixes: 6bd0dcfacf28 ("Input: synaptics-rmi4 - factor out functions
> > from probe")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> 
> Good catch.
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> >  drivers/input/rmi4/rmi_driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index bf5c36e..0c54446 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -1049,7 +1049,7 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
> >  	data->irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
> >  	if (!data->irq_memory) {
> >  		dev_err(dev, "Failed to allocate memory for irq masks.\n");
> > -		return retval;
> > +		return -ENOMEM;
> >  	}
> >  
> >  	data->irq_status	= data->irq_memory + size * 0;
> > 

-- 
Dmitry
