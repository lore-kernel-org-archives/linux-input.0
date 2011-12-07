From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Wed, 07 Dec 2011 09:36:35 -0800
Message-ID: <4EDFA423.70701@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz> <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com> <4ED90E6D.8090402@goop.org> <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com> <4ED9BDF8.3010600@goop.org> <CAD2FfiE-rg-1bMmVpYzBhnQcBMKKKO4WPnu0bvx+pvdFnpARrQ@mail.gmail.com> <4EDE4C7A.1010802@goop.org> <CAD2FfiHWuEmVTa54YqfJDk5zHpSQuM_nwPT=mR6NoWpajpydpg@mail.gmail.com> <4EDFA192.7000602@goop.org> <C
 AD2FfiF+fVoLPWpPyGGKdnoGhx1f=Loh2Ju-vdU58Y=2kf6C3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:57660 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641Ab1LGRgh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Dec 2011 12:36:37 -0500
In-Reply-To: <CAD2FfiF+fVoLPWpPyGGKdnoGhx1f=Loh2Ju-vdU58Y=2kf6C3g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On 12/07/2011 09:29 AM, Richard Hughes wrote:
> On 7 December 2011 17:25, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> Something like this?
>> @@ -63,6 +63,9 @@ static ssize_t power_supply_show_property(struct device *dev,
>>        static char *capacity_level_text[] = {
>>                "Unknown", "Critical", "Low", "Normal", "High", "Full"
>>        };
>> +       static char *scope_text[] = {
>> +               "Unknown", "System", "Device"
>> +       };
> That looks perfect.

OK, I'll put it into a submittable form when I get the chance (oh, and
compile and test it).

>
> Well, upower just assigns a "kind" to each battery which means the
> clients can for instance show all the laptop batteries, but ignore any
> mice and keyboards. For practical purposes, it's so we suspend the
> computer for a low power laptop battery, but not for a low power
> keyboard :)

So you could make that determination from the scope?

    J
