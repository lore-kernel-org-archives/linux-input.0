From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Fri, 19 May 2017 13:23:03 -0700
Message-ID: <20170519202303.GA19281@dtor-ws>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33616 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbdESUXH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 16:23:07 -0400
Content-Disposition: inline
In-Reply-To: <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Wichmann <pascal.wichmann@pa-w.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 19, 2017 at 09:37:32PM +0200, Pascal Wichmann wrote:
> > Do you have i801_smbus driver enabled and loaded?
> 
> I have the following line in my kernel configuration:
> 
> > CONFIG_I2C_I801=m
> 
> Following i2c/smbus-related modules are loaded:
> 
> > lsmod | grep i2c
>                                                                 :(
> > i2c_smbus              16384  0
> > i2c_i801               24576  0
> > i2c_algo_bit           16384  1 i915
> 
> lshw has the following output specifying i801_smbus as driver:
> 
> > *-serial
> >      description: SMBus
> >      product: Wildcat Point-LP SMBus Controller
> >      vendor: Intel Corporation
> >      physical id: 1f.3
> >      bus info: pci@0000:00:1f.3
> >      version: 03
> >      width: 64 bits
> >      clock: 33MHz
> >      configuration: driver=i801_smbus latency=0
> >      resources: irq:18 memory:f1238000-f12380ff ioport:efa0(size=32)

Hmm, what about rmi_core and rmi_smbus? It might be quicker if you send
your dmesg, .config and lsmod...

Thanks.

-- 
Dmitry
