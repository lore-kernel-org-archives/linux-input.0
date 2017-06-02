From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Fri, 02 Jun 2017 14:54:08 +0200
Message-ID: <1496408048.2570.11.camel@hadess.net>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
         <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
         <1496345185.2570.3.camel@hadess.net>
         <20170602072907.GK1293@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602072907.GK1293@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2017-06-02 at 09:29 +0200, Benjamin Tissoires wrote:
> 
<snip>
> Bastien, is is possible to have a simple udev rule that tells upower
> to
> ignore the battery device if builtin_power_supply is there?
> That way we can tell people running old upower to use this to be sure
> to
> ignore the kernel device and just rely on the upower hidpp support?

I'm not sure where we'd ship that in a way that would make it work
differently based on the version of UPower. In UPower? Well, UPower
0.99.x is the stable track for UPower, and the git master already has
support for this feature.

I'm not sure what else would need to be done.
