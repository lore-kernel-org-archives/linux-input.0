From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v2] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 09:42:40 -0800
Message-ID: <AANLkTimnJpmRJCFhOvZndTmL3r21KEdqXr2Bd9ZT3kUb@mail.gmail.com>
References: <1292001842-5000-1-git-send-email-rydberg@euromail.se>
	<20101210173611.GA1630@core.coreip.homeip.net>
	<4D026634.4000602@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35306 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab0LJRml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 12:42:41 -0500
In-Reply-To: <4D026634.4000602@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 10, 2010 at 9:41 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> On 12/10/2010 06:36 PM, Dmitry Torokhov wrote:
>
>> On Fri, Dec 10, 2010 at 06:24:02PM +0100, Henrik Rydberg wrote:
>>> +#define MT_TOOL_ENVELOPE =A0 =A02 =A0 =A0 =A0 /* rectangle corner =
- legacy use only */
>>
>> Legacy to me implies we can upgrade, but this is hardware limitation=
=2E
>> Can we say "rectangle corner - used by older hardware"?
>>
> How about "- older hw only", to stay within a single line?

Why do we suggest it will only be used by older hardware?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
