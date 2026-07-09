Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5923393D
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603722; cv=none; b=Y6XY6TjdXXcjv7P2nuntC/Yf7aoEjqCIz1n8dWhtuoMI68UKsXhAuO4x/dTk+C2bTL1h/U4Zlfu23fqAAlg6WViapmCC/atgrXjldMOF2pVRKjtC7ZfA4yfOcyGwMW/4OZ8/va0tLEE/S+Z4agnsfXWxH556AEijeBWDIzyLnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603722; c=relaxed/simple;
	bh=X3LJtoIF2cz78g7fd2JzTBDARU25iOSmEdSyogFuUdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBWnAnyLuPZdO0677RtxOpwpA3y1N9llekTXFUKdnKuIS3/QIUG5fQUg7a/nlD0NoX8V//1AJx4VYlAL3CWnAtCITpkTKJYKalwIYoIg5ROadcx/X3+sMxjt5eyXSDib1ejrKe0ICxZ6KC40C1lJQt4EbuGuVTjIUQhvJNw26Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGbtrFI3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=okDmZJZC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGbtrFI3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="okDmZJZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783603720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0io07SKI9Zq4iIODgABtJrQ9iS+xBoIqqRbw2Q3fX6U=;
	b=WGbtrFI3kjs/0P6RINPIfxfhEY4hJ5TVPCHW47qruNulaOl8UF6Dans02+L7o7U2dwjTFd
	LFItk1CHM7mth1nkcUEhSmeHaOBKVRQncEkdKiMvUhv2XSNe/u2aTwy7Yxt/l0opDnyKF8
	20trO5W5r4y5LuP78uxwQSyzW8n0+YI=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-m-tjqqJUMwiUY8d75sKyeQ-1; Thu, 09 Jul 2026 09:28:37 -0400
X-MC-Unique: m-tjqqJUMwiUY8d75sKyeQ-1
X-Mimecast-MFC-AGG-ID: m-tjqqJUMwiUY8d75sKyeQ_1783603716
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-664a090b4dcso2958691d50.3
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783603716; x=1784208516; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0io07SKI9Zq4iIODgABtJrQ9iS+xBoIqqRbw2Q3fX6U=;
        b=okDmZJZCbV/HqschLJkt9nqeFZTJ3hCuDQ6lL7v6HyukNUKy4ll6eeT6IqpneiKoQq
         1U8x/sOFC6wGouSTIUlhYBuM0UoesvGpAM0e/XOJ4CUP4T6NGIG2R6lewaV+n+C32RHr
         ueJ5XPC5U4Pa88OIsTVcA6mnwV4kslh/1Mq8AmWljToAHEV05AI5bBOS8/uj2OpMdiBz
         lm8M+1KUGTOXJEmuFOnOSnfZkWH0W1pQ2Nk/8coSNycDaIM5cOe77WZJs+kXjKP+BFYA
         hBp8rZcYSFHF3l+pr1q/MjtnUjKZ+Rn0U3y+gGpLwAtYWpb/ZHBNVfskdBzy21tjCFOK
         peWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603716; x=1784208516;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0io07SKI9Zq4iIODgABtJrQ9iS+xBoIqqRbw2Q3fX6U=;
        b=ogjLXJ5vX//05pXSehepE4AD5eUTZl2KYH+RCeq4NZtv6t7aPGrMPGnq758JThCezJ
         U50bwTtnwa17dhdDkCk2em9hqsIhIek+BocbmWe321LNfwJZquLd2uNODLq6/xoqSJ7B
         RtJX7qBOfBAR4HvBzQzgjuEjHl0mAsEzC+VQyZ17AkMM8/3C3X0yi6Tuwr0Ll2GfGRSb
         FaV+/kntzKVudAQMCgEujHBiRMRE5SZcSIfCeFlTviio5ZGfWjoAUgWsX9TyaiORnnSq
         M4HoJKGwPxlIGG3uLQ8VYFN7QWliTt1NbiGvTgTsdVQEEPXnXbOKm3pPvJf8IyVfMIlu
         tzIA==
X-Forwarded-Encrypted: i=1; AHgh+RobyFVk1WpE+LNiJSMacC+O5BtDw0FpRzEUxddLaTtqoVZpQuGuyfSeRCEFM6G90PRq4mGmgRX0jZVHUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTR/1BZzB4tMY29GrAUIzElLstmCWhH9pzR1YvI+WZ21GBAX2
	nCKnClC0uWgbJlU18UI4JSjg1O4xgRRh84HG06WV65EWwov6OUsD+ZT0h+6PcfRz1A2XDwfBuCA
	D0chu1mgEw3hp7HARKRzNPtS+HHBMzi0hmsuRSl+thbmQuuSX4LJWvAsQOitGTb9p
X-Gm-Gg: AfdE7cnXElMpntCOWmO/ecWKw4KTRDWMpY3ZzHRG606dxISrXfVIV0BVIsjTECxvSWY
	BVAqiPlCNNjaTIcPx9jZPMHAYFBn6D3xwPoK0XYVkReaHeS9n7WdGlFM//Vln3yQxwo9EuwnTiG
	tUde0wmE2mUc99qD4oi2whY48mPapzTldvZkwKRAbdi1dvXK3rOUd8PI+HpHcPNyEEX2q6RdtWT
	957eaKEwP4DDO9tU1ghiRV76D5evTEACE+FHmVwqghFyKfw5+SrFPHsrw538CV71jVWoPahgg5R
	DDmscyltyRc5eibgP/7mHFbOv1J0aFzwyToYC2QmASxS6A5cFVuZm7bVSiqOjuP5VRMwI24Ui+P
	xwyaDXnHqNtN9g0jfZ181lj0wtCsfkfwmmYmSJMeFjqCsTw==
X-Received: by 2002:a05:690e:d48:b0:666:39a8:fb82 with SMTP id 956f58d0204a3-6679f02acb3mr4957911d50.14.1783603715994;
        Thu, 09 Jul 2026 06:28:35 -0700 (PDT)
X-Received: by 2002:a05:690e:d48:b0:666:39a8:fb82 with SMTP id 956f58d0204a3-6679f02acb3mr4957877d50.14.1783603715498;
        Thu, 09 Jul 2026 06:28:35 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a49befsm4150627d50.16.2026.07.09.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:28:34 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:28:18 -0400
From: Brian Masney <bmasney@redhat.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] firmware: arm_scmi: Ensure automatic module
 loading
Message-ID: <ak-h8oPcL69fCUg2@redhat.com>
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
 <8c2a4ae3-95cc-489a-a7a4-90a3ee2597e9@oss.qualcomm.com>
 <20260709-spicy-fiery-squid-6eec1d@sudeepholla>
 <dae4deba-7e5f-434e-80ae-89033bdeb793@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae4deba-7e5f-434e-80ae-89033bdeb793@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

Hi Hans,

On Thu, Jul 09, 2026 at 03:22:29PM +0200, Hans de Goede wrote:
> On 9-Jul-26 12:10, Sudeep Holla wrote:
> > On Thu, Jun 18, 2026 at 10:31:12PM +0200, Hans de Goede wrote:
> >> On 18-Jun-26 17:56, Bjorn Andersson wrote:
> >>> SCMI drivers such as the Arm SCMI CPUfreq driver are allowed to built as
> >>> modules, but they are then not automatically loaded. Rework the SCMI
> >>> device table alias support to make modpost consume the information from
> >>> MODULE_DEVICE_TABLE(scmi, ...) and allow drivers to be loaded based on
> >>> this information, if known. Also add a protocol-based alias to also
> >>> trigger driver loading when only the SCMI protocol id is known.
> >>>
> >>> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> >>
> >> So I just gave this a test spin and unfortunately it does not work.
> >>
> >> The problem with Fedora's kernel-config / setup is that the
> >> request_module() from patch 2/2 runs from the initramfs, but
> >> the scmi_cpufreq module is only available in the rootfs.
> >>
> >> It does work if I explictly add the scmi_cpufreq module to
> >> the initramfs, then it does get autoloaded.
> >>
> >> We really need some place to put a uevent sysfs attr which then
> >> gets replayed when udev is restarted from the rootfs and then
> >> re-reads all the uevent files as part of its coldplug
> >> enumeration.
> >>
> > 
> > I don't have much knowledge on uevent to provide any suggestions/help.
> > But isn't this a generic requirement ? I mean you could have modules
> > install on the rootfs and not all of them are packed in initramfs ?
> > Just wondering if that works for other modules, we can examine how
> > do they work and what are we missing ?
> 
> scmi is special because the actual devices under /sys/bus/scmi/devices
> only get created when the module with the driver is loaded because
> of some funtion/id mapping requiring info from the driver.
> 
> Patch 2/2 tries to work around this by loading all scmi drivers matching
> the scmi protocol which is known at bus enumeration time, but this only
> works if the actual scmi driver is in the initramfs because this done
> through directly calling modprobe() from the kernel which does not
> get "replayed" when switching to the real rootfs.

Should the SCMI drivers be added to the dracut module here?

https://github.com/dracut-ng/dracut/blob/main/modules.d/70kernel-modules/module-setup.sh#L73

A few years ago we had to add the interconnect drivers to the list for
Fedora.

Brian

