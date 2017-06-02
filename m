From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Fri, 2 Jun 2017 07:10:27 -0700
Message-ID: <02006322-6be2-f169-497e-06fc010a4bdb@intel.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
 <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
 <1496345185.2570.3.camel@hadess.net>
 <20170602072907.GK1293@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602072907.GK1293@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 06/02/2017 12:29 AM, Benjamin Tissoires wrote:
> On Jun 01 2017 or thereabouts, Bastien Nocera wrote:
>> On Thu, 2017-06-01 at 11:06 -0700, Dave Hansen wrote:
>>> On 03/27/2017 07:59 AM, Benjamin Tissoires wrote:
>>>> this is finally a rework of the series that provides kernel
>>>> power_supply
>>>> for hidpp devices.
>>>>
>>>> This will allow upower to not handle those devices anymore and to
>>>> have more
>>>> immediate reportng of the device to the system.
>>> FWIW, I'm on Ubuntu 14.04, and upower *is* reporting my mouse battery
>>> as
>>> if it were a laptop battery.  It's mostly garbage, and always reports
>>> 0%, which makes upower always tell me my laptop is 2/3 charged (I
>>> have 2
>>> real batteries).
> Well, the exported battery might be sending levels instead of
> pourcentages. And upower needs to be upgraded to handle those :(

It sounds like there are a number of things here where newer kernels are
breaking older userspace.  It's also causing some very end-user visible
effects, like having folks' systems auto shut down because upower thinks
their batteries are dead.

Old versions of upower are obviously confused here.  It would be really
nice to ensure that newer kernels don't break it like this.

IOW, it would be really nice if this were treated like a regression,
because it's tantalizingly close.
