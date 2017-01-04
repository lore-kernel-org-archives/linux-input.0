From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Wed, 4 Jan 2017 14:09:03 +0100
Message-ID: <20170104130903.GA8832@kroah.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
 <1482456149-4841-7-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482456149-4841-7-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, andriy.shevchenko@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 23, 2016 at 09:22:29AM +0800, Even Xu wrote:
> +/**
> + * ishtp_cl_probe() - ISHTP client driver probe
> + * @cl_device:		ISHTP client device instance
> + *
> + * This function gets called on device create on ISHTP bus
> + *
> + * Return: 0 on success, non zero on error
> + */
> +static int ishtp_cl_probe(struct ishtp_cl_device *cl_device)
> +{
> +	struct ishtp_cl_miscdev *ishtp_cl_misc;
> +	int ret;
> +
> +	if (!cl_device)
> +		return -ENODEV;
> +
> +	ishtp_cl_misc = kzalloc(sizeof(struct ishtp_cl_miscdev),
> +				GFP_KERNEL);
> +	if (!ishtp_cl_misc)
> +		return -ENOMEM;
> +
> +	if (uuid_le_cmp(ishtp_smhi_guid,
> +			cl_device->fw_client->props.protocol_name) == 0) {
> +		ishtp_cl_misc->cl_miscdev.name = "ish-smhi";
> +	} else if (uuid_le_cmp(ishtp_trace_guid,
> +			cl_device->fw_client->props.protocol_name) == 0) {
> +		ishtp_cl_misc->cl_miscdev.name = "ish-trace";
> +	} else if (uuid_le_cmp(ishtp_traceconfig_guid,
> +			cl_device->fw_client->props.protocol_name) == 0) {
> +		ishtp_cl_misc->cl_miscdev.name = "ish-tracec";
> +	} else if (uuid_le_cmp(ishtp_loader_guid,
> +			cl_device->fw_client->props.protocol_name) == 0) {
> +		ishtp_cl_misc->cl_miscdev.name = "ish-loader";
> +	} else {
> +		dev_err(&cl_device->dev, "Not supported client\n");
> +		ret = -ENODEV;
> +		goto release_mem;
> +	}
> +
> +	ishtp_cl_misc->cl_miscdev.parent = &cl_device->dev;
> +	ishtp_cl_misc->cl_miscdev.fops = &ishtp_cl_fops;
> +	ishtp_cl_misc->cl_miscdev.minor = MISC_DYNAMIC_MINOR,
> +
> +	ret = misc_register(&ishtp_cl_misc->cl_miscdev);
> +	if (ret) {
> +		dev_err(&cl_device->dev, "misc device register failed\n");
> +		goto release_mem;
> +	}

Now your userspace device node is created and can be opened up and
accessed.  But:

> +
> +	ishtp_cl_misc->cl_device = cl_device;
> +
> +	init_waitqueue_head(&ishtp_cl_misc->read_wait);
> +
> +	ishtp_set_drvdata(cl_device, ishtp_cl_misc);
> +
> +	ishtp_get_device(cl_device);
> +
> +	mutex_init(&ishtp_cl_misc->cl_mutex);
> +
> +	INIT_WORK(&ishtp_cl_misc->reset_work, ishtp_cl_reset_handler);
> +
> +	/* Register event callback */
> +	ishtp_register_event_cb(cl_device, ishtp_cl_event_cb);

You were not done setting up the device.  What nasty races just
happened?

And the above functions can never fail?  Why are you grabbing a refernce
to the cl_device yet doing nothing with it?  That feels really broken
and wrong.

thanks,

greg k-h
