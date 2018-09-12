From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 02/17] compat_ioctl: move drivers to
 generic_compat_ioctl_ptrarg
Date: Wed, 12 Sep 2018 09:33:00 -0600
Message-ID: <20180912153300.GE5633@ziepe.ca>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912150142.157913-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912150142.157913-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alex Williamson <alex.williamson@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux1394-devel@lists.sourceforge.
List-Id: linux-input@vger.kernel.org

On Wed, Sep 12, 2018 at 05:01:03PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>  drivers/char/ppdev.c              | 12 +---------
>  drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
>  drivers/firewire/core-cdev.c      | 12 +---------
>  drivers/hid/usbhid/hiddev.c       | 11 +--------
>  drivers/hwtracing/stm/core.c      | 12 +---------
>  drivers/misc/mei/main.c           | 22 +----------------
>  drivers/mtd/ubi/cdev.c            | 36 +++-------------------------
>  drivers/net/tap.c                 | 12 +---------
>  drivers/staging/pi433/pi433_if.c  | 12 +---------
>  drivers/usb/core/devio.c          | 16 +------------
>  drivers/vfio/vfio.c               | 39 +++----------------------------
>  drivers/vhost/net.c               | 12 +---------
>  drivers/vhost/scsi.c              | 12 +---------
>  drivers/vhost/test.c              | 12 +---------
>  drivers/vhost/vsock.c             | 12 +---------
>  fs/fat/file.c                     | 13 +----------
>  16 files changed, 20 insertions(+), 237 deletions(-)
> 

> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 87a0ce47f201..a170f5ca7416 100644
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -678,20 +678,10 @@ static long vtpmx_fops_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vtpmx_fops_compat_ioctl(struct file *f, unsigned int ioctl,
> -					  unsigned long arg)
> -{
> -	return vtpmx_fops_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vtpmx_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = vtpmx_fops_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl = vtpmx_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  	.llseek = noop_llseek,
>  };

For vtpm:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Arnd, would you consider including a patch as part of/after this
series to make compat_ioctl in drivers/infiniband/core/uverbs_main.c
use this as well?  Looks like a bug too?

Thanks,
Jason
