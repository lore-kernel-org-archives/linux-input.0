From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] Input: tegra-kbc - report wakeup key for some
 platforms.
Date: Wed, 30 Nov 2011 23:26:49 -0800
Message-ID: <20111201072649.GE16816@core.coreip.homeip.net>
References: <1322685811-14060-1-git-send-email-riyer@nvidia.com>
 <20111130212022.GB3108@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D034F3D1BB4BD@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D034F3D1BB4BD-lR+7xdUAJVNDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org" <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 30, 2011 at 02:14:03PM -0800, Rakesh Iyer wrote:
> Thanks Dmitry.
> 
> Since there can be multiple wake causes I wanted to isolate wake key
> generation to the case where keyboard actually generated the wake
> interrupt.

I do not think you can guarantee this though because if user touches
keyboard "too early", before your resume method had a chance to disable
kbc interrupt as a wakeup source, you are still going to get that
interrupt and deliver KEY_POWER even though KBC is not the actual wakeup
source.

So don't over-complicate it. If hardware can't detect actual key pressed
just emit KEY_POWER if a key was at any time between calls to
tegra_kbc_suspend() and tegra_kbc_resume().

BTW, could you please have your MUA wrap long lines around 75 column or so?

Thanks.

-- 
Dmitry
