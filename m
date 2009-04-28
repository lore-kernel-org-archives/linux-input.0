From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: problem of writing a virtual ps2 mouse driver
Date: Tue, 28 Apr 2009 06:18:24 -0700
Message-ID: <200904280618.24663.dmitry.torokhov@gmail.com>
References: <9A03B08F-52D1-4A83-B060-D0DE111E0064@cic.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:38651 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753762AbZD1NSZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2009 09:18:25 -0400
Content-Disposition: inline
In-Reply-To: <9A03B08F-52D1-4A83-B060-D0DE111E0064@cic.org.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chang yao chung <yaochung@cic.org.tw>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Apr 27, 2009 at 03:18:07PM +0800, chang yao chung wrote:
> Hi all
>
> I want to write a virtual PS/2 mouse driver to hook to the input core=
, =20
> after I load the driver
> The psmouse input device driver probes my virtual device as a =E2=80=9C=
Generic =20
> PS/2 mouse=E2=80=9D in /dev/input/mouse1
> And sent a F4 (mouse enable command) to my pseudo device.
>
> I use a user space program to send the following mouse movement packe=
t =20
> and launch
> gpm =E2=80=93m /dev/input/mouse1 =E2=80=93t ps2
>
> but when I run the user space program , there is no mouse movement ev=
ent=20
> occurred,

Do you see any data coming out if you just do a 'cat /dev/input/mouse1'=
?
Are you positive that mouse1 is bound to your virtual device?

> is there anything wrong with my code using serio_interrupt () ?
>

=2E..

>
> static ssize_t
> write_vms (struct device *dev, struct device_attribute *attr, const c=
har=20
> *buffer, size_t count)
> {
>         int x, y;
>         sscanf (buffer, "%x", &x);

You don't read 'y' coordinate and below pass garbage to serio, users
is likely to reject packets that are suspicious.

>         serio_interrupt (dev, 0x8, 0 , NULL);
>         serio_interrupt (dev, x, NULL);

=46irst question - does it even compile? I don't think so given that yo=
u
trying to pass either 3 or 4 arguments to it.

>         serio_interrupt (dev, y, 0, NULL);
>         serio_interrupt (dev, 0, 0, NULL);

You also need to decide the flavor of PS/2 protocol you are trying to
support. You seem to be aiming for ImPS/2 with 0 4th byte but don't
respond to ImPS/2 probes which will confuse users.

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
