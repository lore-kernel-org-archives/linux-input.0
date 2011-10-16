From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] Staging: hv: mousevsc: Move the mouse driver out of
	staging
Date: Mon, 17 Oct 2011 01:28:47 +0300
Message-ID: <20111016222847.GM18470@longonot.mountain>
References: <1318658907-16698-1-git-send-email-kys@microsoft.com>
	<1318660596.6035.27.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1318660596.6035.27.camel@Joe-Laptop>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Joe Perches <joe@perches.com>
Cc: gregkh@suse.de, Haiyang Zhang <haiyangz@microsoft.com>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, devel@linuxdriverproject.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 14, 2011 at 11:36:36PM -0700, Joe Perches wrote:
> This do {} while (1); seems like it could be simpler,
> less indented and less confusing if it used continues
> or gotos like below (if I wrote it correctly...)
> 
> loop:
> 	ret = vmbus_bus_recvpacket_raw(device->channel, buffer,
> 				       bufferlen, &bytes_recvd, &req_id);
> 	switch (ret) {
> 	case -ENOBUFS:
> 		/* Handle large packet */
> 		bufferlen = bytes_recvd;
> 		buffer = kzalloc(bytes_recvd, GFP_ATOMIC);
> /*
> Why kzalloc and not kmalloc?
> The stack variable packet is not memset to 0,
> why should buffer be zeroed?
> */
> 		if (!buffer)
> 			return;
> 		goto loop;
> 	case 0:
> 		if (bytes_recvd <= 0)
> 			goto loop;

In the original we called break here (which is equivelent to a
return).  Btw setting a stack variable and then returning immediately
like the original code did is pointless.

regards,
dan carpenter
