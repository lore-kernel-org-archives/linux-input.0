Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67010371D01
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133760; cv=none; b=G8bTDVRV/WLxbl24VqhLhTruUaFLHwIxUpdTJ/QFAlXwvYmX6OPMDSqX+Olwkbq3uWl4/s3iNU7izJsah7GgXWoQpIOMe/hJYE/OeQPplZ0fIu/sI3gTVEe9GFClzXk8a6LdmW0zPqmqsLVVvY9vtTVBl7uwfYGPVnrOvqiqrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133760; c=relaxed/simple;
	bh=Qb9fwjWXWQbQ4G5fxMsW4pWxfQnE9Z3sgY1oqF/NeBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFAgw7RHpvuk/iZDGw/IuXEVMPxYAMz877Nm912BoE5yMF8XnFEnurKUZkb9rUy2l66plCAp7oFfO4x68eU1AZAdz5BO2UkqjtOeDZO7ho60bx+sH3I1bW7F49jvetYS7HGWV1680PRlXuyjyBhM8OJasz9mNMzESjpKFygXCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf222bsX; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf222bsX"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-138405b7bc5so1067750c88.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781133757; x=1781738557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anl/tIPqzLKNrSthWVK3ftWFNeblmDRtjXLgHKj0shc=;
        b=nf222bsXZxy8SKR7hik3YYDnjjQ9X9LZ6w1n8nD4GwkfJ5W8AbiT0M0/ktjfZbgXxe
         RwkUe9aCl00Ufl0xjgQLxJCmIDFOaLLXpmq/pRPTQ8T8X9Q7qYY1n6l8STEOVbq0c4ai
         1AfmLoVnvLetp5vuD5XBAUgsuioJ9+SJROGehqaD0/n4Iis84nTP6l4KO9VgLXsLzu8S
         ID1IrbqlYg00IsTcairplEMMDy6XIX1+0RSbMzh7gOlZ2MCuzfGlbagqBRE4yNH4kY29
         QMIrCBGOG1ASScvluB8EmFRKALDimyl/LPREGCCIoLHOWzvQgrIi8eA3XsMjvdP2S0Ha
         G2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781133757; x=1781738557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anl/tIPqzLKNrSthWVK3ftWFNeblmDRtjXLgHKj0shc=;
        b=sPRFof4QnDIrmagVfyYRbcfssg3U0TkOAVPmpe5GrlP/hl8LCRyAGmeaPzOSh+QYPO
         MytT4Tz6fcg8tCK7LZPk6rXUUWX6+4boKmi9f2lovfSI2oJbjrG4reAFcQzpehU29BU2
         IJd/1+O7/I3yCS+E7pYPFQMt2rkA0yW9vQmBupaFphoPAA6ZlR4kDJaxvXjb2sdAuqWD
         BEAikxBDAdM2l42iI0bXGHHJauKD7a+OAm9QU/ZU/X7x+EPe1/hy7tE0bhAOMvD3YtOi
         0n75CYWWQu06PEFwNkcjiS8xNXjcigeV7CXYd3dxY8KujsHhT06Kt2h3NuwQunyOyozV
         Ur0g==
X-Forwarded-Encrypted: i=1; AFNElJ+2VTVocXyDstDzXfKnt0PTMDNHwHg/0+qbB3YxWKdAapNd9ZFDysxkRwAALpLbQAj6NI10mm+ufPhGtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE47L/0yyY9jAr/DIOgOlqlVSLkG0e30RjvK09eoIUZZDXAQCB
	9aJr8b5g7FxzQ89cR5w34dALimdoKGEyPm/N+h6v1wWHhoNiMs036zqN
X-Gm-Gg: Acq92OGkox/7/GJpK4NXzfV1ir/D/p3ouWEjIEamzQyGQVfNyPLbEXm6Jf+B8mwzJXv
	7tInC0ifmjsg6DX9uYYaAVCT+q84btV9Gr22mJIPkx759Zrvui4/KCFRxS+iUlq5iIG9CvAShV8
	KBVd1prE2MSeI0tl/jnjUkIGv0xtG12vYolnRI/nqb/+gEqz0f1hu1+eoD6MWLHVCg6gyEpM6fx
	NdWFlFkXV2t4h7pcd0QO+Ogm+4A+49kI/hLBkFRHRmKqx91IWPzC1vXrYIMSBIw3Fo0CFjszPc9
	0la8aNUd8jREopfXMbwqF7zKDVtk5Cl6nymIXIW+bv6gwCGfomSkOijGGjzaxIhQ7WNJpQmf0mX
	Lp9808sAwuPqzdgObCp+8AYm35PBNIgmGAIomnyPqO0gDcM79LX7xCL0fSFIf25QtU3WgeXJCf8
	Qqg6Y0RSedaGlKnObVub6Pf/JDWHtf8Rcxnr4c4Yq4Z0Wt4ux1PuwCH+6dAIZgeGzwNbr/8OQY5
	MM=
X-Received: by 2002:a05:7300:324d:b0:304:e566:e000 with SMTP id 5a478bee46e88-30804bc1171mr325050eec.31.1781133757533;
        Wed, 10 Jun 2026 16:22:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df75ff6sm28869773eec.26.2026.06.10.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:22:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:22:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Message-ID: <ainwyy-iSRPmqYJQ@google.com>
References: <20260609121353.3743782-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609121353.3743782-1-lee@kernel.org>

On Tue, Jun 09, 2026 at 01:13:37PM +0100, Lee Jones wrote:
> wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
> inside the interrupt handler context.  If the Touch sibling device
> is disconnected, wacom_remove_shared_data() clears 'touch_input'
> outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
> race condition where a preempted reader in interrupt context
> dereferences the freed pointer, leading to a Use-After-Free.
> 
> Resolve this by introducing RCU protection for the touch_input
> pointer:
> 
>  - Annotate 'touch_input' in wacom_shared struct with __rcu
>  - Wrap all lockless readers in wacom_wac.c with rcu_read_lock() and
>    rcu_dereference() using a unified wacom_report_touch_mute()
>    helper
>  - Update writers in wacom_sys.c using rcu_assign_pointer()
>  - Call synchronize_rcu() in wacom_remove_shared_data() to ensure
>    all active RCU readers have finished before the input device is
>    freed
> 
> Also wrap wacom_set_shared_values() and touch/pen assignments in
> wacom_add_shared_data() inside the wacom_udev_list_lock to serialize
> concurrent probe assignments, and verify that 'shared->touch == hdev'
> before setting touch_input to prevent concurrent sibling probe state
> desynchronization.
> 
> Finally, advertise the SW_MUTE_DEVICE capability on Touch input
> devices prior to registration in wacom_setup_touch_input_capabilities()
> to prevent invalid post-registration capability modifications.
> 
> Fixes: 961794a00eab ("Input: wacom - add reporting of SW_MUTE_DEVICE events")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 
> v1 -> v2: Split and use RCU as per Dmitry's review
> v2 -> v3: Sashiko fixes
> 
>  drivers/hid/wacom_sys.c | 41 ++++++++++++++----------
>  drivers/hid/wacom_wac.c | 70 ++++++++++++++++++++++-------------------
>  drivers/hid/wacom_wac.h |  2 +-
>  3 files changed, 63 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2220168bf116..7ba589826548 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
>  		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
>  
> -		if (wacom_wac->shared->touch == wacom->hdev)
> -			wacom_wac->shared->touch = NULL;
> -		else if (wacom_wac->shared->pen == wacom->hdev)
> -			wacom_wac->shared->pen = NULL;
> +		scoped_guard(mutex, &wacom_udev_list_lock) {
> +			if (wacom_wac->shared->touch == wacom->hdev) {
> +				wacom_wac->shared->touch = NULL;
> +				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> +			} else if (wacom_wac->shared->pen == wacom->hdev) {
> +				wacom_wac->shared->pen = NULL;
> +			}
> +		}
> +
> +		synchronize_rcu();
>  
>  		kref_put(&data->kref, wacom_release_shared_data);
>  		wacom_wac->shared = NULL;
> @@ -909,6 +915,11 @@ static int wacom_add_shared_data(struct hid_device *hdev)
>  		list_add_tail(&data->list, &wacom_udev_list);
>  	}
>  
> +	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
> +		data->shared.touch = hdev;
> +	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
> +		data->shared.pen = hdev;
> +
>  	mutex_unlock(&wacom_udev_list_lock);
>  
>  	wacom_wac->shared = &data->shared;
> @@ -917,11 +928,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
>  	if (retval)
>  		return retval;
>  
> -	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
> -		wacom_wac->shared->touch = hdev;
> -	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
> -		wacom_wac->shared->pen = hdev;
> -
>  	return retval;
>  }
>  
> @@ -2345,9 +2351,15 @@ static void wacom_release_resources(struct wacom *wacom)
>  
>  static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
>  {
> +	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
> +
> +	mutex_lock(&wacom_udev_list_lock);

Why not

	guard(mutex)(&wacom_udev_list_lock);

> +
>  	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> -		wacom_wac->shared->type = wacom_wac->features.type;
> -		wacom_wac->shared->touch_input = wacom_wac->touch_input;
> +		if (wacom_wac->shared->touch == wacom->hdev) {
> +			wacom_wac->shared->type = wacom_wac->features.type;
> +			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
> +		}
>  	}
>  
>  	if (wacom_wac->has_mute_touch_switch) {
> @@ -2361,12 +2373,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
>  			wacom_wac->shared->is_touch_on = true;
>  	}
>  
> -	if (wacom_wac->shared->has_mute_touch_switch &&
> -	    wacom_wac->shared->touch_input) {
> -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> -				     SW_MUTE_DEVICE);
> -	}
> +	mutex_unlock(&wacom_udev_list_lock);
>  }
>  
>  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625..495960227b8d 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -510,6 +510,22 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
>  	}
>  }
>  
> +static void wacom_report_touch_mute(struct wacom_wac *wacom_wac, bool mute)
> +{
> +	struct input_dev *touch_input;
> +
> +	if (!wacom_wac->shared)
> +		return;

Can this happen? I think callers already check this or simply
dereference.

> +
> +	rcu_read_lock();

	guard(rcu)();

> +	touch_input = rcu_dereference(wacom_wac->shared->touch_input);
> +	if (touch_input) {
> +		input_report_switch(touch_input, SW_MUTE_DEVICE, mute);
> +		input_sync(touch_input);
> +	}
> +	rcu_read_unlock();
> +}
> +

Thanks.

-- 
Dmitry
