From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Fri, 15 Jan 2016 12:08:51 +0100
Message-ID: <5698D343.3000606@vmware.com>
References: <20160115123928.d06e1fed.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:33562 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755870AbcAOLJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 06:09:03 -0500
In-Reply-To: <20160115123928.d06e1fed.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/15/2016 11:39 AM, Lauri Kasanen wrote:
> Hi,
>
> Seems the new and shiny VMWare mouse driver does not pass events
> to /dev/input/mice, rudely breaking userspace that doesn't
> support absolute input devices.
>
> Can this be changed? Would there be any downside to passing those
> events?
>
> - Lauri

Hi, Lauri.
What particular use-case is broken?

I'm assuming what's happening is that only the relative device gets
recognized as a mouse, and by default we don't send events through that
device.

In the vmware gui there is a workaround, one can select 
edit->preferences->input->"Optimize mouse for games"->Always

This will send events through the relative USB mouse, and if there is no
USB controller in the VM, through the relative MOUSE_PS2_VMMOUSE

The other option is to limit the number of protocols the PS2 driver
checks for and avoid enabling the vmmmouse functionality. There is a
kernel module option for that, although I can't remember it offhand.

We can't send both relative and absolute events simultaneously since
that would confuse the X server severely.

/Thomas



