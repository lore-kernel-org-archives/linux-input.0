From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Fri, 19 May 2017 13:49:14 -0700
Message-ID: <20170519204914.GD19281@dtor-ws>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
 <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34939 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbdESUtS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 16:49:18 -0400
Content-Disposition: inline
In-Reply-To: <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Wichmann <pascal.wichmann@pa-w.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 19, 2017 at 10:35:59PM +0200, Pascal Wichmann wrote:
> > Hmm, what about rmi_core and rmi_smbus? It might be quicker if you send
> > your dmesg, .config and lsmod...
> 
> dmesg:
> 

...
> > [   12.944519] psmouse serio1: synaptics: queried max coordinates: x [..5712], y [..4780]
> > [   12.975692] psmouse serio1: synaptics: queried min coordinates: x [1232..], y [1074..]
> > [   13.036464] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xf002a3/0x943300/0x12e800/0x10000, board id: 3075, fw id: 2560
> > [   13.036480] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> > [   13.075182] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input13
> > [   13.078710] mousedev: PS/2 mouse device common for all mice

Looks like you running your patched kernel?

...

> > CONFIG_RMI4_CORE=m
> > CONFIG_RMI4_I2C=m
> > CONFIG_RMI4_SPI=m
> > # CONFIG_RMI4_SMB is not set

This is your issue I believe.

> > CONFIG_RMI4_F03=y
> > CONFIG_RMI4_F03_SERIO=m
> > CONFIG_RMI4_2D_SENSOR=y
> > CONFIG_RMI4_F11=y
> > CONFIG_RMI4_F12=y
> > CONFIG_RMI4_F30=y
> > # CONFIG_RMI4_F34 is not set
> > CONFIG_RMI4_F54=y
> > CONFIG_RMI4_F55=y

Thanks.

-- 
Dmitry
