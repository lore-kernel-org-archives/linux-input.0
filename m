From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Sat, 20 May 2017 10:35:26 -0700
Message-ID: <20170520173526.GB38800@dtor-ws>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
 <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
 <20170519204914.GD19281@dtor-ws>
 <59adce69-743d-98f1-ece7-1197c49e1b5e@pa-w.de>
 <20170520095950.GB6808@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35805 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdETRf3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 May 2017 13:35:29 -0400
Content-Disposition: inline
In-Reply-To: <20170520095950.GB6808@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pascal Wichmann <pascal.wichmann@pa-w.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 20, 2017 at 11:59:50AM +0200, Benjamin Tissoires wrote:
> Hi,
> 
> On May 20 2017 or thereabouts, Pascal Wichmann wrote:
> > > Looks like you running your patched kernel?
> > That's right.
> > 
> > 
> > >>> CONFIG_RMI4_CORE=m
> > >>> CONFIG_RMI4_I2C=m
> > >>> CONFIG_RMI4_SPI=m
> > >>> # CONFIG_RMI4_SMB is not set
> > >
> > > This is your issue I believe.
> > 
> > Indeed, enabling that configuration solves that issue.
> > 
> > However, I think it is quite unintuitive that a module (psmouse) chooses
> > a default mode which requires another driver which is not necessarily
> > included; though it would probably be not a very clean solution to
> > explicitly check that as well.
> > 
> > Is this behaviour, that one module requires another without
> > communicating that clearly, wanted?
> > 
> 
> I can see 3 solutions:
> 1. Have PS2_SMBUS depending on RMI_SMBUS (and ELAN_I2C, and others when
>    required)
> 2. Have PS2_SMBUS selecting RMI_SMBUS (and the others when time comes)
> 3. Changing the default value of synaptics_intertouch to
>    SYNAPTICS_INTERTOUCH_OFF when RMI_SMBUS is not set
> 
> Solution 3. might be interesting because it doesn't prevent users to
> compile the module on the side and is Synaptics only.
> 
> Dmitry, any comments?

I like #3. We might also want to stick a warning into synaptics.c when
we see a device that has intertouch, but RMI_SMBUS is disabled, so we
could nudge users to switch over to RMI.

Thanks.

-- 
Dmitry
