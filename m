From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input/vmmouse: Update the backdoor call with support
 for new instructions
Date: Wed, 21 Aug 2019 09:03:51 -0700
Message-ID: <20190821160351.GA76194@dtor-ws>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-5-thomas_os@shipmail.org>
 <20190821050925.GA566@penguin>
 <027a55d6-ab26-ef9c-bd89-93a38f96160b@shipmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <027a55d6-ab26-ef9c-bd89-93a38f96160b@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= <thomas_os@shipmail.org>
Cc: linux-kernel@vger.kernel.org, pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org, Doug Covelli <dcovelli@vmware.com>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 21, 2019 at 05:48:23PM +0200, Thomas Hellström (VMware) wrote:
> On 8/21/19 7:09 AM, Dmitry Torokhov wrote:
> > On Sun, Aug 18, 2019 at 04:33:16PM +0200, Thomas Hellström (VMware) wrote:
> > > From: Thomas Hellstrom <thellstrom@vmware.com>
> > > 
> > > Use the definition provided by include/asm/vmware.h
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: <linux-input@vger.kernel.org>
> > > Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> > > Reviewed-by: Doug Covelli <dcovelli@vmware.com>
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Please feel free to merge with the rest of the patches introducing
> > VMWARE_HYPERCALL.
> 
> Thanks, Dmitry!
> 
> I have a version 2 of the patch were the only difference is that edx is
> initialized to zero which is default for vmcall / vmmcall. Can I use your
> ack for that one as well?

Yes, sure.

-- 
Dmitry
