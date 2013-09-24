From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-elo: some systems cannot stomach work around
Date: Tue, 24 Sep 2013 12:08:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309241207190.18703@pobox.suse.cz>
References: <1378721819-26479-1-git-send-email-oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43592 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab3IXKIM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Sep 2013 06:08:12 -0400
In-Reply-To: <1378721819-26479-1-git-send-email-oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: oliver@neukum.org
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jslaby@suse.cz, Oliver Neukum <oneukum@suse.de>

On Mon, 9 Sep 2013, oliver@neukum.org wrote:

> From: Oliver Neukum <oneukum@suse.de>
> 
> Some systems although they have firmware class 'M', which usually
> needs a work around to not crash, must not be subjected to the
> work around because the work around crashes them. They cannot be
> told apart by their own device descriptor, but as they are part
> of compound devices can be identified by looking at their siblings.

What a mess ... :/

> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/hid/hid-elo.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
> index f042a6c..64ac53e 100644
> --- a/drivers/hid/hid-elo.c
> +++ b/drivers/hid/hid-elo.c
> @@ -181,7 +181,40 @@ fail:
>   */
>  static bool elo_broken_firmware(struct usb_device *dev)
>  {
> -	return use_fw_quirk && le16_to_cpu(dev->descriptor.bcdDevice) == 0x10d;
> +	struct usb_device *hub = dev->parent;
> +	struct usb_device *child = NULL;
> +	u16 fw_lvl = le16_to_cpu(dev->descriptor.bcdDevice);
> +	u16 child_vid, child_pid;
> +	int i;
> +    
> +	if (!use_fw_quirk)
> +		return false;
> +	if (fw_lvl != 0x10d)
> +		return false;
> +
> +	/*iterate sibling devices of the touch controller*/

Could you please resubmit with comment reformated (spaces before/after 
asterisk)?

> +	usb_hub_for_each_child(hub, i, child) {
> +		child_vid = le16_to_cpu(child->descriptor.idVendor);
> +		child_pid = le16_to_cpu(child->descriptor.idProduct);
> +
> +		/*
> +		 * If one of the devices below is present attached as a sibling of 
> +		 * the touch controller then  this is a newer IBM 4820 monitor that 
> +		 * does not need the IBM-requested workaround if fw level is
> +		 * 0x010d - aka 'M'.
> +		 * No other HW can have this combination.
> +		*/
> +		if (child_vid==0x04b3) {
> +			switch (child_pid) {
> +			case 0x4676: /*4820 21x Video*/
> +			case 0x4677: /*4820 51x Video*/
> +			case 0x4678: /*4820 2Lx Video*/
> +			case 0x4679: /*4820 5Lx Video*/

Here as well.

Thanks,

-- 
Jiri Kosina
SUSE Labs
