From: ulrik.debie-os@e2big.org
Subject: Re: add Fujitsu Lifebook E546 to force crc_enabled
Date: Mon, 15 May 2017 21:24:05 +0200
Message-ID: <20170515192404.z47o3z2loyw2vci3@beacon.debie>
References: <CAKtuzf7M0oGPA=vny7fO6dTiKcPiSTZ3Xn=_TqBuEp6hvu4DTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:34409 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964880AbdEOTYL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 May 2017 15:24:11 -0400
Content-Disposition: inline
In-Reply-To: <CAKtuzf7M0oGPA=vny7fO6dTiKcPiSTZ3Xn=_TqBuEp6hvu4DTA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dimitar Petrovski <dimeptr@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dimitar,

I just was busy preparing a patch for Lifebook e557.

Can you please give the following information to make the patch complete ?

- Look at dmesg:

  * What number reports the driver as the firmware version of your touchpad?
    (It looks like "with firmware version 0x??????")

  * What is the Synaptics capabilities query result?
    (Three numbers like 0x??, 0x??, 0x??)

- What hardware buttons does your touchpad have? Two distinct left and right
  buttons, or three, or can you click down on the whole touchpad (a so
  called clickpad)?

- What is the output of

    cat /sys/devices/virtual/dmi/id/sys_vendor

- What is the output of

    cat /sys/devices/virtual/dmi/id/product_name

Thanks,
Ulrik

On Sun, May 14, 2017 at 11:36:56AM +0200, Dimitar Petrovski wrote:
> Date:   Sun, 14 May 2017 11:36:56 +0200
> From: Dimitar Petrovski <dimeptr@gmail.com>
> To: linux-input@vger.kernel.org
> Subject: add Fujitsu Lifebook E546 to force crc_enabled
> X-Mailing-List: linux-input@vger.kernel.org
> 
> Hi,
> 
> I have seen this messages https://patchwork.kernel.org/patch/9645671/
> about adding Fujitsu Lifebook E547 to force crc_enabled.
> I own Fujitsu Lifebook E546 and I have the same problem, I currently
> force crc_enabled through rc.local, but I think it should also be
> included in the kernel.
> 
> Regards,
> Dimitar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
