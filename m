Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE5368951;
	Thu, 26 Feb 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125514; cv=none; b=D6Q5EjbC3+o0WLZeyPY3uejG+4qfCpOJjt0jXWkg/vw2YCm/4A862gTA/HJR+dXLgj+EOa13Y3jCIafSPsXG3PDrSQh3Qd+YrG5tzOXtZp2lp6fzGXO8y/QeQTZZxP2lvcZO9wBVzuqJpi3z3Qk3MKEoc5VQeVu0H+OmIspOc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125514; c=relaxed/simple;
	bh=UWPlr3Z5zWw7+Km3JJCkWA7s1gIgF4/6DYP1bgIKhlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GQKMwIuWChyXQlZQ/WPCTSeTbgHbSbqBXaY/HVLk5bjtmbx+h/OqPTFvEPOPnxDKT0XAD9fDgyX32A7rczUt9ymdfL+EbEO1xHRDN9w3xhVLh+soA+OYZLDs5SEJobk6ZSJALlggb40CynZobMJzEJC35ms/TwYL68ADq8QAJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqviDWj8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqviDWj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3777EC19424;
	Thu, 26 Feb 2026 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772125513;
	bh=UWPlr3Z5zWw7+Km3JJCkWA7s1gIgF4/6DYP1bgIKhlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pqviDWj8SPpVypDaNlTFoEcMpJ/kYxnMqXwgKegygilsUwmQgZjx/Ofai7usx9gPp
	 ZeATi507pLBnBXuD3DlERP4dGf6NZNlPwTij2AGs4O5Q0xoHcMljvBopYvSrO9/UhY
	 P/b9rPfc9DaQja5fVDMf3abfGybSdGTeTEmzIc2TRfKyVRM+NGrgXjZMtjopXksOCq
	 3kY7Gy0Cccg5wtbRyW9WNmVRzlFBhx0ygmBSzuWttm+yTf0Ly1kZrYOU2gHseUsiSh
	 50eVUakSKmCL80pBEcyjJqGYrlsTuQPuu3D7S8qvsCihzRdPXnh0AU7HL0ZwRyKsir
	 X0LnqGh5oQtkg==
Date: Thu, 26 Feb 2026 18:05:10 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Richard Hughes <hughsient@gmail.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 01/16] include: device.h: Add named device
 attributes
In-Reply-To: <20260224013217.1363996-2-derekjohn.clark@gmail.com>
Message-ID: <478589q4-1rp6-87q8-02o8-n50071039639@xreary.bet>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com> <20260224013217.1363996-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

You would need and Ack from driver core maintainers (CCing Greg and Rafael 
here) on this one so that I can take it together with the rest of the 
series.

Thanks,

-- 
Jiri Kosina
SUSE Labs

On Tue, 24 Feb 2026, Derek J. Clark wrote:

> Adds DEVICE_ATTR_[RW|RO|WO]_NAMED macros for adding attributes that
> reuse the same sysfs name in a driver under separate subdirectories.
> 
> When dealing with some devices it can be useful to be able to reuse
> the same name for similar attributes under a different subdirectory.
> For example, a single logical HID endpoint may provide a configuration
> interface for multiple physical devices. In such a case it is useful to
> provide symmetrical attribute names under different subdirectories on
> the configuration device. The Lenovo Legion Go is one such device,
> providing configuration to a detachable left controller, detachable
> right controller, the wireless transmission dongle, and the MCU. It is
> therefore beneficial to treat each of these as individual devices in
> the driver, providing a subdirectory for each physical device in the
> sysfs. As some attributes are reused by each physical device, it
> provides a much cleaner interface if the same driver can reuse the same
> attribute name in sysfs while uniquely distinguishing the store/show
> functions in the driver, rather than repeat string portions.
> 
> Example new WO attrs:
> ATTRS{left_handle/reset}=="(not readable)"
> ATTRS{right_handle/reset}=="(not readable)"
> ATTRS{tx_dongle/reset}=="(not readable)"
> 
> vs old WO attrs in a subdir:
> ATTRS{left_handle/left_handle_reset}=="(not readable)"
> ATTRS{right_handle/right_handle_reset}=="(not readable)"
> ATTRS{tx_dongle/tx_dongle_reset}=="(not readable)"
> 
> or old WO attrs with no subdir:
> ATTRS{left_handle_reset}=="(not readable)"
> ATTRS{right_handle_reset}=="(not readable)"
> ATTRS{tx_dongle_reset}=="(not readable)"
> 
> While the third option is usable, it doesn't logically break up the
> physical devices and creates a device directory with over 80 attributes
> once all attrs are defined.
> 
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v4:
>   - Use dmabuf per request instead of devm allocated static buffer.
>     Resolves bug with side effects during suspend.
> ---
>  include/linux/device.h | 46 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0be95294b6e61..381463baed6d3 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -189,6 +189,22 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
>  #define DEVICE_ATTR_ADMIN_RW(_name) \
>  	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
>  
> +/**
> + * DEVICE_ATTR_RW_NAMED - Define a read-write device attribute with a sysfs name
> + * that differs from the function name.
> + * @_name: Attribute function preface
> + * @_attrname: Attribute name as it wil be exposed in the sysfs.
> + *
> + * Like DEVICE_ATTR_RW(), but allows for reusing names under separate paths in
> + * the same driver.
> + */
> +#define DEVICE_ATTR_RW_NAMED(_name, _attrname)                            \
> +	struct device_attribute dev_attr_##_name = {                      \
> +		.attr = { .name = _attrname, .mode = 0644 }, \
> +		.show = _name##_show,                                     \
> +		.store = _name##_store,                                   \
> +	}
> +
>  /**
>   * DEVICE_ATTR_RO - Define a readable device attribute.
>   * @_name: Attribute name.
> @@ -207,6 +223,21 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
>  #define DEVICE_ATTR_ADMIN_RO(_name) \
>  	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
>  
> +/**
> + * DEVICE_ATTR_RO_NAMED - Define a read-only device attribute with a sysfs name
> + * that differs from the function name.
> + * @_name: Attribute function preface
> + * @_attrname: Attribute name as it wil be exposed in the sysfs.
> + *
> + * Like DEVICE_ATTR_RO(), but allows for reusing names under separate paths in
> + * the same driver.
> + */
> +#define DEVICE_ATTR_RO_NAMED(_name, _attrname)                            \
> +	struct device_attribute dev_attr_##_name = {                      \
> +		.attr = { .name = _attrname, .mode = 0444 }, \
> +		.show = _name##_show,                                     \
> +	}
> +
>  /**
>   * DEVICE_ATTR_WO - Define an admin-only writable device attribute.
>   * @_name: Attribute name.
> @@ -216,6 +247,21 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
>  #define DEVICE_ATTR_WO(_name) \
>  	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
>  
> +/**
> + * DEVICE_ATTR_WO_NAMED - Define a read-only device attribute with a sysfs name
> + * that differs from the function name.
> + * @_name: Attribute function preface
> + * @_attrname: Attribute name as it wil be exposed in the sysfs.
> + *
> + * Like DEVICE_ATTR_WO(), but allows for reusing names under separate paths in
> + * the same driver.
> + */
> +#define DEVICE_ATTR_WO_NAMED(_name, _attrname)                            \
> +	struct device_attribute dev_attr_##_name = {                      \
> +		.attr = { .name = _attrname, .mode = 0200 }, \
> +		.store = _name##_store,                                   \
> +	}
> +
>  /**
>   * DEVICE_ULONG_ATTR - Define a device attribute backed by an unsigned long.
>   * @_name: Attribute name.
> -- 
> 2.52.0
> 
