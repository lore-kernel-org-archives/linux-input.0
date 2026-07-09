Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0EA40B38F;
	Thu,  9 Jul 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591821; cv=none; b=pd5lRw1LnOwpW5ZFo9s8h3N6sSHhSTmqXvmfyZjkqhfrfMfTUxC77FGQjLcZyWE8cY9ZFsGIr7UnxAtfKoZTgVpOj68/J5K7EQgpgET3KpAWFUR3Ib36v+KuvJCvy95nK5IeCoaohFQY5Psl0AQG88bBAER9Vswf2s5tsXtUwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591821; c=relaxed/simple;
	bh=fRNeER7LnUmcwoquzvpNn39F7hoZUAISetj6EkZZm2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAglQaMDywneEb1thEshAVduxVhdTQAdza10AKSLHiCwHo//34ycBrSULpSST9TXkIaxsJI25G1amlNVvCSXhbQaTsbXrQ+iKaJjZl3wExj1ioZNlTwnV7EsOw8TczW1fWk7H5eHj+XIfWjv0wqxCY1W7gB2KXQgiQxjz1pheWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F03vhvIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F03vhvIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C61F00A3D;
	Thu,  9 Jul 2026 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591819;
	bh=oWFW04FqDfkqF6FQ5XuyyPvQ7Y46Kanl78+AV4Ugsl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F03vhvIwmj4StkRYQPee7Mpo8rhhvPDYa1ZUqMf2+g/CIeGCVIfCN0xnG5MJNYpgT
	 G/xk+YiSmjsIpQ2a+ZCD1F7xW6UWIvVaIlA6EZhjtHM2GrgY2ZJp+KTKbZzmfeMY3V
	 YI9cy3UqYXyMdyhNZ1zM949+ZSyI5yjfsP0DsW4R6T1oCjhBIM50nriVks3E2TiNTH
	 S9m1h8vO+qxxJ7t4pzTYadBUln5t8vaGIXxmcrGaq5iBn0yQiXfbw6yHSMCKDUSEG8
	 sAdltXpvBqJuHdUtm+PegrAGj97SvlIeTEKN0AltXJqRF1FwfLCw0B+XrWz/skAojF
	 Ifn+6OI6uNVwQ==
Date: Thu, 9 Jul 2026 11:10:12 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
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
Message-ID: <20260709-spicy-fiery-squid-6eec1d@sudeepholla>
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
 <8c2a4ae3-95cc-489a-a7a4-90a3ee2597e9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2a4ae3-95cc-489a-a7a4-90a3ee2597e9@oss.qualcomm.com>

On Thu, Jun 18, 2026 at 10:31:12PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 18-Jun-26 17:56, Bjorn Andersson wrote:
> > SCMI drivers such as the Arm SCMI CPUfreq driver are allowed to built as
> > modules, but they are then not automatically loaded. Rework the SCMI
> > device table alias support to make modpost consume the information from
> > MODULE_DEVICE_TABLE(scmi, ...) and allow drivers to be loaded based on
> > this information, if known. Also add a protocol-based alias to also
> > trigger driver loading when only the SCMI protocol id is known.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> So I just gave this a test spin and unfortunately it does not work.
> 
> The problem with Fedora's kernel-config / setup is that the
> request_module() from patch 2/2 runs from the initramfs, but
> the scmi_cpufreq module is only available in the rootfs.
> 
> It does work if I explictly add the scmi_cpufreq module to
> the initramfs, then it does get autoloaded.
> 
> We really need some place to put a uevent sysfs attr which then
> gets replayed when udev is restarted from the rootfs and then
> re-reads all the uevent files as part of its coldplug
> enumeration.
> 

I don't have much knowledge on uevent to provide any suggestions/help.
But isn't this a generic requirement ? I mean you could have modules
install on the rootfs and not all of them are packed in initramfs ?
Just wondering if that works for other modules, we can examine how
do they work and what are we missing ?

-- 
Regards,
Sudeep
