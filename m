From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [input:next 1215/1216] drivers/tty/vt/keyboard.c:994:2: warning:
 (near initialization for 'kbd_led_triggers[0].trigger')
Date: Tue, 16 Jun 2015 15:03:23 -0700
Message-ID: <20150616220323.GA17610@dtor-ws>
References: <201506170453.xHm7stex%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38123 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbFPWD2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 18:03:28 -0400
Received: by igblz2 with SMTP id lz2so24303894igb.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2015 15:03:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201506170453.xHm7stex%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kbuild-all@01.org, linux-input@vger.kernel.org

On Wed, Jun 17, 2015 at 04:02:55AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> head:   f3de1613abd5085b1f36eb6007e3484708719590
> commit: 17155b6144843281a199ef626fe294a752fd3ff5 [1215/1216] tty/vt/keyboard: define LED triggers for VT LED states
> config: x86_64-randconfig-i0-201524 (attached as .config)
> reproduce:
>   git checkout 17155b6144843281a199ef626fe294a752fd3ff5
>   # save the attached .config to linux build tree
>   make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/list.h:8:0,
>                     from include/linux/module.h:9,
>                     from drivers/tty/vt/keyboard.c:28:
>    drivers/tty/vt/keyboard.c: In function 'kbd_led_trigger_activate':
>    drivers/tty/vt/keyboard.c:975:20: error: 'struct led_classdev' has no member named 'trigger'
>       container_of(cdev->trigger, struct kbd_led_trigger, trigger);

I fixed it up by adding "&& IS_ENABLED(CONFIG_LEDS_TRIGGERS)" to the
ifdef block.

Thanks.

-- 
Dmitry
