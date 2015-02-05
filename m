From: simon@mungewell.org
Subject: EPERM instead of EINVAL?
Date: Thu, 5 Feb 2015 12:51:18 -0500
Message-ID: <5b8e4413b01943e95996b4b4614b5d76.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:36646 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbBESVW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 13:21:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>, Elias Vanderstuyft <elias.vds@gmail.com>, Edwin Velds <edwin@velds.nl>

Hi all,
Michal is working on another round of changes for the Logitech wheel
(hid-lg4ff), and we are including code to switch between different modes -
thus allowing a G27 wheel (for example) to emulate a simpler wheel.

At present we automatically 'upgrade' wheel to the best mode they can
handle, we then allow the user to 'downgrade' as they wish.

However, we have to prevent them downgrading to the simplest
(USB_DEVICE_ID_LOGITECH_WHEEL) as when the devices does the USB
detach/attach it would then just upgrade automatically.

We have a module parameter which prevents the automatic upgrade if the
user _really_ wants their expensive wheel to behave like the cheapest.

The code does this:
--
        /* Automatic switching has to be disabled for the switch to DF-EX
mode to work
correctly */
        if (target_product_id == USB_DEVICE_ID_LOGITECH_WHEEL &&
!lg4ff_no_autoswitch) {
                hid_info(hid, "\"%s\" cannot be switched to \"DF-EX\"
mode. Load the
\"hid_logitech\" module with \"lg4ff_no_autoswitch=1\" parameter set and try
again.\n",
                       entry->real_name);
                return -EINVAL;
        }
--

So it throws an EINVAL if you try to set simplest when auto-switch is
enabled.

The message on the console is a little confusing, but hid debug explains.
--
root@bigbox:/storage/linux-git# echo DF-EX >
/sys/bus/hid/devices/0003\:046D\:C298.000F/alternate_modes
bash: echo: write error: Invalid argument
--
Feb  4 22:21:01 bigbox kernel: [ 7715.452435] logitech
0003:046D:C298.000F: "G27 Racing Wheel" cannot be switched to "DF-EX"
mode. Load the "hid_logitech" module with "lg4ff_no_autoswitch=1"
parameter set and try again.
--

Would it make more sense to use EPERM, or is there another error code we
can throw to be more informative.

Thanks,
Simon.

