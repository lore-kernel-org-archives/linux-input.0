From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 09/26] compat_ioctl: move drivers to compat_ptr_ioctl
Date: Fri, 19 Apr 2019 19:16:42 -0400
Message-ID: <20190419191633-mutt-send-email-mst@kernel.org>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-10-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-10-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@mellanox.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Tomas Winkler <tomas.winkler@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:47PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
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
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 1ae77b41050a..e96c8d9623e0 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -674,14 +674,6 @@ static long pp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long pp_compat_ioctl(struct file *file, unsigned int cmd,
> -			    unsigned long arg)
> -{
> -	return pp_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static int pp_open(struct inode *inode, struct file *file)
>  {
>  	unsigned int minor = iminor(inode);
> @@ -790,9 +782,7 @@ static const struct file_operations pp_fops = {
>  	.write		= pp_write,
>  	.poll		= pp_poll,
>  	.unlocked_ioctl	= pp_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl   = pp_compat_ioctl,
> -#endif
> +	.compat_ioctl   = compat_ptr_ioctl,
>  	.open		= pp_open,
>  	.release	= pp_release,
>  };
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index d74f3de74ae6..fb845f0a430b 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -675,20 +675,10 @@ static long vtpmx_fops_ioctl(struct file *f, unsigned int ioctl,
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
> +	.compat_ioctl = compat_ptr_ioctl,
>  	.llseek = noop_llseek,
>  };
>  
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index 16a7045736a9..fb934680fdd3 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -1659,14 +1659,6 @@ static long fw_device_op_ioctl(struct file *file,
>  	return dispatch_ioctl(file->private_data, cmd, (void __user *)arg);
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long fw_device_op_compat_ioctl(struct file *file,
> -				      unsigned int cmd, unsigned long arg)
> -{
> -	return dispatch_ioctl(file->private_data, cmd, compat_ptr(arg));
> -}
> -#endif
> -
>  static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct client *client = file->private_data;
> @@ -1808,7 +1800,5 @@ const struct file_operations fw_device_ops = {
>  	.mmap		= fw_device_op_mmap,
>  	.release	= fw_device_op_release,
>  	.poll		= fw_device_op_poll,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= fw_device_op_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  };
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index a746017fac17..ef4a1cd389d6 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -855,13 +855,6 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	return r;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long hiddev_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	return hiddev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations hiddev_fops = {
>  	.owner =	THIS_MODULE,
>  	.read =		hiddev_read,
> @@ -871,9 +864,7 @@ static const struct file_operations hiddev_fops = {
>  	.release =	hiddev_release,
>  	.unlocked_ioctl =	hiddev_ioctl,
>  	.fasync =	hiddev_fasync,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= hiddev_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.llseek		= noop_llseek,
>  };
>  
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index c7ba8acfd4d5..454da259f144 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -840,23 +840,13 @@ stm_char_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	return err;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long
> -stm_char_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	return stm_char_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> -}
> -#else
> -#define stm_char_compat_ioctl	NULL
> -#endif
> -
>  static const struct file_operations stm_fops = {
>  	.open		= stm_char_open,
>  	.release	= stm_char_release,
>  	.write		= stm_char_write,
>  	.mmap		= stm_char_mmap,
>  	.unlocked_ioctl	= stm_char_ioctl,
> -	.compat_ioctl	= stm_char_compat_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.llseek		= no_llseek,
>  };
>  
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 87281b3695e6..cc6af92cdef0 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -535,24 +535,6 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
>  	return rets;
>  }
>  
> -/**
> - * mei_compat_ioctl - the compat IOCTL function
> - *
> - * @file: pointer to file structure
> - * @cmd: ioctl command
> - * @data: pointer to mei message structure
> - *
> - * Return: 0 on success , <0 on error
> - */
> -#ifdef CONFIG_COMPAT
> -static long mei_compat_ioctl(struct file *file,
> -			unsigned int cmd, unsigned long data)
> -{
> -	return mei_ioctl(file, cmd, (unsigned long)compat_ptr(data));
> -}
> -#endif
> -
> -
>  /**
>   * mei_poll - the poll function
>   *
> @@ -855,9 +837,7 @@ static const struct file_operations mei_fops = {
>  	.owner = THIS_MODULE,
>  	.read = mei_read,
>  	.unlocked_ioctl = mei_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl = mei_compat_ioctl,
> -#endif
> +	.compat_ioctl = compat_ptr_ioctl,
>  	.open = mei_open,
>  	.release = mei_release,
>  	.write = mei_write,
> diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> index 947a8adbc799..265d34fa3efa 100644
> --- a/drivers/mtd/ubi/cdev.c
> +++ b/drivers/mtd/ubi/cdev.c
> @@ -1091,36 +1091,6 @@ static long ctrl_cdev_ioctl(struct file *file, unsigned int cmd,
>  	return err;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vol_cdev_compat_ioctl(struct file *file, unsigned int cmd,
> -				  unsigned long arg)
> -{
> -	unsigned long translated_arg = (unsigned long)compat_ptr(arg);
> -
> -	return vol_cdev_ioctl(file, cmd, translated_arg);
> -}
> -
> -static long ubi_cdev_compat_ioctl(struct file *file, unsigned int cmd,
> -				  unsigned long arg)
> -{
> -	unsigned long translated_arg = (unsigned long)compat_ptr(arg);
> -
> -	return ubi_cdev_ioctl(file, cmd, translated_arg);
> -}
> -
> -static long ctrl_cdev_compat_ioctl(struct file *file, unsigned int cmd,
> -				   unsigned long arg)
> -{
> -	unsigned long translated_arg = (unsigned long)compat_ptr(arg);
> -
> -	return ctrl_cdev_ioctl(file, cmd, translated_arg);
> -}
> -#else
> -#define vol_cdev_compat_ioctl  NULL
> -#define ubi_cdev_compat_ioctl  NULL
> -#define ctrl_cdev_compat_ioctl NULL
> -#endif
> -
>  /* UBI volume character device operations */
>  const struct file_operations ubi_vol_cdev_operations = {
>  	.owner          = THIS_MODULE,
> @@ -1131,7 +1101,7 @@ const struct file_operations ubi_vol_cdev_operations = {
>  	.write          = vol_cdev_write,
>  	.fsync		= vol_cdev_fsync,
>  	.unlocked_ioctl = vol_cdev_ioctl,
> -	.compat_ioctl   = vol_cdev_compat_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  /* UBI character device operations */
> @@ -1139,13 +1109,13 @@ const struct file_operations ubi_cdev_operations = {
>  	.owner          = THIS_MODULE,
>  	.llseek         = no_llseek,
>  	.unlocked_ioctl = ubi_cdev_ioctl,
> -	.compat_ioctl   = ubi_cdev_compat_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  /* UBI control character device operations */
>  const struct file_operations ubi_ctrl_cdev_operations = {
>  	.owner          = THIS_MODULE,
>  	.unlocked_ioctl = ctrl_cdev_ioctl,
> -	.compat_ioctl   = ctrl_cdev_compat_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  	.llseek		= no_llseek,
>  };
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 2ea9b4976f4a..ebe425e65992 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1123,14 +1123,6 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long tap_compat_ioctl(struct file *file, unsigned int cmd,
> -			     unsigned long arg)
> -{
> -	return tap_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations tap_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= tap_open,
> @@ -1140,9 +1132,7 @@ static const struct file_operations tap_fops = {
>  	.poll		= tap_poll,
>  	.llseek		= no_llseek,
>  	.unlocked_ioctl	= tap_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= tap_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  };
>  
>  static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index b2314636dc89..ab7dfc7c2917 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -935,16 +935,6 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	return retval;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long
> -pi433_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> -{
> -	return pi433_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> -}
> -#else
> -#define pi433_compat_ioctl NULL
> -#endif /* CONFIG_COMPAT */
> -
>  /*-------------------------------------------------------------------------*/
>  
>  static int pi433_open(struct inode *inode, struct file *filp)
> @@ -1101,7 +1091,7 @@ static const struct file_operations pi433_fops = {
>  	.write =	pi433_write,
>  	.read =		pi433_read,
>  	.unlocked_ioctl = pi433_ioctl,
> -	.compat_ioctl = pi433_compat_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
>  	.open =		pi433_open,
>  	.release =	pi433_release,
>  	.llseek =	no_llseek,
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index fa783531ee88..d75052b36584 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -2568,18 +2568,6 @@ static long usbdev_ioctl(struct file *file, unsigned int cmd,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long usbdev_compat_ioctl(struct file *file, unsigned int cmd,
> -			unsigned long arg)
> -{
> -	int ret;
> -
> -	ret = usbdev_do_ioctl(file, cmd, compat_ptr(arg));
> -
> -	return ret;
> -}
> -#endif
> -
>  /* No kernel lock - fine */
>  static __poll_t usbdev_poll(struct file *file,
>  				struct poll_table_struct *wait)
> @@ -2603,9 +2591,7 @@ const struct file_operations usbdev_file_operations = {
>  	.read =		  usbdev_read,
>  	.poll =		  usbdev_poll,
>  	.unlocked_ioctl = usbdev_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl =   usbdev_compat_ioctl,
> -#endif
> +	.compat_ioctl =   compat_ptr_ioctl,
>  	.mmap =           usbdev_mmap,
>  	.open =		  usbdev_open,
>  	.release =	  usbdev_release,
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a3030cdf3c18..a5efe82584a5 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -1200,15 +1200,6 @@ static long vfio_fops_unl_ioctl(struct file *filep,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vfio_fops_compat_ioctl(struct file *filep,
> -				   unsigned int cmd, unsigned long arg)
> -{
> -	arg = (unsigned long)compat_ptr(arg);
> -	return vfio_fops_unl_ioctl(filep, cmd, arg);
> -}
> -#endif	/* CONFIG_COMPAT */
> -
>  static int vfio_fops_open(struct inode *inode, struct file *filep)
>  {
>  	struct vfio_container *container;
> @@ -1291,9 +1282,7 @@ static const struct file_operations vfio_fops = {
>  	.read		= vfio_fops_read,
>  	.write		= vfio_fops_write,
>  	.unlocked_ioctl	= vfio_fops_unl_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= vfio_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.mmap		= vfio_fops_mmap,
>  };
>  
> @@ -1572,15 +1561,6 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vfio_group_fops_compat_ioctl(struct file *filep,
> -					 unsigned int cmd, unsigned long arg)
> -{
> -	arg = (unsigned long)compat_ptr(arg);
> -	return vfio_group_fops_unl_ioctl(filep, cmd, arg);
> -}
> -#endif	/* CONFIG_COMPAT */
> -
>  static int vfio_group_fops_open(struct inode *inode, struct file *filep)
>  {
>  	struct vfio_group *group;
> @@ -1636,9 +1616,7 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
>  static const struct file_operations vfio_group_fops = {
>  	.owner		= THIS_MODULE,
>  	.unlocked_ioctl	= vfio_group_fops_unl_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= vfio_group_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.open		= vfio_group_fops_open,
>  	.release	= vfio_group_fops_release,
>  };
> @@ -1703,24 +1681,13 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>  	return device->ops->mmap(device->device_data, vma);
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vfio_device_fops_compat_ioctl(struct file *filep,
> -					  unsigned int cmd, unsigned long arg)
> -{
> -	arg = (unsigned long)compat_ptr(arg);
> -	return vfio_device_fops_unl_ioctl(filep, cmd, arg);
> -}
> -#endif	/* CONFIG_COMPAT */
> -
>  static const struct file_operations vfio_device_fops = {
>  	.owner		= THIS_MODULE,
>  	.release	= vfio_device_fops_release,
>  	.read		= vfio_device_fops_read,
>  	.write		= vfio_device_fops_write,
>  	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= vfio_device_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.mmap		= vfio_device_fops_mmap,
>  };
>  
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index df51a35cf537..1642b3573230 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1765,14 +1765,6 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vhost_net_compat_ioctl(struct file *f, unsigned int ioctl,
> -				   unsigned long arg)
> -{
> -	return vhost_net_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static ssize_t vhost_net_chr_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct file *file = iocb->ki_filp;
> @@ -1808,9 +1800,7 @@ static const struct file_operations vhost_net_fops = {
>  	.write_iter     = vhost_net_chr_write_iter,
>  	.poll           = vhost_net_chr_poll,
>  	.unlocked_ioctl = vhost_net_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl   = vhost_net_compat_ioctl,
> -#endif
> +	.compat_ioctl   = compat_ptr_ioctl,
>  	.open           = vhost_net_open,
>  	.llseek		= noop_llseek,
>  };
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 618fb6461017..f9b14c39d89b 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1721,21 +1721,11 @@ vhost_scsi_ioctl(struct file *f,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vhost_scsi_compat_ioctl(struct file *f, unsigned int ioctl,
> -				unsigned long arg)
> -{
> -	return vhost_scsi_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vhost_scsi_fops = {
>  	.owner          = THIS_MODULE,
>  	.release        = vhost_scsi_release,
>  	.unlocked_ioctl = vhost_scsi_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= vhost_scsi_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.open           = vhost_scsi_open,
>  	.llseek		= noop_llseek,
>  };
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 40589850eb33..61d4d98c8f70 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -298,21 +298,11 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vhost_test_compat_ioctl(struct file *f, unsigned int ioctl,
> -				   unsigned long arg)
> -{
> -	return vhost_test_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vhost_test_fops = {
>  	.owner          = THIS_MODULE,
>  	.release        = vhost_test_release,
>  	.unlocked_ioctl = vhost_test_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl   = vhost_test_compat_ioctl,
> -#endif
> +	.compat_ioctl   = compat_ptr_ioctl,
>  	.open           = vhost_test_open,
>  	.llseek		= noop_llseek,
>  };
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bb5fc0e9fbc2..9a86202678b6 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -716,23 +716,13 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
> -					 unsigned long arg)
> -{
> -	return vhost_vsock_dev_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vhost_vsock_fops = {
>  	.owner          = THIS_MODULE,
>  	.open           = vhost_vsock_dev_open,
>  	.release        = vhost_vsock_dev_release,
>  	.llseek		= noop_llseek,
>  	.unlocked_ioctl = vhost_vsock_dev_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl   = vhost_vsock_dev_compat_ioctl,
> -#endif
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  static struct miscdevice vhost_vsock_misc = {
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index b3bed32946b1..f173d9261115 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -171,15 +171,6 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long fat_generic_compat_ioctl(struct file *filp, unsigned int cmd,
> -				      unsigned long arg)
> -
> -{
> -	return fat_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static int fat_file_release(struct inode *inode, struct file *filp)
>  {
>  	if ((filp->f_mode & FMODE_WRITE) &&
> @@ -209,9 +200,7 @@ const struct file_operations fat_file_operations = {
>  	.mmap		= generic_file_mmap,
>  	.release	= fat_file_release,
>  	.unlocked_ioctl	= fat_generic_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	= fat_generic_compat_ioctl,
> -#endif
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.fsync		= fat_file_fsync,
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
> -- 
> 2.20.0
