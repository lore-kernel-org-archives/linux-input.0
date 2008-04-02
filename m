From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Fix tosakbd suspend
Date: Wed, 2 Apr 2008 19:06:24 +0400
Message-ID: <bc64b4640804020806y2dc68600k8179092c9c4a100e@mail.gmail.com>
References: <20080401144224.GA6436@USFSHXP-002051>
	 <20080402141632.GA19698@doriath.ww600.siemens.net>
	 <bc64b4640804020738l25b51263la04cff12c38e0325@mail.gmail.com>
	 <20080402104921.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757902AbYDBPGf@vger.kernel.org>
In-Reply-To: <20080402104921.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

2008/4/2, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Wed, Apr 02, 2008 at 06:38:26PM +0400, Dmitry wrote:
>  > Hi,
>  >
>  > Sorry, that was me... Sometimes I hate git-am & git-format-patch
>  >
>
>
> Heh, you had me scratching my head for a moment ;)

:)

>
>  > 2008/4/2, <dbaryshkov@gmail.com>:
>
> > >
>  > > Fixed two minor glitches. Works for me. Please add it to your tree.
>  > >
>
>
> What were they? I dont see any difference from the patch I sent to you,
>  so I want to make sure I have the correct version.

suspended instead of suspeneded in struct tosakbd definition,
declaration of tosakbd in tosakbd_resume.

-- 
With best wishes
Dmitry
