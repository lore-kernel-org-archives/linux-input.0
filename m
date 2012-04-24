From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Tue, 24 Apr 2012 23:46:41 +0800
Message-ID: <CACVXFVM_p=VZ76zX89CppbeXFh-bhTwqzU6FWHzuaJa2bYcBUA@mail.gmail.com>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
	<Pine.LNX.4.44L0.1204231121200.1612-100000@iolanthe.rowland.org>
	<CACVXFVNhPKbFZN5AjT3BNdNP+3bZP7miJZrBEER97scMR5nNAQ@mail.gmail.com>
	<201204241622.08411.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46609 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab2DXPqp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 11:46:45 -0400
In-Reply-To: <201204241622.08411.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Tue, Apr 24, 2012 at 10:22 PM, Oliver Neukum <oneukum@suse.de> wrote=
:
> Am Dienstag, 24. April 2012, 06:19:00 schrieb Ming Lei:
>
>> @@ -486,11 +494,15 @@ static void hid_ctrl(struct urb *urb)
>>
>> =A0 =A0 =A0 if (usbhid->ctrlhead !=3D usbhid->ctrltail && !hid_submi=
t_ctrl(hid)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Successfully submitted next urb in qu=
eue */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status !=3D -ECONNRESET)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&usbhid->unlin=
k_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&usbhid->lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
>> + =A0 =A0 if (status !=3D -ECONNRESET)
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&usbhid->unlink_lock);
>> =A0 =A0 =A0 spin_unlock(&usbhid->lock);
>> =A0 =A0 =A0 usb_autopm_put_interface_async(usbhid->intf);
>> =A0 =A0 =A0 wake_up(&usbhid->wait);
>
> Now you race against a double time out
>
> CPU A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU B
>
> __usbhid_submit_report()
> time_after()
> usb_unlink_urb()
> -- this has to go to the hardware -->
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
hid_irq_out()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
if (status !=3D -ECONNRESET)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
--> no lock
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
hid_submit_out()
> __usbhid_submit_report()
> time_after()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
usb_submit_urb()

This submit won't happen because HID_OUT_RUNNING is not cleared.

> usb_unlink_urb()
>
>
>> @@ -546,8 +558,13 @@ static void __usbhid_submit_report(struct
>> hid_device *hid, struct hid_report *re
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because thi=
s is called under
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* spinlock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, us=
bhid->last_out + HZ * 5))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&usbhid->unlink_=
lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, us=
bhid->last_out + HZ * 5)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unloc=
k(&usbhid->lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_unli=
nk_urb(usbhid->urbout);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(=
&usbhid->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&usbhid->unlin=
k_lock);
>
> AB-BA deadlock

OK, if we always acquire unlink_lock before lock in usbhid_submit_repor=
t,
hid_led, hid_ctrl, and hid_irq_out, the AB-BA deadlock can be removed.

Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
