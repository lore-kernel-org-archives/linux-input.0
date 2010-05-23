From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev4)
Date: Sat, 22 May 2010 23:52:17 -0700
Message-ID: <AANLkTinyVk0cHpsI6ZfMmxqGI7C_jM-BcYiaue185kBA@mail.gmail.com>
References: <1274567437-2818-1-git-send-email-rydberg@euromail.se>
	 <1274567437-2818-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42610 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab0EWGwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 May 2010 02:52:17 -0400
In-Reply-To: <1274567437-2818-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

The fool is smiling like a fool now :).

Ping

BTW, I didn't receive the updated "[PATCH 1/2] input: mt: Introduce MT
event slots (rev 5)".  Maybe gmail filtered the file for me?

On Sat, May 22, 2010 at 3:30 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> This patch adds documentation for the ABS_MT_SLOT event and gives
> examples of how to use the event slot protocol.
>
> Reviewed-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Revision 4 incorporates the following changes:
> =A0 =A0 =A0 =A0 - Rename the slot event to ABS_MT_SLOT to keep all MT=
-related events
> =A0 =A0 =A0 =A0 =A0 in the same namespace.
> =A0 =A0 =A0 =A0 - Fix typo, thanks to Ping Cheng.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
