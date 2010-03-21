From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Sun, 21 Mar 2010 08:59:27 +0800
Message-ID: <20100321005927.GA11076@ywang-moblin2.bj.intel.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com> <20100319135929.GA29027@srcf.ucam.org> <20100319151054.GA30664@ywang-moblin2.bj.intel.com> <20100319152323.GA30456@srcf.ucam.org> <20100320005553.GB32163@ywang-moblin2.bj.intel.com> <20100320122049.GA1478@holoscopio.com> <20100320122416.GA10558@ywang-moblin2.bj.intel.com> <71cd59b01003201021q118500a9nc1f56b37803d5bf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:2173 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751532Ab0CUBI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 21:08:27 -0400
Content-Disposition: inline
In-Reply-To: <71cd59b01003201021q118500a9nc1f56b37803d5bf3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: cascardo@holoscopio.com, Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Mar 20, 2010 at 06:21:42PM +0100, Corentin Chary wrote:
> 
> Hi Yong,
> 
> You can check how eeepc-laptop work for backlight stuff.
> I think you should also remove all the NOTIFY_BRNDOWN_* code. It's
> still in eeepc-laptop for backward compatibility, but it should not be
> i newer drivers.
> 
> Anyway, most of the time the backlight will be handled by the
> acpi/video.ko driver which will
> send events itself.
> 

Thanks for the info. I will take a look.

> I will update this page soon
> http://dev.iksaif.net/projects/acpi4asus/wiki/Eeepc-wmi .
> 

Yeah, I actually passed by this wiki page last week and I read the "how
to help" section. I cannot donate hardware so I wrote the driver;-)

> Do you want this driver to be part of acpi4asus project ? It would
> allow to share the same git tree / bugtracker / wiki. I can give you
> access to all that stuff quickly. I think it would be easier for users
> if we merge into one single project.
> 

I have no problem. What is the relationship between acpi4asus and
platform x86 drivers? Will Matthew merge your tree?

Thanks
-Yong
