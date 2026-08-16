Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807A3A1A23;
	Sun, 16 Aug 2026 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786843938; cv=none; b=lMLtfpd0vZ/+Fn0ffuAjVnDwH4328FETeYSQZywByKKjXp1gwJnd/vHJx5WnvSn4TRBhSE+yZlv6dZWPzCSG6qVagQ2bZ1ZedQ+OFmuE7JxBmfOQZ+jpBbP/gklp8RgtugnCsVMSyo/rK9zmw/u67rE+ejvtwrbL5TKL+uFOmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786843938; c=relaxed/simple;
	bh=vvmGUtVWLQU9DRKmRc0hyjAh/DH0vFP4+bG8P3LDDOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA6scBk0n5VwqH/G6Et9bFGkbqIZido9sTpKLHOob5DSIixXAu9kZTBOA7ZbQjo1n83WNHiGT0dYTATeewB/4KX8x05Y93isGzfIWV7C5FqLmIgOKrJihMKeGxtK0G0DTRZoiS8PPhr/Nvw42/mUiGR3IZ6SORoEsgkD1rR8Z60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpZEQoTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpZEQoTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AED1F000E9;
	Sun, 16 Aug 2026 01:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786843934;
	bh=d9hosoQH9NphUkjXzv2Y1g9DrPCs9polhMUA0fTBt+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YpZEQoTqalC7K6F/M90LHoRQr9m9pNAXww7gKfgL65zKOvoCVyubrmyFEhqNyYWhY
	 82v+8+c4vVza/SwXXyk0j/ACdeUK8iNJ78F2M80nlFeWEAPtDHiCeguBwyeX700eV9
	 ZsjI5NHUXaayMCo5oD9PN7s4TMrmts+6AkQleTud7rR+oac88wIFjoRJxYIPXvUwlm
	 R5ICxnTPFuNpxrVURPA+K18mTlN5NYAKepaPlNY3GbK8/sWdood569RBiu8dOg89+g
	 chSyVBkbwOaiV2myGkM0oYCaciWbgJmzFImE23+RnLQHH0TPEY2feOtuZR+z6PBYP9
	 YEKFQStPVVr6g==
Date: Sun, 16 Aug 2026 02:32:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 03/13] HID: hid-sensor-hub: introduce device managed
 API
Message-ID: <20260816023210.3205ae5c@jic23-huawei>
In-Reply-To: <aneNIxxRVuJDFgh0@ashevche-desk.local>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
	<20260806-28-apr-iio-redundant-argument-v5-temp-v5-3-f1f92c1d830f@gmail.com>
	<aneNIxxRVuJDFgh0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Aug 2026 23:10:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Aug 06, 2026 at 05:55:49PM +0530, Sanjay Chitroda via B4 Relay wrote:
> 
> > sensor_hub_register_callback() is common API used for the HID IIO drivers,
> > prepare devm API devm_sensor_hub_register_callback() to acquire resource
> > during setup and release using device managed framework during drivers
> > fail, unbind or remove path.
> > 
> > store the required callback removal context (hsdev and usage_id) in a  
> 
> Store
> 
> > dedicated struct sensor_hub_cb_devres, and register a devres action to
> > handle to release resource with devres framework and helper API.  
> 
> ...
> 
> > +static void sensor_hub_remove_callback_helper(void *ptr)
> > +{
> > +	struct sensor_hub_cb_devres *res = ptr;
> > +
> > +	sensor_hub_remove_callback(res->hsdev, res->usage_id);
> > +}
> > +
> > +int devm_sensor_hub_register_callback(struct device *dev,
> > +				      struct hid_sensor_hub_device *hsdev,
> > +				      u32 usage_id,
> > +				      struct hid_sensor_hub_callbacks *usage_callback)
> > +{
> > +	struct sensor_hub_cb_devres *res;
> > +	int ret;
> > +
> > +	ret = sensor_hub_register_callback(hsdev, usage_id, usage_callback);
> > +	if (ret)
> > +		return ret;
> > +
> > +	res = devm_kmalloc(dev, sizeof(*res), GFP_KERNEL);
> > +	if (!res) {
> > +		sensor_hub_remove_callback(hsdev, usage_id);
> > +		return -ENOMEM;
> > +	}  
> 
> Why is this order? What's wrong with the memory allocation first?

Why do we have a devm_kmalloc() in here at all rather than devres_alloc()
/devres_add()  When there is an allocation needed that tends to
end up at a similar level of complexity but with one fewer allocation and
similar unwind.  Fun thought, maybe we can have a DEFINE_FREE() to do
the cleanup (devres_free) on error in sensor_hub_register_callback()
with devres_add(no_free_ptr(devres)) to hand over ownership.


> 
> > +	res->hsdev = hsdev;
> > +	res->usage_id = usage_id;
> > +
> > +	return devm_add_action_or_reset(dev, sensor_hub_remove_callback_helper, res);
> > +}  
> 
> ...
> 
> > +/**
> > + * devm_sensor_hub_register_callback() - Managed register client callbacks
> > + * @dev: Device for resource management
> > + * @hsdev: Hub device instance
> > + * @usage_id: Usage id of the client (e.g. 0x200076 for Gyro)
> > + * @usage_callback: Callback function storage
> > + *
> > + * This is the devres (managed) version of sensor_hub_register_callback().
> > + * The callback will be automatically unregistered when the device is detached.  
> 
> Here, and everywhere else, validate kernel-doc. Here you introduced a new warning
> (missing return section).
> 
> > + */  
> 
> Also, why kernel-doc is here?! It should accompany the implementation, here is
> a declaration.
> 
> > +int devm_sensor_hub_register_callback(struct device *dev,
> > +				      struct hid_sensor_hub_device *hsdev,
> > +				      u32 usage_id,
> > +				      struct hid_sensor_hub_callbacks *usage_callback);  
> 

