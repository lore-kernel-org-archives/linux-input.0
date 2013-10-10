From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Q: weird hidraw behaviour
Date: Thu, 10 Oct 2013 11:26:45 +0200
Message-ID: <CANq1E4TxGS4NSc3BOon2+zVwkvY2LQTmQowHxOJnypf860+-jw@mail.gmail.com>
References: <20130924085606.GI28875@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56734 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3JJJ0p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 05:26:45 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so4607743ief.3
        for <linux-input@vger.kernel.org>; Thu, 10 Oct 2013 02:26:45 -0700 (PDT)
In-Reply-To: <20130924085606.GI28875@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Manoj Chourasia <mchourasia@nvidia.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Sep 24, 2013 at 10:56 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Hi,
>
> I noticed that after commit 212a871a393 (HID: hidraw: correctly deallocate
> memory on device disconnect) hidraw doesn't close the underlying hid device
> when the device node is closed last time.
>
> For example I have a touch panel (HID over I2C) device with added debug
> prints in i2c_hid_open()/i2c_hid_close():
>
>         # od -x /dev/hidraw0
>         [   41.363813] i2c_hid 1-004c: i2c_hid_power lvl:32
>         [   41.368464] i2c_hid 1-004c: i2c_hid_set_power
>         [   41.372831] i2c_hid 1-004c: __i2c_hid_command: cmd=54 01 00 08
>         [   41.451455] i2c_hid 1-004c: i2c_hid_open
>         ^C
>
>         # od -x /dev/hidraw0
>         [   58.420928] i2c_hid 1-004c: i2c_hid_power lvl:32
>         [   58.425577] i2c_hid 1-004c: i2c_hid_set_power
>         [   58.429945] i2c_hid 1-004c: __i2c_hid_command: cmd=54 01 00 08
>         [   58.525276] i2c_hid 1-004c: i2c_hid_open
>         ^C
>
> i2c_hid_close() is never called. Is this intended or am I missing
> something?

I don't know whether it's intentional, but it is hardcoded this way
now. Logic is, ->close() is called on hidraw_disconnect() that is,
when hidraw is unloaded on a device. It no longer depends on
user-space processes.

Any reason to change it back? It's no bug, so if no-one cares I'd
leave it as it is now. Otherwise, we can try to change it again.

Regards
David
