From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 1/2] HID: HID Sensor: Custom and Generic sensor
 support
Date: Fri, 10 Apr 2015 12:03:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504101200510.26287@pobox.suse.cz>
References: <1426888728-9344-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1426888728-9344-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46487 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161AbbDJKDG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 06:03:06 -0400
In-Reply-To: <1426888728-9344-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org

On Fri, 20 Mar 2015, Srinivas Pandruvada wrote:
B
> HID Sensor Spec defines two usage ids for custom sensors
> HID_USAGE_SENSOR_TYPE_OTHER_CUSTOM (0x09, 0xE1)
> HID_USAGE_SENSOR_TYPE_OTHER_GENERIC(0x09, 0xE2)
> In addition the standard also defines usage ids for custom fields.
> The purpose of these sensors is to extend the functionality or provide a
> way to obfuscate the data being communicated by a sensor. Without knowing the
> mapping between the data and its encapsulated form, it is difficult for
> an driver to determine what data is being communicated by the sensor.
> This allows some differentiating use cases, where vendor can provide applications.
> Since these can't be represented by standard sensor interfaces like IIO,
> we present these as fields with
> - type (input/output)
> - units
> - min/max
> - get/set value
> In addition an dev interface to transfer report events. Details about this
> interface is described in /Documentation/hid/hid-sensor.txt.
> Manufacturers should not use these ids for any standard sensors, otherwise
> the the product/vendor id can be added to black list.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[ ... snip ... ]
> +static int hid_sensor_custom_add_attributes(struct hid_sensor_custom
> +								*sensor_inst)
> +{
> +	struct hid_sensor_hub_device *hsdev = sensor_inst->hsdev;
> +	struct hid_device *hdev = hsdev->hdev;
> +	int ret = -1;
> +	int i, j;
> +
> +	for (j = 0; j < HID_REPORT_TYPES; ++j) {
> +		if (j == HID_OUTPUT_REPORT)
> +			continue;
> +
> +		ret = hid_sensor_custom_add_fields(sensor_inst,
> +						   &hdev->report_enum[j], j);
> +		if (ret)
> +			return ret;
> +
> +	}
> +
> +	/* Create sysfs attributes */
> +	for (i = 0; i < sensor_inst->sensor_field_count; ++i) {
> +		j = 0;
> +		while (j < HID_CUSTOM_TOTAL_ATTRS &&
> +		       hid_custom_attrs[j].name) {
> +			struct device_attribute *device_attr;
> +
> +			device_attr = &sensor_inst->fields[i].sd_attrs[j];
> +
> +			snprintf((char *)&sensor_inst->fields[i].attr_name[j],
> +				 HID_CUSTOM_NAME_LENGTH, "%s-%s",
> +				 sensor_inst->fields[i].group_name,
> +				 hid_custom_attrs[j].name);
> +			sysfs_attr_init(device_attr->dev_attr.attr);

This is wrong -- struct device_attribute doesn't have 'dev_attr' field.

The fix would be trivial, but given the fact that this means that your 
patch hasn't been even compile-tested, I'd like to ask for proper 
resubmission of code you've actually tested.

Thanks,

-- 
Jiri Kosina
SUSE Labs
