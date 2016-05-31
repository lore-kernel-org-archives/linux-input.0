From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v6 0/4] i2c-smbus: add support for HOST NOTIFY
Date: Tue, 31 May 2016 11:17:31 +0200
Message-ID: <20160531091731.GV23234@mail.corp.redhat.com>
References: <1458146348-17171-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458146348-17171-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Mar 16 2016 or thereabouts, Benjamin Tissoires wrote:
> Hi,
> 
> this is a quick respin of the series with the kbuild test bot fixes and the
> requested lm90 change.
> 
> Again, I think applying the RMI4 input driver needs the merge of the input tree
> in master first, but having reviews on the Host Notify implementation would be
> good.


Well, RMI4 is now in master, and it's been 2 months and a half since this
v6. Thanks for everyone who send their acks, but I'd like to have a
review on the Host Notify implementation (Jean??????).

We just had a new bug this week that shows that the fallback protocol we
use under Linux for Synaptics touchpad is buggy[1]. I really like to see
this moving forward so I'll send a v7 with the acks and tested by, but I
really would like to get Wolfram's or Jean's attention for the Host
notify part.

Cheers,
Benjamin

[1] https://bugs.freedesktop.org/show_bug.cgi?id=96267

> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (4):
>   i2c: add a protocol parameter to the alert callback
>   i2c-smbus: add SMBus Host Notify support
>   i2c: i801: add support of Host Notify
>   Input: synaptics-rmi4 - add SMBus support
> 
>  Documentation/i2c/smbus-protocol |   3 +
>  drivers/char/ipmi/ipmi_ssif.c    |   6 +-
>  drivers/hwmon/lm90.c             |   6 +-
>  drivers/i2c/busses/Kconfig       |   1 +
>  drivers/i2c/busses/i2c-i801.c    |  85 +++++++-
>  drivers/i2c/i2c-smbus.c          | 112 ++++++++++-
>  drivers/input/rmi4/Kconfig       |  12 ++
>  drivers/input/rmi4/Makefile      |   1 +
>  drivers/input/rmi4/rmi_bus.h     |  12 ++
>  drivers/input/rmi4/rmi_smbus.c   | 416 +++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-smbus.h        |  44 +++++
>  include/linux/i2c.h              |  10 +-
>  include/uapi/linux/i2c.h         |   1 +
>  13 files changed, 699 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/input/rmi4/rmi_smbus.c
> 
> -- 
> 2.5.0
> 
