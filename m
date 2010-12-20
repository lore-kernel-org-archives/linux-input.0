From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/4] acer-wmi: Enabled Acer Launch Manager mode
Date: Mon, 20 Dec 2010 16:06:12 +0000
Message-ID: <20101220160612.GA25502@srcf.ucam.org>
References: <1291688963-23232-1-git-send-email-jlee@novell.com> <1291688963-23232-2-git-send-email-jlee@novell.com> <1291688963-23232-3-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291688963-23232-3-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: dmitry.torokhov@gmail.com, corentin.chary@gmail.com, corentincj@iksaif.net, tiwai@novell.com, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 07, 2010 at 10:29:21AM +0800, Lee, Chun-Yi wrote:
> +	struct lm_return_value return_value;
> +	acpi_status status;
> +	struct lm_input_params params = {
> +		.function_num = 0x1,
> +		.commun_devices = 0x0041,	/* WiFi on, 3G on, BT off */

Why this set of devices?

> +		printk(ACER_INFO "Enabled Launch Manager");

This is the default behaviour, so I don't think you need to print 
anything in this case.

The other patches in the series look fine - I'll apply those to -next 
now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
