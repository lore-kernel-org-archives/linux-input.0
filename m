From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 1/7] HID: sony: Fix race condition in sony_probe
Date: Mon, 10 Oct 2016 15:03:36 -0700
Message-ID: <CANndSKk54o_XSgH-V8Yt-tc0BpygrScB3juMBUfJio49FSFLEQ@mail.gmail.com>
References: <1475869180-26757-1-git-send-email-roderick@gaikai.com> <1475869180-26757-2-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33338 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbcJJWDi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Oct 2016 18:03:38 -0400
Received: by mail-vk0-f46.google.com with SMTP id z126so2860664vkd.0
        for <linux-input@vger.kernel.org>; Mon, 10 Oct 2016 15:03:37 -0700 (PDT)
In-Reply-To: <1475869180-26757-2-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

We have been developing some new code building on top of this hid-sony patchset.
However during additional testing we noticed some issues between
swapping devices
between USB and Bluetooth. There is some code as part of 'sony_input_configured'
preventing two connections from the same device. The code is kind of
working as it
rejects the device, but there is some memory corruption due to 'sony_probe'
succeeding on this failure (later on 'sony_remove' double frees memory), which
was introduced by this patch. We intend to fix this, but I'm not sure
where the fix
should be. So far I'm leaning towards outside of this driver, but let
me explain.

On close inspection, the problem is that 'hid_hw_start' as called by
'sony_probe'
isn't returning an error on a 'sony_input_configured' failure.
Personally, I expected
it to behave like that, but it doesn't. As an outsider to the HID subsystem, I'm
not sure what expected behavior is.

I looked over some other drivers, which are emitting errors from
'input_configured'.
There are only 2 drivers returning errors and catching them through a
custom mechanism.
The drivers are 'hid-magicmouse' and 'hid-rmi'. The first kind of works around
'hid_hw_start' returning errors by setting some state (msc->input) from within
'input_configured' which 'probe' can pick up.
The 'hid-rmi' driver kind of relies on hid_hw_start not returning
errors. It leaves
the device in some in-between state with hidraw operational, so
someone could flash
a new firmware. For reference I have attached these code snippets to
the bottom of this
email.

I'm not exactly sure on what the best way to fix the issue I'm
experiencing is. My
feeling is that it should be fixed in a general way within
'hid_hw_start' and related
logic; not in a driver specific workaround. Outside of hid_hw_start
feels unclean
to me for various including keeping a device node around in some undefined state
for a short period of time.

The root cause seems to be that 'hid_connect' doesn't return a failure upon
'hidinput_connect' and only sets a flag:
    if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
                connect_mask & HID_CONNECT_HIDINPUT_FORCE))
        hdev->claimed |= HID_CLAIMED_INPUT;

I think it should return an error when hidinput_connect fails, which
would ultimately
bubble up to a return error in 'hid_hw_start'. I don't know the
intimate details of
all the HID code well, so I'm not sure if this is the best solution.

With such a change made, the 'if (!msc->input)' logic in magicmouse_probe could
be removed. The RMI driver would need some fixing. I would say it should call
'hid_hw_start' again on the first hid_hw_start failure, but with a different
connect_mask, so only hidraw is activated.


For reference two pieces of code, which are dealing with the same kind
of problem,
I'm seeing in hid-sony. I put some comments '<--' to show relevant pieces.

magicmouse_input_configured:
    ret = magicmouse_setup_input(msc->input, hdev);
    if (ret) {
        hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
        /* clean msc->input to notify probe() of the failure */
        msc->input = NULL; <-- Used to notify magicmouse_probe on
hid_hw_start failure
        return ret;
    }

magicmouse_probe:
    ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    if (ret) {
        hid_err(hdev, "magicmouse hw start failed\n");
        return ret;
    }

    if (!msc->input) { <-- workaround to detect
magicmouse_input_configured failure
        hid_err(hdev, "magicmouse input not registered\n");
        ret = -ENOMEM;
        goto err_stop_hw;
    }


rmi_probe:
    ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    if (ret) {
        hid_err(hdev, "hw start failed\n");
        return ret;
    }

    if ((data->device_flags & RMI_DEVICE) &&
        !test_bit(RMI_STARTED, &data->flags)) <-- input_configure sets
this bit on success
        /*
         * The device maybe in the bootloader if rmi_input_configured
         * failed to find F11 in the PDT. Print an error, but don't
         * return an error from rmi_probe so that hidraw will be
         * accessible from userspace. That way a userspace tool
         * can be used to reload working firmware on the touchpad.
         */
        hid_err(hdev, "Device failed to be properly configured\n");


Thanks,
Roderick
