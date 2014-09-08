From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Mon, 8 Sep 2014 14:45:08 -0700
Message-ID: <20140908214508.GE24033@core.coreip.homeip.net>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33682 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbaIHVpL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Sep 2014 17:45:11 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so3323784pad.30
        for <linux-input@vger.kernel.org>; Mon, 08 Sep 2014 14:45:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

On Tue, Sep 02, 2014 at 02:43:22PM +0200, Hans de Goede wrote:
> Hi,
> 
> It is useful for userspace to know that they're not dealing with a regular
> mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
> can e.g. automatically enable middle button scrollwheel emulation.
> 
> It is impossible to tell the difference from the evdev info without resorting
> to putting a list of device / driver names in userspace, this is undesirable.
> 
> These patches add a property which allows userspace to see if a device is a
> pointing stick, and set it on all the pointing stick drivers.
> 
> Note these patch apply on top of the current dtor/input.git for-linus
> branch. Specifically they depend upon a2418fc4a13 (Input: elantech - add
> support for trackpoint found on some v3 models).

Applied both, thank you.

-- 
Dmitry
