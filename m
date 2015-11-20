From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 1/5] Input: db9 - clear unused function pointers
Date: Fri, 20 Nov 2015 14:04:24 +0530
Message-ID: <20151120083424.GA4485@sudip-pc>
References: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151117180052.GB29423@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151117180052.GB29423@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Nov 17, 2015 at 10:00:52AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 17, 2015 at 07:10:15PM +0530, Sudip Mukherjee wrote:
> > db9_parport_cb is a local uninitialized structure and the member
> > function pointers will be pointing to arbitrary locations unless they
> > are cleared.
> > 
> > Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> 
> Applied all 5, thank you.

Thanks Dmitry. Hopefully this was the last of my careless mistakes.

regards
sudip
