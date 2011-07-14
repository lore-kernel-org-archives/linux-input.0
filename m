From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC] [PATCH] HID: Fix race condition between driver core and ll-driver
Date: Thu, 14 Jul 2011 10:48:24 +0200
Message-ID: <CANq1E4QLsSezP-pSFsNWPT924Xc9y=j8jHi2R-k4ieZzewO5PA@mail.gmail.com>
References: <1310567061-2679-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54995 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab1GNIsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2011 04:48:25 -0400
Received: by vws1 with SMTP id 1so23866vws.19
        for <linux-input@vger.kernel.org>; Thu, 14 Jul 2011 01:48:24 -0700 (PDT)
In-Reply-To: <1310567061-2679-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, dmitry.torokhov@gmail.com, David Herrmann <dh.herrmann@googlemail.com>

On Wed, Jul 13, 2011 at 4:24 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> HID low level drivers register new devices with the HID core which th=
en
> adds the devices to the HID bus. The HID bus normally immediately pro=
bes
> an appropriate driver which then handles HID input for this device.
> The ll driver now uses the hid_input_report() function to report inpu=
t
> events for a specific device. However, if the HID bus unloads the dri=
ver
> at the same time (for instance via a call to
> =A0/sys/bus/hid/devices/<dev>/unbind) then the hdev->driver pointer m=
ay be
> used by hid_input_report() and hid_device_remove() at the same time
> which may cause hdev->driver to point to invalid memory.
>
> This fix adds a semaphore to every hid device which protects
> hdev->driver from asynchronous access. This semaphore is locked durin=
g
> driver *_probe and *_remove and also inside hid_input_report(). The
> *_probe and *_remove functions may sleep so the semaphore is good her=
e,
> however, hid_input_report() is in atomic context and hence only uses
> down_trylock(). If it cannot acquire the lock it simply drops the inp=
ut
> package.
>
> The low-level drivers report input events synchronously so
> hid_input_report() should never be entered twice at the same time on =
the
> same device. Hence, the lock should always be available. But if the
> driver is currently probed/removed then the lock is not available and
> dropping the package should be safe because this is what would have
> happened if the package arrived some milliseconds earlier/later.
>
> This also fixes another race condition while probing drivers:
> First the *_probe function of the driver is called and only if that
> succeeds, the related input device of hidinput is registered. If the =
low
> level driver reports input events after the *_probe function returned
> but before the input device is registered, then a NULL pointer
> dereference will occur. (Equivalently on driver remove function).
> This is not possible anymore, since the semaphore lock drops all
> incoming packages until the driver/device is fully initialized.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> =A0drivers/hid/hid-core.c | =A0 41 ++++++++++++++++++++++++++++++++++=
-------
> =A0include/linux/hid.h =A0 =A0| =A0 =A02 ++
> =A02 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2a268fc..59b1a5b 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -29,6 +29,7 @@
> =A0#include <linux/wait.h>
> =A0#include <linux/vmalloc.h>
> =A0#include <linux/sched.h>
> +#include <linux/semaphore.h>
>
> =A0#include <linux/hid.h>
> =A0#include <linux/hiddev.h>
> @@ -1087,14 +1088,23 @@ int hid_input_report(struct hid_device *hid, =
int type, u8 *data, int size, int i
> =A0 =A0 =A0 =A0unsigned int i;
> =A0 =A0 =A0 =A0int ret;

This must be "int ret =3D 0;".

>
> - =A0 =A0 =A0 if (!hid || !hid->driver)
> + =A0 =A0 =A0 if (!hid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> +
> + =A0 =A0 =A0 if (down_trylock(&hid->driver_lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 if (!hid->driver) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0report_enum =3D hid->report_enum + type;
> =A0 =A0 =A0 =A0hdrv =3D hid->driver;
>
> =A0 =A0 =A0 =A0if (!size) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbg_hid("empty report\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0buf =3D kmalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_=
ATOMIC);
> @@ -1118,17 +1128,23 @@ int hid_input_report(struct hid_device *hid, =
int type, u8 *data, int size, int i
> =A0nomem:
> =A0 =A0 =A0 =A0report =3D hid_get_report(report_enum, data);
>
> - =A0 =A0 =A0 if (!report)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 if (!report) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (hdrv && hdrv->raw_event && hid_match_report(hid, r=
eport)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D hdrv->raw_event(hid, report, d=
ata, size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret < 0 ? ret : =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ret < 0 ? ret :=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0hid_report_raw_event(hid, type, data, size, interrupt)=
;
>
> +unlock:
> + =A0 =A0 =A0 up(&hid->driver_lock);
> =A0 =A0 =A0 =A0return 0;

And this must be "return ret;" of course.

>
> Regards
> David
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
