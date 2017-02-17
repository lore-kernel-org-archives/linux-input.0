From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] xen,input: try to read screen resolution for
 xen-kbdfront
Date: Fri, 17 Feb 2017 11:48:15 -0800
Message-ID: <20170217194815.GC13050@dtor-ws>
References: <20170130151052.20296-1-jgross@suse.com>
 <d5de4a65-2085-47e3-e57a-2b7a239ed8dd@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d5de4a65-2085-47e3-e57a-2b7a239ed8dd@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 17, 2017 at 10:08:58AM +0100, Juergen Gross wrote:
> On 30/01/17 16:10, Juergen Gross wrote:
> > Instead of using the default resolution of 800*600 for the pointing
> > device of xen-kbdfront try to read the resolution of the (virtual)
> > framebuffer device. Use the default as fallback only.
> > 
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Dmitry, any comment from you?
> 
> In case you don't object I can carry this patch through the Xen tree.

Sorry, yes, I still object. I replied in the other thread.

Thanks.

-- 
Dmitry
