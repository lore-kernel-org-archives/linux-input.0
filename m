From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Sat, 12 Mar 2016 13:54:28 +0100
Message-ID: <56E41184.8020006@gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
 <56E1EE3C.6010007@gmail.com>
 <CA+V1LzoHQq71riUOciB2PTLm4-Xk5DO1DA49f2uF9SOk5x_rKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34635 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcCLMyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Mar 2016 07:54:31 -0500
Received: by mail-wm0-f53.google.com with SMTP id p65so48916999wmp.1
        for <linux-input@vger.kernel.org>; Sat, 12 Mar 2016 04:54:30 -0800 (PST)
In-Reply-To: <CA+V1LzoHQq71riUOciB2PTLm4-Xk5DO1DA49f2uF9SOk5x_rKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-input@vger.kernel.org

> In ACPI DSDT it is declared something regarding 0x30, but may be below
> lines mean something other???
> 
> 
> Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>                 {
>                     Name (RBUF, ResourceTemplate ()
>                     {
>                         I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
>                             AddressingMode7Bit, "\\_SB.I2C4",
>                             0x00, ResourceConsumer, ,
>                             )

In general, you should go with the values in the DSDT.
They may be wrong if the manufacturer messed up (it happens), but they are
your best bet. Remember, even the Windows driver needs to get the values
somewhere.

