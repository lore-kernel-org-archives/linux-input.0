From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: [PATCH] HID: Invert HWHEEL mappings for some Logitech mice
Date: Wed, 18 Jun 2008 14:20:34 -0700
Message-ID: <91705d080806181420p24db55a3xd323a540b8a5c476@mail.gmail.com>
References: <1213464384-4602-1-git-send-email-dbn.lists@gmail.com>
	 <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:56062 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYFRVUg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jun 2008 17:20:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so104330and.103
        for <linux-input@vger.kernel.org>; Wed, 18 Jun 2008 14:20:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, Jun 18, 2008 at 9:03 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 14 Jun 2008, Dan Nicholson wrote:
>
>> Some Logitech mice have a tilt wheel which register as HWHEEL buttons.
>> The events are positive for a click to the right and negative for a
>> click to the left. Applications expect the opposite, though.
>> I suspect this affects a lot more Logitech mice, but these are the only
>> two I have. I tested this using evtest and a GTK application. A similar
>> Microsoft Intellimouse I have works correctly.
>
> Thanks Dan, applied.

Great! I thought I would have a harder time convincing you. :)

--
Dan
