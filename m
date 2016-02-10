From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v4 07/10] Input: synaptics-rmi4: Add support for F30
 (fwd)
Date: Wed, 10 Feb 2016 07:46:43 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1602100745130.2050@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49698 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550AbcBJGqr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2016 01:46:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org

Please check.  It looks quite possible that something else was intended.

julia

-----------------------------------------

Hi Andrew,

[auto build test WARNING on input/next]
[also build test WARNING on v4.5-rc3 next-20160209]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Andrew-Duggan/Input-synaptics-rmi4-Synaptics-RMI4-Driver/20160210-094628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
:::::: branch date: 83 minutes ago
:::::: commit date: 83 minutes ago

>> drivers/input/rmi4/rmi_f30.c:280:5-17: duplicated argument to && or ||

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 4d35b26e3aa9c79b321a4766aaa7776459f29aa1
vim +280 drivers/input/rmi4/rmi_f30.c

4d35b26e Andrew Duggan 2016-02-09  264  
4d35b26e Andrew Duggan 2016-02-09  265  	f30->has_extended_pattern = buf[0] & RMI_F30_EXTENDED_PATTERNS;
4d35b26e Andrew Duggan 2016-02-09  266  	f30->has_mappable_buttons = buf[0] & RMI_F30_HAS_MAPPABLE_BUTTONS;
4d35b26e Andrew Duggan 2016-02-09  267  	f30->has_led = buf[0] & RMI_F30_HAS_LED;
4d35b26e Andrew Duggan 2016-02-09  268  	f30->has_gpio = buf[0] & RMI_F30_HAS_GPIO;
4d35b26e Andrew Duggan 2016-02-09  269  	f30->has_haptic = buf[0] & RMI_F30_HAS_HAPTIC;
4d35b26e Andrew Duggan 2016-02-09  270  	f30->has_gpio_driver_control = buf[0] & RMI_F30_HAS_GPIO_DRV_CTL;
4d35b26e Andrew Duggan 2016-02-09  271  	f30->has_mech_mouse_btns = buf[0] & RMI_F30_HAS_MECH_MOUSE_BTNS;
4d35b26e Andrew Duggan 2016-02-09  272  	f30->gpioled_count = buf[1] & RMI_F30_GPIO_LED_COUNT;
4d35b26e Andrew Duggan 2016-02-09  273  
4d35b26e Andrew Duggan 2016-02-09  274  	f30->register_count = (f30->gpioled_count + 7) >> 3;
4d35b26e Andrew Duggan 2016-02-09  275  
4d35b26e Andrew Duggan 2016-02-09  276  	control_address = fn->fd.control_base_addr;
4d35b26e Andrew Duggan 2016-02-09  277  	ctrl_reg = f30->ctrl_regs;
4d35b26e Andrew Duggan 2016-02-09  278  
4d35b26e Andrew Duggan 2016-02-09  279  	/* Allocate buffers for the control registers */
4d35b26e Andrew Duggan 2016-02-09 @280  	if (f30->has_led && f30->has_led)
4d35b26e Andrew Duggan 2016-02-09  281  		rmi_f30_set_ctrl_data(&f30->ctrl[0], &control_address,
4d35b26e Andrew Duggan 2016-02-09  282  					f30->register_count, &ctrl_reg);
4d35b26e Andrew Duggan 2016-02-09  283  
4d35b26e Andrew Duggan 2016-02-09  284  	rmi_f30_set_ctrl_data(&f30->ctrl[1], &control_address, sizeof(u8),
4d35b26e Andrew Duggan 2016-02-09  285  				&ctrl_reg);
4d35b26e Andrew Duggan 2016-02-09  286  
4d35b26e Andrew Duggan 2016-02-09  287  	if (f30->has_gpio) {
4d35b26e Andrew Duggan 2016-02-09  288  		rmi_f30_set_ctrl_data(&f30->ctrl[2], &control_address,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
