From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 13/16] hid: intel-ish-hid: use dev_groups and not
 dev_attrs for bus_type
Date: Tue, 06 Jun 2017 15:33:02 -0700
Message-ID: <1496788382.195383.1.camel@linux.intel.com>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
         <20170606192221.1617-14-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbdFFWdE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Jun 2017 18:33:04 -0400
In-Reply-To: <20170606192221.1617-14-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wei Yongjun <weiyj.lk@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org

On Tue, 2017-06-06 at 21:22 +0200, Greg Kroah-Hartman wrote:
> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wei Yongjun <weiyj.lk@gmail.com>
> Cc: Bhumika Goyal <bhumirks@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: <linux-input@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 5f382fedc2ab..f272cdd9bd55 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -321,11 +321,13 @@ static ssize_t modalias_show(struct device
> *dev, struct device_attribute *a,
>  	len = snprintf(buf, PAGE_SIZE, "ishtp:%s\n", dev_name(dev));
>  	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
>  }
> +static DEVICE_ATTR_RO(modalias);
>  
> -static struct device_attribute ishtp_cl_dev_attrs[] = {
> -	__ATTR_RO(modalias),
> -	__ATTR_NULL,
> +static struct attribute *ishtp_cl_dev_attrs[] = {
> +	&dev_attr_modalias.attr,
> +	NULL,
>  };
> +ATTRIBUTE_GROUPS(ishtp_cl_dev);
>  
>  static int ishtp_cl_uevent(struct device *dev, struct
> kobj_uevent_env *env)
>  {
> @@ -346,7 +348,7 @@ static const struct dev_pm_ops
> ishtp_cl_bus_dev_pm_ops = {
>  
>  static struct bus_type ishtp_cl_bus_type = {
>  	.name		= "ishtp",
> -	.dev_attrs	= ishtp_cl_dev_attrs,
> +	.dev_groups	= ishtp_cl_dev_groups,
>  	.probe		= ishtp_cl_device_probe,
>  	.remove		= ishtp_cl_device_remove,
>  	.pm		= &ishtp_cl_bus_dev_pm_ops,
