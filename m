From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: ThinkPad input device IDs
Date: Wed, 8 Oct 2008 14:12:37 -0400
Message-ID: <41840b750810081112p1c2e4071xd34f095091faa060@mail.gmail.com>
References: <41840b750810072144g6e6becfby1c960eb24249869c@mail.gmail.com>
	 <20081008134402.GA15645@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:48455 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYJHSMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2008 14:12:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4156527wfd.4
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2008 11:12:37 -0700 (PDT)
In-Reply-To: <20081008134402.GA15645@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Oct 8, 2008 at 9:44 AM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> I guess it used "isa1600" because it talks to the EC over LPC3B port IO, and
> the ports are in the 1600-161F range, over the LPC bus.

I see... But this is an ad-hoc port assignment by IBM and other
machines may map different devices to port 1600h. Is it presently
possible to write a udev rule that will match the (mainline) hdaps
input device but not random junk at port 1600 on other machines?


>> The out-of-tree tp_smapi version of hdaps followed the thinkpad-acpi
>> convention so it now conflicts with mainline hdaps. Which should I
>> follow?
>
> I think it is better to use the BUS_HOST convention for this, since HDAPS
> really is just one of the services on LPC3B even if LPC3B really *is*
> BUS_ISA, ports 1600-161F.  Dmitry would know better, though.  Dmitry?

For what it's worth, I should note that tp_smapi's hdaps input IDs
were introduced in July 2007 [1] and are by now in widespread use by
udev rules since they're needed for the reduced-interrupts mode of
hdaps+hdapsd [2].

  Shem

[1] http://article.gmane.org/gmane.linux.drivers.hdaps.devel/1040
[2] http://www.thinkwiki.org/wiki/HDAPS#Userspace_daemon)
