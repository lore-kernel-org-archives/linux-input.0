From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Wed, 30 Dec 2009 12:32:22 +0100
Message-ID: <4B3B3A46.5010300@physik.uni-muenchen.de>
References: <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de> <20091221074419.GD3234@core.coreip.homeip.net> <20091221082259.GG3234@core.coreip.homeip.net> <4B39FA1D.6070107@physik.uni-muenchen.de> <1AD572D6-2C2F-4664-9B52-36A8D1BE8B29@gmail.com> <20091230032326.GC7049@core.coreip.homeip.net> <4B3B16CD.1050700@physik.uni-muenchen.de> <20091230104744.GB2214@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:49090 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659AbZL3LcY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2009 06:32:24 -0500
In-Reply-To: <20091230104744.GB2214@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry Torokhov wrote:
> On Wed, Dec 30, 2009 at 10:01:01AM +0100, Johannes Ebke wrote:
>> Dmitry Torokhov wrote:
>>> On Tue, Dec 29, 2009 at 02:40:21PM -0800, Dmitry Torokhov wrote:
>>>>  Dec 29, 2009, at 4:46 AM, Johannes Ebke
>>>> <johannes.ebke@physik.uni-muenchen.de> wrote:
>>>>
>>>>> Dmitry Torokhov wrote:
>>>>>> On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
>>>>>>> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> It seems that the force feedback works well, I have ported
>>>>>>>> the force
>>>>>>>> feedback for my favorite game to linux now, and it works well.
>>>>>>>>
>>>>>>>> What does not work is updating effects - there just nothing
>>>>>>>> happens, and
>>>>>>>> the old event is played. I have circumvented this by
>>>>>>>> deleting/re-uploading the effect, but this should probably
>>>>>>>> been made to
>>>>>>>> work. Does it work well with other hardware?
>>>>>>>>
>>>>>>>> Thirdly, I have re-discovered one kernel oops that occurs if the
>>>>>>>> joystick is unplugged if some process still has the event
>>>>>>>> device open.
>>>>>>>> Steps to reproduce:
>>>>>>>> * plug joystick in
>>>>>>>> * fftest /dev/input/eventXX
>>>>>>>> * unplug joystick
>>>>>>>>
>>>>>>>> (kern.log extract attached)
>>>>>>>>
>>>>>>>> Sometimes this just gives an oops, sometimes it escalates
>>>>>>>> into a kernel
>>>>>>>> panic.
>>>>>>>>
>>>>>>> Hmm, it looks like iforce unbinding is completely busted:
>>>>>>>
>>>>>>> static void iforce_usb_disconnect(struct usb_interface *intf)
>>>>>>> {
>>>>>>>       struct iforce *iforce = usb_get_intfdata(intf);
>>>>>>>       int open = 0; /* FIXME! iforce->dev.handle->open; */
>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>
>>>>>>>       usb_set_intfdata(intf, NULL);
>>>>>>>       if (iforce) {
>>>>>>>               iforce->usbdev = NULL;
>>>>>>>               input_unregister_device(iforce->dev);
>>>>>>>
>>>>>>>               if (!open) {
>>>>>>>                       iforce_delete_device(iforce);
>>>>>>>                       kfree(iforce);
>>>>>>>               }
>>>>>>>       }
>>>>>>> }
>>>>>>>
>>>>>>>
>>>>>>> Any chance you could fix that FIXME ;) ?
>>>>>>>
>>>>>> Actually, does the below fixes it for you?
>>>>>>
>>>>> This fixes the kernel oops - thanks! However it also disables FF,
>>>>> unless
>>>>> I remove "usb_kill_urb(iforce->out);" from iforce_close.
>>>> >From some debug statements I found that iforce_close is called
>>>>> twice if
>>>>> you just plug in the joystick, so the effect is immediate.
>>>> I still believe that usb_kill_urb is needed however we need to wait
>>>> for packet disabling FF to complete.
>>>>
>>> Does the patch below (on top of the unmodofied previous one) fixes the
>>> issue for you?
>>>
>>> Thanks.
>>>
>> This fixes it completely, both the FF and the clean shutdown on
>> unexpected disconnect! Thank you very much!
> 
> Ah, great!
>  
>> Finally, for correct orientation of the rudder axis, I have attached one
>> small change to packets - this makes it work for me if i remove the old
>> configuration.
> 
> Hmm, that might break some other users though (or does it only kick in
> for Cyborg?

This is in the part that only kicks in for the Cyborg, or perhaps other
devices as well (if(HI(cmd)==6)..)

> 
>> One other question: Since the USB HID driver can actually discover the
>> joystick buttons and axis ranges sucessfully, would it not be easier to
>> use that for generic input and only add force-feedback in iforce, or is
>> that just too much overhead?
> 
> We do prefer to have HID driver handle the devices and have only
> non-HID-compliant devices use specialized drivers. Iforce is an older
> driver though, working with both USB devices and devices attached to
> serial ports.
> 
> Does your joystick works well with HID driver (sans FF)?
> 

Yes, with one grievance: Since the "dead man switch" is not physically
present on the cyborg but logically present and "always on", some
applications like the flightgear joystick calibration "fgjs" cannot be used.
However, I am not sure how the information "this is a dead man switch"
can be published to userspace most efficiently, and the application
should probably deal with it anyway (stuck key in old joystick, etc...)

Cheers,
Johannes
