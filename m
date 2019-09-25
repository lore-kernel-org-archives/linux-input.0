From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
Date: Wed, 25 Sep 2019 19:53:22 +0000
Message-ID: <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568244952-66716-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, September 11, 2019 4:36 PM
>=20
> We need mousevsc_pm_notify() to make sure the pm_wakeup_hard_event()
> call
> does not prevent the system from entering hibernation: the hibernation
> is a relatively long process, which can be aborted by the call
> pm_wakeup_hard_event(), which is invoked upon mouse events.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This patch is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
> Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin=
's
> Hyper-V tree's hyperv-next branch [ ... snipped ...]
>=20
> I request this patch should go through Sasha's tree rather than the
> input subsystem's tree.
>=20
> Hi Jiri, Benjamin, can you please Ack?

Hi Jiri, Benjamin,
Can you please take a look at the patch?

Thanks,
-- Dexuan
