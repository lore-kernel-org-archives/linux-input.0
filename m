From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Fri, 20 Jan 2012 11:59:21 +0530
Message-ID: <CAM1yFZ_FWMrRH6a_nW1AW6vZcmC67LNKO0rsCWc1G1KSg9Z8bQ@mail.gmail.com>
References: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
	<2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
	<CAM1yFZ82ZqJ+DAh2fU+Lqijcm=r6DE_EmCR8OX7M7ubNRMxyyg@mail.gmail.com>
	<07591daed833aaf50ea155c918cd04e0.squirrel@mungewell.org>
	<CAM1yFZ_eD2gV-vEwQp+BmD5OJxhH7ov3hqYRUBLtNm-Cp8GLGg@mail.gmail.com>
	<747fc1e52c224cb3cc1c4b37c9de9bb7.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:63986 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507Ab2ATG3W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jan 2012 01:29:22 -0500
Received: by obcva7 with SMTP id va7so305609obc.19
        for <linux-input@vger.kernel.org>; Thu, 19 Jan 2012 22:29:21 -0800 (PST)
In-Reply-To: <747fc1e52c224cb3cc1c4b37c9de9bb7.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 19 January 2012 20:50,  <simon@mungewell.org> wrote:
> I would suggest that you pick the latest kernel version available.

So, yesterday I did download and compile the 3.2.1 kernel, and also
installed it
successfully! But haven't tested the wheel yet.

> On that machine I have a kernel version '3.0+dfp' which is a patched build
> made when I was testing Michal's changes.

Would you please post the link of that patch here?
Reason - To make this wheel work on 10 computers, we'll have to compile the
kernel 10 times since the old configuration will have to be copied for
"make oldconfig".
That "may" result in errors in some cases. So, if I could get a patch
for kernel 3.1 (which
is by default on Suse 12.1), it may make my life easier.
