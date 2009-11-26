From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] (uu.6cd36bd9ef57) joystick/xpad.c -- Support HORI
	RAP.EX/MadCatz Fightpad
Date: Wed, 25 Nov 2009 22:04:44 -0800
Message-ID: <20091126060443.GJ23244@core.coreip.homeip.net>
References: <4B08FC8A.6030404@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:36053 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZKZGEm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 01:04:42 -0500
Received: by pxi10 with SMTP id 10so328197pxi.33
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2009 22:04:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B08FC8A.6030404@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas =?iso-8859-1?Q?L=E9veill=E9?= <knos@free.fr>
Cc: linux-input@vger.kernel.org

Hi Nicolas,

On Sun, Nov 22, 2009 at 09:55:38AM +0100, Nicolas L=E9veill=E9 wrote:
> Part one of three patches against latest head of
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>

It looks like your mailer wrapped the mails so the patches won't apply.
Please resend. Also, instead of creating a new field maybe chnage
dpad_mapping to be a bitmap of options?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
