From: Adam Goode <adam@spicenitz.org>
Subject: Re: successful intertouch support: PNP: LEN2014 PNP0f13
Date: Fri, 18 Aug 2017 08:59:19 -0400
Message-ID: <CACuduqphCpX4P3A97Uve2-Dt7hrREUNKQ7jibxnoHWacF=4DGA@mail.gmail.com>
References: <CACuduqo7g9fJbjR3d0DStKMaRCc8H5W39yjqUDXWV+Nb6FiXSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54653 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751091AbdHRM7m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Aug 2017 08:59:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7844420E40
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 08:59:41 -0400 (EDT)
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com [209.85.218.42])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1695A24BA4
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 08:59:41 -0400 (EDT)
Received: by mail-oi0-f42.google.com with SMTP id x3so95496758oia.1
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 05:59:41 -0700 (PDT)
In-Reply-To: <CACuduqo7g9fJbjR3d0DStKMaRCc8H5W39yjqUDXWV+Nb6FiXSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Thu, Aug 17, 2017 at 11:55 PM, Adam Goode <adam@spicenitz.org> wrote:
> Aug 17 23:36:24 localhost kernel: psmouse serio1: synaptics: Your
> touchpad (PNP: LEN2014 PNP0f13) says it can support a different bus.
> If i2c-hid and hid-rmi are not used, you might want to try setting
> psmouse.synaptics_intertouch to 1 and report this to
> linux-input@vger.kernel.org.
>
> It does work with the kernel setting. Please add this to the whitelist.

This failed to resume from sleep. Neither the trackpad nor the
touchpoint work, and I cannot suspend again.


[ 3332.225906] rmi4_smbus 6-002c: failed to get SMBus version number!
[ 3332.225913] rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed
to read current IRQ mask.
[ 3332.225922] rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
[ 3332.225924] rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
[ 3332.225927] rmi4_physical rmi4-00: Failed to suspend functions: -16
[ 3332.225929] rmi4_smbus 6-002c: Failed to resume device: -16
[ 3332.225945] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to
write to F03 TX register (-16).
[ 3332.252105] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to
write to F03 TX register (-16).

[ 3404.759232] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -16.
[ 3404.759233] rmi4_f01 rmi4-00.fn01: Suspend failed with code -16.
[ 3404.759235] rmi4_physical rmi4-00: Failed to suspend functions: -16
[ 3404.759238] rmi4_smbus 6-002c: Failed to suspend device: -16
[ 3404.759243] dpm_run_callback(): rmi_smb_suspend+0x0/0x50
[rmi_smbus] returns -16
[ 3404.759245] PM: Device 6-002c failed to suspend: error -16
[ 3404.759246] PM: Some devices failed to suspend, or early wake event detected


>
>
> Thanks,
>
> Adam
