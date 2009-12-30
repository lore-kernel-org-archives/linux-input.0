From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Wed, 30 Dec 2009 10:01:01 +0100
Message-ID: <4B3B16CD.1050700@physik.uni-muenchen.de>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de> <20091221074419.GD3234@core.coreip.homeip.net> <20091221082259.GG3234@core.coreip.homeip.net> <4B39FA1D.6070107@physik.uni-muenchen.de> <1AD572D6-2C2F-4664-9B52-36A8D1BE8B29@gmail.com> <20091230032326.GC7049@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040904060501000107070906"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:37283 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202AbZL3JBD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2009 04:01:03 -0500
In-Reply-To: <20091230032326.GC7049@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040904060501000107070906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:
> On Tue, Dec 29, 2009 at 02:40:21PM -0800, Dmitry Torokhov wrote:
>>  Dec 29, 2009, at 4:46 AM, Johannes Ebke
>> <johannes.ebke@physik.uni-muenchen.de> wrote:
>>
>>> Dmitry Torokhov wrote:
>>>> On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
>>>>> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
>>>>>> Hi,
>>>>>>
>>>>>> It seems that the force feedback works well, I have ported
>>>>>> the force
>>>>>> feedback for my favorite game to linux now, and it works well.
>>>>>>
>>>>>> What does not work is updating effects - there just nothing
>>>>>> happens, and
>>>>>> the old event is played. I have circumvented this by
>>>>>> deleting/re-uploading the effect, but this should probably
>>>>>> been made to
>>>>>> work. Does it work well with other hardware?
>>>>>>
>>>>>> Thirdly, I have re-discovered one kernel oops that occurs if the
>>>>>> joystick is unplugged if some process still has the event
>>>>>> device open.
>>>>>> Steps to reproduce:
>>>>>> * plug joystick in
>>>>>> * fftest /dev/input/eventXX
>>>>>> * unplug joystick
>>>>>>
>>>>>> (kern.log extract attached)
>>>>>>
>>>>>> Sometimes this just gives an oops, sometimes it escalates
>>>>>> into a kernel
>>>>>> panic.
>>>>>>
>>>>> Hmm, it looks like iforce unbinding is completely busted:
>>>>>
>>>>> static void iforce_usb_disconnect(struct usb_interface *intf)
>>>>> {
>>>>>       struct iforce *iforce = usb_get_intfdata(intf);
>>>>>       int open = 0; /* FIXME! iforce->dev.handle->open; */
>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>
>>>>>       usb_set_intfdata(intf, NULL);
>>>>>       if (iforce) {
>>>>>               iforce->usbdev = NULL;
>>>>>               input_unregister_device(iforce->dev);
>>>>>
>>>>>               if (!open) {
>>>>>                       iforce_delete_device(iforce);
>>>>>                       kfree(iforce);
>>>>>               }
>>>>>       }
>>>>> }
>>>>>
>>>>>
>>>>> Any chance you could fix that FIXME ;) ?
>>>>>
>>>> Actually, does the below fixes it for you?
>>>>
>>> This fixes the kernel oops - thanks! However it also disables FF,
>>> unless
>>> I remove "usb_kill_urb(iforce->out);" from iforce_close.
>> >From some debug statements I found that iforce_close is called
>>> twice if
>>> you just plug in the joystick, so the effect is immediate.
>> I still believe that usb_kill_urb is needed however we need to wait
>> for packet disabling FF to complete.
>>
> 
> Does the patch below (on top of the unmodofied previous one) fixes the
> issue for you?
> 
> Thanks.
> 

This fixes it completely, both the FF and the clean shutdown on
unexpected disconnect! Thank you very much!

Finally, for correct orientation of the rudder axis, I have attached one
small change to packets - this makes it work for me if i remove the old
configuration.

One other question: Since the USB HID driver can actually discover the
joystick buttons and axis ranges sucessfully, would it not be easier to
use that for generic input and only add force-feedback in iforce, or is
that just too much overhead? Thanks!

Cheers,
Johannes


--------------040904060501000107070906
Content-Type: text/x-patch;
 name="flipRx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flipRx.patch"

Input: iforce - flip initial RUDDER orientation to correct one

Remove the inversion from the data acqisition routine

Signed-off-by: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
---

diff -ru drivers/input/joystick/iforce_dmitry/iforce-packets.c drivers/input/joystick/iforce/iforce-packets.c
--- drivers/input/joystick/iforce_dmitry/iforce-packets.c	2009-12-30 09:42:22.000000000 +0100
+++ drivers/input/joystick/iforce/iforce-packets.c	2009-12-30 09:32:34.000000000 +0100
@@ -193,7 +193,7 @@
 				if (HI(cmd) == 6) {
 					input_report_abs(dev, ABS_THROTTLE, data[4]);
 					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-						input_report_abs(dev, ABS_RUDDER, 255 - data[7]);
+						input_report_abs(dev, ABS_RUDDER, data[7]);
 				} else {
 					input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))

--------------040904060501000107070906--
