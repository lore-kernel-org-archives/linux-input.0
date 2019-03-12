From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] hid: logitech: check the return value of
 create_singlethread_workqueue
Date: Tue, 12 Mar 2019 10:02:33 -0600
Message-ID: <20190312100233.106098c8@lwn.net>
References: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
        <20190312061628.13869-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312061628.13869-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 12 Mar 2019 01:16:28 -0500
Kangjie Lu <kjlu@umn.edu> wrote:

> create_singlethread_workqueue may fail and return NULL. The fix
> checks if it is NULL to avoid NULL pointer dereference.
> Also, the fix moves the call of create_singlethread_workqueue
> earlier to avoid resource-release issues.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

So I don't know this code at all, but...

>  drivers/hid/hid-logitech-hidpp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 15ed6177a7a3..1b7c336cae6d 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2106,6 +2106,12 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> +
> +	/* init the hardware command queue */
> +	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
> +	if (!data->wq)
> +		return -ENOMEM;

It's clear just from the diff that this return will leak 'data'.  You also
break the error handling just below:

>  	data->effect_ids = kcalloc(num_slots, sizeof(int), GFP_KERNEL);
>  	if (!data->effect_ids) {
>  		kfree(data);

It's also worth asking: how are you testing these error path changes?

Thanks,

jon
