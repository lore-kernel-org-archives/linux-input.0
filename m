From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v3 0/8] HID: sony: More Sony controller fixes and improvements.
Date: Thu, 27 Mar 2014 10:27:39 -0400
Message-ID: <CAH+9E3o+W5y0=KiREqUKSsP4nxK00ZevUrv5azVEoD9LD7ospg@mail.gmail.com>
References: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:42840 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbaC0O1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2014 10:27:40 -0400
Received: by mail-ie0-f177.google.com with SMTP id rl12so3309314iec.8
        for <linux-input@vger.kernel.org>; Thu, 27 Mar 2014 07:27:39 -0700 (PDT)
In-Reply-To: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Sat, Mar 15, 2014 at 9:41 AM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Just a couple of small changes in v3:
>
> Patch 6 was changed to use the controller Bluetooth MAC address as the unique
> value for the battery name string.
>
> The IDA code was moved from patch 6 to 7 since it was no longer needed in
> patch 6.  It's the same otherwise.

Just a quick note since the 3.15 merge window is approaching: patches
1 and 2 are strictly bug fixes and should be merged into the 3.15 tree
even if the rest of the series has to wait until 3.16.
