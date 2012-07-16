From: Jian-Jhong Ding <jj_ding@emc.com.tw>
Subject: Re: On the fly input_set_abs_params changes
Date: Mon, 16 Jul 2012 13:17:12 +0800
Message-ID: <87liiknv3b.fsf@emc.com.tw>
References: <50031664.6090302@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:51156 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab2GPF1Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 01:27:24 -0400
In-Reply-To: <50031664.6090302@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>, linux-input@vger.kernel.org

Hi Yann,

Yann Cantin <yann.cantin@laposte.net> writes:
> Hi,
>
> I'm working on a kernel input driver for eBeam devices (see http://www.e-beam.com).
>
> This hardware is very special, and his handling don't fit in any existing category
> (or i've not found it yet).
>
> I'm wondering if it's ok to change min/max parameters after registration, and how
> it should be handled by xorg's evdev.

I am really intrigued why you have to do this. Some specific feature of
your device? Can you elaborate more on this?

> I've some other input related questions, is it the right place to post ?

This list is all about Linux input subsystem, HID devices, etc. More on
the kernel side, of course. ;-)

Thank you,
-JJ

> -- 
> Yann Cantin
> A4FEB47F
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
