From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/5] vfio: platform: Convert to use devm_*()
Date: Sun, 2 Apr 2017 16:45:28 +0200
Message-ID: <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-5-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDVMPI6S7EDRBEU5QTDQKGQEEG7BNUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1490539314-9681-5-git-send-email-leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Leo,

On 26/03/2017 16:41, Leo Yan wrote:
> Convert driver to use devm_*() APIs so rely on driver model core layer
> to manage resources. This eliminates error path boilerplate and makes
> code neat.
> 
> This patch also renames amba_id structure, the old code used some code
> which directly copied from other driver.
> 
> Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Looks good to me
Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

May be interesting to go further converting as well the vfio-platform
driver but this can be done later on.

Thanks

Eric


> ---
>  drivers/vfio/platform/vfio_amba.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index 31372fb..433db1f 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -53,15 +53,14 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct vfio_platform_device *vdev;
>  	int ret;
>  
> -	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> +	vdev = devm_kzalloc(&adev->dev, sizeof(*vdev), GFP_KERNEL);
>  	if (!vdev)
>  		return -ENOMEM;
>  
> -	vdev->name = kasprintf(GFP_KERNEL, "vfio-amba-%08x", adev->periphid);
> -	if (!vdev->name) {
> -		kfree(vdev);
> +	vdev->name = devm_kasprintf(&adev->dev, GFP_KERNEL,
> +				    "vfio-amba-%08x", adev->periphid);
> +	if (!vdev->name)
>  		return -ENOMEM;
> -	}
>  
>  	vdev->opaque = (void *) adev;
>  	vdev->flags = VFIO_DEVICE_FLAGS_AMBA;
> @@ -71,11 +70,6 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
>  	vdev->reset_required = false;
>  
>  	ret = vfio_platform_probe_common(vdev, &adev->dev);
> -	if (ret) {
> -		kfree(vdev->name);
> -		kfree(vdev);
> -	}
> -
>  	return ret;
>  }
>  
> @@ -84,25 +78,22 @@ static int vfio_amba_remove(struct amba_device *adev)
>  	struct vfio_platform_device *vdev;
>  
>  	vdev = vfio_platform_remove_common(&adev->dev);
> -	if (vdev) {
> -		kfree(vdev->name);
> -		kfree(vdev);
> +	if (vdev)
>  		return 0;
> -	}
>  
>  	return -EINVAL;
>  }
>  
> -static struct amba_id pl330_ids[] = {
> +static struct amba_id vfio_ids[] = {
>  	{ 0, 0 },
>  };
>  
> -MODULE_DEVICE_TABLE(amba, pl330_ids);
> +MODULE_DEVICE_TABLE(amba, vfio_ids);
>  
>  static struct amba_driver vfio_amba_driver = {
>  	.probe = vfio_amba_probe,
>  	.remove = vfio_amba_remove,
> -	.id_table = pl330_ids,
> +	.id_table = vfio_ids,
>  	.drv = {
>  		.name = "vfio-amba",
>  		.owner = THIS_MODULE,
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
