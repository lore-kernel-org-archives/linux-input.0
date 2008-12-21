From: "Parag Warudkar" <parag.lkml@gmail.com>
Subject: Re: 2.6.28-rc9: USB Mouse unhappy
Date: Sun, 21 Dec 2008 10:17:39 -0500
Message-ID: <f7848160812210717w5e5cc7a2uc5571710f755ec99@mail.gmail.com>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com>
	 <20081220221253.e09b1b1f.akpm@linux-foundation.org>
	 <f7848160812202226w1f930c86vfd17a2b0163bfc56@mail.gmail.com>
	 <494E20F7.7050106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:9223 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbYLUPRk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Dec 2008 10:17:40 -0500
In-Reply-To: <494E20F7.7050106@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, Dec 21, 2008 at 5:56 AM, Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> This sounds to me like 'usbmouse' gets used instead of 'usbhid' on
> 2.6.28-rc9. Many users have reported only vertical movement with
> 'usbmouse'. Better check the kernel configuration, if you had usbmouse
> disabled in 2.6.27, then disable it with 2.6.28-rc9 as well.

Sure enough - rmmod usbhid; modprobe usbmouse reproduces the exact
same problem on a working kernel.

But the thing is I use the same base configuration across all kernels
I build (sans of course the newly added config options) - so something
changed somewhere and now usbmouse gets used instead of usbhid.

What's the deal with usbmouse though - is it supposed to be working or
is it considered lost cause in favor of usbhid? May be if people don't
need to use it and it is not actively looked into, we can
disable/remove it?

Thanks

Parag
