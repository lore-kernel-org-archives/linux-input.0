From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 3/3] HID: wacom: generic: support touch on/off softkey
Date: Wed, 15 Feb 2017 11:27:59 +0100
Message-ID: <1487154479.3089.2.camel@hadess.net>
References: <1487136465-5255-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36945 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdBOK2F (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Feb 2017 05:28:05 -0500
In-Reply-To: <1487136465-5255-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@gmail.com, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Tue, 2017-02-14 at 21:27 -0800, Ping Cheng wrote:
> Wacom Cintiq Pro has a softkey to turn touch on/off. Since it is
> a softkey, hardware/firmware still reports touch events no matter
> what state the softkey is. We need to ignore touch events when
> the key is in off mode.

Why can't this simply be reported to user-space to handle? This would
allow an OSD popping up. Implementing everything in the driver means
that we're setting ourselves up for "fat finger" bug reports where the
user doesn't know that they disabled the tablet, as there would be no
notification of the change.
