From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Wed, 08 Dec 2010 12:44:40 -0800
Message-ID: <4CFFEE38.2070609@canonical.com>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se> <4CFFC3C2.1080905@canonical.com> <4CFFCD10.5030202@euromail.se> <4CFFD0BF.2020601@canonical.com> <4CFFD3FE.1090103@euromail.se> <4CFFD801.8060704@canonical.com> <4CFFDB35.2020506@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:48791 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab0LHUor (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 15:44:47 -0500
In-Reply-To: <4CFFDB35.2020506@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/08/2010 11:23 AM, Henrik Rydberg wrote:
>>>> I suggest merely renaming this to MT_TOOL_RECT to avoid confusion.
> 
>>
>> This is really the main point I wanted to make, even though it was
>> hidden among other things :). Do you have thoughts here?
> 
> 
> I think envelope works fine - it is easier to associate with a single point that
> the notion of a rectangle.

I thought we were talking specifically about two points? If I'm wrong,
the following won't make any sense either :).

There would be two slots with MT_TOOL_ENVELOPE set to 1. These define
the two possible combinations of touch points. I can't see how this
concept could be expanded any further than a rectangle without switcing
to full MT, thus I think it would be clearer to define it as such.

This all drives at the heart of the frustrations felt about evdev
property naming and documentation. The envelope tool, as you've
proposed, is only useful for defining rectangles. I think leaving it
named envelope is just begging for misuse, just as BTN_TOOL_DOUBLETAP
has been misused.

Perhaps it will be clearer to me why you like the name envelope if I
could read the formal documentation that would be merged along with the
new property name. The documentation added by the patch just isn't
enough to understand what it's for or how to use it, and the discussion
so far hasn't left me with the feeling that MT_TOOL_ENVELOPE is the best
name.

-- Chase
