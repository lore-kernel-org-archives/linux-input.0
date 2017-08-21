From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Mon, 21 Aug 2017 10:52:11 +0200
Message-ID: <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
References: <20170818193436.GA31365@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34438 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdHUIwN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Aug 2017 04:52:13 -0400
In-Reply-To: <20170818193436.GA31365@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

On 18 August 2017 at 21:34, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> The touchpad on Lenovo Carbon X1 Gen 5 (2017 - Kabylake) is accessible over
> SMBUS/RMI, so let's activate it by default.

the patch over latest Linus 4.13-rc5 makes the trackpoint device to
not appear after boot.

Sometimes it  spontaneuosly appears 100-200 seconds after boot.

It does appear after suspend/resume. And it does appear after `rmmod
psmouse; modprobe psmouse`.


Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
Mouse". Middle button scrolling is not enabled by default.

hardware is:
Lenovo ThinkPad X1 Carbon 5th, model 20HQS0LV00
DMI: LENOVO 20HQS0LV00/20HQS0LV00, BIOS N1MET37W (1.22 ) 07/04/2017


-- 
damjan
