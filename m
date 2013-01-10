From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V4 0/4] input: keyboard: tegra: cleanups and DT supports
Date: Thu, 10 Jan 2013 09:44:56 -0800
Message-ID: <20130110174456.GA2797@core.coreip.homeip.net>
References: <1357470900-12619-1-git-send-email-ldewangan@nvidia.com>
 <50EAFD36.9070909@wwwdotorg.org>
 <50EE603B.7080702@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50EE603B.7080702@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Laxman,

On Thu, Jan 10, 2013 at 12:01:23PM +0530, Laxman Dewangan wrote:
> Hi Dmitry,
> 
> On Monday 07 January 2013 10:22 PM, Stephen Warren wrote:
> >On 01/06/2013 04:14 AM, Laxman Dewangan wrote:
> >>This patch series:
> >>  - fix build warning,
> >>  - use devm_* for allocation,
> >>  - make column/rows configuration through DT and
> >>  - remove the rarely used  key mapping table.
> >The series,
> >Reviewed-by: Stephen Warren <swarren@nvidia.com>
> >
> 
> If you are fine with this series then can it be apply please? I can
> handle if there is any comment on this series to close this.
> 

The patches are applied with minor edits to the 3rd and 4th (there was
no point in having a separate keymap setup function anymore).

Thanks.

-- 
Dmitry
