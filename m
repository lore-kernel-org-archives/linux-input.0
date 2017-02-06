From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/10] Input: synaptics-rmi4 - f30/f03: Forward
 mechanical buttons on buttonpads to PS/2 guest
Date: Mon, 6 Feb 2017 11:23:27 -0800
Message-ID: <20170206192327.GA17441@dtor-ws>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
 <20170110161128.7441-4-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34851 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdBFTXb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2017 14:23:31 -0500
Content-Disposition: inline
In-Reply-To: <20170110161128.7441-4-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>, Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Benjamin,

On Tue, Jan 10, 2017 at 05:11:21PM +0100, Benjamin Tissoires wrote:
> +void rmi_f03_commit_buttons(struct rmi_function *fn)
> +{
> +	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
> +	int i;
> +
> +	f03->serio->extra_byte = f03->overwrite_buttons;
> +
> +	for (i = 0; i < 3; i++)
> +		serio_interrupt(f03->serio, 0x00, 0x00);

How does this work with protocols larger than 3 bytes (i.e. anything but
bare PS/2)? Or F03 limits the kind of devices we connect to RMI4 device?

Overall, I am very uncomfortable with the concept of "extra byte" at
serio level. Maybe we should define a new flag, something like
SERIO_SYNTHETIC or SERIO_OOB_DATA, and have something like:

void rmi_f03_commit_buttons(struct rmi_function *fn)
{
	struct serio *serio = f03->serio;

	serio_pause_rx(serio);
	if (serio->drv) {
		serio->drv->interrupt(serio, PSMOUSE_EXTRA_BTNS,
				      SERIO_OOB_DATA);
		serio->drv->interrupt(serio, f03->overwrite_buttons.
				      SERIO_OOB_DATA);
	}
	serio_pause_rx(serio);
}

and have psmouse driver store and use it as it sees fit.

Thanks.

-- 
Dmitry
