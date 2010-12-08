From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Wed, 08 Dec 2010 21:02:52 +0100
Message-ID: <4CFFE46C.60401@euromail.se>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se> <4CFFC3C2.1080905@canonical.com> <4CFFCD10.5030202@euromail.se> <4CFFD0BF.2020601@canonical.com> <4CFFD3FE.1090103@euromail.se> <4CFFD801.8060704@canonical.com> <4CFFDB35.2020506@euromail.se> <AANLkTi=iw+7CDhbO4N9rMVSwS0t93BaaBVgoAwz-GeHo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:55866 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755118Ab0LHUDK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 15:03:10 -0500
In-Reply-To: <AANLkTi=iw+7CDhbO4N9rMVSwS0t93BaaBVgoAwz-GeHo@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/08/2010 08:51 PM, Mohamed Ikbel Boulabiar wrote:

> I have seen this touchless touchpad hardware (huh?)
> it detects finger/hand and it's better explained by a video:
> http://www.youtube.com/watch?v=6SjMdtdhXlA
> 
> How it fit in the convex notion?


This is precisely what the patch for ABS_MT_DISTANCE is for. Perhaps you meant
to comment on that email. This one is about support for hardware without
individual finger detection capabilities.

Henrik
