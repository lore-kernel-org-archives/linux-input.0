From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 2/2] Input: synaptics-rmi4 - add support for F34 V7
 bootloader
Date: Tue, 22 Nov 2016 17:51:11 -0800
Message-ID: <20161123015111.GC21078@dtor-ws>
References: <1479668642-376-1-git-send-email-nick@shmanahar.org>
 <1479668642-376-3-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32849 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbcKWBvP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Nov 2016 20:51:15 -0500
Content-Disposition: inline
In-Reply-To: <1479668642-376-3-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Nick,

On Sun, Nov 20, 2016 at 07:04:02PM +0000, Nick Dyer wrote:
> +			/* query 7 */
> +			unsigned char f34_query7_b0:1;
> +			unsigned char has_bootloader:1;
> +			unsigned char has_device_config:1;
> +			unsigned char has_flash_config:1;
> +			unsigned char has_manufacturing_block:1;
> +			unsigned char has_guest_serialization:1;
> +			unsigned char has_global_parameters:1;
> +			unsigned char has_core_code:1;
> +			unsigned char has_core_config:1;
> +			unsigned char has_guest_code:1;
> +			unsigned char has_display_config:1;
> +			unsigned char f34_query7_b11__15:5;
> +			unsigned char f34_query7_b16__23;
> +			unsigned char f34_query7_b24__31;

I see bitfields and I think this is not going to work on big endian
arches because unfortunately they "fill" the bytes with bits in opposite
order.

We had to rework old Unixsphere code to get rid of bitfields for on-wire
data; this seems to be coming from that code base as well and so needs
to be reworked too.

Thanks.

-- 
Dmitry
