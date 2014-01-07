From: Chris Diamand <chris@diamand.org>
Subject: Re: [PATCH] Input: ALPS - Recognise "Dolphin V2" touchpads
Date: Tue, 07 Jan 2014 18:30:29 +0000
Message-ID: <52CC47C5.4090307@diamand.org>
References: <1389039034-14040-1-git-send-email-chris@diamand.org> <CAKvfdtK18rQ4TOqwKCj1P3oQs-BQZr2h3db5NH18WdtNjjnH=g@mail.gmail.com> <CA+F6ckNx8nxjtXLrgzYyNUBnnmb09tFx8zSe=y0JxtMiVrTooQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:45550 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbaAGSbL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 13:31:11 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so4540155wib.8
        for <linux-input@vger.kernel.org>; Tue, 07 Jan 2014 10:31:10 -0800 (PST)
In-Reply-To: <CA+F6ckNx8nxjtXLrgzYyNUBnnmb09tFx8zSe=y0JxtMiVrTooQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org

Hi, and thanks for your reply.

> Umm, however, I had submited a similar patch for supporting dolphin v2
> device last month and it was now applied into latest mainline.

Do you mean commit 'ee65d4...add support for "Dolphin" devices'?

It's in the dtor/input.git kernel but I don't think it's been merged 
into mainline (torvalds/linux.git).

Running 'git log drivers/input/mouse/alps.c' with the latest mainline 
kernel shows the last commit as '95f75e...add support for DualPoint 
device on Dell XT2 model', which doesn't work with my device (Dell 
Vostro 3360).

Are there any plans for it to be merged? It looks like your patch fixes 
it much better than mine ;)

Regards,
Chris
