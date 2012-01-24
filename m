From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Tue, 24 Jan 2012 18:08:56 +0530
Message-ID: <CAM1yFZ9wZ4+G0kENq0p=SyDPTkzC3nXp2Jqrk83cj_1fyoprEw@mail.gmail.com>
References: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
	<2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
	<CAM1yFZ82ZqJ+DAh2fU+Lqijcm=r6DE_EmCR8OX7M7ubNRMxyyg@mail.gmail.com>
	<07591daed833aaf50ea155c918cd04e0.squirrel@mungewell.org>
	<CAM1yFZ_eD2gV-vEwQp+BmD5OJxhH7ov3hqYRUBLtNm-Cp8GLGg@mail.gmail.com>
	<747fc1e52c224cb3cc1c4b37c9de9bb7.squirrel@mungewell.org>
	<CAM1yFZ_FWMrRH6a_nW1AW6vZcmC67LNKO0rsCWc1G1KSg9Z8bQ@mail.gmail.com>
	<e79444a78f0412701e85c030f4d2b4e1.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:64599 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752923Ab2AXMi5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 07:38:57 -0500
Received: by obcva7 with SMTP id va7so4222198obc.19
        for <linux-input@vger.kernel.org>; Tue, 24 Jan 2012 04:38:56 -0800 (PST)
In-Reply-To: <e79444a78f0412701e85c030f4d2b4e1.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 21 January 2012 00:20,  <simon@mungewell.org> wrote:
> I don't really understand why you would want to build seperately on each
> machine, either grab a binary kernel RPM from the site I linked before ()
> or use one machine to create your own kernel package (either RPM or just
> TAR).

:redface:

What I did was to copy the hid-lg4ff.c file on kernel 3.0.0 and change
that variable's name in the Kconfig file.
Recompiled the kernel successfully.

To my horror, after rebooting the recompiled kernel I found that
`fftest` doesn't produce the force feedback even in the "default"
mode. :banghead:

You have any idea what could I have messed up?

-Anisha
