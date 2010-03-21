From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Sun, 21 Mar 2010 14:14:18 +0100
Message-ID: <71cd59b01003210614j3fd77990g502fb062175a9ed0@mail.gmail.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com>
	 <20100319135929.GA29027@srcf.ucam.org>
	 <20100319151054.GA30664@ywang-moblin2.bj.intel.com>
	 <20100319152323.GA30456@srcf.ucam.org>
	 <20100320005553.GB32163@ywang-moblin2.bj.intel.com>
	 <20100320122049.GA1478@holoscopio.com>
	 <20100320122416.GA10558@ywang-moblin2.bj.intel.com>
	 <71cd59b01003201021q118500a9nc1f56b37803d5bf3@mail.gmail.com>
	 <20100321005927.GA11076@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f211.google.com ([209.85.218.211]:64843 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0CUNOU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Mar 2010 09:14:20 -0400
In-Reply-To: <20100321005927.GA11076@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: cascardo@holoscopio.com, Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Mar 21, 2010 at 1:59 AM, Yong Wang <yong.y.wang@linux.intel.com> wrote:
> On Sat, Mar 20, 2010 at 06:21:42PM +0100, Corentin Chary wrote:
>>
>> Hi Yong,
>>
>> You can check how eeepc-laptop work for backlight stuff.
>> I think you should also remove all the NOTIFY_BRNDOWN_* code. It's
>> still in eeepc-laptop for backward compatibility, but it should not be
>> i newer drivers.
>>
>> Anyway, most of the time the backlight will be handled by the
>> acpi/video.ko driver which will
>> send events itself.
>>
>
> Thanks for the info. I will take a look.
>
>> I will update this page soon
>> http://dev.iksaif.net/projects/acpi4asus/wiki/Eeepc-wmi .
>>
>
> Yeah, I actually passed by this wiki page last week and I read the "how
> to help" section. I cannot donate hardware so I wrote the driver;-)
>
>> Do you want this driver to be part of acpi4asus project ? It would
>> allow to share the same git tree / bugtracker / wiki. I can give you
>> access to all that stuff quickly. I think it would be easier for users
>> if we merge into one single project.
>>
>
> I have no problem. What is the relationship between acpi4asus and
> platform x86 drivers? Will Matthew merge your tree?

Yep Matthew will merge my tree. Platform x86 subsystem is young, so it
only happened once, but I think
he will continue to do so. Do you want a write access to acpi4asus
tree, or do you want me to merge your tree ?

-- 
Corentin Chary
http://xf.iksaif.net
