From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v2] Documentation: Add evdev type and code definitions
Date: Sat, 08 Jan 2011 01:26:45 +0300
Message-ID: <4D279325.3040205@gmail.com>
References: <1294435695-16750-1-git-send-email-chase.douglas@canonical.com> <4D278E6B.7020002@gmail.com> <4D279075.4080503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64768 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1AGW0u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 17:26:50 -0500
In-Reply-To: <4D279075.4080503@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/08/2011 01:15 AM, Chase Douglas wrote:
> Hmm.. That seems incorrect to me. Why wouldn't it follow the behavior
> outlined above?
Because the tablet doesn't report when the tool enters/leaves the proximity.
It just starts/stops sending the coordinates.

A leave timer could be used, though. Maybe we could ignore the case when the
mouse is laying still on the tablet or the pen is held very steadily in
place and just tell that tool left the surface.

Maybe it will be beneficial to have it synthesised after all, as it would
probably ease the integration with xf86-input-wacom and will keep the evdev
protocol more consistent.

Sincerely,
Nick
