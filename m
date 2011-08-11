From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH RESEND] Input: tegra-kbc - correct call to
 input_free_device
Date: Thu, 11 Aug 2011 10:14:17 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24C2F@HQMAIL01.nvidia.com>
References: <1313052569.2139.1.camel@phoenix>
 <74CDBE0F657A3D45AFBB94109FB122FF04AEA24C0A@HQMAIL01.nvidia.com>
 <20110811165134.GA24861@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110811165134.GA24861@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rakesh Iyer <riyer@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote at Thursday, August 11, 2011 10:52 AM:
> On Thu, Aug 11, 2011 at 09:42:54AM -0700, Stephen Warren wrote:
> > Axel Lin wrote at Thursday, August 11, 2011 2:49 AM:
> > > If kzalloc for kbc fails, then we have NULL pointer dereference while
> > > calling input_free_device(kbc->idev) in the error handling.
> > > So it is safer to always use the original name, input_dev.
> > >
> > > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >
> > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> Gah, sorry, already pushed into my public branch so won't be able so
> add your reviewed-by...

No worries; you had no reason to expect anyone to review it!

-- 
nvpublic
