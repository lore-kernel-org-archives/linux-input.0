From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Tue, 06 Jun 2017 09:46:19 +0200
Message-ID: <1496735179.2570.45.camel@hadess.net>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
         <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
         <1496345185.2570.3.camel@hadess.net>
         <20170602072907.GK1293@mail.corp.redhat.com>
         <02006322-6be2-f169-497e-06fc010a4bdb@intel.com>
         <alpine.LSU.2.20.1706050959500.30709@cbobk.fhfr.pm>
         <20170606072549.GS1293@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38779 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdFFHq1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 03:46:27 -0400
In-Reply-To: <20170606072549.GS1293@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>

On Tue, 2017-06-06 at 09:25 +0200, Benjamin Tissoires wrote:
> 
<snip>
> Well, as Bastien said, the issue is that old user space is buggy, and
> even if we postpone the switch to 4.13, there will always be someone
> who
> did not updated upower and who will complain.
> 
> As soon as I started the development of this series, Bastien upgraded
> upower with the required changes, and usually the development cycle
> of
> the kernel gives plenty of time for users to upgrade their user space
> tools before the kernel hits mainline.
> 
> [...after a little bit of digging...]
> 
> I tried today with a Fedora 25 and the shipped upower that doesn't
> have
> the bits Bastien worked on last March.

Richard should be able to cut a release, UPower hasn't had one since
early last year, so it's time in any case :)

> I couldn't expose the bug as reported here. The reason being what
> Bastien said, there is a "scope" property exported by the kernel
> device
> which is set to "Device" telling upower to ignore the device
> completely
> in this version.

Unless we added code to the obsolete version of UPower, we don't have a
way to tell UPower to not use a particular device as a generic
"power_supply" device.
