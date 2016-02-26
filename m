From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
 file
Date: Fri, 26 Feb 2016 09:52:47 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1602260951390.2614@hadrien>
References: <201602261633.y2ggBswA%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:18904
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699AbcBZIwx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 03:52:53 -0500
In-Reply-To: <201602261633.y2ggBswA%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: kbuild-all@01.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org, scott.liu@emc.com.tw, jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Please adjust the indentation.

julia

On Fri, 26 Feb 2016, kbuild test robot wrote:

> Hi jeffrey.lin,
>
> [auto build test WARNING on input/next]
> [also build test WARNING on v4.5-rc5 next-20160226]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/jeffrey-lin/driver-input-touchscreen-add-Raydium-I2C-touch-driver-file/20160226-152542
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> :::::: branch date: 64 minutes ago
> :::::: commit date: 64 minutes ago
>
> >> drivers/input/touchscreen/raydium_i2c_ts.c:536:3-12: code aligned with following code on line 538
>
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 18ddd28567d08b114b576e801475d6d7209f76f5
> vim +536 drivers/input/touchscreen/raydium_i2c_ts.c
>
> 18ddd285 jeffrey.lin 2016-02-26  530
> 18ddd285 jeffrey.lin 2016-02-26  531  		input_mt_slot(ts->input, i);
> 18ddd285 jeffrey.lin 2016-02-26  532  		input_mt_report_slot_state(ts->input,
> 18ddd285 jeffrey.lin 2016-02-26  533  				MT_TOOL_FINGER, f_state != 0);
> 18ddd285 jeffrey.lin 2016-02-26  534
> 18ddd285 jeffrey.lin 2016-02-26  535  		if (!f_state)
> 18ddd285 jeffrey.lin 2016-02-26 @536  			continue;
> 18ddd285 jeffrey.lin 2016-02-26  537
> 18ddd285 jeffrey.lin 2016-02-26 @538  			x = (data->x_pos_msb << 8) | (data->x_pos_lsb);
> 18ddd285 jeffrey.lin 2016-02-26  539  			y = (data->y_pos_msb << 8) | (data->y_pos_lsb);
> 18ddd285 jeffrey.lin 2016-02-26  540
> 18ddd285 jeffrey.lin 2016-02-26  541  			input_report_key(ts->input,
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
