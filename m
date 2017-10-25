From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: hidraw: Improve a size determination in two
 functions
Date: Wed, 25 Oct 2017 09:37:17 +0200
Message-ID: <20171025073717.GG13605@mail.corp.redhat.com>
References: <0bb90455-4c2b-bf44-1e9e-9542bb223163@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0bb90455-4c2b-bf44-1e9e-9542bb223163@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Oct 24 2017 or thereabouts, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 24 Oct 2017 20:52:19 +0200
> 
> * Replace the specification of data structures by pointer dereferences
>   as the parameter for the operator "sizeof" to make the corresponding size
>   determination a bit safer according to the Linux coding style convention.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Return directly after a call of the function "kzalloc" failed
>   at the beginning of the function "hidraw_open".
> 
> * Delete the jump target "out" which became unnecessary
>   with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/hid/hidraw.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 5fbe0f81ab2e..26fbf9e82f84 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -269,10 +269,9 @@ static int hidraw_open(struct inode *inode, struct file *file)
>  	unsigned long flags;
>  	int err = 0;
>  
> -	if (!(list = kzalloc(sizeof(struct hidraw_list), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	list = kzalloc(sizeof(*list), GFP_KERNEL);

I am not sure the change from "if (!a = kzalloc())" to "a = kzalloc();
if (!a)" adds anything besides clearer code. I prefer the later, so:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> +	if (!list)
> +		return -ENOMEM;
>  
>  	mutex_lock(&minors_lock);
>  	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
> @@ -304,7 +303,6 @@ static int hidraw_open(struct inode *inode, struct file *file)
>  	file->private_data = list;
>  out_unlock:
>  	mutex_unlock(&minors_lock);
> -out:
>  	if (err < 0)
>  		kfree(list);
>  	return err;
> @@ -513,7 +511,7 @@ int hidraw_connect(struct hid_device *hid)
>  
>  	/* we accept any HID device, all applications */
>  
> -	dev = kzalloc(sizeof(struct hidraw), GFP_KERNEL);
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
>  
> -- 
> 2.14.3
> 
