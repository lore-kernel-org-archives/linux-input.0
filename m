From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] xpad: Add support for two more dance pads and one more
 guitar
Date: Tue, 31 May 2011 13:31:21 +0200
Message-ID: <1306841481.16310.5.camel@lovely>
References: <1306823799.8840.8.camel@ubuntu>
	 <20110531075348.GA13855@core.coreip.homeip.net>
	 <1306829685.8840.13.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55857 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab1EaLbY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2011 07:31:24 -0400
Received: by fxm17 with SMTP id 17so2965947fxm.19
        for <linux-input@vger.kernel.org>; Tue, 31 May 2011 04:31:23 -0700 (PDT)
In-Reply-To: <1306829685.8840.13.camel@ubuntu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus =?ISO-8859-1?Q?H=F6rlin?= <magnus@alefors.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, oneukum@suse.de

On Tue, 2011-05-31 at 10:14 +0200, Magnus H=C3=B6rlin wrote:
> +       { 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_B=
UTTONS, XTYPE_XBOX360 },
> +       { 0x0e6f, 0x0105, "HSM3 Xbox360 dancepad", MAP_DPAD_TO_BUTTON=
S, XTYPE_XBOX360 },

Nice to see that MAP_DPAD_TO_BUTTONS is used.

Reviewed-by: Christoph Fritz <chf.fritz@googlemail.com>

Thanks,
 -- Christoph

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
