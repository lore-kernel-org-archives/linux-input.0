From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bug in i2c-core?
Date: Fri, 27 Feb 2015 09:01:07 -0800
Message-ID: <20150227170107.GB6679@dtor-ws>
References: <54F0507F.6030804@armadeus.com>
 <20150227165944.GA6679@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:32891 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbbB0RBO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 12:01:14 -0500
Content-Disposition: inline
In-Reply-To: <20150227165944.GA6679@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?S=E9bastien?= SZYMANSKI <sebastien.szymanski@armadeus.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, laurent.pinchart+renesas@ideasonboard.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Fri, Feb 27, 2015 at 08:59:44AM -0800, Dmitry Torokhov wrote:
> On Fri, Feb 27, 2015 at 12:09:51PM +0100, S=E9bastien SZYMANSKI wrote=
:
> > Hi,
> >=20
> > I am writing an I2C touchscreen driver for an i.MX6 based board. I
> > compiled it as a module and when I unload it, I get the following w=
arning:
> >=20
> > # modprobe sx8654
> > [   46.261494] input: SX8654 I2C Touchscreen as
> > /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/i=
nput1
> > # rmmod sx8654
> > [   76.435223] ------------[ cut here ]------------
> > [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> > remove_proc_entry+0x148/0x164()
> > [   76.448582] remove_proc_entry: removing non-empty directory
> > 'irq/208', leaking at least 'sx8654'
>=20
> ...
>=20
> > When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> > client removal time) I don't get the warning.
> >=20
> > Is this a bug in the i2c-core or am I doing something wrong in my d=
river?
>=20
> Yes, this commit breaks all drivers using devm* for IRQ management on
> OF-based systemsi because devm* cleanup happens in device code, after
> bus's remove() method returns. I'd recommend reverting and finding a
> better way (making cleanup a custom devm action as well?).
>=20

Also it seems that the original patch is incomplete as I do not see us
disposing the mapping when probe fails...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
