From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Date: Wed, 4 Sep 2019 16:23:27 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909041623050.31470@cbobk.fhfr.pm>
References: <1566269763-26817-1-git-send-email-decui@microsoft.com> <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 3 Sep 2019, Dexuan Cui wrote:

> > Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> > 
> > This is a purely Hyper-V specific change.
> 
> Hi Jiri, Benjamin,
> Are you OK if this patch for the Hyper-V HID driver goes through the Hyper-V
> tree maintained by Sasha Levin? It's a purely Hyper-V change, and I have
> been using the patch for several months and there is no regression.

No problem with that. Feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

in that case.

Thanks,

-- 
Jiri Kosina
SUSE Labs
