Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFC35975;
	Wed, 26 Aug 2026 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787723281; cv=none; b=YqP325W2r43zWN/SSdrdU/PkU0zOEOWFh1qe2ai2smsgj7QWPXHCpvpzrNwC2uX1JV5adTWwjDixlzeN7BFtCpK3E4pkreST8Yxvqxpp6X6U0g8AmnuGpehKO5b0dAXpLMTamb+aGEyX0shPamGbcPHZRyCRp6O3uxSTe0mA1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787723281; c=relaxed/simple;
	bh=7KFW5ZV0rZ9LQxVtBOP2xBxu/vrfylQk2CuFKIgFwDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KulySBkE6N9fY6rzNnYtZBvPOLyiWMUUK9MhfwOwQoiT1PUdRnCEauXC570rNK7F6LFZ939TReqrifJ42ADANruKPQgXa6Y89U37BU5jxegdQhVGki936UaEY7LZMbeprBaz0IKLeyhTvfJTb28Jpffsq9pEWml7oXz8aF/tEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: acf4bfd0a11111f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cd334b5b-6579-41d4-8796-c628d5a79b9d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9ce3f20f8424bc3298e6ea736ecbba34,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: acf4bfd0a11111f19a56ed5b684f684d-20260826
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 505565819; Wed, 26 Aug 2026 13:47:51 +0800
Message-ID: <0c4adf4f-e1e8-4523-b3e9-969d6bab125c@kylinos.cn>
Date: Wed, 26 Aug 2026 13:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] input: sur40: fix use-after-free in disconnect
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <6a8e44ca.dbb3a75c.7844.002f.GAE@google.com>
 <51e68e6de6d9e7a864a5729bac1b33bd083802f6.1787715605.git.xiaopei01@kylinos.cn>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <51e68e6de6d9e7a864a5729bac1b33bd083802f6.1787715605.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/26 11:42, Pei Xiao 写道:
> When the USB device is disconnected while userspace still holds
> an open file descriptor to the V4L2 video device, sur40_disconnect()
> calls kfree(sur40) immediately after video_unregister_device(). However,
> video_unregister_device() only removes the device from the V4L2
> framework and does not drop the kref. Userspace still holds a valid
> reference to the embedded video_device, causing a use-after-free when
> subsequently performing ioctls that access vdev->flags via
> video_is_registered().
> 
> Fix this by setting vdev->release to a new callback sur40_video_release()
> that frees the containing sur40_state via container_of(). Replace the
> direct kfree(sur40) in sur40_disconnect() with a reliance on the kref
> mechanism: video_unregister_device() triggers device_unregister() which
> drops the kref on vdev->dev; when the last reference is released
> (all userspace file descriptors closed), the V4L2 core automatically
> calls vdev->release(), safely freeing sur40_state.
> 
> Also fix the error path err_unreg_video to properly free the
> independently-allocated input device and return early, preventing
> fall-through to cleanup labels that would access the already-freed
> sur40_state.
> 
> Fixes: e831cd251fb9 ("[media] add raw video stream support for Samsung SUR40")
> Reported-by: syzbot+4a6e6173b1fc7916e950@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a8e44ca.dbb3a75c.7844.002f.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/input/touchscreen/sur40.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 09d8c5f8d09f..2d93234cc86a 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -237,6 +237,7 @@ static const struct video_device sur40_video_device;
>  static const struct vb2_queue sur40_queue;
>  static void sur40_process_video(struct sur40_state *sur40);
>  static int sur40_s_ctrl(struct v4l2_ctrl *ctrl);
> +static void sur40_video_release(struct video_device *vdev);
>  
>  static const struct v4l2_ctrl_ops sur40_ctrl_ops = {
>  	.s_ctrl = sur40_s_ctrl,
> @@ -750,6 +751,7 @@ static int sur40_probe(struct usb_interface *interface,
>  	sur40->vdev.v4l2_dev = &sur40->v4l2;
>  	sur40->vdev.lock = &sur40->lock;
>  	sur40->vdev.queue = &sur40->queue;
> +	sur40->vdev.release = sur40_video_release;
>  	video_set_drvdata(&sur40->vdev, sur40);
>  
>  	/* initialize the control handler for 4 controls */
> @@ -806,6 +808,8 @@ static int sur40_probe(struct usb_interface *interface,
>  
>  err_unreg_video:
>  	video_unregister_device(&sur40->vdev);
> +	input_free_device(input);
> +	return error;
>  err_free_ctrl:
>  	v4l2_ctrl_handler_free(&sur40->hdl);
>  err_unreg_v4l2:
> @@ -820,19 +824,23 @@ static int sur40_probe(struct usb_interface *interface,
>  	return error;
>  }
>  
> -/* Unregister device & clean up. */
> +static void sur40_video_release(struct video_device *vdev)
> +{
> +	struct sur40_state *sur40 = container_of(vdev, struct sur40_state, vdev);
> +
> +	v4l2_ctrl_handler_free(&sur40->hdl);
> +	v4l2_device_unregister(&sur40->v4l2);
> +	kfree(sur40->bulk_in_buffer);
> +	kfree(sur40);
> +}
> +
>  static void sur40_disconnect(struct usb_interface *interface)
>  {
>  	struct sur40_state *sur40 = usb_get_intfdata(interface);
>  
>  	input_unregister_device(sur40->input);
>  
> -	v4l2_ctrl_handler_free(&sur40->hdl);
>  	video_unregister_device(&sur40->vdev);
> -	v4l2_device_unregister(&sur40->v4l2);
> -
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
>  
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);

