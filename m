From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/2] xen,input: xen-kbdfront pointing device resolution
 support
Date: Tue, 4 Apr 2017 13:58:57 +0200
Message-ID: <ffacba2c-e86f-eacc-b76c-8434871022a3@suse.com>
References: <20170321171905.31584-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321171905.31584-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On 21/03/17 18:19, Juergen Gross wrote:
> As my patch tying the resolution of the xen pointing device to that of
> the framebuffer wasn't accepted add support for different resolutions
> via a module parameter.
> 
> Another possibility would be to set parameters via Xenstore, but this
> is broken (patch 2 fixes that) and not yet supported by Xen tools.
> 
> Juergen Gross (2):
>   xen,input: add xen-kbdfront module parameter for setting resolution
>   xen,input: repair xen-kbdfront resolution setting via xenstore
> 
>  drivers/input/misc/xen-kbdfront.c | 42 ++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 

Ping?


Juergen
