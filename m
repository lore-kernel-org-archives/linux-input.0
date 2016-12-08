From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8] Input: synaptics-rmi4 - add support for F34 V7
 bootloader
Date: Wed, 7 Dec 2016 18:14:18 -0800
Message-ID: <20161208021418.GD27638@dtor-ws>
References: <1480899769-31330-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34346 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933023AbcLHCOW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 21:14:22 -0500
Content-Disposition: inline
In-Reply-To: <1480899769-31330-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Nick,

On Mon, Dec 05, 2016 at 01:02:49AM +0000, Nick Dyer wrote:
> +static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
> +						       const u8 *image)
> +{
> +	int i;
> +	u8 num_of_containers;
> +	unsigned int addr;
> +	unsigned int container_id;
> +	unsigned int length;
> +	const u8 *content;
> +	struct container_descriptor *descriptor;
> +
> +	BUG_ON(f34->v7.img.bootloader.size < 4);
> +
> +	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;
> +
> +	for (i = 1; i <= num_of_containers; i++) {
> +		addr = le32_to_cpu(f34->v7.img.bootloader.data + (i * 4));

This cannot possibly be right. "f34->v7.img.bootloader.data + (i * 4)"
is a pointer in memory, you should not be converting it from le32.

Did you mean to use le32_to_cpup((__le32 *)(f34->v7.img.bootloader.data
+ (i * 4))) ?

Thanks.

-- 
Dmitry
