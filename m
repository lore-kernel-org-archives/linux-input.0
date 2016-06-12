From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: [PATCH v3] hid-sony: Prevent crash when rumble effects are still
 loaded at USB disconnect
Date: Sun, 12 Jun 2016 12:01:31 +0200
Message-ID: <22b65c72-671a-51fc-db87-bdf9a927cf7f@m-reimer.de>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de>
 <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
 <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de>
 <01146ebc-3710-e3cd-812a-ca4f0ef84372@m-reimer.de>
 <768f4bf0-4b8d-7036-7ddd-1dc9ff4a171b@m-reimer.de>
 <650C9404-0604-4783-B8AC-A7FEC9A73676@gmail.com>
 <29a17dba-d98d-65a1-5949-2b74e00ecdf5@m-reimer.de>
 <a5670e69-cd2b-36c1-a3b6-5a11afedc16d@m-reimer.de>
 <575C4C44.4070401@gmail.com> <575C6345.6040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:47654 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbcFLKBq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2016 06:01:46 -0400
In-Reply-To: <575C6345.6040203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, jikos@kernel.org, dmitry.torokhov@gmail.com

On 06/11/2016 09:15 PM, Cameron Gutman wrote:
> Sorry, I misremembered what I thought I read in your email - you said=
 you didn't see a call to ml_ff_destroy()
> in the disconnect case.

I also don't see this call with the xpad driver!

> Though that is quite strange to me, as the comments on ff_device indi=
cate that it should be the right spot:
>
> 483  * @destroy: called by input core when parent input device is bei=
ng
> 484  *      destroyed

What does "input device is being destroyed" actually mean in this case?

I tried with the xpad driver and as long as fftest is running (it will=20
keep running until it detects that the device has been disconnected)=20
there is no ml_ff_destroy event. So, if I want, there can be hours=20
between actual USB disconnect and ml_ff_destroy.

So what does it mean to the kernel that fftest is keeping an open file=20
handle to this input device? Is it really gone if there is at least one=
=20
process still holding a reference to it?


And. It actually seems possible to trigger the bug with the xpad driver=
=2E=20
I didn't have the crash, but there is a good chance to get it. This is=20
what I managed to get:

[  267.006873] ml_effect_timer start
[  267.256399] ml_effect_timer end
[  268.286814] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[  268.331112] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[  268.384689] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[  268.452146] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[  273.813537] ml_effect_timer start
[  273.816845] usb =C8=B5=EF=BF=BD<: xpad_try_sending_next_out_packet -=
=20
usb_submit_urb failed with result -19
[  274.400668] ml_effect_timer end


Starting with 268.286814 the USB device is gone! That's why the xpad=20
driver is throwing errors.

Some time later at 273.813537 (USB device is gone!) there is a new call=
=20
to the timer callback. "Unfortunately" no crash.

> I want to be sure we're on the right track though. Can you please res=
olve the address in the RIP register to a
> line number in hid-sony.c?

Can you point me to some instructions on how to do this? The only way t=
o=20
debug things, I currently know, is the "good old print(f/k)" debugging.=
=2E.

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
