From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-logitech-dj: 046d:c52b Problems using Logitech Unifying Receiver
Date: Tue, 12 Feb 2013 15:28:36 +0100
Message-ID: <CAN+gG=EVBx8oMZf_fpBAoYmmLCDiTMqXNcQ9bXEJ2EwrV5g-uw@mail.gmail.com>
References: <51180E99.10208@gmail.com>
	<51193A0E.80306@gmail.com>
	<511A17FF.2000704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41382 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759477Ab3BLO2i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2013 09:28:38 -0500
Received: by mail-lb0-f175.google.com with SMTP id n3so163717lbo.20
        for <linux-input@vger.kernel.org>; Tue, 12 Feb 2013 06:28:37 -0800 (PST)
In-Reply-To: <511A17FF.2000704@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bob Bowles <bobjohnbowles@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nestor_lopez@logitech.com>

On Tue, Feb 12, 2013 at 11:22 AM, Bob Bowles <bobjohnbowles@gmail.com> wrote:
> Hi Benjamin
>
> Thanks for getting back to me. So far I have been doing upstream tests on
> published .deb packages
> (http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.8-rc6-raring/), so I
> cannot  atm apply the patch to a source. Do you have a url for the source?

here you go: https://github.com/bentiss/hid-logitech-dj
I pulled the latest up to date module, so I don't know if it's gonna
work out of the box on your kernel.

$ git clone https://github.com/bentiss/hid-logitech-dj.git
$ cd hid-logitech-dj
$ make

Remove your cron workaround.

$ sudo rmmod hid-logitech-dj && sudo insmod ./hid-logitech-dj.ko

Then look at the dmesg output and try to move your mouse.

If the module does not load, simply run:
$ sudo modprobe hid-logitech-dj

This will reload your module shipped by your distribution. And don't
forget to tell me if it did not worked (with the dmesg output).

>
> Please also see other comments below.
>
> Regards   Bob Bowles
>
>
> On 11/02/13 18:35, Benjamin Tissoires wrote:
>
> Hi Bob,
>
> adding in CC Jiri, the HID maintainer and Nestor, the author of
> hid-logitech-dj.
>
> First, thanks for putting this upstream. After ~130 comments on the two
> bugs, you are the first to report it on the proper mailing list.
>
> In spite of the work on the Launchpad bugs I think it has only recently been
> triaged as an upstream issue. I filed it upstream on the advice of one of
> the Launchpad guys, only after conducting the tests he requested in the bug
> thread. We recognize you have a lot of stuff to do, and don't want to bug
> (sic) you with non-relevant issues.

Yeah, I saw that you have been asked to fill it upstream recently. I
don't think it was your fault, but this bug is staying in various
distributions bugzillas since a while, so there has been a problem
somewhere.
This kind of problem has been diagnosed upstream since a long time
(not in your bug thread) and no one reported it correctly. Our job is
also to fix problems, thus, we should have been noticed earlier.

>
>
> According to Nestor, there are some known problems with 2.4GHz receivers and
> USB3.
> Intel even posted a document explaining those problems:
>
> http://www.intel.com/content/www/us/en/io/universal-serial-bus/usb3-frequency-interference-paper.html
>
> So the problem either comes from a bad firmware (which I doubt) or from
> those interferences, leading to a hardware failure.
>
> Interesting further information that may (or may not) be relevant:
> I tried out using a 2m usb cable to distance the receiver from any
> interference. This had no noticeable effect on the tests.

Did you tried with a USB2 hub? It worked here:
https://bugzilla.redhat.com/show_bug.cgi?id=840391

Cheers,
Benjamin
