From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Mon, 13 Mar 2017 10:11:11 +0100
Message-ID: <7964888d-05dd-b109-973a-e0503884e2e2@leemhuis.info>
References: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:34336 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752163AbdCMJLV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 05:11:21 -0400
In-Reply-To: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>, benjamin.tissoires@redhat.com, aduggan@synaptics.com, nick@shmanahar.org, cheiny@synaptics.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
>
> Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13 9343's
> Synaptics touchpad and dropping some errors into dmesg. Here are the
> messages that seem RMI-related:
> 
> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3038-001, fw id: 1832324
> input: Synaptics TM3038-001 as /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
> hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0665:01 06CB:76AD] on i2c-DLL0665:01

FWIW, I get this on my XPS 13 DE (9360) with 4.11-rc1:

input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
rmi4_f34: probe of rmi4-00.fn34 failed with error -22
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
product: TM3038-003, fw id: 2375007
input: Synaptics TM3038-003 as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
hid-rmi 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse
[DLL075B:01 06CB:76AF] on i2c-DLL075B:01

> […] 
> Compared to hid-multitouch, the RMI stack seems to have completely broken
> palm rejection and introduced some random jumpiness during fine pointing
> motions. I don't know if these issues are caused by the above errors or
> are a separate issue.

Just to confirm: I noticed "jumpiness during fine pointing motions" as
well since switching to 4.11-rc.

@benjamin: Just wondering: Could that have something to do with the
ps2->rmi handover? I noticed that patches to improve things in this area
are still circulating, which lead me to wonder if that might have
anything to do with this. But it's just a wild guess.

> The affected machine is an XPS 13 9343 running Fedora 25 with 4.11-rc1 
> and libinput 1.6.3-3.fc25 (latest in F25).

Same setup here. In case it matters: I'm running Gnome-Shell in Wayland
mode.

Ciao, Thorsten

P.S.: I fixed the model number in above quotes from Cameron to avoid
confusion (he has a 9343, and not a 9443, as initially stated; see a
different mail in this thread for details)
