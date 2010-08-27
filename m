From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] firmware sysfs node
Date: Fri, 27 Aug 2010 14:09:05 +0200
Message-ID: <4C77AAE1.6050001@euromail.se>
References: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu> <1282798497-19791-5-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:49905 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141Ab0H0MJc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Aug 2010 08:09:32 -0400
In-Reply-To: <1282798497-19791-5-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, micki@n-trig.com

On 08/26/2010 06:54 AM, Rafi Rubin wrote:

> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
>  drivers/hid/hid-ntrig.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index ab0ca7f..e341e88 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -375,6 +375,26 @@ static ssize_t set_deactivate_slack(struct device *dev,
>  static DEVICE_ATTR(deactivate_slack, S_IWUSR | S_IRUGO, show_deactivate_slack,
>  		   set_deactivate_slack);
>  
> +static ssize_t show_firmware(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
> +	struct ntrig_data *nd = hid_get_drvdata(hdev);
> +
> +	if (!(nd->firmware_version[0] || nd->firmware_version[1] ||
> +	      nd->firmware_version[2] || nd->firmware_version[3]))
> +		return sprintf(buf, "Firmware version unavailable");


If this sysfs node should really be added (see EVIO), it is probably better if
it returns the same format for all devices. If all numbers are zero, that is
understandable also by someone reading the node.

> +
> +	ntrig_version_string(nd->firmware_version, buf);
> +
> +	return sprintf(buf, "%s (%02x%02x %02x%02x)\n", buf,
> +		       nd->firmware_version[0], nd->firmware_version[1],
> +		       nd->firmware_version[2], nd->firmware_version[3]);
> +}
> +
> +static DEVICE_ATTR(firmware, S_IRUGO, show_firmware, NULL);
> +
>  static struct attribute *sysfs_attrs[] = {
>  	&dev_attr_sensor_physical_width.attr,
>  	&dev_attr_sensor_physical_height.attr,
> @@ -386,6 +406,7 @@ static struct attribute *sysfs_attrs[] = {
>  	&dev_attr_activation_width.attr,
>  	&dev_attr_activation_height.attr,
>  	&dev_attr_deactivate_slack.attr,
> +	&dev_attr_firmware.attr,
>  	NULL
>  };
>  


Henrik
