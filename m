From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx51 crashes at gpio_keys_probe
Date: Thu, 2 Aug 2012 20:58:37 -0300
Message-ID: <CAOMZO5C_x=1KhgofYAV9oKYVvCYB_37mBj-wak9rf5VcUODUCg@mail.gmail.com>
References: <CAOMZO5D9CZ2=ON2zNxcMa+PW549NE12=aeS522cor67F8Soaww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41765 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab2HBX6h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Aug 2012 19:58:37 -0400
Received: by ghrr11 with SMTP id r11so142985ghr.19
        for <linux-input@vger.kernel.org>; Thu, 02 Aug 2012 16:58:37 -0700 (PDT)
In-Reply-To: <CAOMZO5D9CZ2=ON2zNxcMa+PW549NE12=aeS522cor67F8Soaww@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, rob.herring@calxeda.com
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, aletes.xgr@gmail.com

On Thu, Aug 2, 2012 at 7:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Running today's linux-next on a imx51-babbage board I get the
> following (with a dt kernel):
>
> ...
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> pgd = 80004000
> [00000004] *pgd=00000000
> Internal error: Oops: 805 [#1] ARM
> Modules linked in:

Reverting 30161f6b2e7d1 (Input: gpio_keys - clean up device tree
parser ) fixes the issue for me.
