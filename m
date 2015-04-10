From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 1/2] HID: HID Sensor: Custom and Generic sensor
 support
Date: Fri, 10 Apr 2015 17:59:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504101758250.26287@pobox.suse.cz>
References: <1426888728-9344-1-git-send-email-srinivas.pandruvada@linux.intel.com>  <1426888728-9344-2-git-send-email-srinivas.pandruvada@linux.intel.com>  <alpine.LNX.2.00.1504101200510.26287@pobox.suse.cz>
 <1428680164.13005.11.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbbDJP7c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 11:59:32 -0400
In-Reply-To: <1428680164.13005.11.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org

On Fri, 10 Apr 2015, Srinivas Pandruvada wrote:

> > > +	/* Create sysfs attributes */
> > > +	for (i = 0; i < sensor_inst->sensor_field_count; ++i) {
> > > +		j = 0;
> > > +		while (j < HID_CUSTOM_TOTAL_ATTRS &&
> > > +		       hid_custom_attrs[j].name) {
> > > +			struct device_attribute *device_attr;
> > > +
> > > +			device_attr = &sensor_inst->fields[i].sd_attrs[j];
> > > +
> > > +			snprintf((char *)&sensor_inst->fields[i].attr_name[j],
> > > +				 HID_CUSTOM_NAME_LENGTH, "%s-%s",
> > > +				 sensor_inst->fields[i].group_name,
> > > +				 hid_custom_attrs[j].name);
> > > +			sysfs_attr_init(device_attr->dev_attr.attr);
> > 
> > This is wrong -- struct device_attribute doesn't have 'dev_attr' field.
> > 
> > The fix would be trivial, but given the fact that this means that your 
> > patch hasn't been even compile-tested, I'd like to ask for proper 
> > resubmission of code you've actually tested.
>
> You found a bug. But it doesn't mean that this is not tested (I submit 
> 100+ patches each cycle related to power and thermal, so this is just a 
> honest mistake). This is even tested by ST Micro developer. The issue is 
> sysfs_attr_init() is ignored unless CONFIG_DEBUG_LOCK_ALLOC is defined. 
> I use Fedora, Ubuntu and Android builds, none of which defined this 
> symbol. So it slipped away.

Ah, indeed, I've missed the fact that !CONFIG_DEBUG_LOCK_ALLOC will hide 
this issue.

> So this is a bug, I will resubmit this.

Thanks,

-- 
Jiri Kosina
SUSE Labs
