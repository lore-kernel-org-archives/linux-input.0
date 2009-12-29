From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Tue, 29 Dec 2009 13:46:21 +0100
Message-ID: <4B39FA1D.6070107@physik.uni-muenchen.de>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de> <20091221074419.GD3234@core.coreip.homeip.net> <20091221082259.GG3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:53020 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475AbZL2MqZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Dec 2009 07:46:25 -0500
In-Reply-To: <20091221082259.GG3234@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
>> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
>>> Hi,
>>>
>>> It seems that the force feedback works well, I have ported the force
>>> feedback for my favorite game to linux now, and it works well.
>>>
>>> What does not work is updating effects - there just nothing happens, and
>>> the old event is played. I have circumvented this by
>>> deleting/re-uploading the effect, but this should probably been made to
>>> work. Does it work well with other hardware?
>>>
>>> Thirdly, I have re-discovered one kernel oops that occurs if the
>>> joystick is unplugged if some process still has the event device open.
>>> Steps to reproduce:
>>> * plug joystick in
>>> * fftest /dev/input/eventXX
>>> * unplug joystick
>>>
>>> (kern.log extract attached)
>>>
>>> Sometimes this just gives an oops, sometimes it escalates into a kernel
>>> panic.
>>>
>> Hmm, it looks like iforce unbinding is completely busted:
>>
>> static void iforce_usb_disconnect(struct usb_interface *intf)
>> {
>>         struct iforce *iforce = usb_get_intfdata(intf);
>>         int open = 0; /* FIXME! iforce->dev.handle->open; */
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>         usb_set_intfdata(intf, NULL);
>>         if (iforce) {
>>                 iforce->usbdev = NULL;
>>                 input_unregister_device(iforce->dev);
>>
>>                 if (!open) {
>>                         iforce_delete_device(iforce);
>>                         kfree(iforce);
>>                 }
>>         }
>> }
>>
>>
>> Any chance you could fix that FIXME ;) ?
>>
>
> Actually, does the below fixes it for you?
>

This fixes the kernel oops - thanks! However it also disables FF, unless
I remove "usb_kill_urb(iforce->out);" from iforce_close.
>From some debug statements I found that iforce_close is called twice if
you just plug in the joystick, so the effect is immediate.

However, when I unplug the joystick while having it open, I get some
input input22: usb_submit_urb failed -19
messages in dmesg (after iforce_disconnect but before iforce_close)
This is probably what should happen, however.

Cheers,
Johannes
