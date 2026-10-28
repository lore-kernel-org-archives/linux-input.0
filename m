Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196130;
	b=Rj5jkeDdrp+XvIVSQzg0nH2y9+yLSfRGLwHw2FdSvyUcwZuG5WtddACHlzidgdLiJTYt
	 rL7AofQXRIMgwbmQ9xWj4PmKIQUJ2k/fpB1U/SET/Ug9P26Mu4entxJLxwzTw9dMScIa0
	 QzzAQJj+Q0eNTWOqO3/fqjj+VaLiU01rOjyOw9uoco+UFxGNBRKFxdLHwfPDeo179HCs0
	 YDcQkxkc58Ccn13fAdItYKwRQ2WSkToAcNTp5rJvY1nH1+abarj+S8QFi0HzgxvEAQ8aU
	 AsKVeA+sxxEgvzxaiECnOyfGsT39EUTMktIWGiM6wfxIk4TAacpvvn/mRiG9FCHZ+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3H8BI2LFf6f0BdxDXU8zUV0CwMCvi64uAcJ3leq5mmw=;
	b=dI3BaNtAPF/kbYz9Z/G08Kmh/UgFL1pk/2NPKb6KRc1iJwbhVnQWu4mYBx/MwFTQilo7
	 006v3lX5bBauFqbcn0o1bg1mOg13Mk9ECnEcVbJSKdy0C1HKSHZbvpO5n1VUCpuYcAPyy
	 Zh6ggI0DQ/g4o1uYDtIqbh8Va7vI8XMnx7kwoiIEbHN7S57OIwf5Mw3zd5psfRsS6Wplg
	 aoHyG60wcmBt17F8W0BWGGU9b4oUH7NQRN6VgA7oC3HCoigB4wqHZWNXwD7x09GmVRfYb
	 TjIlaqMr0F3YNLF3ekep7VjCuJhupzZBg6GSe2GHE9epJRRrJCsviPZV5pHuIrLKVQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJSe+mjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04184606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJSe+mjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F60F1F01825;
	Wed, 28 Oct 2026 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196129;
	bh=3H8BI2LFf6f0BdxDXU8zUV0CwMCvi64uAcJ3leq5mmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJSe+mjL0BOxaNdc8HWlBJRXpeQRsmCQF6nfViCI4lfTa74HStSCmRAHMAPJlZdSl
	 a+fxtYY4wRFN60OGKskcM4FX4Fyj5qHArocPFTRvDj1E5hV2v21F5XAHQ4jOuGbOUS
	 YzygMNGQQri2BWU+7SsctLSskm8xgENBB8+/JeqU9UzGhrxUGDJ1/MH7zAq56gLObM
	 F8li+xKYGx/dTzjlxFY+ejTI2DoP2JqwRl8x5xow/y3D9Mo72zWpVVfUcDQqSYKarb
	 BoAYy7dzf09P7t/zt7jkpSbtZgGKeb6t06rThE+0NnvJTiNhXKGExsAcZRvVOdrZlH
	 V2Tl4i6assyeA==
Message-ID: <sashiko-outbox-187952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/tiny: add driver for Valkyrie USB LCD displays
Reply-To: sashiko-reviews@lists.linux.dev
To: "ZiAo Wang" <ziaowang2007@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261028132536.375927-4-ziaowang2007@gmail.com>
References: <20261028132536.375927-1-ziaowang2007@gmail.com>
 <20261028132536.375927-4-ziaowang2007@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:02:08 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/tiny: missing drm_atomic_helper_shutdown() in vk_disconnect()
- [Medium] drm/tiny: missing drm_dev_set_dma_dev() in vk_probe()
- [Medium] drm/tiny: vk_crtc_atomic_check() skips validation when CRTC is i=
nactive
- [Medium] drm/tiny: vk_device_enable_pre() leaves device_state true on fai=
lure
- [Medium] drm/tiny: valkyrie-lcd: broken resume recovery when drm suspend =
fails
--

commit 172f750ba1a198c982441dc0256107aec140e020
Author: ZiAo Wang <ziaowang2007@gmail.com>

drm/tiny: add driver for Valkyrie USB LCD displays

This commit adds a DRM/KMS driver for Valkyrie USB LCD displays (320x240 and
360x960 variants) using GEM shmem buffers, atomic modesetting, USB control
transfers for panel initialization, and bulk OUT transfers for UYVY frame
streaming.

> diff --git a/drivers/gpu/drm/tiny/valkyrie-lcd.c b/drivers/gpu/drm/tiny/v=
alkyrie-lcd.c
> new file mode 100644
> index 0000000000000..6478e9246263b
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/valkyrie-lcd.c
[ ... ]
> +static int vk_plane_atomic_check(struct drm_plane *plane,
> +				 struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_plane_state =3D
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *new_crtc_state;
> +	int ret;
> +
> +	if (!new_plane_state->fb)
> +		return 0;
> +
> +	if (!new_plane_state->crtc)
> +		return -EINVAL;
> +	new_crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
> +	if (!new_crtc_state)
> +		return -EINVAL;
> +
> +	ret =3D drm_atomic_helper_check_plane_state(new_plane_state,
> +						  new_crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING, false,
> +						  false);
> +	if (ret)
> +		return ret;
> +
> +	if (new_plane_state->rotation !=3D DRM_MODE_ROTATE_0) {
> +		drm_dbg_kms(plane->dev, "Unsupported plane rotation %#x\n",
> +			    new_plane_state->rotation);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
[ ... ]
> +static int vk_crtc_atomic_check(struct drm_crtc *crtc,
> +				struct drm_atomic_commit *state)
> +{
> +	struct vk_driver *drv =3D container_of(crtc->dev, struct vk_driver, drm=
);
> +	struct drm_crtc_state *new_crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_plane *plane =3D &drv->plane;
> +	struct vk_connector_driver *connector_drv =3D drv->connector;
> +	struct drm_plane_state *new_plane_state;
> +
> +	if (!new_crtc_state->enable || !new_crtc_state->active)
> +		return 0;
> +
> +	if (new_crtc_state->plane_mask !=3D drm_plane_mask(plane) ||
> +	    new_crtc_state->connector_mask !=3D
> +		    drm_connector_mask(&connector_drv->connector)) {
> +		drm_dbg_kms(crtc->dev,
> +			    "Active CRTC requires the primary plane and USB connector\n");
> +		return -EINVAL;
> +	}
> +
> +	new_plane_state =3D drm_atomic_get_new_plane_state(state, plane);
> +	if (!new_plane_state)
> +		new_plane_state =3D plane->state;
> +	if (!new_plane_state || new_plane_state->crtc !=3D crtc ||
> +	    !new_plane_state->fb) {
> +		drm_dbg_kms(crtc->dev,
> +			    "Active CRTC has no framebuffer on its primary plane\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Should vk_crtc_atomic_check() only return early when !new_crtc_state->enabl=
e,
rather than also skipping validation when !new_crtc_state->active?

According to the struct drm_crtc_state documentation, drivers must not cons=
ult
new_crtc_state->active in atomic_check to decide whether shared resources a=
re
required because userspace expects a subsequent DPMS ON transition to succe=
ed.

When the CRTC is enabled but inactive (enable is true, active is false),
returning early here allows userspace (for example via DRM_IOCTL_MODE_RMFB =
or
DRM_IOCTL_MODE_SETPLANE) to detach the primary plane and its framebuffer wh=
ile
leaving the CRTC enabled with plane_mask =3D=3D 0. Any subsequent commit se=
tting
active back to true will then fail in vk_crtc_atomic_check() with -EINVAL.

Also, in vk_plane_atomic_check(), returning 0 before calling
drm_atomic_helper_check_plane_state() when !new_plane_state->fb skips clear=
ing
new_plane_state->visible to false when disabling the plane.

[ ... ]
> +	if (!new_enable) {
> +		if (drv->device_state)
> +			ret =3D vk_device_disable(drv);
> +	} else {
> +		bool enabling =3D !drv->device_state;
> +
> +		/* Testing found a ~10-second timeout; refresh every 3 seconds. */
> +		mod_delayed_work(system_dfl_wq, &crtc_drv->timeout_flush,
> +				 msecs_to_jiffies(VK_TIMEOUT_FLUSH_INTERVAL_MS));
> +		if (enabling)
> +			ret =3D vk_device_enable_pre(drv);
> +		ret2 =3D vk_scan_frame(crtc_drv, connector_drv,
> +				     to_drm_shadow_plane_state(new_plane_state));
> +		ret =3D ret ? ret : ret2;
> +		if (enabling) {
> +			ret2 =3D vk_device_enable_post(drv);
> +			ret =3D ret ? ret : ret2;
> +		}
> +	}

[Severity: Medium]
What happens in vk_crtc_atomic_flush() if vk_device_enable_pre(),
vk_scan_frame(), or vk_device_enable_post() fails when enabling is true?

In vk_device_enable_pre():

	drv->device_state =3D true;
	return vk_a604_switch(drv, true);

drv->device_state is unconditionally set to true before vk_a604_switch() and
the rest of the enable sequence succeed. If a transient USB error or poll
timeout occurs during vk_device_enable_pre(), vk_crtc_atomic_flush() still
proceeds to call vk_scan_frame() and vk_device_enable_post(), and leaves
drv->device_state set to true. Because drv->device_state stays true,
subsequent page flips and 3-second timeout_flush refreshes will see enabling
as false and will never retry the enable sequence.

Similarly, in vk_device_reset(), vk_device_enable_pre() is called
unconditionally even when vk_device_bootstrap() returns an error.

[ ... ]
> +static int vk_probe(struct usb_interface *intf, const struct usb_device_=
id *id)
> +{
> +	struct vk_driver *drv =3D devm_drm_dev_alloc(&intf->dev, &vk_drm_driver,
> +						   struct vk_driver, drm);
> +	int ret;
> +
> +	if (IS_ERR(drv))
> +		return dev_err_probe(&intf->dev, PTR_ERR(drv),
> +				     "Failed to allocate DRM device\n");
> +	mutex_init(&drv->io_lock);
> +
> +	ret =3D vk_init_usb(drv, intf);
> +	if (ret)
> +		goto fail;

[Severity: Medium]
Does vk_probe() need to configure the DMA device on drv->drm via
usb_intf_get_dma_device(intf) and drm_dev_set_dma_dev()?

vk_drm_driver uses DRM_GEM_SHMEM_DRIVER_OPS, which wires up PRIME DMA-BUF
import via drm_gem_prime_import() -> drm_gem_prime_import_dev(dev, dma_buf,
drm_dev_dma_dev(dev)). Because drv->drm is allocated with &intf->dev as its
parent and a struct usb_interface device has no dma_mask, importing a DMA-B=
UF
via DRM_IOCTL_PRIME_FD_TO_HANDLE will pass &intf->dev to
dma_buf_map_attachment(), triggering a WARN_ON_ONCE(!dev->dma_mask) and
failing with -EINVAL.

[ ... ]
> +static void vk_disconnect(struct usb_interface *intf)
> +{
> +	struct vk_driver *drv =3D usb_get_intfdata(intf);
> +	int ret;
> +
> +	drm_dbg_driver(&drv->drm, "Disconnecting display\n");
> +
> +	drm_dev_get(&drv->drm);
> +	drm_dev_unplug(&drv->drm);
> +
> +	mutex_lock(&drv->io_lock);
> +	drv->io_blocking =3D true;
> +	mutex_unlock(&drv->io_lock);
> +
> +	cancel_delayed_work_sync(&drv->crtc->timeout_flush);
> +
> +	if (drv->drm.mode_config.suspend_state) {
> +		drm_atomic_commit_put(drv->drm.mode_config.suspend_state);
> +		drv->drm.mode_config.suspend_state =3D NULL;
> +	}
> +
> +	drm_dev_put(&drv->drm);

[Severity: High]
Can skipping drm_atomic_helper_shutdown(&drv->drm) in vk_disconnect() leak =
the
active shadow-plane vmap and pinned shmem pages on unplug?

When the display is active, drm_gem_begin_shadow_fb_access() vmaps the
framebuffer (incrementing shmem->vmap_use_count, shmem->pages_pin_count, and
shmem->pages_use_count), and vk_crtc_atomic_enable() enables the CRTC vblank
timer. The shadow-plane vmap is only released by drm_gem_end_shadow_fb_acce=
ss()
when a subsequent atomic commit disables or replaces the plane state.

Because vk_disconnect() never calls drm_atomic_helper_shutdown(&drv->drm), =
if
the active framebuffer is not explicitly removed by drm_mode_rmfb() before =
the
final drm_dev_put() (for example when a compositor has called
DRM_IOCTL_MODE_CLOSEFB on its frontbuffer, or when fbdev emulation is not
enabled), drm_mode_config_cleanup() destroys the active shadow_plane_state =
via
drm_gem_destroy_shadow_plane_state() without calling
drm_gem_end_shadow_fb_access(). When the framebuffer is freed,
drm_gem_shmem_release() hits drm_WARN_ONs for non-zero vmap_use_count,
pages_use_count, and pages_pin_count, leaking the kernel vmap and backing
pages, and drm_vblank_init_release() also warns that vblank->enabled is sti=
ll
set.

In addition, if vk_timeout_atomic_submit() queued a non-blocking atomic com=
mit
just before cancel_delayed_work_sync(&drv->crtc->timeout_flush), its
commit_work is not drained without drm_atomic_helper_shutdown() before
vk_device_reset() and teardown run.

[ ... ]
> +static int __vk_resume_device(struct usb_interface *intf, bool rebootstr=
ap,
> +			      bool reidentify)
> +{
> +	struct vk_driver *drv =3D usb_get_intfdata(intf);
> +	int ret =3D 0;
[ ... ]
> +	drv->io_blocking =3D false;
> +	mutex_unlock(&drv->io_lock);
> +
> +	if (drv->drm_suspended) {
> +		ret =3D drm_mode_config_helper_resume(&drv->drm);
> +		drv->drm_suspended =3D false;
> +		if (ret)
> +			drm_err(&drv->drm, "Failed to restore DRM state: %d\n",
> +				ret);
> +	} else {
> +		drm_dbg_driver(&drv->drm,
> +			       "No saved DRM state; scheduling an immediate refresh\n");
> +		schedule_delayed_work(&drv->crtc->timeout_flush, 0);
> +	}
[ ... ]
> +static int __vk_suspend_device(struct usb_interface *intf, bool force)
> +{
> +	struct vk_driver *drv =3D usb_get_intfdata(intf);
> +	int ret =3D 0;
> +
> +	drm_dbg_driver(&drv->drm,
> +		       "Suspending display (force=3D%d, DRM suspended=3D%d)\n",
> +		       force, drv->drm_suspended);
> +
> +	if (!drv->drm_suspended) {
> +		ret =3D drm_mode_config_helper_suspend(&drv->drm);
> +		if (ret)
> +			drm_err(&drv->drm, "Failed to suspend DRM state: %d\n",
> +				ret);
> +		if (ret && !force)
> +			return ret;
> +		if (!ret)
> +			drv->drm_suspended =3D true;
> +	}
> +
> +	mutex_lock(&drv->io_lock);
> +	drv->io_blocking =3D true;
> +	mutex_unlock(&drv->io_lock);
> +	cancel_delayed_work_sync(&drv->crtc->timeout_flush);
> +	drm_dbg_driver(&drv->drm, "Display I/O suspended\n");
> +	return ret;
> +}

[Severity: Medium]
In __vk_suspend_device(), if force is true (from vk_suspend()) and
drm_mode_config_helper_suspend() fails while the display is active, can the
display recover on vk_resume()?

When drm_mode_config_helper_suspend() fails, vk_device_disable() is not
called, so the panel remains enabled with drv->device_state =3D=3D true and
drv->drm_suspended =3D=3D false while timeout_flush is cancelled across sus=
pend.
Once the panel's ~10-second hardware watchdog expires during suspend and
resets the device, vk_resume() calls __vk_resume_device(intf, false, false)
and takes the !drv->drm_suspended fallback branch to schedule timeout_flush.
However, when timeout_flush runs vk_crtc_atomic_flush(), drv->device_state =
is
still true, so enabling (!drv->device_state) is false and neither
vk_device_bootstrap() nor vk_device_enable_pre() / vk_device_enable_post() =
is
executed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028132536.3759=
27-1-ziaowang2007@gmail.com?part=3D3
