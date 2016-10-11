From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/7] HID: sony: Fix race condition in sony_probe
Date: Tue, 11 Oct 2016 17:43:00 +0200
Message-ID: <20161011154300.GN30411@mail.corp.redhat.com>
References: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
 <1475869180-26757-2-git-send-email-roderick@gaikai.com>
 <CANndSKk54o_XSgH-V8Yt-tc0BpygrScB3juMBUfJio49FSFLEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752185AbcJKPnE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Oct 2016 11:43:04 -0400
Content-Disposition: inline
In-Reply-To: <CANndSKk54o_XSgH-V8Yt-tc0BpygrScB3juMBUfJio49FSFLEQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Oct 10 2016 or thereabouts, Roderick Colenbrander wrote:
> Hi,
> 
> We have been developing some new code building on top of this hid-sony patchset.
> However during additional testing we noticed some issues between
> swapping devices
> between USB and Bluetooth. There is some code as part of 'sony_input_configured'
> preventing two connections from the same device. The code is kind of
> working as it
> rejects the device, but there is some memory corruption due to 'sony_probe'
> succeeding on this failure (later on 'sony_remove' double frees memory), which
> was introduced by this patch. We intend to fix this, but I'm not sure
> where the fix
> should be. So far I'm leaning towards outside of this driver, but let
> me explain.
> 
> On close inspection, the problem is that 'hid_hw_start' as called by
> 'sony_probe'
> isn't returning an error on a 'sony_input_configured' failure.
> Personally, I expected
> it to behave like that, but it doesn't. As an outsider to the HID subsystem, I'm
> not sure what expected behavior is.
> 
> I looked over some other drivers, which are emitting errors from
> 'input_configured'.
> There are only 2 drivers returning errors and catching them through a
> custom mechanism.
> The drivers are 'hid-magicmouse' and 'hid-rmi'. The first kind of works around
> 'hid_hw_start' returning errors by setting some state (msc->input) from within
> 'input_configured' which 'probe' can pick up.

Well, hid-magicmouse is not the best of the art in term of HID driver.
But this quirk works OK-ish.

> The 'hid-rmi' driver kind of relies on hid_hw_start not returning
> errors. It leaves
> the device in some in-between state with hidraw operational, so
> someone could flash
> a new firmware. For reference I have attached these code snippets to
> the bottom of this
> email.

And hid-rmi is also a "temporary" driver and we (Andrew mostly) are
trying to clean it up and forward all the RMI4 logic to RMI4 core now
upstream in the drivers/input/rmi4 directory.

> 
> I'm not exactly sure on what the best way to fix the issue I'm
> experiencing is. My
> feeling is that it should be fixed in a general way within
> 'hid_hw_start' and related
> logic; not in a driver specific workaround. Outside of hid_hw_start
> feels unclean
> to me for various including keeping a device node around in some undefined state
> for a short period of time.

I am not entirely sure having hidinput_connect failing being an actual
error. It can be useful to still present the HID node through hidraw if
the device fails for whatever reasons to bind on the input side.

If I am not wrong, you can simply check after hid_hw_start() if
hdev->claimed matches HID_CLAIMED_INPUT, and if not just bail out.

> 
> The root cause seems to be that 'hid_connect' doesn't return a failure upon
> 'hidinput_connect' and only sets a flag:
>     if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
>                 connect_mask & HID_CONNECT_HIDINPUT_FORCE))
>         hdev->claimed |= HID_CLAIMED_INPUT;
> 
> I think it should return an error when hidinput_connect fails, which
> would ultimately
> bubble up to a return error in 'hid_hw_start'. I don't know the
> intimate details of
> all the HID code well, so I'm not sure if this is the best solution.
> 
> With such a change made, the 'if (!msc->input)' logic in magicmouse_probe could
> be removed. The RMI driver would need some fixing. I would say it should call
> 'hid_hw_start' again on the first hid_hw_start failure, but with a different
> connect_mask, so only hidraw is activated.

Again, I wouldn't bother much for these 2 drivers. The first one works
and this wouldn't add much, and the second one is doomed to be changed,
so as long as it ain't broken... :)

Cheers,
Benjamin

> 
> 
> For reference two pieces of code, which are dealing with the same kind
> of problem,
> I'm seeing in hid-sony. I put some comments '<--' to show relevant pieces.
> 
> magicmouse_input_configured:
>     ret = magicmouse_setup_input(msc->input, hdev);
>     if (ret) {
>         hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
>         /* clean msc->input to notify probe() of the failure */
>         msc->input = NULL; <-- Used to notify magicmouse_probe on
> hid_hw_start failure
>         return ret;
>     }
> 
> magicmouse_probe:
>     ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>     if (ret) {
>         hid_err(hdev, "magicmouse hw start failed\n");
>         return ret;
>     }
> 
>     if (!msc->input) { <-- workaround to detect
> magicmouse_input_configured failure
>         hid_err(hdev, "magicmouse input not registered\n");
>         ret = -ENOMEM;
>         goto err_stop_hw;
>     }
> 
> 
> rmi_probe:
>     ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>     if (ret) {
>         hid_err(hdev, "hw start failed\n");
>         return ret;
>     }
> 
>     if ((data->device_flags & RMI_DEVICE) &&
>         !test_bit(RMI_STARTED, &data->flags)) <-- input_configure sets
> this bit on success
>         /*
>          * The device maybe in the bootloader if rmi_input_configured
>          * failed to find F11 in the PDT. Print an error, but don't
>          * return an error from rmi_probe so that hidraw will be
>          * accessible from userspace. That way a userspace tool
>          * can be used to reload working firmware on the touchpad.
>          */
>         hid_err(hdev, "Device failed to be properly configured\n");
> 
> 
> Thanks,
> Roderick
