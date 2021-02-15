Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460FC433E0
	for <linux-input@archiver.kernel.org>; Mon, 15 Feb 2021 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6850D64DEE
	for <linux-input@archiver.kernel.org>; Mon, 15 Feb 2021 16:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhBOQIx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:08:53 -0500
Received: from mail.nic.cz ([217.31.204.67]:50570 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhBOP4I (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 Feb 2021 10:56:08 -0500
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 0CF4E1409F0;
        Mon, 15 Feb 2021 16:55:20 +0100 (CET)
Date:   Mon, 15 Feb 2021 16:55:18 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Roderick Colenbrander <roderick@gaikai.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-leds@vger.kernel.org,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
Subject: Re: [PATCH v6 1/4] HID: playstation: add DualSense lightbar support
Message-ID: <20210215165518.16033bb6@nic.cz>
In-Reply-To: <CANndSKmSP7rdsrMuwRapQkDru75TxN9zbDUbvOj_5hrQpskmJg@mail.gmail.com>
References: <20210215004549.135251-1-roderick@gaikai.com>
        <20210215004549.135251-2-roderick@gaikai.com>
        <20210215143144.060fdbe6@nic.cz>
        <CANndSKmSP7rdsrMuwRapQkDru75TxN9zbDUbvOj_5hrQpskmJg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 15 Feb 2021 07:36:58 -0800
Roderick Colenbrander <roderick@gaikai.com> wrote:

> Hi Marek,
> 
> On Mon, Feb 15, 2021 at 5:31 AM Marek Behun <marek.behun@nic.cz> wrote:
> >
> > On Sun, 14 Feb 2021 16:45:46 -0800
> > Roderick Colenbrander <roderick@gaikai.com> wrote:
> >  
> > > +     led_cdev->name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "playstation::%pMR::rgb",
> > > +                     ps_dev->mac_address);  
> > ...  
> > > +     ret = devm_led_classdev_multicolor_register(&hdev->dev, lightbar_mc_dev);  
> >
> > The LED subsystem has a predefined schema by which LED names should
> > look like:
> >   devicename:color:function
> > (Not all fields are required, but the order must be preserved. The ':'
> >  character should be used only as separator of these fields, so not MAC
> >  addresses in these names, it will confuse userspace parsers.)
> > See Documentation/leds/leds-class.rst
> >
> > The devicename part should not be "playstation". It should be something
> > otherwise recognizable from userspace. For example an mmc indicator has
> > devicename "mmc0", keyboard capslock LED can have devicename "input0"...
> >
> > In your case the name should be something like:
> >   input3:rgb:indicator  
> 
> Naming is a little bit tricky. The LEDs as well as other sysfs nodes
> are added to the 'parent' HID device, not the input devices. In case
> of DualSense it is actually implemented as a composite device with
> mulitple input devices (gamepad, touchpad and motion sensors) per HID
> device. The device name of HID devices seems to be something like:
> <bus>:<vendor_id>:<product_id>:<some other id> e.g. for DualSense USB
> 0003:054C:0CE6.0029 or Bluetooth 0005:054C:0CE6.002B
> 
> This is I guess why many HID devices in general pick their own names
> (and not all have need to have input devices I guess). Though Benjamin
> and Jiri know better.
> 
> I'm not sure what naming could make sense here. The previous Sony
> driver for PlayStation devices used: HID_name "::red" for e.g. red LED
> on DualShock 4.

We have to find a reasonable devicename here. If each joystick registers
multiple input devices, it cannot be "input%d". I suppose there isn't
an API for grouping mulitple input devices toghether into inputgroups.
Maybe it could be in the format "joystick%d".

But I don't think it can be "playstation". Nor can MAC addresses be
there if they contain ':'s.

Marek
