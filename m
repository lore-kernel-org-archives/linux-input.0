From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Date: Tue, 3 Sep 2019 00:43:34 +0000
Message-ID: <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <1566269763-26817-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566269763-26817-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, August 19, 2019 7:57 PM
> To: jikos@kernel.org; benjamin.tissoires@redhat.com;
> linux-input@vger.kernel.org; linux-hyperv@vger.kernel.org; Stephen
> Hemminger <sthemmin@microsoft.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>; sashal@kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Michael
> Kelley <mikelley@microsoft.com>
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>
> Subject: [PATCH] HID: hyperv: Use in-place iterator API in the channel ca=
llback
>=20
> Simplify the ring buffer handling with the in-place API.
>=20
> Also avoid the dynamic allocation and the memory leak in the channel
> callback function.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>=20
> This is a purely Hyper-V specific change.

Hi Jiri, Benjamin,
Are you OK if this patch for the Hyper-V HID driver goes through the Hyper-=
V
tree maintained by Sasha Levin? It's a purely Hyper-V change, and I have
been using the patch for several months and there is no regression.

Thanks,
-- Dexuan
