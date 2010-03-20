From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Sat, 20 Mar 2010 18:21:42 +0100
Message-ID: <71cd59b01003201021q118500a9nc1f56b37803d5bf3@mail.gmail.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com>
	 <20100319135929.GA29027@srcf.ucam.org>
	 <20100319151054.GA30664@ywang-moblin2.bj.intel.com>
	 <20100319152323.GA30456@srcf.ucam.org>
	 <20100320005553.GB32163@ywang-moblin2.bj.intel.com>
	 <20100320122049.GA1478@holoscopio.com>
	 <20100320122416.GA10558@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62781 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0CTRVp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 13:21:45 -0400
In-Reply-To: <20100320122416.GA10558@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: cascardo@holoscopio.com, Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

>> You should either use backlight_force_update in your driver or let the
>> user update it writing to the brightness file. In your case, I'd say you
>> should use backlight_force_update and give BACKLIGHT_UPDATE_HOTKEY as
>> the reason.
>>
>
> Oh, I see. Thank for clarifying, Cascardo.
>
> -Yong
>

Hi Yong,

You can check how eeepc-laptop work for backlight stuff.
I think you should also remove all the NOTIFY_BRNDOWN_* code. It's
still in eeepc-laptop for backward compatibility, but it should not be
i newer drivers.

Anyway, most of the time the backlight will be handled by the
acpi/video.ko driver which will
send events itself.

I will update this page soon
http://dev.iksaif.net/projects/acpi4asus/wiki/Eeepc-wmi .

Do you want this driver to be part of acpi4asus project ? It would
allow to share the same git tree / bugtracker / wiki. I can give you
access to all that stuff quickly. I think it would be easier for users
if we merge into one single project.

Thanks for you work.

-- 
Corentin Chary
http://xf.iksaif.net
