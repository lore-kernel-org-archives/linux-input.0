From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG?] EV_LED events not seperated from other events by
 SYN_REPORT
Date: Sat, 27 Jul 2013 22:26:08 -0700
Message-ID: <20130728052608.GB23567@core.coreip.homeip.net>
References: <CAFRyfCzE2_SE2YJuApUF35+s_Kt-P_tH1dwDwucJL3J_73w8=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42177 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3G1F0N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 01:26:13 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so4126398pde.24
        for <linux-input@vger.kernel.org>; Sat, 27 Jul 2013 22:26:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFRyfCzE2_SE2YJuApUF35+s_Kt-P_tH1dwDwucJL3J_73w8=Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rolf Morel <rolfmorel@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Rolf,

On Fri, Jul 26, 2013 at 04:41:11PM +0200, Rolf Morel wrote:
> Hello,
> 
> I am having some trouble with how device LED switches are being
> presented in the, userspace API, event stream.
> 
> If a program sets the LED using the evdev interface, write EV_LED
> input_event to device, other programs connected to the device will
> have the event in their stream, as expected. The problem is the
> received EV_LED events are not separated in time, as in moment in
> time. It does not generate a separate SYN_REPORT to make the EV_LED
> event a separate event in time.
> 
> I have only two devices which have this functionality, set LED state
> through evdev, to test and they both are 3Dconnexion devices. They
> both exhibit the same behavior.
> 
> So my questions are:
> Is this considered a bug (/should it be filed as a bug)?
> Does the fault lie in the input-subsystem or a more specific driver?

We have 2 options:

- emit EV_SYN from evedev_write() for every even written or
- require application writing events into /dev/eventX write EV_SYN as
  well.

At the moment I am inclined to say that applications shoudl do this.

Thanks.

-- 
Dmitry
