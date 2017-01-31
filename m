From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - add sysfs attribute
 update_fw_status
Date: Tue, 31 Jan 2017 15:43:01 -0800
Message-ID: <20170131234301.GA37992@dtor-ws>
References: <1485630362-27423-1-git-send-email-nick@shmanahar.org>
 <1485630362-27423-2-git-send-email-nick@shmanahar.org>
 <20170131090257.GG8311@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33890 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdAaXnF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 18:43:05 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so30291477pfb.1
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2017 15:43:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170131090257.GG8311@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Chris Healy <cphealy@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Tue, Jan 31, 2017 at 01:02:57AM -0800, Dmitry Torokhov wrote:
> On Sat, Jan 28, 2017 at 07:06:01PM +0000, Nick Dyer wrote:
> > The attribute returns the percentage complete. If the firmware update fails, it
> > reports a negative error code.
> > 
> > Signed-off-by: Nick Dyer <nick@shmanahar.org>
> > Tested-by: Chris Healy <cphealy@gmail.com>
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Applied, thank you.
> 
> > ---
> >  drivers/input/rmi4/rmi_f34.c   | 40 +++++++++++++++++++++++++++++++++++++++-
> >  drivers/input/rmi4/rmi_f34.h   |  4 ++++
> >  drivers/input/rmi4/rmi_f34v7.c | 11 +++++++++++
> >  3 files changed, 54 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> > index c3285ce..048e593 100644
> > --- a/drivers/input/rmi4/rmi_f34.c
> > +++ b/drivers/input/rmi4/rmi_f34.c
> > @@ -157,6 +157,9 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
> >  			i + 1, block_count);
> >  
> >  		data += f34->v5.block_size;
> > +		f34->update_progress += f34->v5.block_size;
> > +		f34->update_status = (f34->update_progress * 100) /
> > +			f34->update_size;
> >  	}
> >  
> >  	return 0;
> > @@ -186,6 +189,8 @@ static int rmi_f34_flash_firmware(struct f34_data *f34,
> >  	struct rmi_function *fn = f34->fn;
> >  	int ret;
> >  
> > +	f34->update_progress = 0;
> > +	f34->update_size = syn_fw->image_size + syn_fw->config_size;

By the way, this breaks on big endian boxes. I fixed it up locally.

Please try incorporating 'sparse' into your workflow.

Thanks.

-- 
Dmitry
