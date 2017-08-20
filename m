From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [input:next 1901/1903] drivers/input/misc/axp20x-pek.c:385:1-2:
 axp_pek_id_match is not NULL terminated at line 385 (fwd)
Date: Sun, 20 Aug 2017 09:32:29 -0700
Message-ID: <20170820163229.GD1176@dtor-ws>
References: <alpine.DEB.2.20.1708171119580.3748@hadrien>
 <1bf47905-c971-4a2b-f154-26f0d2474dad@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33951 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdHTQcd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 20 Aug 2017 12:32:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id w127so660712pfd.1
        for <linux-input@vger.kernel.org>; Sun, 20 Aug 2017 09:32:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1bf47905-c971-4a2b-f154-26f0d2474dad@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-input@vger.kernel.org, kbuild-all@01.org

On Thu, Aug 17, 2017 at 12:14:22PM +0200, Quentin Schulz wrote:
> Hi Julia,
> 
> Thanks for the report.
> 
> @Dimitry: do I need to wait for the patches to come in next in order to
> add a Fixes tag or do I send a fix for this now?

I fixed it in place, no need to send the patch.

Thanks!

> 
> Thanks,
> Quentin
> 
> On 17/08/2017 11:20, Julia Lawall wrote:
> > 
> > 
> > ---------- Forwarded message ----------
> > Date: Thu, 17 Aug 2017 10:09:14 +0800
> > From: kbuild test robot <fengguang.wu@intel.com>
> > To: kbuild@01.org
> > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > Subject: [input:next 1901/1903] drivers/input/misc/axp20x-pek.c:385:1-2:
> >     axp_pek_id_match is not NULL terminated at line 385
> > 
> > CC: kbuild-all@01.org
> > CC: linux-input@vger.kernel.org
> > TO: Quentin Schulz <quentin.schulz@free-electrons.com>
> > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> > head:   448f587d525d4fb5bda4b521e35ad6f15050cebd
> > commit: 2ebdfecef50840a9c6fd6a2236a1bdf2942dc1a7 [1901/1903] Input: axp20x-pek - use driver_data of platform_device_id instead of extended attributes
> > :::::: branch date: 83 minutes ago
> > :::::: commit date: 83 minutes ago
> > 
> >>> drivers/input/misc/axp20x-pek.c:385:1-2: axp_pek_id_match is not NULL terminated at line 385
> > 
> > # https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?id=2ebdfecef50840a9c6fd6a2236a1bdf2942dc1a7
> > git remote add input https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> > git remote update input
> > git checkout 2ebdfecef50840a9c6fd6a2236a1bdf2942dc1a7
> > vim +385 drivers/input/misc/axp20x-pek.c
> > 
> > 58be7689 Hans de Goede  2017-06-02  380
> > 2ebdfece Quentin Schulz 2017-08-14  381  static const struct platform_device_id axp_pek_id_match[] = {
> > 2ebdfece Quentin Schulz 2017-08-14  382  	{
> > 2ebdfece Quentin Schulz 2017-08-14  383  		.name = "axp20x-pek",
> > 2ebdfece Quentin Schulz 2017-08-14  384  		.driver_data = (kernel_ulong_t)&axp20x_info,
> > 2ebdfece Quentin Schulz 2017-08-14 @385  	},
> > 2ebdfece Quentin Schulz 2017-08-14  386  };
> > 2ebdfece Quentin Schulz 2017-08-14  387
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> > 
> 
> -- 
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Dmitry
