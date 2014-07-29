From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 0/7] Second batch of cleanups for cros_ec
Date: Tue, 29 Jul 2014 14:58:11 +0200
Message-ID: <53D79A63.4010500@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk> <53D79328.8060609@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53D79328.8060609-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Andreas,

On 07/29/2014 02:27 PM, Andreas F=E4rber wrote:
> Hi Javier,
>=20
> Am 28.07.2014 14:19, schrieb Javier Martinez Canillas:
>> The patches in this series are authored by different people
>> (all on cc) and consist of the following:
>>=20
>> Andrew Bresticker (3):
>>   mfd: cros_ec: stop calling ->cmd_xfer() directly
>>   mfd: cros_ec: move locking into cros_ec_cmd_xfer
>>   mfd: cros_ec: wait for completion of commands that return IN_PROGR=
ESS
>>=20
>> Derek Basehore (1):
>>   i2c: i2c-cros-ec-tunnel: Set retries to 3
>>=20
>> Doug Anderson (1):
>>   mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC
>>=20
>> Todd Broch (2):
>>   mfd: cros_ec: Instantiate sub-devices from device tree
>>   Input: cros_ec_keyb: Optimize ghosting algorithm.
>=20
> When you submit other people's patches, I believe you still need to s=
ign
> them off as submitter. In particular when you rebased them.
>=20

You are right. I thought that given that I only rebased the patches and=
 removed
changes for files that are not yet in mainline I shouldn't add my s-o-b=
=2E

But looking at the Developer's Certificate of Origin 1.1 rule (b) it se=
ems that
I should had added my s-o-b as well.

> Regards,
> Andreas
>=20

Thanks a lot and best regards,
Javier
