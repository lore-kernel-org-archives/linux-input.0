From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] Add Cobalt button interface driver support
Date: Thu, 26 Apr 2007 15:40:25 +0900
Message-ID: <200704260640.l3Q6eP6R020764@mbox32.po.2iij.net>
References: <20070216123608.733f04a3.yoichi_yuasa@tripeaks.co.jp>
	<200704040001.41494.dtor@insightbb.com>
	<200704050502.l3552gss048910@mbox31.po.2iij.net>
	<200704250134.33610.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704250134.33610.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, 25 Apr 2007 01:34:33 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> Hi Yoichi,
> 
> On Thursday 05 April 2007 01:02, Yoichi Yuasa wrote:
> > Hi Dmitry,
> > 
> > On Wed, 4 Apr 2007 00:01:41 -0400
> > Dmitry Torokhov <dtor@insightbb.com> wrote:
> > 
> > > Hi Yoichi,
> > > 
> > > Could you please try the patch below? It moves platform device creation
> > > code into cobalt arch code to belletr follow driver model.
> > 
> > It works fine.
> >
> 
> Coudl you please try couple more patches, please? I wrote a generic
> stub for polled (as opposed to interrupt-driven) input devices and
> converting existing drivers to use it. Cobalt buttons seem to be
> a good candidate...

Looks good to me and works fine.

Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Thanks for your great work,

Yoichi
