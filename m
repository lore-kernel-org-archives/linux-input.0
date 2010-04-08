From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-wmi: Add backlight support
Date: Thu, 8 Apr 2010 07:29:59 +0200
Message-ID: <p2y71cd59b01004072229wb66497a4q77d647bdcce49e9d@mail.gmail.com>
References: <20100407141750.GA16896@ywang-moblin2.bj.intel.com>
	 <m2y71cd59b01004070805nb2e7a03cgccfa8d3deebe954c@mail.gmail.com>
	 <20100407225005.GA30445@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:58155 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0DHFaB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 01:30:01 -0400
In-Reply-To: <20100407225005.GA30445@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Apr 8, 2010 at 12:50 AM, Yong Wang <yong.y.wang@linux.intel.com> wrote:
> On Wed, Apr 07, 2010 at 05:05:41PM +0200, Corentin Chary wrote:
>> On Wed, Apr 7, 2010 at 4:17 PM, Yong Wang <yong.y.wang@linux.intel.com> wrote:
>> > Add backlight support for WMI based Eee PC laptops. In addition, start
>> > to use a platform device to manage all functional devices as more
>> > features will be implemented later.
>> >
>> > +static struct platform_device *eeepc_wmi_platform_device;
>> > ?static struct input_dev *eeepc_wmi_input_dev;
>> > +struct backlight_device *eeepc_wmi_backlight_device;
>>
>> Instead of using static variables, you should really use a struct
>> eeepc_wmi, store stuff inside it,
>> and make all these functions reentrant. Alan did it for eeepc-laptop,
>> and I did it for asus-laptop,
>> see http://git.iksaif.net/?p=acpi4asus.git;a=commit;h=854c78363f37f03e30e2856ef17d7eefc62e0d06
>> .
>> The driver would really be cleaner and easier to review with that. And
>> it would be more coherent with
>> eeepc-laptop's code.
>>
>
> Thanks for your review, Corentin. Could you please explain a bit more
> what you mean by "make all these functions reentrant"?
>
> Thanks
> -Yong
>
>

Well, it means that you should'nt use a static variable for platform,
backlight, input
and only use function parameters to get the job done.
In your case, it's not really mandatory, but as Alan explain in the
changelog I linked,
it's really cleaner. And also make the code a lot easier to review.

Also, if you do that, could you split up the patch in (for example):
- add a eeepc_wmi context structure, and put input_device into it
- add a platform device
- add backlight support

Thanks !

-- 
Corentin Chary
http://xf.iksaif.net
