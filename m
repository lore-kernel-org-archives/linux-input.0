From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Wed, 11 Jan 2012 11:09:18 +0100
Message-ID: <4F0D5FCE.6080809@canonical.com>
References: <20120110102211.GA7682@polaris.bitmath.org> <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com> <20120110114212.GA2142@polaris.bitmath.org> <20120111073812.GB18668@core.coreip.homeip.net> <4F0D5521.5030808@canonical.com> <20120111100444.GA5573@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53537 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab2AKKJV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 05:09:21 -0500
In-Reply-To: <20120111100444.GA5573@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On 01/11/2012 11:04 AM, Henrik Rydberg wrote:
>>> Applied, however I removed stable notation as this change IMO does not
>>> qualify for the stable since it does not address a regression.
>>
>> It's not a regression per-se, but we want to fix buttonpad support, and
>> we can't do that without this patch. It's a clear bug that when the
>> property was added we did not set the property in the devices that need it.
> 
> The current behavior depends on userspace and is not a kernel bug,
> please stop the nonsense already.
> 
> For bcm5974 devices, extracting buttonpad properties has been possible
> since early 2009 (158e9287). The mechanism, predating the input
> properties interface by nearly two years, has been used in the
> multitouch and mtrack X drivers ever since. To those users, the
> present patch has no effect at all.

Just because an alternative interface has existed does not mean there
isn't a bug. A device that has a physical property, but does not set the
property bit in the driver is a real bug that needs to be fixed.
Userspace should not have to quirk around broken implementations.

It's true that userspace can quirk around things in a kernel that
predates the property bits, but where the property bits are available
the devices *must* set them or else things will break.

-- Chase
