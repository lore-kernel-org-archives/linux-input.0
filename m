From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 1/7] HID: sony: Fix race condition in sony_probe
Date: Tue, 11 Oct 2016 08:52:27 -0700
Message-ID: <CANndSK=gOSbT3PhEQLSrQbKGMxbx6-B9dN-HR9g8Ks784jLnPQ@mail.gmail.com>
References: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
 <1475869180-26757-2-git-send-email-roderick@gaikai.com> <CANndSKk54o_XSgH-V8Yt-tc0BpygrScB3juMBUfJio49FSFLEQ@mail.gmail.com>
 <20161011154300.GN30411@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34234 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbcJKPyV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Oct 2016 11:54:21 -0400
Received: by mail-vk0-f52.google.com with SMTP id b186so23893959vkb.1
        for <linux-input@vger.kernel.org>; Tue, 11 Oct 2016 08:52:28 -0700 (PDT)
In-Reply-To: <20161011154300.GN30411@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Tue, Oct 11, 2016 at 8:43 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Oct 10 2016 or thereabouts, Roderick Colenbrander wrote:
>> Hi,
>>
>> We have been developing some new code building on top of this hid-sony patchset.
>> However during additional testing we noticed some issues between
>> swapping devices
>> between USB and Bluetooth. There is some code as part of 'sony_input_configured'
>> preventing two connections from the same device. The code is kind of
>> working as it
>> rejects the device, but there is some memory corruption due to 'sony_probe'
>> succeeding on this failure (later on 'sony_remove' double frees memory), which
>> was introduced by this patch. We intend to fix this, but I'm not sure
>> where the fix
>> should be. So far I'm leaning towards outside of this driver, but let
>> me explain.
>>
>> On close inspection, the problem is that 'hid_hw_start' as called by
>> 'sony_probe'
>> isn't returning an error on a 'sony_input_configured' failure.
>> Personally, I expected
>> it to behave like that, but it doesn't. As an outsider to the HID subsystem, I'm
>> not sure what expected behavior is.
>>
>> I looked over some other drivers, which are emitting errors from
>> 'input_configured'.
>> There are only 2 drivers returning errors and catching them through a
>> custom mechanism.
>> The drivers are 'hid-magicmouse' and 'hid-rmi'. The first kind of works around
>> 'hid_hw_start' returning errors by setting some state (msc->input) from within
>> 'input_configured' which 'probe' can pick up.
>
> Well, hid-magicmouse is not the best of the art in term of HID driver.
> But this quirk works OK-ish.
>
>> The 'hid-rmi' driver kind of relies on hid_hw_start not returning
>> errors. It leaves
>> the device in some in-between state with hidraw operational, so
>> someone could flash
>> a new firmware. For reference I have attached these code snippets to
>> the bottom of this
>> email.
>
> And hid-rmi is also a "temporary" driver and we (Andrew mostly) are
> trying to clean it up and forward all the RMI4 logic to RMI4 core now
> upstream in the drivers/input/rmi4 directory.
>
>>
>> I'm not exactly sure on what the best way to fix the issue I'm
>> experiencing is. My
>> feeling is that it should be fixed in a general way within
>> 'hid_hw_start' and related
>> logic; not in a driver specific workaround. Outside of hid_hw_start
>> feels unclean
>> to me for various including keeping a device node around in some undefined state
>> for a short period of time.
>
> I am not entirely sure having hidinput_connect failing being an actual
> error. It can be useful to still present the HID node through hidraw if
> the device fails for whatever reasons to bind on the input side.
>
> If I am not wrong, you can simply check after hid_hw_start() if
> hdev->claimed matches HID_CLAIMED_INPUT, and if not just bail out.

Yep that's correct. We actually implemented that method already, but
weren't sure if it was a workaround or a solution. What concerned me
is that doing it this way still leaves a 'transient' device node
around (although for a very short while until probe really fails). If
you think something like this is fine over, maybe modifying the other
HID code, I'm fine with that.

Thanks,
Roderick
