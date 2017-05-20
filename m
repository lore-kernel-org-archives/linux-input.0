From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Sat, 20 May 2017 11:59:50 +0200
Message-ID: <20170520095950.GB6808@mail.corp.redhat.com>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
 <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
 <20170519204914.GD19281@dtor-ws>
 <59adce69-743d-98f1-ece7-1197c49e1b5e@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbdETJ74 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 May 2017 05:59:56 -0400
Content-Disposition: inline
In-Reply-To: <59adce69-743d-98f1-ece7-1197c49e1b5e@pa-w.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Wichmann <pascal.wichmann@pa-w.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On May 20 2017 or thereabouts, Pascal Wichmann wrote:
> > Looks like you running your patched kernel?
> That's right.
> 
> 
> >>> CONFIG_RMI4_CORE=m
> >>> CONFIG_RMI4_I2C=m
> >>> CONFIG_RMI4_SPI=m
> >>> # CONFIG_RMI4_SMB is not set
> >
> > This is your issue I believe.
> 
> Indeed, enabling that configuration solves that issue.
> 
> However, I think it is quite unintuitive that a module (psmouse) chooses
> a default mode which requires another driver which is not necessarily
> included; though it would probably be not a very clean solution to
> explicitly check that as well.
> 
> Is this behaviour, that one module requires another without
> communicating that clearly, wanted?
> 

I can see 3 solutions:
1. Have PS2_SMBUS depending on RMI_SMBUS (and ELAN_I2C, and others when
   required)
2. Have PS2_SMBUS selecting RMI_SMBUS (and the others when time comes)
3. Changing the default value of synaptics_intertouch to
   SYNAPTICS_INTERTOUCH_OFF when RMI_SMBUS is not set

Solution 3. might be interesting because it doesn't prevent users to
compile the module on the side and is Synaptics only.

Dmitry, any comments?

Cheers,
Benjamin

> Thanks,
> Pascal
> 
> 



