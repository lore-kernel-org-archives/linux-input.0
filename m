From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: [PATCH] Revert "HID: Invert HWHEEL mappings for some Logitech mice"
Date: Wed, 22 Oct 2008 06:07:16 -0700
Message-ID: <91705d080810220607i494d63ccx5c468c672baa6aab@mail.gmail.com>
References: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz>
	 <1224219974-4216-1-git-send-email-dbn.lists@gmail.com>
	 <alpine.LNX.1.10.0810171125090.28536@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:35759 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYJVNHR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Oct 2008 09:07:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3014604wfd.4
        for <linux-input@vger.kernel.org>; Wed, 22 Oct 2008 06:07:16 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0810171125090.28536@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ander Conselvan de Oliveira <ander@c3sl.ufpr.br>, linux-input@vger.kernel.org, stable@kernel.org

On Fri, Oct 17, 2008 at 2:26 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 16 Oct 2008, Dan Nicholson wrote:
>
>> This reverts commit 740f370dc61dc478d891d7d47660bb3ae39ddb4f.
>>
>> It turned out to be correct in the first place: a positive value should
>> be sent when the wheel is moved to the right, and a negative value when
>> moved to the left. This is the behavior expected by the Xorg evdev
>> driver. I must have had a remapping somewhere else in my system when
>> originally testing this. Testing on another system shows that the
>> unpatched kernel is correct.
>
> Hi Dan,
>
> thanks. Still I'd like to understand what caused the behavior you were
> seeing. Do you still have the system showing the inverted values
> available?

Hi Jiri,

Sorry for the slow reply; I was travelling for a few days.

I've now gotten the old system back up with a patched 2.6.22 kernel.
After comparing it to a freshly installed Fedora 9 system with an
unpatched 2.6.26 kernel, I can say that the difference is the
xf86-input-evdev driver. I was able to build a newer xf86-input-evdev
driver and swap that in against my older kernel.

linux-2.6.22 (without patch) + xf86-input-evdev-1.1.5:
  wheel left = HWheel -1 = X button 7
  wheel right = HWheel +1 = X button 6

linux-2.6.22 (with patch) + xf86-input-evdev-1.1.5:
  wheel left = HWheel +1 = X button 6
  wheel right = HWheel -1 = X button 7

linux-2.6.22 (with patch) + xf86-input-evdev-2.0.7:
  wheel left = HWheel +1 = X button 7
  wheel right = HWheel -1 = X button 6

linux-2.6.22 (with patchout) + xf86-input-evdev-2.0.7:
  wheel left = HWheel -1 = X button 6
  wheel right = HWheel +1 = X button 7

linux-2.6.26 (without patch) + xf86-input-evdev-2.0.7:
  wheel left = HWheel -1 = X button 6
  wheel right = HWheel +1 = X button 7

X applications behave correctly when wheel left = button 6 and wheel
right = button 7. When I started using the newer xf86-input-evdev with
an unpatched kernel, things work fine.

So, it seems that X evdev-1.1.x interprets +1 events from the kernel
as button 6, and X evdev 2.0.x interprets +1 events from the kernel as
button 7. I don't know who's correct there, but here's quoting Ander
on how xf86-input-evdev-2.x works:

'''
I have a user reporting his horizontal wheel is inverted using the evdev input
driver. If I understand correctly, evdev handles positive values as "to the
right" and negative as "to the left":

           case REL_HWHEEL:
               if (value > 0)
                   PostButtonClicks(pInfo, wheel_right_button, value);
               if (value < 0)
                   PostButtonClicks(pInfo, wheel_left_button, -value);
               break;
'''

I tried having a look at the older X evdev driver, but it was much
more convoluted and I couldn't figure it out.

What do you think? I'm gonna lean towards the newer X evdev driver
behaving correctly, but I have no authority here.

--
Dan
