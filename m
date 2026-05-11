Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6C449EB1;
	Mon, 11 May 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517216; cv=none; b=hbocwnZe09Aaijx0mFDJGyeB1pfpY/X8OE+eRD/D9wf2ttaPHjNhvy/acB56z+mKssHzZiMDSFDEaldDhfvnQQU5PgcxhTtk4i60qf9+J2Lctrqy4hTQkTh0s0iV2G0d3+FrmKj19aWjzCzzqknXIuCA0wpD0OztzjwAPNIWj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517216; c=relaxed/simple;
	bh=SOwEkbBowDZlhVzF1T/3EQ1uclyN57I12KvaaCTOE44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGwlovGJJaXduVSXV4mmRpS0B3n72HixlIBzIpUN1wQbeFvKm10XOLzkeEHPt5RhhxupcQDwFyyzp/ULBl+zN0st2MPZbiYvt1OiAicrP43Jdc6N51NAr/7Gct+0056vUx8Toc0sMPTuzFnXsh2vFHp7oiSptzRHbsBlDvBF2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdmCV3tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdmCV3tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF0C2BCB0;
	Mon, 11 May 2026 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517216;
	bh=SOwEkbBowDZlhVzF1T/3EQ1uclyN57I12KvaaCTOE44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdmCV3tlO+JaMuEJ8L74dOvkTUhErNxeb1AxaBeSBvRBD746LPxXqgapZM4i1YsLM
	 3PIqxDdJ63x8CK/FR08SZqFnr3xslRF5pjtC2kqxjn2I15pIMT5sV6lkJG3vPpaH0q
	 wZ1g655gvCJIPO9ZVR2BILeTQOH27uYgOHo5dBur6Y11Y56ersEBqhoG7Wf7RnWssj
	 HSNBtV8M3lBbTcJPAw+c63ygpPbmT/m7Zf8ldqQ0AV0HeezG2BzbQJbt31Zg6UxrG6
	 E5H2zYLUgapmzQCx7hpF/R2epZqAKyDauT+/XPtMUWMvBYTmy3XFkX0YLIRg9jsnea
	 M4/Ufebj6J3LA==
Date: Mon, 11 May 2026 17:33:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] iio: hid-sensors: introduce device managed API
Message-ID: <20260511173326.7fbab0eb@jic23-huawei>
In-Reply-To: <agAngXqFb5L2--AN@ashevche-desk.local>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
	<20260509101040.791404-4-sanjayembedded@gmail.com>
	<agAngXqFb5L2--AN@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 09:36:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, May 09, 2026 at 03:40:34PM +0530, Sanjay Chitroda wrote:
> 
> > hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
> > prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
> > during setup and release using device managed framework during drivers
> > fail, unbind or remove path.
> > 
> > Register action with devm_add_action_or_reset() to release resource with
> > devres framework.  
> 
> ...
> 
> > +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
> > +				  const char *name, struct hid_sensor_common *attrb)  
> 
> At this point don't we have indio_dev->dev.parent == dev?

yes probably but I'd rather we didn't use that.  For devm calls it's nicer to have the
owner device explicit. 

> 
> > +{
> > +	int ret;
> > +
> > +	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
> > +}  
> 

