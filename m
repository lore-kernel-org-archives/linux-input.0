From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug in i2c-core?
Date: Fri, 27 Feb 2015 08:59:44 -0800
Message-ID: <20150227165944.GA6679@dtor-ws>
References: <54F0507F.6030804@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F0507F.6030804-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?S=E9bastien?= SZYMANSKI <sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 27, 2015 at 12:09:51PM +0100, S=E9bastien SZYMANSKI wrote:
> Hi,
>=20
> I am writing an I2C touchscreen driver for an i.MX6 based board. I
> compiled it as a module and when I unload it, I get the following war=
ning:
>=20
> # modprobe sx8654
> [   46.261494] input: SX8654 I2C Touchscreen as
> /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/inp=
ut1
> # rmmod sx8654
> [   76.435223] ------------[ cut here ]------------
> [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> remove_proc_entry+0x148/0x164()
> [   76.448582] remove_proc_entry: removing non-empty directory
> 'irq/208', leaking at least 'sx8654'

=2E..

> When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> client removal time) I don't get the warning.
>=20
> Is this a bug in the i2c-core or am I doing something wrong in my dri=
ver?

Yes, this commit breaks all drivers using devm* for IRQ management on
OF-based systemsi because devm* cleanup happens in device code, after
bus's remove() method returns. I'd recommend reverting and finding a
better way (making cleanup a custom devm action as well?).

Thanks.

--=20
Dmitry
