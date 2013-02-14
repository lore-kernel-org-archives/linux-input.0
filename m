From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 00/14] Input: ALPS - Clean up and rework driver to
 support newer touchpads
Date: Thu, 14 Feb 2013 09:17:19 -0800
Message-ID: <20130214171719.GA4007@core.coreip.homeip.net>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:55110 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab3BNRRY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2013 12:17:24 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so239637pbb.4
        for <linux-input@vger.kernel.org>; Thu, 14 Feb 2013 09:17:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Hi Kevin,

On Sun, Feb 03, 2013 at 03:56:40PM -0800, Kevin Cernekee wrote:
> Several modern ALPS devices require slight variations on existing driver
> functions.  This patchset provides a way to "mix and match" various
> components, to avoid excessive code duplication and clutter:
> 
>  - Separating the report format decoding from processing, so that
>    Pinnacle AGx, Rushmore, and Dolphin touchpads can use a common
>    processing function.
> 
>  - Allowing devices with different register layouts to use the same
>    processing functions but disparate init functions.
> 
>  - Providing a way to discover touchpads like Pinnacle AGx and Rushmore,
>    which are identified by a range of EC report values rather than an
>    exact match to a specific E7 report sequence.
> 
>  - Storing the bitmap and pixel constants in the alps_data struct, so
>    they can be updated if the device uses different values (ala Dolphin).
> 
> 
> V1->V2 changes with respect to Rushmore support:
> 
>  - Fix MT and trackstick report decoding (credit to Emmanual Thome)
> 
> 
> Baseline:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> 
> git pull from:
> 
> https://github.com/cernekee/linux alps-v2
> 
> 
> Tested on:
> 
> Dell E6410 (Pinnacle AGx) - E7/EC: 73 02 64 / 88 07 9d
> Dell E6230 (Rushmore without trackstick) - E7/EC: 73 03 0a / 88 08 1d
> Dell E6430 (Rushmore with trackstick) - E7/EC: 73 03 0a / 88 08 1d
> 
> Dolphin support is new and completely untested; if nobody reports success
> we should drop that patch.  Also, there are at least two known Dolphin
> versions, which use different init sequences (at least in the Windows
> driver).


Thank you very much, nice work! I applied the first 13 patches; waiting
for acknowledgements that Dolphin works before I apply it.

Thanks.

-- 
Dmitry
