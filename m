From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: sh_keysc - Remove dependency on SUPERH
Date: Fri, 4 Mar 2016 11:22:01 -0800
Message-ID: <20160304192201.GC17145@dtor-ws>
References: <1456966425-14664-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWdeZkjk++5kpPLH6vHvz=ZAPqFp8z9od+Y-=R1W8HCxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWdeZkjk++5kpPLH6vHvz=ZAPqFp8z9od+Y-=R1W8HCxA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 03, 2016 at 09:11:18AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 3, 2016 at 1:53 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > A dependency on ARCH_SHMOBILE seems to be the best option for sh_keysc:
> >
> > * For Super H based SoCs: sh_keysc is used on SH_MIGOR, SH_ECOVEC, SH_KFR2R09,
> >   SH_7722_SOLUTION_ENGINE, and SH_7724_SOLUTION_ENGINE, which depend on
> >   either CPU_SUBTYPE_SH7722 or CPU_SUBTYPE_SH7724, and both select
> >   ARCH_SHMOBILE.
> >
> > * For ARM Based SoCs: Since the removal of legacy (non-multiplatform) support
> >   this driver has not been used by any Renesas ARM based SoCs. The Renesas
> >   ARM based SoCs currently select ARCH_SHMOBILE, however, it is planned
> >   that this will no longer be the case.
> >
> > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
