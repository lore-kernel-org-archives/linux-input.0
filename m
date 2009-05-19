From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH  3/3] hid: Multitouch support for the N-Trig touchscreen
 [v2]
Date: Tue, 19 May 2009 14:34:18 -0400
Message-ID: <4A12FBAA.302@seas.upenn.edu>
References: <3EF4E25A-E606-4056-BBF0-4BC2B31001F1@enac.fr> <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de> <7DB10F0C-6528-43B9-B816-61368904D798@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:41528 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbZESSeb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 14:34:31 -0400
In-Reply-To: <7DB10F0C-6528-43B9-B816-61368904D798@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

I used hid-lg.c as a reference/example for what was needed and style.
Taking the side of caution, I simply copied the copyright lines from
that file.  I have no objection to pruning it as long as there are no
objections.  Jiri, you're on that list, what's your feeling on this?

Rafi

St=E9phane Chatty wrote:
> Added support for multitouch interaction on the N-Trig touchscreen,
> using the new ABS_MT_* input constants.  Single touch support works a=
s
> previously. This code was tested against two versions of the N-Trig
> firmware: one that supports dual pen/finger single touch, and one tha=
t
> supports finger multitouch  but no pen at all. Copyright notices that
> looked wrong were removed, as it seems that there is only code writte=
n
> in 2009 by Rafin Rubin and Stephane Chatty in this file.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
