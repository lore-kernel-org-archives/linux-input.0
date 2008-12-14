From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 5/5] Add support for E-Ink Broadsheet controller and AM300 kit
Date: Mon, 15 Dec 2008 00:26:04 +0800
Message-ID: <45a44e480812140826v8ab912cr821b23f9e3789f38@mail.gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
	 <12257601541179-git-send-email-jayakumar.lkml@gmail.com>
	 <f17812d70812090535h69fa6c15t4b7c50a29955dc42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:65218 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYLNQ0G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Dec 2008 11:26:06 -0500
Received: by ey-out-2122.google.com with SMTP id 6so321309eyi.37
        for <linux-input@vger.kernel.org>; Sun, 14 Dec 2008 08:26:04 -0800 (PST)
In-Reply-To: <f17812d70812090535h69fa6c15t4b7c50a29955dc42@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On Tue, Dec 9, 2008 at 9:35 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Nov 4, 2008 at 8:55 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> This patch adds support for the E-Ink Broadsheet display controller and the
>> AM300 gumstix kit.
>>
>> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
>
> You may want to break this patch into two pieces, one for the base
> broadsheetfb support and another for the am300epd board.
>

Okay, will split the am300epd patch and broadsheetfb patch for review,
and will only merge back before posting to patchqueue (so that bisect
will work).

Thanks,
jaya
