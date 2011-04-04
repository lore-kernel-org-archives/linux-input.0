From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH resend] hid-magicmouse: Increase evdev buffer size
Date: Mon, 04 Apr 2011 14:20:21 +0200
Message-ID: <4D99B785.9070602@kernelconcepts.de>
References: <1301691819-2090-1-git-send-email-chase.douglas@canonical.com> <AANLkTim-tN=siA8tJVCzNZHs+oM0hN-N8Ckc+9ynnNpb@mail.gmail.com> <4D975072.1040507@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:35123 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab1DDMlQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 08:41:16 -0400
In-Reply-To: <4D975072.1040507@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jeffrey Brown <jeffbrown@android.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/02/2011 06:36 PM, Chase Douglas wrote:
> On 04/01/2011 07:51 PM, Jeffrey Brown wrote:
>> I've got another change in the works that fixes this problem more
>> systematically.
> 
> That would be great :). I still would like to see this patch added so
> it's released with the 2.6.39 kernel and backported to earlier stable
> releases. I hope that's not a problem.

Wouldn't it make sense to change the buffer logic in the input layer
that in the case of a buffer overrun the head gets pushed forward to the
next SYN_REPORT?

One symptom I witnessed with the bug was, that I got partial reports,
which especially in the case of a multitouch report (A-Type) creates
false release-events. This would be solved by the head-forwarding.

(one could even think about more fancy stuff like combining relative
events and keeping track of the absolute events, but this seems a bit
like overkill)

Thanks,
        Simon
- -- 
       Simon Budig                        kernel concepts GbR
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2Zt4UACgkQO2O/RXesiHByIgCgmHsujFhsYcM0wp7qEl+HytNh
wSMAoLygXVkU1Lx+jNgBA++H8OL6dNVR
=9+3z
-----END PGP SIGNATURE-----
