From: Dan Williams <dcbw@redhat.com>
Subject: Re: [RFC v0 3/8] firmware: Factor out firmware load helpers
Date: Thu, 28 Jul 2016 10:01:01 -0500
Message-ID: <1469718061.3013.18.camel@redhat.com>
References: <1469692512-16863-1-git-send-email-wagi@monom.org>
	 <1469692512-16863-4-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758767AbcG1PBI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 11:01:08 -0400
In-Reply-To: <1469692512-16863-4-git-send-email-wagi@monom.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>, Bastien Nocera <hadess@hadess.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Wagner <daniel.wagner@bmw-carit.de>

On Thu, 2016-07-28 at 09:55 +0200, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>=20
> Factor out the firmware loading synchronization code in order to
> allow
> drivers to reuse it. This also documents more clearly what is
> happening. This is especial useful the drivers which will be
> converted
> afterwards. Not everyone has to come with yet another way to handle
> it.

It's somewhat odd to me that the structure is "firmware_stat" but most
of the functions are "fw_loading_*". =C2=A0That seems inconsistent for =
a
structure that is (currently) only used by these functions.

I would personally do either:

a) "struct fw_load_status" and "fw_load_*()"

or

b) "struct firmware_load_stat" and "firmware_load_*()"

I'd also change the function names from "loading" -> "load", similar to
how userland has read(2), not reading(2).

Dan

> We use swait instead completion. complete() would only wake up one
> waiter, so complete_all() is used. complete_all() wakes max
> MAX_UINT/2
> waiters which is plenty in all cases. Though withh swait we just wait
> until the exptected status shows up and wake any waiter.
>=20
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
> =C2=A0drivers/base/firmware_class.c | 112 +++++++++++++++++++--------=
-----
> ----------
> =C2=A0include/linux/firmware.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A071 ++++++++++++++++++++++++++
> =C2=A02 files changed, 122 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/base/firmware_class.c
> b/drivers/base/firmware_class.c
> index 773fc30..bf1ca70 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -30,6 +30,7 @@
> =C2=A0#include <linux/syscore_ops.h>
> =C2=A0#include <linux/reboot.h>
> =C2=A0#include <linux/security.h>
> +#include <linux/swait.h>
> =C2=A0
> =C2=A0#include <generated/utsrelease.h>
> =C2=A0
> @@ -85,11 +86,36 @@ static inline bool fw_is_builtin_firmware(const
> struct firmware *fw)
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> -enum {
> -	FW_STATUS_LOADING,
> -	FW_STATUS_DONE,
> -	FW_STATUS_ABORT,
> -};
> +
> +#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE)
> && defined(MODULE))
> +
> +static inline bool is_fw_sync_done(unsigned long status)
> +{
> +	return status =3D=3D FW_STATUS_LOADED || status =3D=3D
> FW_STATUS_ABORT;
> +}
> +
> +int __firmware_stat_wait(struct firmware_stat *fwst,
> +				long timeout)
> +{
> +	int err;
> +	err =3D swait_event_interruptible_timeout(fwst->wq,
> +				is_fw_sync_done(READ_ONCE(fwst-
> >status)),
> +				timeout);
> +	if (err =3D=3D 0 && fwst->status =3D=3D FW_STATUS_ABORT)
> +		return -ENOENT;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(__firmware_stat_wait);
> +
> +void __firmware_stat_set(struct firmware_stat *fwst, unsigned long
> status)
> +{
> +	WRITE_ONCE(fwst->status, status);
> +	swake_up(&fwst->wq);
> +}
> +EXPORT_SYMBOL(__firmware_stat_set);
> +
> +#endif
> =C2=A0
> =C2=A0static int loading_timeout =3D 60;	/* In seconds */
> =C2=A0
> @@ -138,9 +164,8 @@ struct firmware_cache {
> =C2=A0struct firmware_buf {
> =C2=A0	struct kref ref;
> =C2=A0	struct list_head list;
> -	struct completion completion;
> +	struct firmware_stat fwst;
> =C2=A0	struct firmware_cache *fwc;
> -	unsigned long status;
> =C2=A0	void *data;
> =C2=A0	size_t size;
> =C2=A0#ifdef CONFIG_FW_LOADER_USER_HELPER
> @@ -194,7 +219,7 @@ static struct firmware_buf
> *__allocate_fw_buf(const char *fw_name,
> =C2=A0
> =C2=A0	kref_init(&buf->ref);
> =C2=A0	buf->fwc =3D fwc;
> -	init_completion(&buf->completion);
> +	firmware_stat_init(&buf->fwst);
> =C2=A0#ifdef CONFIG_FW_LOADER_USER_HELPER
> =C2=A0	INIT_LIST_HEAD(&buf->pending_list);
> =C2=A0#endif
> @@ -292,15 +317,6 @@ static const char * const fw_path[] =3D {
> =C2=A0module_param_string(path, fw_path_para, sizeof(fw_path_para), 0=
644);
> =C2=A0MODULE_PARM_DESC(path, "customized firmware image search path w=
ith a
> higher priority than default path");
> =C2=A0
> -static void fw_finish_direct_load(struct device *device,
> -				=C2=A0=C2=A0struct firmware_buf *buf)
> -{
> -	mutex_lock(&fw_lock);
> -	set_bit(FW_STATUS_DONE, &buf->status);
> -	complete_all(&buf->completion);
> -	mutex_unlock(&fw_lock);
> -}
> -
> =C2=A0static int fw_get_filesystem_firmware(struct device *device,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct firmware_b=
uf *buf)
> =C2=A0{
> @@ -339,7 +355,7 @@ static int fw_get_filesystem_firmware(struct
> device *device,
> =C2=A0		}
> =C2=A0		dev_dbg(device, "direct-loading %s\n", buf->fw_id);
> =C2=A0		buf->size =3D size;
> -		fw_finish_direct_load(device, buf);
> +		fw_loading_done(buf->fwst);
> =C2=A0		break;
> =C2=A0	}
> =C2=A0	__putname(path);
> @@ -457,12 +473,11 @@ static void __fw_load_abort(struct firmware_buf
> *buf)
> =C2=A0	=C2=A0* There is a small window in which user can write to
> 'loading'
> =C2=A0	=C2=A0* between loading done and disappearance of 'loading'
> =C2=A0	=C2=A0*/
> -	if (test_bit(FW_STATUS_DONE, &buf->status))
> +	if (is_fw_loading_done(buf->fwst))
> =C2=A0		return;
> =C2=A0
> =C2=A0	list_del_init(&buf->pending_list);
> -	set_bit(FW_STATUS_ABORT, &buf->status);
> -	complete_all(&buf->completion);
> +	fw_loading_abort(buf->fwst);
> =C2=A0}
> =C2=A0
> =C2=A0static void fw_load_abort(struct firmware_priv *fw_priv)
> @@ -475,9 +490,6 @@ static void fw_load_abort(struct firmware_priv
> *fw_priv)
> =C2=A0	fw_priv->buf =3D NULL;
> =C2=A0}
> =C2=A0
> -#define is_fw_load_aborted(buf)	\
> -	test_bit(FW_STATUS_ABORT, &(buf)->status)
> -
> =C2=A0static LIST_HEAD(pending_fw_head);
> =C2=A0
> =C2=A0/* reboot notifier for avoid deadlock with usermode_lock */
> @@ -577,7 +589,7 @@ static ssize_t firmware_loading_show(struct
> device *dev,
> =C2=A0
> =C2=A0	mutex_lock(&fw_lock);
> =C2=A0	if (fw_priv->buf)
> -		loading =3D test_bit(FW_STATUS_LOADING, &fw_priv->buf-
> >status);
> +		loading =3D is_fw_loading(fw_priv->buf->fwst);
> =C2=A0	mutex_unlock(&fw_lock);
> =C2=A0
> =C2=A0	return sprintf(buf, "%d\n", loading);
> @@ -632,23 +644,20 @@ static ssize_t firmware_loading_store(struct
> device *dev,
> =C2=A0	switch (loading) {
> =C2=A0	case 1:
> =C2=A0		/* discarding any previous partial load */
> -		if (!test_bit(FW_STATUS_DONE, &fw_buf->status)) {
> +		if (!is_fw_loading_done(fw_buf->fwst)) {
> =C2=A0			for (i =3D 0; i < fw_buf->nr_pages; i++)
> =C2=A0				__free_page(fw_buf->pages[i]);
> =C2=A0			vfree(fw_buf->pages);
> =C2=A0			fw_buf->pages =3D NULL;
> =C2=A0			fw_buf->page_array_size =3D 0;
> =C2=A0			fw_buf->nr_pages =3D 0;
> -			set_bit(FW_STATUS_LOADING, &fw_buf->status);
> +			fw_loading_start(fw_buf->fwst);
> =C2=A0		}
> =C2=A0		break;
> =C2=A0	case 0:
> -		if (test_bit(FW_STATUS_LOADING, &fw_buf->status)) {
> +		if (is_fw_loading(fw_buf->fwst)) {
> =C2=A0			int rc;
> =C2=A0
> -			set_bit(FW_STATUS_DONE, &fw_buf->status);
> -			clear_bit(FW_STATUS_LOADING, &fw_buf-
> >status);
> -
> =C2=A0			/*
> =C2=A0			=C2=A0* Several loading requests may be pending
> on
> =C2=A0			=C2=A0* one same firmware buf, so let all
> requests
> @@ -670,10 +679,11 @@ static ssize_t firmware_loading_store(struct
> device *dev,
> =C2=A0			=C2=A0*/
> =C2=A0			list_del_init(&fw_buf->pending_list);
> =C2=A0			if (rc) {
> -				set_bit(FW_STATUS_ABORT, &fw_buf-
> >status);
> +				fw_loading_abort(fw_buf->fwst);
> =C2=A0				written =3D rc;
> +			} else {
> +				fw_loading_done(fw_buf->fwst);
> =C2=A0			}
> -			complete_all(&fw_buf->completion);
> =C2=A0			break;
> =C2=A0		}
> =C2=A0		/* fallthrough */
> @@ -681,7 +691,7 @@ static ssize_t firmware_loading_store(struct
> device *dev,
> =C2=A0		dev_err(dev, "%s: unexpected value (%d)\n",
> __func__, loading);
> =C2=A0		/* fallthrough */
> =C2=A0	case -1:
> -		fw_load_abort(fw_priv);
> +		fw_loading_abort(fw_buf->fwst);
> =C2=A0		break;
> =C2=A0	}
> =C2=A0out:
> @@ -702,7 +712,7 @@ static ssize_t firmware_data_read(struct file
> *filp, struct kobject *kobj,
> =C2=A0
> =C2=A0	mutex_lock(&fw_lock);
> =C2=A0	buf =3D fw_priv->buf;
> -	if (!buf || test_bit(FW_STATUS_DONE, &buf->status)) {
> +	if (!buf || is_fw_loading_done(buf->fwst)) {
> =C2=A0		ret_count =3D -ENODEV;
> =C2=A0		goto out;
> =C2=A0	}
> @@ -799,7 +809,7 @@ static ssize_t firmware_data_write(struct file
> *filp, struct kobject *kobj,
> =C2=A0
> =C2=A0	mutex_lock(&fw_lock);
> =C2=A0	buf =3D fw_priv->buf;
> -	if (!buf || test_bit(FW_STATUS_DONE, &buf->status)) {
> +	if (!buf || is_fw_loading_done(buf->fwst)) {
> =C2=A0		retval =3D -ENODEV;
> =C2=A0		goto out;
> =C2=A0	}
> @@ -917,8 +927,7 @@ static int _request_firmware_load(struct
> firmware_priv *fw_priv,
> =C2=A0		timeout =3D MAX_JIFFY_OFFSET;
> =C2=A0	}
> =C2=A0
> -	retval =3D wait_for_completion_interruptible_timeout(&buf-
> >completion,
> -			timeout);
> +	retval =3D fw_loading_wait_timeout(buf->fwst, timeout);
> =C2=A0	if (retval =3D=3D -ERESTARTSYS || !retval) {
> =C2=A0		mutex_lock(&fw_lock);
> =C2=A0		fw_load_abort(fw_priv);
> @@ -927,7 +936,7 @@ static int _request_firmware_load(struct
> firmware_priv *fw_priv,
> =C2=A0		retval =3D 0;
> =C2=A0	}
> =C2=A0
> -	if (is_fw_load_aborted(buf))
> +	if (is_fw_loading_aborted(buf->fwst))
> =C2=A0		retval =3D -EAGAIN;
> =C2=A0	else if (!buf->data)
> =C2=A0		retval =3D -ENOMEM;
> @@ -986,26 +995,6 @@ static inline void
> kill_requests_without_uevent(void) { }
> =C2=A0
> =C2=A0#endif /* CONFIG_FW_LOADER_USER_HELPER */
> =C2=A0
> -
> -/* wait until the shared firmware_buf becomes ready (or error) */
> -static int sync_cached_firmware_buf(struct firmware_buf *buf)
> -{
> -	int ret =3D 0;
> -
> -	mutex_lock(&fw_lock);
> -	while (!test_bit(FW_STATUS_DONE, &buf->status)) {
> -		if (is_fw_load_aborted(buf)) {
> -			ret =3D -ENOENT;
> -			break;
> -		}
> -		mutex_unlock(&fw_lock);
> -		ret =3D wait_for_completion_interruptible(&buf-
> >completion);
> -		mutex_lock(&fw_lock);
> -	}
> -	mutex_unlock(&fw_lock);
> -	return ret;
> -}
> -
> =C2=A0/* prepare firmware and firmware_buf structs;
> =C2=A0 * return 0 if a firmware is already assigned, 1 if need to loa=
d
> one,
> =C2=A0 * or a negative error code
> @@ -1039,7 +1028,8 @@ _request_firmware_prepare(struct firmware
> **firmware_p, const char *name,
> =C2=A0	firmware->priv =3D buf;
> =C2=A0
> =C2=A0	if (ret > 0) {
> -		ret =3D sync_cached_firmware_buf(buf);
> +		ret =3D fw_loading_wait_timeout(buf->fwst,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0firmware_loading_timeo
> ut());
> =C2=A0		if (!ret) {
> =C2=A0			fw_set_page_data(buf, firmware);
> =C2=A0			return 0; /* assigned */
> @@ -1057,7 +1047,7 @@ static int assign_firmware_buf(struct firmware
> *fw, struct device *device,
> =C2=A0	struct firmware_buf *buf =3D fw->priv;
> =C2=A0
> =C2=A0	mutex_lock(&fw_lock);
> -	if (!buf->size || is_fw_load_aborted(buf)) {
> +	if (!buf->size || is_fw_loading_aborted(buf->fwst)) {
> =C2=A0		mutex_unlock(&fw_lock);
> =C2=A0		return -ENOENT;
> =C2=A0	}
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index 5c41c5e..f584160 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -4,10 +4,17 @@
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/compiler.h>
> =C2=A0#include <linux/gfp.h>
> +#include <linux/swait.h>
> =C2=A0
> =C2=A0#define FW_ACTION_NOHOTPLUG 0
> =C2=A0#define FW_ACTION_HOTPLUG 1
> =C2=A0
> +enum {
> +	FW_STATUS_LOADING,
> +	FW_STATUS_LOADED,
> +	FW_STATUS_ABORT,
> +};
> +
> =C2=A0struct firmware {
> =C2=A0	size_t size;
> =C2=A0	const u8 *data;
> @@ -17,6 +24,11 @@ struct firmware {
> =C2=A0	void *priv;
> =C2=A0};
> =C2=A0
> +struct firmware_stat {
> +	unsigned long status;
> +	struct swait_queue_head wq;
> +};
> +
> =C2=A0struct module;
> =C2=A0struct device;
> =C2=A0
> @@ -49,6 +61,36 @@ int request_firmware_direct(const struct firmware
> **fw, const char *name,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0struct device *device);
> =C2=A0
> =C2=A0void release_firmware(const struct firmware *fw);
> +
> +static inline void firmware_stat_init(struct firmware_stat *fwst)
> +{
> +	init_swait_queue_head(&fwst->wq);
> +}
> +
> +static inline unsigned long __firmware_stat_get(struct firmware_stat
> *fwst)
> +{
> +	return READ_ONCE(fwst->status);
> +}
> +void __firmware_stat_set(struct firmware_stat *fwst, unsigned long
> status);
> +int __firmware_stat_wait(struct firmware_stat *fwst, long timeout);
> +
> +#define fw_loading_start(fwst)				=09
> \
> +	__firmware_stat_set(&fwst, FW_STATUS_LOADING)
> +#define fw_loading_done(fwst)				=09
> \
> +	__firmware_stat_set(&fwst, FW_STATUS_LOADED)
> +#define fw_loading_abort(fwst)				=09
> \
> +	__firmware_stat_set(&fwst, FW_STATUS_ABORT)
> +#define fw_loading_wait(fwst)				=09
> \
> +	__firmware_stat_wait(&fwst, 0)
> +#define fw_loading_wait_timeout(fwst, timeout)		=09
> \
> +	__firmware_stat_wait(&fwst, timeout)
> +#define is_fw_loading(fwst)					\
> +	(__firmware_stat_get(&fwst) =3D=3D FW_STATUS_LOADING)
> +#define is_fw_loading_done(fwst)				\
> +	(__firmware_stat_get(&fwst) =3D=3D FW_STATUS_LOADED)
> +#define is_fw_loading_aborted(fwst)				\
> +	(__firmware_stat_get(&fwst) =3D=3D FW_STATUS_ABORT)
> +
> =C2=A0#else
> =C2=A0static inline int request_firmware(const struct firmware **fw,
> =C2=A0				=C2=A0=C2=A0=C2=A0const char *name,
> @@ -75,5 +117,34 @@ static inline int request_firmware_direct(const
> struct firmware **fw,
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> +static inline void firmware_stat_init(struct firmware_stat *fwst)
> +{
> +}
> +
> +static inline unsigned long __firmware_stat_get(struct firmware_stat
> *fwst)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void __firmware_stat_set(struct firmware_stat *fwst,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long status)
> +{
> +}
> +
> +static inline int __firmware_stat_wait(struct firmware_stat *fwst,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0long timeout)
> +{
> +	return -EINVAL;
> +}
> +
> +#define fw_loading_start(fwst)
> +#define fw_loading_done(fwst)
> +#define fw_loading_abort(fwst)
> +#define fw_loading_wait(fwst)
> +#define fw_loading_wait_timeout(fwst, timeout)
> +#define is_fw_loading(fwst)		0
> +#define is_fw_loading_done(fwst)	0
> +#define is_fw_loading_aborted(fwst)	0
> +
> =C2=A0#endif
> =C2=A0#endif
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
