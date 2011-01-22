From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] hid: Add HID Report Descriptor to sysfs.
Date: Sat, 22 Jan 2011 05:55:16 -0800
Message-ID: <20110122135516.GA4893@kroah.com>
References: <1295590785-7101-1-git-send-email-alan@signal11.us>
 <1295590785-7101-2-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:36172 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab1AVOLP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jan 2011 09:11:15 -0500
Content-Disposition: inline
In-Reply-To: <1295590785-7101-2-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 21, 2011 at 01:19:45AM -0500, Alan Ott wrote:
> Add a new sysfs entry called report_descriptor which contains the HID report
> descriptor.
> 
> Signed-off-by: Alan Ott <alan@signal11.us>
> ---
>  drivers/hid/hid-core.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index d678cf3..0ff1ba2 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1159,6 +1159,28 @@ static bool hid_hiddev(struct hid_device *hdev)
>  	return !!hid_match_id(hdev, hid_hiddev_list);
>  }
>  
> +
> +static ssize_t show_report_descriptor(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	int i, cur = 0;
> +	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
> +
> +	for (i = 0; i < hdev->rsize; i++) {
> +		if (cur + 4 >= PAGE_SIZE)
> +			break;
> +		sprintf(buf + cur, "%02hhx ", hdev->rdesc[i]);
> +		cur += 3;
> +	}
> +	/* Replace the last space with a newline. */
> +	buf[cur-1] = '\n';
> +	buf[PAGE_SIZE-1] = '\0';
> +	return cur + 1;
> +}

If you are going to do this this way through sysfs, please make this a
binary file, not a text one.

thanks,

greg k-h
