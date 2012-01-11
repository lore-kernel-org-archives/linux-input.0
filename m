From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Wed, 11 Jan 2012 10:23:45 +0100
Message-ID: <4F0D5521.5030808@canonical.com>
References: <20120110102211.GA7682@polaris.bitmath.org> <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com> <20120110114212.GA2142@polaris.bitmath.org> <20120111073812.GB18668@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53344 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab2AKJXt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 04:23:49 -0500
In-Reply-To: <20120111073812.GB18668@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On 01/11/2012 08:38 AM, Dmitry Torokhov wrote:
> On Tue, Jan 10, 2012 at 12:42:12PM +0100, Henrik Rydberg wrote:
>> On Tue, Jan 10, 2012 at 12:56:49PM +0200, Jussi Pakkanen wrote:
>>> Some bcm5974 trackpads have a physical button beneath the physical surface.
>>> This patch sets the property bit so user space applications can
>>> detect the trackpad type and act accordingly.
>>>
>>> Signed-off-by: Jussi Pakkanen <jussi.pakkanen@canonical.com>
>>> Cc: stable@vger.kernel.org
> 
> Applied, however I removed stable notation as this change IMO does not
> qualify for the stable since it does not address a regression.

It's not a regression per-se, but we want to fix buttonpad support, and
we can't do that without this patch. It's a clear bug that when the
property was added we did not set the property in the devices that need it.

I believe this is exactly what the stable queue is for. Are you saying
you will still NACK this patch if we submit it to the stable queue?
Otherwise, we'll have to distro-patch it for our next Ubuntu release.

I wish you had asked about this before committing it to your tree
without the stable Cc. If we convince you that it makes sense for
stable, we now have quite a bit more work to do to get it into stable...

-- Chase
