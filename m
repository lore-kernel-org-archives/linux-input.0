From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-wmi: Add backlight support
Date: Wed, 7 Apr 2010 17:05:41 +0200
Message-ID: <m2y71cd59b01004070805nb2e7a03cgccfa8d3deebe954c@mail.gmail.com>
References: <20100407141750.GA16896@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:34020 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596Ab0DGPFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 11:05:43 -0400
In-Reply-To: <20100407141750.GA16896@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 7, 2010 at 4:17 PM, Yong Wang <yong.y.wang@linux.intel.com>=
 wrote:
> Add backlight support for WMI based Eee PC laptops. In addition, star=
t
> to use a platform device to manage all functional devices as more
> features will be implemented later.
>
> +static struct platform_device *eeepc_wmi_platform_device;
> =A0static struct input_dev *eeepc_wmi_input_dev;
> +struct backlight_device *eeepc_wmi_backlight_device;

Instead of using static variables, you should really use a struct
eeepc_wmi, store stuff inside it,
and make all these functions reentrant. Alan did it for eeepc-laptop,
and I did it for asus-laptop,
see http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dcommit;h=3D854c78363f3=
7f03e30e2856ef17d7eefc62e0d06
=2E
The driver would really be cleaner and easier to review with that. And
it would be more coherent with
eeepc-laptop's code.

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
