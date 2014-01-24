From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 00/15] Input: synaptics-rmi4 - cleanup and add DT support
Date: Thu, 23 Jan 2014 16:06:43 -0800
Message-ID: <20140124000642.GB19653@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:1655 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752323AbaAXAFC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 19:05:02 -0500
Content-Disposition: inline
In-Reply-To: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "cheiny@synaptics.com" <cheiny@synaptics.com>

On Fri, Jan 24, 2014 at 01:00:08AM +0100, Courtney Cavin wrote:
> This is an attempt to get this driver closer to being in an upstream-able form.
> In the process, this drops legacy callback methods for managing power and GPIO
> configuration, in favor of the already existing frameworks.  Most of this
> series is cleanup, but there are a few intermixed bug fixes to make it all
> work.
> 
> This patch series is based off of the synaptics-rmi4 branch merged into
> Linus' 3.13.  A tree is available at [1].
> 
> This was tested on Synaptics TM2281-001 & TM2282-001.
> 
> [1] http://github.com/courtc/linux.git
> 	tag for-input/synaptics-rmi4
> 
> Courtney Cavin (15):
>   Input: synaptics-rmi4 - fix checkpatch.pl, sparse and GCC warnings
>   Input: synaptics-rmi4 - don't kfree devm_ alloced memory
>   Input: synaptics-rmi4 - don't free devices directly
>   Input: synaptics-rmi4 - remove sensor name from platform data
>   Input: synaptics-rmi4 - remove gpio handling and polling
>   Input: synaptics-rmi4 - remove platform suspend callbacks
>   Input: synaptics-rmi4 - remove remaining debugfs code
>   Input: synaptics-rmi4 - cleanup platform data
>   Input: synaptics-rmi4 - remove unused defines and variables
>   Input: synaptics-rmi4 - add devicetree support
>   Input: synaptics-rmi4 - add regulator support
>   Input: synaptics-rmi4 - don't immediately set page on probe
>   Input: synaptics-rmi4 - properly set F01 container on PDT scan
>   Input: synaptics-rmi4 - ensure we have IRQs before reading status
>   Input: synaptics-rmi4 - correct RMI4 spec url
> 
>  Documentation/devicetree/bindings/input/rmi4.txt   | 117 +++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/input/rmi4/Kconfig                         |   1 -
>  drivers/input/rmi4/rmi_bus.c                       | 131 +-----
>  drivers/input/rmi4/rmi_bus.h                       |  18 +-
>  drivers/input/rmi4/rmi_driver.c                    | 321 +++++--------
>  drivers/input/rmi4/rmi_driver.h                    |  33 +-
>  drivers/input/rmi4/rmi_f01.c                       | 163 ++++---
>  drivers/input/rmi4/rmi_f11.c                       | 523 ++++++---------------
>  drivers/input/rmi4/rmi_i2c.c                       |  55 +--
>  include/linux/rmi.h                                | 219 ++-------
>  11 files changed, 551 insertions(+), 1031 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4.txt

Oh no!  Terribly sorry about the threading.  Somehow my gitconfig
'chainreplyto' setting was reset to 'true'.  It won't happen again ...
hopefully.

-Courtney
