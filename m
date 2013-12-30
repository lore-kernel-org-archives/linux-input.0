From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: hello, please help me check this potential bug, thanks.
Date: Mon, 30 Dec 2013 14:45:08 +0100
Message-ID: <52C178E4.3060201@metafoo.de>
References: <52C11B36.167D70.09200@tsinghua.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:43995 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755907Ab3L3Nms (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 08:42:48 -0500
In-Reply-To: <52C11B36.167D70.09200@tsinghua.edu.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Huqiu Liu <liuhq11@mails.tsinghua.edu.cn>
Cc: yinj2010@gmail.com, Linux Input <linux-input@vger.kernel.org>

Added linux-input to Cc

On 12/30/2013 08:05 AM, Huqiu Liu wrote:
> Dear Lars-Peter Clausen,
> I'm very sorry to trouble you. Recently I checked lots of drivers and found the
> following potential bug:
> 1) In the file _/drivers\input\misc\pwm-beeper.c/_, the function
> *input_allocate_device * is called by the function *pwm_beeper_probe*. While the
> function *pwm_beeper_remove * does not call the function *input_free_device * to
> release the acquired resources when removing the device. Generelly the function
> *input_free_device * and *input_allocate_device * should be used in pairs, and
> more than *109 * drivers have called the function *input_free_device * to
> release the resources which are acquired by the function *input_allocate_device*.
> The acqured resources are ignored to be released when removing the device, which
> would cause memory leaks and other potential problems. Could you help me to
> check or confirm this bug please? Thank you very much. I'm looking forward to
> your reply.

I think the code is corect. See the input_allocate_device() documentation:

  * input_allocate_device - allocate memory for new input device
  *
  * Returns prepared struct input_dev or %NULL.
  *
  * NOTE: Use input_free_device() to free devices that have not been
  * registered; input_unregister_device() should be used for already
  * registered devices.

- Lars

