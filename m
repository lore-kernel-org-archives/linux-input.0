From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH TRIVIAL 1/5] Input: keyboard: use macro module_platform_driver()
Date: Tue, 22 Nov 2011 10:00:50 -0500
Message-ID: <CAMjpGUdn-Rp+7Qo_zJOoG9-QtuF-r=rPKODm_ktyjObR-_OhAg@mail.gmail.com>
References: <1321952446-7591-1-git-send-email-jj_ding@emc.com.tw> <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44077 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab1KVPBP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 10:01:15 -0500
In-Reply-To: <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

On Tue, Nov 22, 2011 at 04:00, JJ Ding wrote:
> =C2=A0drivers/input/keyboard/adp5520-keys.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 13 +------------
> =C2=A0drivers/input/keyboard/bf54x-keys.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 14 +-------------

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
