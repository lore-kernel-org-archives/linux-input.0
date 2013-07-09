From: wujun zhou <zwj.echo@gmail.com>
Subject: Re: My logitech wireless keyboard and mouse stop working after 3.10 kernel
Date: Tue, 9 Jul 2013 11:27:24 -0700
Message-ID: <CAPf1XsPnC+wQf_qgScS2DZuAavCrEF5B3FXy2wj24M72mnWg+g@mail.gmail.com>
References: <CAPf1XsNNqBajqi=SZ=_gcB9dQ1RSAvMnGn981gnN7JqqdThjhQ@mail.gmail.com>
	<alpine.LNX.2.00.1307071153210.26857@pobox.suse.cz>
	<CAPf1XsMECGhdXLLm8zw9s13pOKDrWQV2aMp-vWSVrrDNvTYv5g@mail.gmail.com>
	<51DC39CB.9070508@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043be1ba09c19104e11850f7
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:45122 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3GIS10 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jul 2013 14:27:26 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so5112752wes.31
        for <linux-input@vger.kernel.org>; Tue, 09 Jul 2013 11:27:25 -0700 (PDT)
In-Reply-To: <51DC39CB.9070508@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Andrew de los Reyes <adlr@chromium.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Linus Torvalds <torvalds@linux-foundation.org>

--f46d043be1ba09c19104e11850f7
Content-Type: text/plain; charset=UTF-8

Sorry it still doesn't work all the time. 90% time it works. But
sometime(very rare), I still get -EPIPE in packet 49.


In case it matters:
My motherboard is a GIgabyte GA-Z87-UD4H, and all the usb port is
connected to the USB3.0 controller in the intel Z87 chipset

lspci -vv
00:14.0 USB controller: Intel Corporation Lynx Point USB xHCI Host
Controller (rev 04) (prog-if 30 [XHCI])
        Subsystem: Giga-byte Technology Device 5007
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 44
        Region 0: Memory at f0520000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
                Address: 00000000feeff00c  Data: 41d1
        Kernel driver in use: xhci_hcd

lsusb
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 5000M
    |__ Port 5: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
    |__ Port 6: Dev 3, If 0, Class=Hub, Driver=hub/4p, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
    |__ Port 9: Dev 4, If 0, Class=Hub, Driver=hub/4p, 480M
    |__ Port 10: Dev 5, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 4: Dev 8, If 0, Class=Human Interface Device,
Driver=usbhid, 12M
        |__ Port 4: Dev 8, If 1, Class=Human Interface Device,
Driver=usbhid, 12M
        |__ Port 4: Dev 8, If 2, Class=Human Interface Device,
Driver=usbhid, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/8p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/6p, 480M

On Tue, Jul 9, 2013 at 9:26 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On 07/09/2013 06:44 AM, wujun zhou wrote:
>> Hello Jiri,
>>     Thanks for the quick reply.
>>
>>> Does the keyboard/mouse get properly discovered if you unplug and replug
>>> the receiver?
>> No. It is still not working after replug or reboot
>>
>>> What if you revert back to the 59626408 workaround (i.e. revert
>>> a9dd22b730 and 8af6c0883)?
>> It works after revert 8af6c08830b1ae114d1a8b548b1f8b056e068887.
>>
>>> so it's either rather timing sensitive, or device-specific.
>> The problem is indeed timing sensitive. Yesterday, after I inserted
>> some dbg_hid() for debuging, the problem just gone,  very strange.
>>
>>
>> I think for my case, I find the reason of the problem. My device do
>> not report the expected  REPORT_TYPE_NOTIF_DEVICE_PAIRED(0x41). (Not
>> discarded by the hid-core as mentioned in 8af6c0883, the hardware
>> itself has not sent the packet.)
>> Instead, the device reports a
>> REPORT_TYPE_NOTIF_CONNECTION_STATUS(0x42) event, with
>> dj_report->report_params[CONNECTION_STATUS_PARAM_STATUS]=0, the first
>> time I move the mouse.
>> And then report the normal activities of the mouse. (details about the
>> usb packets can be found in the attachment.)
>>
>
> Thanks for the logs. Your analysis is nearly good :) the problem comes
> from the frame 49 and not the 50 in your pcap logs. When calling the
> command REPORT_TYPE_CMD_GET_PAIRED_DEVICES (20 ff 81), we get an error
> -EPIPE. That means that the receiver never got the request for him to
> send the REPORT_TYPE_NOTIF_DEVICE_PAIRED(0x41).
>
> So this bug is definitively linked to the bugs closed by commit
> dcd9006b1b053c7b1cebe81333261d4fd492ffeb. There is something different
> with USB 3 hubs that triggers this -EPIPE. The urb is still not ready
> while it should.
>
> I am trying a long shot here, but could you please give a test to the
> following patch?
>
> Cheers,
> Benjamin
>
>
> From d73c86cff1be22e264fd857ebdc1fd16d07edaad Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date: Tue, 9 Jul 2013 18:22:29 +0200
> Subject: [PATCH] HID: logitech-dj: wait for URB completion before asking
>  paired devices
>
> On some USB3 boards, once the receiver is switched to the DJ mode, if
> we try to directly call another SET_REPORT request, we get an error
> -EPIPE.
>
> Waiting for the command to complete fixes this.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-logitech-dj.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 5207591a..9a6ccf8 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -766,6 +766,9 @@ static int logi_dj_probe(struct hid_device *hdev,
>         /* Allow incoming packets to arrive: */
>         hid_device_io_start(hdev);
>
> +       /* wait for the receiver to accept other commands */
> +       hid_hw_wait(hdev);
> +
>         retval = logi_dj_recv_query_paired_devices(djrcv_dev);
>         if (retval < 0) {
>                 dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
> --
> 1.8.3.1
>
>

--f46d043be1ba09c19104e11850f7
Content-Type: application/x-gzip; name="logitech_with_patch.pcapng.gz"
Content-Disposition: attachment; filename="logitech_with_patch.pcapng.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hixegsjf0

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
W/AWAAA=
--f46d043be1ba09c19104e11850f7--
