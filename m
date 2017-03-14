From: Nick Dyer <nick@shmanahar.org>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Tue, 14 Mar 2017 19:53:38 +0000
Message-ID: <20170314195338.GA12169@bm.shmanahar.org>
References: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
 <7964888d-05dd-b109-973a-e0503884e2e2@leemhuis.info>
 <20170313131356.GH4378@mail.corp.redhat.com>
 <20170313131537.GI4378@mail.corp.redhat.com>
 <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
 <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bm.shmanahar.org ([80.68.91.236]:39691 "EHLO bm.shmanahar.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdCNUIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 16:08:10 -0400
Content-Disposition: inline
In-Reply-To: <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thorsten Leemhuis <linux@leemhuis.info>, Jiri Kosina <jikos@kernel.org>, cheiny@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 13, 2017 at 10:10:22PM -0700, Cameron Gutman wrote:
> >>>>> Compared to hid-multitouch, the RMI stack seems to have
> >>>>> completely broken palm rejection and introduced some random
> >>>>> jumpiness during fine pointing motions. I don't know if these
> >>>>> issues are caused by the above errors or are a separate issue.
> > 
> > The error about the bootloader version not being recognized just
> > means that updating the firmware is not supported on this touchpad.
> > It is only the F34 firmware update functionality which is failing to
> > load. The palm rejection and jumps are not related to this error.
> > 
> 
> Maybe that code path should be changed to not make as much noise when
> it runs on known unsupported hardware. Something like the attached
> patch?

> ---
> diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
> index 56c6c39..1291d9a 100644
> --- a/drivers/input/rmi4/rmi_f34v7.c
> +++ b/drivers/input/rmi4/rmi_f34v7.c
> @@ -1369,9 +1369,9 @@ int rmi_f34v7_probe(struct f34_data *f34)
>  	} else if (f34->bootloader_id[1] == 7) {
>  		f34->bl_version = 7;
>  	} else {
> -		dev_err(&f34->fn->dev, "%s: Unrecognized bootloader version\n",
> -				__func__);
> -		return -EINVAL;
> +		dev_info(&f34->fn->dev, "%s: Unsupported bootloader version: %u\n",
> +				__func__, f34->bootloader_id[1]);
> +		return -ENODEV;
>  	}
>  
>  	memset(&f34->v7.blkcount, 0x00, sizeof(f34->v7.blkcount));

I'm afraid I'm responsible for this. I agree it's very unlikely to be
related to your other issues.

One approach to suppress the extra output would be to turn off
CONFIG_RMI_F34. I think your proposed change in wording would be fine,
though.

cheers

Nick
