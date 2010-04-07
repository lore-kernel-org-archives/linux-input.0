From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] eeepc-wmi: Add backlight support
Date: Thu, 8 Apr 2010 06:50:05 +0800
Message-ID: <20100407225005.GA30445@ywang-moblin2.bj.intel.com>
References: <20100407141750.GA16896@ywang-moblin2.bj.intel.com> <m2y71cd59b01004070805nb2e7a03cgccfa8d3deebe954c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:46220 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755476Ab0DGXAF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 19:00:05 -0400
Content-Disposition: inline
In-Reply-To: <m2y71cd59b01004070805nb2e7a03cgccfa8d3deebe954c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 07, 2010 at 05:05:41PM +0200, Corentin Chary wrote:
> On Wed, Apr 7, 2010 at 4:17 PM, Yong Wang <yong.y.wang@linux.intel.com> wrote:
> > Add backlight support for WMI based Eee PC laptops. In addition, start
> > to use a platform device to manage all functional devices as more
> > features will be implemented later.
> >
> > +static struct platform_device *eeepc_wmi_platform_device;
> > ?static struct input_dev *eeepc_wmi_input_dev;
> > +struct backlight_device *eeepc_wmi_backlight_device;
> 
> Instead of using static variables, you should really use a struct
> eeepc_wmi, store stuff inside it,
> and make all these functions reentrant. Alan did it for eeepc-laptop,
> and I did it for asus-laptop,
> see http://git.iksaif.net/?p=acpi4asus.git;a=commit;h=854c78363f37f03e30e2856ef17d7eefc62e0d06
> .
> The driver would really be cleaner and easier to review with that. And
> it would be more coherent with
> eeepc-laptop's code.
> 

Thanks for your review, Corentin. Could you please explain a bit more
what you mean by "make all these functions reentrant"?

Thanks
-Yong

