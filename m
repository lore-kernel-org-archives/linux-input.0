From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: Re: [PATCH v2 00/30] HID: wacom: cleanup/EKR/LED
Date: Wed, 13 Jul 2016 14:36:07 -0700
Message-ID: <CAEoswT0aZTu7hk_Th1t8Kd7mfVRj3Zh5NGpNTPCf7n1rtKPptw@mail.gmail.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36233 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbcGMVgJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 17:36:09 -0400
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jul 13, 2016 at 9:05 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> So this is a v2 of my summer cleanup of the wacom driver.
> I fixed the remarks from everybody I think, and it should be in a better shape
> now.
> I removed the patch that changed the LED banks ordering as libwacom exports it
> that way. I also added 3 extra patches for the power_supply to be a little bit
> more user friendly in gnome-control-center (well, upowerd).
>
> Thanks for double testing on the Cintiq 21UX2 and the 24HD as I could only

Retested on the 21UX2 and the 24HD.

Tested-by Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Best,
Aaron

> compare the raw events to what was expected, and nothing is better than actual
> testing with real hardware.
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (30):
>   HID: wacom: actually report the battery level for wireless connected
>   HID: wacom: store the type in wacom->shared for INTUOSHT and INTUOSHT2
>   HID: wacom: remove cleanup of wacom->remote_dir from
>     wacom_clean_inputs()
>   HID: wacom: untie leds from inputs
>   HID: wacom: use one work queue per task
>   HID: wacom: switch battery to devres
>   HID: wacom: switch inputs to devres
>   HID: wacom: put the managed resources in a group
>   HID: wacom: convert LEDs to devres
>   HID: wacom: use devm_kasprintf for allocating the name of the remote
>   HID: wacom: use devres to allocate driver data
>   HID: wacom: devres manage the shared data too
>   HID: wacom: leds: dynamically allocate LED groups
>   HID: wacom: EKR: add a worker to add/remove resources on
>     addition/removal
>   HID: wacom: EKR: have the wacom resources dynamically allocated
>   HID: wacom: rework fail path in probe() and parse_and_register()
>   HID: wacom: EKR: have proper allocator and destructor
>   HID: wacom: EKR: use devres groups to manage resources
>   HID: wacom: EKR: have one array of struct remotes instead of many
>     arrays
>   HID: wacom: EKR: allocate one input node per remote
>   HID: wacom: EKR: have one power_supply per remote
>   HID: wacom: EKR: attach the power_supply on first connection
>   HID: wacom: leds: use the ledclass instead of custom made sysfs files
>   HID: wacom: leds: actually release the LEDs on disconnect
>   HID: wacom: leds: handle the switch of the LEDs directly in the kernel
>   HID: wacom: leds: make sure Cintiq 21UX2 and 24HD control the right
>     LEDs
>   HID: wacom: leds: handle Cintiq 24HD leds buttons
>   HID: wacom: power_supply: mark the type as USB
>   HID: wacom: power_supply: remove ac information
>   HID: wacom: power_supply: provide the actual model_name
>
>  Documentation/ABI/testing/sysfs-driver-wacom |    5 +
>  drivers/hid/Kconfig                          |    1 +
>  drivers/hid/wacom.h                          |   96 ++-
>  drivers/hid/wacom_sys.c                      | 1104 ++++++++++++++++++--------
>  drivers/hid/wacom_wac.c                      |  254 ++++--
>  drivers/hid/wacom_wac.h                      |   19 +-
>  6 files changed, 1058 insertions(+), 421 deletions(-)
>
> --
> 2.5.5
>
