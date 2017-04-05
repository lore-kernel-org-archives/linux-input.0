From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Revert "Input: bma150 - avoid binding to bma180 if IIO bma180 driver present" and "Input: bma150 - extend chip detection for bma180"
Date: Wed, 5 Apr 2017 21:16:28 +0200
Message-ID: <C162E895-4ECF-4047-AD75-3C358142CDBB@goldelico.com>
References: <631685e1205d8b1b45d61e57070310d89d535b74.1491057884.git.hns@goldelico.com> <cce3c9da-8092-1092-56f5-46afecffeb19@redhat.com> <20170401164632.GD17130@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:17740 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbdDETQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Apr 2017 15:16:40 -0400
In-Reply-To: <20170401164632.GD17130@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Aniroop Mathur <a.mathur@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org


> Am 01.04.2017 um 18:46 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> On Sat, Apr 01, 2017 at 04:59:26PM +0200, Hans de Goede wrote:
>> Hi,
>>=20
>> On 01-04-17 16:44, H. Nikolaus Schaller wrote:
>>> This reverts commit baf28d91e7b1 ("Input: bma150 - avoid binding to =
bma180 if IIO bma180 driver present")
>>> and commit ef3714fdbc8d ("Input: bma150 - extend chip detection for =
bma180")
>>>=20
>>> Rationale: initially (2012) the GTA04 device using a bma180 chip =
simply refereced
>>> the bma150 platform driver in its board file [1] which happened to =
work in all
>>> scenarios that were tested.
>>>=20
>>> When conversion to DT started (2014), we needed to make the driver =
be still
>>> recognised. Hence we introduced the compatibility to the bma180 chip =
in
>>> Linux 3.15-rc5 [2] without further checks if it is really 100% =
compatible. This
>>> worked flawlessly for years with the GTA04 device.
>>>=20
>>> Recently (2016), Hans de Goede pointed out that the chips are not as =
similar
>>> as they appeared and the driver works with the bma180 for the GTA04 =
only
>>> by good luck. He proposed to remove the bma180 support completely =
[3], but
>>> we still did need it until we have a replacement. Thus, a =
condifional compile
>>> was added.
>>>=20
>>> We have now developed a generic iio-input-bridge which works with =
any 2 or
>>> 3 axis iio based accelerometer. It has been tested on GTA04 and Pyra =
and
>>> works as expected. Therefore we can remove the bma180 support from =
this
>>> driver completely. User-space API compatibility can be restored by =
using the
>>> iio-input-bridge.
>>>=20
>>> Maybe it is time to convert the bma150 driver to iio as well and =
retire the
>>> accelerometer input drivers completely but this is a different story =
and task.
>>>=20
>>> [1]: =
https://github.com/neilbrown/linux/blob/gta04/3.2.y/arch/arm/mach-omap2/bo=
ard-omap3gta04.c#L976
>>> [2]: https://patchwork.kernel.org/patch/3961171/
>>> [3]: https://patchwork.kernel.org/patch/9325481/
>>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>=20
>> Looks good to me:
>>=20
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Changed subject slightly (we are not reverting because patches were
> defective, we are removing support for bma180), and applied.

Just noticed: the subject in linux-next has a typo:
Should IMHO be "Input: bma150 - remove support for bma180"

=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3Df069b5a0b27ad4a87e9351e54fbcab3d3f8a9fd5

thanks,
Nikolaus=
