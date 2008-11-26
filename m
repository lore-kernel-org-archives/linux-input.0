From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Thu, 27 Nov 2008 00:01:39 +0100
Message-ID: <200811270001.39260.marek.vasut@gmail.com>
References: <200811262333.45245.lukasz@lubojanski.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:59362 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbYKZXBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2008 18:01:43 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1558533ugf.37
        for <linux-input@vger.kernel.org>; Wed, 26 Nov 2008 15:01:39 -0800 (PST)
In-Reply-To: <200811262333.45245.lukasz@lubojanski.info>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?q?=C5=81ukasz_Luboja=C5=84ski?= <lukasz@lubojanski.info>
Cc: linux-input@vger.kernel.org

On Wednesday 26 of November 2008 23:33:44 =C5=81ukasz Luboja=C5=84ski w=
rote:
> Hi..
>
> I have implemented Force Feedback driver for another "GreeAsia" based
> device (0e8f:0012 "GreenAsia Inc. =C2=A0 =C2=A0USB Joystick =C2=A0 =C2=
=A0 ").
> The functionality was tested with MANTA Warior MM816 and SpeedLink St=
rike2
> SL-6635 and fftest software - everything seems to work right.
>
> Is there anyone able to check the code say if this good enough to inc=
lude
> it into official kernel ?
>
> If there are any suggestion what I should additionally check or what =
I
> should change before posting it please let me know.
>
> ps. I hope the attachement will be visible :D
>
> Thanx
> Lukasz Lubojanski

1) Please check the patch with checkpatch (scripts/checkpatch.pl) befor=
e=20
posting here

2) Use git format-patch to generate the final patch.

Marek
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
