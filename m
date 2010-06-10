From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] input: evdev: Dynamic buffers (rev4)
Date: Thu, 10 Jun 2010 12:11:50 -0700
Message-ID: <201006101211.51395.dmitry.torokhov@gmail.com>
References: <1275735869-2185-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48931 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0FODPk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 23:15:40 -0400
In-Reply-To: <1275735869-2185-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On Saturday, June 05, 2010 04:04:26 am Henrik Rydberg wrote:
> Dmitry,
> 
> Please find enclosed the fourth version of the evdev buffer patches.
> 
> This version implements buffer locking using event_lock as you
> suggested, such that we can proceed with fixing the evdev buffer
> problem independently from providing a suitable one-to-many buffer.
> 
> The first patch converts the per-client buffers to a common buffer,
> and adds a fixme since the code is expected to be further
> improved. The second and third patch includes your review comments.

Henrik,

Applied to .36 queue with minor adjustments, please take a peek in my
'for-linus' branch and see if you spot anything wrong. The changes have
been made with an eye of implementing a per-client event filters which
would again require using private event queues (but only by clients that
request filtering).

The desire for allowing event filtering in kernel is to avoid waking up
HAL-ish processes (ones that only interested in certain special events, 
like KEY_SUSPEND, KEY_WIFI, KEY_MUTE, etc) needlessly. Not sure if I am
going to have time to actually implement it though, anyone wants to
take a stab?

-- 
Dmitry
