Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173D3382EC
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463435; cv=none; b=kgtnnCnTKRLHGY7t7g6Jy7UW27NrwaPPdsoVmnlkFFFnetBmabiRqLxTGuAltYFec52JiWUvTdasfLTUJcIfF155NElbEWwpD9Wh2FleQYQMmPbsuYssZF6nRNExF7FviRydr66nZZEXaYK3SywsFABOlyCRtDzWKOVYZZcWKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463435; c=relaxed/simple;
	bh=/pVQ2IAjiW0sthXZl69ON6WFGMKgszbeUzRUnO7csLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpLhItQEvY+aT636Tn+vDMKRHX6+TuBjPDrfrZUjPlh2rqwTj7usLSrNGD9kPggKlgt8T9c+2WNyheJz+oUbupvFMh+2fr0+BC4zdvX4og3nN+XFXeIgsgCy7j1Jx+3oF+vK76OPElE5Li6ZvmntiTao0anAtm2hLZ6Pc3UOhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACao4GtO; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACao4GtO"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1370417c01cso12249219c88.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780463432; x=1781068232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdFl1rFSf/nLN8QBSz3ZAaskYjSuoVwRsROtIBKRbbY=;
        b=ACao4GtOTvtk4u/VqEQmDG0xc1kH0n4wKeRS4HeYFJopSfhwDoD/RhisKJhbJsQBYg
         nmL81OqjObgtQLRqAQtyN9NtFd+V79ybahlewEaFgs2qbcQaYbKYJkWbqDPbtk/hsGJU
         nN9/EWu7okcVTek1x0Wfi2YidHvljEQUC8GiewgvE7xC2TbOG5/1A5NBbO58iPoRoS1s
         c3G8BxpwboR4Pbpfr7OEXBpSBXeatrywBsndKee5t0pu13jE/F8FKQk8mYedP5ZwKYBY
         B081Q+nZngBA1mMqTUpf9zkw4z15yauSC00GWmQqDzcXlg0rDM+7dGyX34YV7NTqP8S2
         5pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780463432; x=1781068232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdFl1rFSf/nLN8QBSz3ZAaskYjSuoVwRsROtIBKRbbY=;
        b=hzdllAKxoHeGCnn7eH35q4U+fzAWVq67nqM8Yqpqje4TJH4gx45BIjfE0lopOzt8wJ
         pp/yfTIipSXTXZ2s4uU9RbaPHbTrz4LHqS4tzGk2RxRLgeMBTw+DWFvaQHhshJKnCRbl
         ySM4VXpQ7Ox0HBFNN0sheOyCT+bs7Q7uHPxX3OJzL8I8ew43PObxE25qvEEQovo5cDio
         al+qYQ/r2v1xmWlEXTjIC5Glzw/Eh/6TOsHb+CRfr1Pe6qXMl81xz8toTFWJg52CmbdV
         NPJWEWQX7xEsg+nYK/bx7w7nfiCHL4AtwnX5btImtM6Svi77vrRplo2vtWTCZ26n7yTt
         WoAA==
X-Forwarded-Encrypted: i=1; AFNElJ8iIU3gM4qFVbf3PQvm2VBMJnmLVGBLnsr5IU9uAybXB9HJ/HI73fLeD8bzIONp5AdrBIi3e3pEkqfHJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KXNCQTZXefO0PoULzb6x4j/ykG/johajC3/CPYqBGqgAky01
	9hP1W/7keEtRk6ul9bTe8jdaa9ODqRh78rszKzI/HvaLevHr/Oe+qZV1
X-Gm-Gg: Acq92OH242hKCQDJjgzfZBh2vG62W7PiyOBMBoACBpunoZYlQ/HX0HTuBEkVBfo5ioB
	+bh/sJCsYG8yI51IFgCWiqH7HRNILViQzWBNpbc78Hi7/8LoKNuIeWObNHOyd1a/gYqDNOMfbAl
	B8fViox9RZg7End3Jmhs0ZssqN6vu1K7JytmVp4pQMKjer1RSFLCy/9AdcsIALJhbMLfm5+NVoM
	CIxzoguOFMrZp5BMl8B57lXFPPgtGYSOBSqWU1be7Z8UEXM+9iAcarumN1ZGmzagxSLHF1Z5eII
	+Q8HbQGRZOpCTrGePjSlKYBMAHv7YcM53ElkcDXgPfxKA9l8ZbshTZu1j34HCZlgccaXA6mdSrQ
	JOLKhIdjaj1KFVmbH1RQFE8NWSkUISI+D/2S39PilGmEgDlRqstBicrMDnxyCDJom7WQfO46QuF
	kwhBjnwvxtwlunL27b5UKrGsArtRSe4VBFNF9/+Ej9ovSPRqUtUl8dr538V1zI5QYELEnXZpfl9
	1k=
X-Received: by 2002:a05:7300:2206:b0:304:c9f1:a0f6 with SMTP id 5a478bee46e88-3074fca06b5mr868863eec.33.1780463431945;
        Tue, 02 Jun 2026 22:10:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c4f4:520b:1304:b259])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df349d8sm1547406eec.22.2026.06.02.22.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 22:10:31 -0700 (PDT)
Date: Tue, 2 Jun 2026 22:10:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>, Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Message-ID: <ah-1z9LhVG0wtfBw@google.com>
References: <20260520183815.2510387-3-arnd@kernel.org>
 <20260530004519.1C8E81F00893@smtp.kernel.org>
 <dfe153e1-a3d1-4dca-a59b-59899082c4e9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe153e1-a3d1-4dca-a59b-59899082c4e9@app.fastmail.com>

On Mon, Jun 01, 2026 at 08:32:31PM +0200, Arnd Bergmann wrote:
> On Sat, May 30, 2026, at 02:45, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > Does this change break legacy devices that legitimately provide both a valid
> > GPIO and a valid IRQ?
> >
> > If a legacy platform provides both a valid GPIO and an IRQ, this condition
> > now evaluates to false.
> >
> > By skipping the GPIO request entirely, the driver falls back to treating the
> > device as a pure IRQ button. This forces the driver to lose hardware
> > debouncing and rely on a simulated release timer instead of checking the
> > physical GPIO line.
> 
> There are only three drivers that provide the ->irq field. Two are the
> ones that I'm changing in this patch, the soc_button_array driver
> is the third and none of them set ->irq and ->gpio at the same time.
> 
> >>   */
> >>  struct gpio_keys_button {
> >>  	unsigned int code;
> >> +#ifdef CONFIG_GPIOLIB_LEGACY
> >>  	int gpio;
> >> +#endif
> >>  	int active_low;
> >
> > [Severity: Medium]
> > Will this cause build failures for drivers that assign to this field when
> > CONFIG_GPIOLIB_LEGACY is disabled?
> 
> Yes, that is the intention of the patch: nothing should set the
> ->gpio field unless GPIOLIB_LEGACY is set.
> 
> > Other modern drivers dynamically create the platform device and pass legacy
> > GPIO numbers by directly assigning to this field:
> >
> > drivers/input/misc/soc_button_array.c:soc_button_device_create() {
> >     ...
> >     gpio_keys[n_buttons].gpio = gpio;
> >     ...
> > }
> >
> > When CONFIG_GPIOLIB_LEGACY is disabled, this results in a compilation failure
> > since struct gpio_keys_button no longer has the gpio member.
> 
> I previously included a patch force-enable GPIOLIB_LEGACY in this
> patch series, see
> 
> https://lore.kernel.org/all/npijagtgyad33xxlq46b7kwzydhcgt5tkgd5ihsjl6t4czbqyf@umovipwh73i2/
> 
> I made a mistake during a rebase, so my older patch was still
> included in my randconfig testing but not in the series I
> sent. All the other changes in it are now redundant, bit
> the soc_button_array portion indeed still remains.
> 
> Hans, Dmitry, do you already have plans to deal with the
> soc_button_array driver to move it away from legacy GPIOs?
> 
> So far I can see four possible ways we can deal with it,
> but none that I actually like:
> 
> a) delay the problem, apply my original oneline change
>    to 'select GPIOLIB_LEGACY' and fix it later, so we
>    can make GPIOLIB_LEGACY default-disabled in 7.3.
> 
> b) add a gpiod member to struct gpio_keys_button and skip
>    the intermediate gpio number here. Clean it up later.
> 
> c) always pass the gpio as an interrupt, as the driver
>    already does for some machines
> 
> d) add dynamic device properties that duplicate the
>    information from ACPI/DMI, so the driver can
>    stop using platform data
> 
> e) disconnect gpio_keys_button from gpio-keys.c and
>    register the buttons to the input subsystem
>    directly from soc_button_device_create().

I tried doing e) and while it is possible I ended up re-implementing
most of gpio_keys.c which is not great. We still need both GPIO and
IRQ-only modes, and handling debouncing, both software and hardware, and
so on. So I would like to see if d) is possible. The problem is that we
need to reconstruct GPIO reference from existing gpio_desc. If Bart will
be OK with something like below then I think the conversion should be
achievable.

gpiolib: Introduce gpiod_get_software_node_reference()

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

To support converting drivers (such as soc_button_array) to use static
device properties/software nodes, we need a way to reconstruct a GPIO
reference from an existing gpio_desc.

Introduce gpiod_get_software_node_reference() which populates a
struct software_node_ref_args with the GPIO device's fwnode, the pin
offset, and the appropriate active-low flag.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib.c        |   35 +++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |   12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1e6dce430dca..63cef0fb02b5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -247,6 +247,41 @@ int gpiod_hwgpio(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_hwgpio);
 
+/**
+ * gpiod_get_software_node_reference() - Reconstruct a software node reference
+ *                                       from a GPIO descriptor
+ * @desc: GPIO descriptor
+ * @args: Pointer to software node reference arguments structure to populate
+ *
+ * This function can be used to construct a software node reference from
+ * an existing GPIO descriptor. This is useful when a driver wants to pass
+ * a software node to a secondary device, but needs to reconstruct a GPIO
+ * reference dynamically.
+ *
+ * Returns:
+ * 0 on success, or a negative error code on failure.
+ */
+int gpiod_get_software_node_reference(const struct gpio_desc *desc,
+				      struct software_node_ref_args *args)
+{
+	struct gpio_device *gdev;
+
+	if (IS_ERR_OR_NULL(desc) || !args)
+		return -EINVAL;
+
+	gdev = desc->gdev;
+
+	memset(args, 0, sizeof(*args));
+	args->fwnode = dev_fwnode(&gdev->dev);
+	args->nargs = 2;
+	args->args[0] = gpiod_hwgpio(desc);
+	if (test_bit(GPIOD_FLAG_ACTIVE_LOW, &desc->flags))
+		args->args[1] = GPIO_ACTIVE_LOW;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpiod_get_software_node_reference);
+
 /**
  * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
  * @desc:	descriptor to return the chip of
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 3efb5cb1e1d1..c95b715a1d15 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -11,6 +11,7 @@
 struct acpi_device;
 struct device;
 struct fwnode_handle;
+struct software_node_ref_args;
 
 struct gpio_array;
 struct gpio_desc;
@@ -177,6 +178,9 @@ int desc_to_gpio(const struct gpio_desc *desc);
 
 int gpiod_hwgpio(const struct gpio_desc *desc);
 
+int gpiod_get_software_node_reference(const struct gpio_desc *desc,
+				      struct software_node_ref_args *args);
+
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
 					 enum gpiod_flags flags,
@@ -545,6 +549,14 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 	return -EINVAL;
 }
 
+static inline
+int gpiod_get_software_node_reference(const struct gpio_desc *desc,
+				      struct software_node_ref_args *args)
+{
+	WARN_ON(desc);
+	return -EINVAL;
+}
+
 static inline
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,

Thanks.

-- 
Dmitry
